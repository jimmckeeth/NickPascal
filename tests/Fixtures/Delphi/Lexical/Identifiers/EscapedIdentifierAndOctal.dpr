program EscapedIdentifierAndOctal;

{$APPTYPE CONSOLE}

{
  Fixture purpose:
  - Validate the lexer disambiguation between escaped identifiers and octal literals.

  Reference links:
  - ObjectPascalReference.md §1.4 Identifiers
  - ObjectPascalReference.md §1.7.1 Integer Literals
  - ObjectPascalReference_ReviewFixes.md fix #52

  Expected behavior:
  - `&begin` is parsed as an escaped identifier named `begin`
  - `&77` is parsed as an octal literal with decimal value 77

  Expected output:
  - line 1: 1
  - line 2: 77
}

var
  &begin: Integer;
  OctValue: Integer;
begin
  &begin := 1;
  OctValue := &77;
  Writeln(&begin);
  Writeln(OctValue);
end.
