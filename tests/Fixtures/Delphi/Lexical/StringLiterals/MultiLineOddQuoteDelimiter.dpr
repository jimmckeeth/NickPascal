program MultiLineOddQuoteDelimiter;

{$APPTYPE CONSOLE}

{
  Fixture purpose:
  - Validate multiline string acceptance with an odd-quote delimiter larger than 3.
  - Validate that a five-quote delimiter allows embedded triple quotes inside the body.

  Reference links:
  - ObjectPascalReference.md §1.8.1 Multi-Line String Literals
  - upstream main commit `c000fec` (odd-quote delimiter clarification)

  Historical note:
  - This fixture is especially useful when checking whether the generalized odd-quote
    delimiter form is available in older Delphi versions or whether only the triple-quote
    form is accepted.
  - Current project knowledge: Delphi 11 has no multiline string support at all. This
    fixture should therefore fail in Delphi 11 and succeed in Delphi 12 and later.

  Test value:
  - The resulting string should contain: `A`, `'`, `'`, `'`, CR, LF, `B`

  Expected output:
  - line 1: 7   (length)
  - line 2: 65  (`A`)
  - line 3: 39  (`'`)
  - line 4: 39  (`'`)
  - line 5: 39  (`'`)
  - line 6: 13  (CR on Win32/Win64)
  - line 7: 10  (LF)
  - line 8: 66  (`B`)
}

const
  S = '''''
A'''
B
''''';
begin
  Writeln(Length(S));
  Writeln(Ord(S[1]));
  Writeln(Ord(S[2]));
  Writeln(Ord(S[3]));
  Writeln(Ord(S[4]));
  Writeln(Ord(S[5]));
  Writeln(Ord(S[6]));
  Writeln(Ord(S[7]));
end.
