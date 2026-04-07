# Object Pascal Reference Open Questions

These items remain open until stronger authoritative evidence or compiler/runtime verification is collected.

1. `&` and octal disambiguation
   - Confirm the exact Delphi 13.1 Florence lexer behavior when `&` is followed by an identifier-start character versus an octal digit.
   - The current reference and fix ledger describe both behaviors, but the reviewed Florence lexical documentation only directly documents extended identifiers.

2. Binary and octal integer literals in current Delphi
   - Confirm the current normative status of `%...` binary literals and `&...` octal literals for Delphi 13.1 Florence.
   - The current reference documents them, but the currently reviewed Florence lexical page does not by itself settle the claim.

3. Caret control-sequence support in string constants
   - Determine whether forms such as `^A` are part of current supported Delphi string-constant syntax, historical behavior, or undocumented legacy behavior.
   - The fix ledger mentions caret sequences, while the reviewed Embarcadero string documentation only describes quoted strings plus control strings (`#nn`, `#$nn`).

4. Numeric separator coverage by literal kind
   - Confirm whether underscore separators are accepted uniformly across decimal, hexadecimal, octal, and binary numerals in Delphi 13.1 Florence.
   - The reference currently states this broadly and should be backed by either a stronger source or a compiler experiment.

5. Multiline-string introduction version
   - Resolve the version conflict between the current reference text and the currently reviewed Embarcadero documentation.
   - `ObjectPascalReference.md` currently states Delphi 11, while the reviewed Florence `Fundamental Syntactic Elements (Delphi)` page says multiline strings were added in RAD Studio 12.0.
