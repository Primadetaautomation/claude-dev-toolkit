#!/usr/bin/env python3
"""
Claude Code PreCompact Hook - Simplified Version
Automatically saves conversation transcript before compaction.

Install:
1. Copy to your project: .claude/hooks/hook-precompact.py
2. Make executable: chmod +x .claude/hooks/hook-precompact.py
3. Configure in .claude/settings.json:
   {
     "hooks": {
       "PreCompact": ".claude/hooks/hook-precompact.py"
     }
   }
"""

import json
import sys
from datetime import datetime
from pathlib import Path


def format_message(msg: dict) -> str:
    """Format a message for readable text output."""
    role = msg.get("role", "unknown").upper()
    content = msg.get("content", "")

    lines = [f"\n[{role}]:"]

    # Handle structured content (list of content blocks)
    if isinstance(content, list):
        for item in content:
            if isinstance(item, dict):
                item_type = item.get("type", "text")

                if item_type == "text":
                    text = item.get("text", "")
                    if text:
                        lines.append(text)

                elif item_type == "thinking":
                    thinking = item.get("text", "")
                    if thinking:
                        lines.append("\n[THINKING]:")
                        lines.append(thinking)
                        lines.append("[/THINKING]\n")

                elif item_type == "tool_use":
                    tool_name = item.get("name", "unknown")
                    lines.append(f"\n[TOOL: {tool_name}]")
                    lines.append(json.dumps(item.get("input", {}), indent=2))

                elif item_type == "tool_result":
                    result = item.get("content", "")
                    lines.append("\n[TOOL RESULT]:")
                    # Limit output to prevent massive dumps
                    if isinstance(result, str) and len(result) > 2000:
                        lines.append(result[:2000] + "\n... (truncated) ...")
                    else:
                        lines.append(str(result))

    # Handle simple string content
    elif isinstance(content, str):
        lines.append(content)

    return "\n".join(lines) + "\n"


def export_transcript(transcript_path: str, session_id: str, trigger: str) -> str:
    """
    Export conversation transcript to text file.

    Args:
        transcript_path: Path to JSONL transcript file
        session_id: Session ID
        trigger: "manual" or "auto"

    Returns:
        Path to exported file
    """
    try:
        # Create storage directory
        storage_dir = Path.home() / ".claude-toolkit" / "transcripts" / "saved"
        storage_dir.mkdir(parents=True, exist_ok=True)

        # Generate filename
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        output_file = storage_dir / f"transcript_{timestamp}_{session_id[:8]}.txt"

        # Read JSONL transcript
        transcript_file = Path(transcript_path)
        if not transcript_file.exists():
            return ""

        # Parse JSONL entries
        entries = []
        with open(transcript_file) as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue

                try:
                    entry = json.loads(line)
                    entry_type = entry.get("type")

                    if entry_type in ["user", "assistant"] and "message" in entry:
                        entries.append((entry_type, entry["message"]))

                except json.JSONDecodeError:
                    continue

        # Write formatted transcript
        with open(output_file, "w", encoding="utf-8") as f:
            # Header
            f.write("=" * 80 + "\n")
            f.write("CLAUDE CODE CONVERSATION TRANSCRIPT\n")
            f.write(f"Exported: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"Session ID: {session_id}\n")
            f.write(f"Trigger: {trigger}\n")
            f.write(f"Messages: {len(entries)}\n")
            f.write("=" * 80 + "\n")

            # Messages
            for i, (entry_type, msg) in enumerate(entries, 1):
                f.write(f"\n--- Message {i} ({entry_type}) ---")
                f.write(format_message(msg))

            # Footer
            f.write("\n" + "=" * 80 + "\n")
            f.write("END OF TRANSCRIPT\n")
            f.write(f"Location: {output_file}\n")
            f.write("=" * 80 + "\n")

        return str(output_file)

    except Exception as e:
        print(f"Error exporting transcript: {e}", file=sys.stderr)
        return ""


def main():
    """Main hook entry point."""
    try:
        # Read input from Claude Code
        raw_input = sys.stdin.read()
        input_data = json.loads(raw_input)

        # Extract fields
        transcript_path = input_data.get("transcript_path", "")
        session_id = input_data.get("session_id", "unknown")
        trigger = input_data.get("trigger", "unknown")

        # Export transcript
        exported_path = ""
        if transcript_path:
            exported_path = export_transcript(transcript_path, session_id, trigger)

        # Return success (non-blocking)
        output = {
            "continue": True,
            "suppressOutput": True,
            "metadata": {
                "transcript_exported": bool(exported_path),
                "export_path": exported_path
            }
        }

        # Add notification
        if exported_path:
            filename = Path(exported_path).name
            output["systemMessage"] = f"💾 Transcript saved: {filename}"

        json.dump(output, sys.stdout)

    except Exception as e:
        # Non-blocking error - don't prevent compaction
        json.dump({
            "continue": True,
            "suppressOutput": True,
            "metadata": {"error": str(e)}
        }, sys.stdout)
        sys.exit(1)


if __name__ == "__main__":
    main()
