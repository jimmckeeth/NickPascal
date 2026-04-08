program CaretControlStrings;

{$APPTYPE CONSOLE}

{
  Fixture purpose:
  - Validate that Delphi accepts legacy caret control-string fragments.
  - Capture a small, compiler-verified subset of the accepted mappings.

  Reference links:
  - ObjectPascalReference.md §1.8 String Literals
  - ObjectPascalReference_ReviewFixes.md fix #52

  Notes:
  - The full accepted caret mapping table is still treated as implementation-defined
    in the reference.
  - This fixture intentionally checks only the subset that has been compiler-verified.

  Expected output:
  - line 1: 0   (`^@`)
  - line 2: 1   (`^A`)
  - line 3: 13  (`^M`)
  - line 4: 31  (`^_`)
  - line 5: 127 (`^?`)
}

const
  C0 = ^@;
  C1 = ^A;
  C13 = ^M;
  C31 = ^_;
  C127 = ^?;
begin
  Writeln(Ord(C0));
  Writeln(Ord(C1));
  Writeln(Ord(C13));
  Writeln(Ord(C31));
  Writeln(Ord(C127));
end.
