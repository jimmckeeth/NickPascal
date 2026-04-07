program MultiLineTripleQuotes;

{$APPTYPE CONSOLE}

{
  Fixture purpose:
  - Validate multiline string acceptance with the common triple-quote delimiter.
  - Preserve a tiny runtime witness for the actual resulting character sequence.

  Reference links:
  - ObjectPascalReference.md §1.8.1 Multi-Line String Literals

  Historical note:
  - This fixture helps answer cross-version availability questions.
  - Current project knowledge: Delphi 11 does not support multiline strings; Delphi 12+
    does support them. This fixture should therefore fail in Delphi 11 and succeed in
    Delphi 12 and later.

  Test value:
  - Multiline content contains `A`, line break, `B`

  Expected output:
  - line 1: 4   (length)
  - line 2: 65  (`A`)
  - line 3: 13  (CR on Win32/Win64)
  - line 4: 10  (LF)
  - line 5: 66  (`B`)
}

const
  S = '''
A
B
''';
begin
  Writeln(Length(S));
  Writeln(Ord(S[1]));
  Writeln(Ord(S[2]));
  Writeln(Ord(S[3]));
  Writeln(Ord(S[4]));
end.
