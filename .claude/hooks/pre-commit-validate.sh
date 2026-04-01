#!/bin/bash
# Pre-commit validation for Object Pascal Language Reference
# Runs before Claude executes any git commit command

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Only intercept git commit commands
if ! echo "$COMMAND" | grep -q "git commit"; then
  exit 0
fi

SPEC="$CLAUDE_PROJECT_DIR/ObjectPascalReference.md"
ERRORS=()

# Check 1: No trailing whitespace in staged changes
if git -C "$CLAUDE_PROJECT_DIR" diff --cached --check 2>/dev/null | grep -q "trailing whitespace"; then
  ERRORS+=("Trailing whitespace found in staged changes")
fi

# Check 2: Markdown code fences are balanced (opened and closed)
OPENS=$(grep -c '^```' "$SPEC" 2>/dev/null || echo 0)
if (( OPENS % 2 != 0 )); then
  ERRORS+=("Unbalanced code fences: $OPENS backtick-fence lines (should be even)")
fi

# Check 3: No broken internal cross-reference anchors (##...## headers referenced by links)
# Find all [text](#anchor) links and check they have matching headers
while IFS= read -r anchor; do
  # Convert anchor to expected heading pattern (GitHub auto-id rules)
  if ! grep -qi "^#.*${anchor#\#}" "$SPEC" 2>/dev/null; then
    ERRORS+=("Possible broken cross-reference: $anchor")
  fi
done < <(grep -oP '\]\(#[^)]+\)' "$SPEC" 2>/dev/null | grep -oP '#[^)]+' | head -20)

# Check 4: Reserved word count in A.1 matches actual list
CLAIMED_COUNT=$(grep -oP 'Reserved Words \(\K[0-9]+' "$SPEC" 2>/dev/null || echo 0)
if [ "$CLAIMED_COUNT" -gt 0 ]; then
  # Count words between the A.1 code fence markers
  ACTUAL_COUNT=$(sed -n '/^### A\.1/,/^### A\.2/{/^```$/,/^```$/p}' "$SPEC" 2>/dev/null \
    | grep -v '^```' | tr -s ' ' '\n' | grep -c '[a-z]' 2>/dev/null || echo 0)
  if [ "$ACTUAL_COUNT" -gt 0 ] && [ "$CLAIMED_COUNT" != "$ACTUAL_COUNT" ]; then
    ERRORS+=("A.1 claims $CLAIMED_COUNT reserved words but lists $ACTUAL_COUNT")
  fi
fi

if [ ${#ERRORS[@]} -gt 0 ]; then
  {
    echo "Pre-commit validation failed:"
    printf '  - %s\n' "${ERRORS[@]}"
  } >&2
  exit 2
fi

exit 0
