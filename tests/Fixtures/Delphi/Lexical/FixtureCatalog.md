# Lexical Fixture Catalog

This catalog records the purpose and expected behavior of the current lexical fixtures.

Primary reference sections:

- `ObjectPascalReference.md:113` - identifiers and escaped identifiers
- `ObjectPascalReference.md:197` - numeric literals
- `ObjectPascalReference.md:228` - string literals and string parts
- `ObjectPascalReference.md:249` - multiline string literals

| Fixture | Reference | Focus | Mode | Expected output |
| --- | --- | --- | --- |
| `Identifiers/EscapedIdentifierAndOctal.dpr` | `§1.4`, `§1.7.1`, fix `#52` | `&begin` vs `&77` disambiguation | compile + run | `1`, `77` |
| `NumericLiterals/BasePrefixesAndSeparators.dpr` | `§1.7.1`, fix `#52` | decimal / hex / binary / octal with separators | compile + run | `1000000`, `65535`, `240`, `77` |
| `StringLiterals/CaretControlStrings.dpr` | `§1.8`, fix `#52` | caret control-character fragments | compile + run | `0`, `1`, `13`, `31`, `127` |
| `StringLiterals/StringPartConcatenation.dpr` | `§1.8`, fix `#52` | mixed quoted, caret, and control-string parts | compile + run | `4`, `65`, `13`, `10`, `66` |
| `StringLiterals/MultiLineTripleQuotes.dpr` | `§1.8.1` | multiline string acceptance with triple quotes | compile + run | `4`, `65`, `13`, `10`, `66` (Delphi 12+); compile fail in Delphi 11 |
| `StringLiterals/MultiLineOddQuoteDelimiter.dpr` | `§1.8.1`, upstream `c000fec` | multiline string acceptance with five-quote delimiter and embedded triple quotes | compile + run | `7`, `65`, `39`, `39`, `39`, `13`, `10`, `66` (Delphi 12+); compile fail in Delphi 11 |

## Notes

- Output is listed one value per line in program order.
- These fixtures are intended to be recompiled against multiple Delphi versions to answer historical-introduction questions as well as current-behavior questions.
- Current historical conclusion: multiline string fixtures should fail to compile in Delphi 11 and succeed in Delphi 12+.
- A future harness can lift this catalog into machine-readable metadata.
