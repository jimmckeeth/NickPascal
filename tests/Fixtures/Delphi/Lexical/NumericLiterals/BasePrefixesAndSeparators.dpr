program BasePrefixesAndSeparators;

{$APPTYPE CONSOLE}

{
  Fixture purpose:
  - Validate decimal, hexadecimal, binary, and octal literals.
  - Validate underscore separators inside all four literal families.

  Reference links:
  - ObjectPascalReference.md §1.7.1 Integer Literals
  - ObjectPascalReference_ReviewFixes.md fix #52

  Expected behavior:
  - `1_000_000` remains decimal 1000000
  - `$FF_FF` evaluates to 65535
  - `%1111_0000` evaluates to 240
  - `&7_7` evaluates to octal 77 = decimal 77

  Expected output:
  - line 1: 1000000
  - line 2: 65535
  - line 3: 240
  - line 4: 77
}

begin
  Writeln(1_000_000);
  Writeln($FF_FF);
  Writeln(%1111_0000);
  Writeln(&7_7);
end.
