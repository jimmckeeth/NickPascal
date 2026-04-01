# Object Pascal Metamorf Compiler Definition

A comprehensive Metamorf language definition for Object Pascal (Delphi 13.1 Florence), targeting C++23 native binary output.

## Files

| File | Purpose |
|------|---------|
| `ObjectPascal.mor` | Root language definition (imports all stages) |
| `ObjectPascal_tokens.mor` | Lexer tokens, operators, type system |
| `ObjectPascal_helpers.mor` | Shared routines and reusable fragments |
| `ObjectPascal_grammar.mor` | Pratt parser rules (prefix, infix, statement) |
| `ObjectPascal_semantics.mor` | Multi-pass semantic analysis |
| `ObjectPascal_emitters.mor` | C++23 code generation |
| `tests/test_basic.pas` | Core language features test |
| `tests/test_oop.pas` | OOP and advanced features test |
| `tests/mathlib.pas` | Unit/module compilation test |

## Prerequisites

1. Download **Metamorf v0.1.0** (or later) from [GitHub Releases](https://github.com/nicbarker/metamorf/releases)
2. Extract `Metamorf.exe` to a directory on your PATH (or use the full path in commands below)
3. Windows is required for the current Metamorf binary

## Running the Tests

From the `metamorf/` directory:

```bash
# Parse and run the basic test
Metamorf -l ObjectPascal.mor -s tests/test_basic.pas -r

# Parse only (no execution) -- useful for checking grammar errors
Metamorf -l ObjectPascal.mor -s tests/test_basic.pas

# OOP and advanced features
Metamorf -l ObjectPascal.mor -s tests/test_oop.pas -r

# Unit compilation (parse only -- units have no main block)
Metamorf -l ObjectPascal.mor -s tests/mathlib.pas
```

### Command flags

| Flag | Description |
|------|-------------|
| `-l <file>` | Language definition file (root `.mor` file) |
| `-s <file>` | Source file to compile |
| `-r` | Run after compilation (compile + execute) |
| `-o <file>` | Output file for generated C++23 code |

## Expected Output

### test_basic.pas

If parsing succeeds and `-r` is used, you should see output like:

```
Hello, Metamorf!
AppName = TestBasic
MaxItems = 100
...
All basic tests completed.
```

### test_oop.pas

```
=== OOP Tests ===
Rex (age 5)
Rex says: Woof!
...
All OOP tests completed.
```

## Troubleshooting

### Comment syntax

Pascal source files **must not** use `{ }` block comments. The Metamorf ConfigCpp layer reserves braces for C++ passthrough. Use instead:

- `//` for line comments
- `(* *)` for block comments

### Parse errors

If you see parse errors, the most common causes are:

1. **Brace comments** -- Replace `{ comment }` with `(* comment *)` or `// comment`
2. **Missing semicolons** -- Pascal requires semicolons after declarations and statements
3. **Unsupported features** -- Some advanced Delphi features have limited support (see below)

### Known limitations

- `{ }` block comments are not supported (use `(* *)` or `//`)
- Inline assembly (`asm..end`) is parsed but passed through as raw text
- Full generic constraint validation is limited
- COM/dispinterface code generation is simplified
- RTTI attribute generation is beyond C++23 emission scope
- Compiler directives (`{$...}`) are handled but not all switches are implemented

## Iterative Validation Workflow

1. Run `Metamorf -l ObjectPascal.mor -s tests/test_basic.pas` (parse only)
2. If errors appear, note the line number and token
3. Check the grammar rule in `ObjectPascal_grammar.mor`
4. Fix the grammar or adjust the test file
5. Re-run until parsing succeeds
6. Add `-r` flag to compile and execute
7. Check generated C++23 output with `-o output.cpp`
8. Move on to `test_oop.pas` and `mathlib.pas`
