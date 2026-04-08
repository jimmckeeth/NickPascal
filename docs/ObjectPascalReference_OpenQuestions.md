# Object Pascal Reference Open Questions

These items remain open until stronger authoritative evidence or compiler/runtime verification is collected.

1. Multiline-string introduction version
   - Resolve the version conflict between the current reference text and the currently reviewed Embarcadero documentation.
   - `ObjectPascalReference.md` currently states Delphi 11, while the reviewed Florence `Fundamental Syntactic Elements (Delphi)` page says multiline strings were added in RAD Studio 12.0.

Resolved by compiler verification in Delphi 13.1 Florence and now reflected in the evidence matrix:

- `&` escaped-identifier vs octal-literal disambiguation
- `%...` / `&...` / underscore-separated numeric literals
- caret control-sequence support in string constants
