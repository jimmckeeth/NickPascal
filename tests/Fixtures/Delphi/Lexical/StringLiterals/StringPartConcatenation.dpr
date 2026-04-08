program StringPartConcatenation;

{$APPTYPE CONSOLE}

{
  Fixture purpose:
  - Validate that different string-part forms can participate in one string literal.
  - Specifically exercise quoted strings combined with caret-control fragments.

  Reference links:
  - ObjectPascalReference.md §1.8 String Literals
  - ObjectPascalReference_ReviewFixes.md fix #52

  Test value:
  - `S = 'A'^M^J'B'`
  - The resulting string should contain: `A`, CR, LF, `B`

  Expected output:
  - line 1: 4   (length)
  - line 2: 65  (`A`)
  - line 3: 13  (CR)
  - line 4: 10  (LF)
  - line 5: 66  (`B`)
}

const
  S = 'A'^M^J'B';
begin
  Writeln(Length(S));
  Writeln(Ord(S[1]));
  Writeln(Ord(S[2]));
  Writeln(Ord(S[3]));
  Writeln(Ord(S[4]));
end.
