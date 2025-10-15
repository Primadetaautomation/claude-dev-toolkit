# Claude Toolkit - Defensive Utilities

**Battle-tested utilities for robust AI integration**

Extracted from Microsoft Amplifier and simplified for standalone use.

## Features

### 1. **parse_llm_json** - Handle Messy LLM Responses

LLMs don't always return clean JSON. This utility extracts JSON from:
- Markdown-wrapped responses (````json blocks)
- Responses with explanatory text
- Slightly malformed JSON
- Nested JSON structures

```python
from claude_toolkit_defensive import parse_llm_json

# Works with messy responses
response = """Here's the data you requested:
```json
{
  "name": "example",
  "value": 42
}
```
"""

data = parse_llm_json(response)  # Returns: {"name": "example", "value": 42}
```

### 2. **retry_with_feedback** - Intelligent Retry with Error Correction

Retries AI operations and tells the AI what went wrong so it can self-correct:

```python
from claude_toolkit_defensive import retry_with_feedback

result = await retry_with_feedback(
    func=ai_session.query,
    prompt="Extract key concepts as JSON",
    max_retries=3
)
```

On failure, it appends feedback like:
> "IMPORTANT: Attempt 1 failed with error: JSON parse error. Your response MUST be valid JSON only. Do NOT include explanatory text..."

### 3. **isolate_prompt** - Prevent Context Contamination

Ensures AI uses ONLY your content, not system files or previous context:

```python
from claude_toolkit_defensive import isolate_prompt

clean_prompt = isolate_prompt(
    prompt="Summarize the key themes",
    content=document_text
)
```

Prevents the AI from accidentally referencing:
- System files
- Previous conversation context
- External knowledge bases

### 4. **File I/O with Cloud Sync Retry**

Handles OSError errno 5 from OneDrive/Dropbox/cloud-synced directories:

```python
from pathlib import Path
from claude_toolkit_defensive import write_json_with_retry, read_json_with_retry

# Automatically retries on cloud sync delays
write_json_with_retry(data, Path("output.json"))
data = read_json_with_retry(Path("input.json"), default={})
```

## Installation

```bash
# Install from local directory
pip install -e ~/.claude-toolkit/defensive

# Or copy to your project
cp -r ~/.claude-toolkit/defensive/ your-project/
```

## Usage Examples

### Complete Example: Robust LLM Processing

```python
from claude_toolkit_defensive import (
    parse_llm_json,
    retry_with_feedback,
    isolate_prompt,
    write_json_with_retry
)
from pathlib import Path

async def process_document(doc_text: str, ai_session):
    """Process document with full defensive utilities."""

    # 1. Isolate content to prevent context leakage
    prompt = isolate_prompt(
        prompt="Extract key concepts as JSON array",
        content=doc_text
    )

    # 2. Retry with feedback on failure
    response = await retry_with_feedback(
        func=ai_session.query,
        prompt=prompt,
        max_retries=3
    )

    # 3. Parse messy JSON response
    concepts = parse_llm_json(response, default=[])

    # 4. Save with cloud-sync retry logic
    if concepts:
        write_json_with_retry(
            data={"concepts": concepts},
            filepath=Path("output/concepts.json")
        )

    return concepts
```

## Why These Utilities?

**Real-world testing** (from Amplifier's DISCOVERIES.md):

> "Fresh md_synthesizer run with defensive utilities showed dramatic improvement:
> - ✅ Zero JSON parsing errors (was 100% failure rate)
> - ✅ Zero context contamination (was synthesizing from wrong files)
> - ✅ Zero crashes (was failing with exceptions)
> - ✅ 62.5% completion rate (vs 0% before)"

## Source

Extracted from [Microsoft Amplifier](https://github.com/microsoft/amplifier)
- `amplifier/ccsdk_toolkit/defensive/`
- Simplified and made standalone
- All credit to original authors

## License

MIT - Same as Microsoft Amplifier
