# Delphi Fixtures

This directory contains version-check and regression fixtures for the Delphi implementation targeted by the reference.

## Conventions

- each fixture is a minimal standalone `.dpr`
- fixtures should focus on one claim or one tight cluster of related claims
- runtime output should stay deterministic and easy to compare across compiler versions
- fixture names should describe the language behavior under test
- every fixture should have a descriptive header comment linking it back to the relevant section(s) in `ObjectPascalReference.md`
- if a fixture exists because of a specific correction, also reference the matching entry in `ObjectPascalReference_ReviewFixes.md`
- when the exact historical introduction version is unknown, say so in the comment and describe the fixture as a version-check artifact

## Initial Areas

- `Lexical/Identifiers/`
- `Lexical/NumericLiterals/`
- `Lexical/StringLiterals/`

The current fixtures are kept as long-lived repo artifacts so they can later be integrated into `/tests` automation and into the Metamorf parity phase.
