"""
Claude Toolkit - Defensive Utilities

Minimal, battle-tested utilities for robust AI integration:
- parse_llm_json: Extract JSON from messy LLM responses
- retry_with_feedback: Intelligent retry with error correction
- isolate_prompt: Prevent context contamination
- File I/O with cloud-sync retry logic

Source: Extracted from Microsoft Amplifier
License: MIT
"""

from .file_io import read_json_with_retry, write_json_with_retry
from .llm_parsing import parse_llm_json
from .prompt_isolation import isolate_prompt
from .retry_patterns import retry_with_feedback

__version__ = "1.0.0"

__all__ = [
    # LLM response handling
    "parse_llm_json",
    "isolate_prompt",
    "retry_with_feedback",
    # File I/O with cloud sync awareness
    "write_json_with_retry",
    "read_json_with_retry",
]
