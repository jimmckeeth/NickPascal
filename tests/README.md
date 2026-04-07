# Tests

This directory is the persistent home for executable validation artifacts that support `ObjectPascalReference.md`.

## Layout

- `Fixtures/Delphi/` - minimal Delphi source fixtures used for compile-pass and runtime verification across Delphi versions

## Current Scope

The first fixture wave focuses on lexical edge cases that are easy to validate with small standalone console programs:

- escaped identifiers vs octal literals
- binary, octal, hex, and decimal literals with underscore separators
- caret control-string fragments and mixed string-part sequences
- multiline string syntax introduced in Delphi 12, including triple quotes and larger odd-quote delimiters

## Fixture Documentation Rules

Every persistent Delphi fixture should explain itself without requiring a reader to inspect git history or external notes.

- add a short header comment block at the top of each `.dpr`
- state the exact reference sections and, where relevant, fix-ledger entries being exercised
- state whether the fixture is intended for compile-only validation, runtime validation, or both
- keep expected output explicit so historical-version checks stay reproducible
- prefer comments that explain **why this fixture exists** and **which language claim it protects**

## Intended Usage

These fixtures are designed to be compiled directly with specific Delphi compiler versions such as Delphi 11, 12, and 13.1.

Known historical baseline currently established from manual validation:

- Delphi 11: no multiline string literal support
- Delphi 12+: multiline string literal support present

They are intentionally small so that historical feature-introduction questions can be answered with a simple compile or compile-and-run check, without needing the future DUnitX harness first.

The long-term plan is for a DUnitX test project to wrap these fixtures and make the validation repeatable through one canonical runner.
