// ===========================================================================
//  test_basic.pas -- Core language features for Metamorf grammar validation
//
//  Exercises: program declaration, uses clause, const/var/type sections,
//  literals, arithmetic, comparison, logical expressions, control flow
//  (if/case/for/while/repeat), functions, procedures, WriteLn output.
//
//  NOTE: Uses // and (* *) comments only -- no { } block comments.
//  Compile: Metamorf -l ObjectPascal.mor -s tests/test_basic.pas -r
// ===========================================================================

program TestBasic;

uses
  SysUtils;

// -------------------------------------------------------------------------
//  Constants
// -------------------------------------------------------------------------
const
  AppName    = 'TestBasic';
  MaxItems   = 100;
  Pi         = 3.14159265;
  IsDebug    = True;
  Greeting   = 'Hello, Metamorf!';
  HexValue   = $FF;

// -------------------------------------------------------------------------
//  Type aliases
// -------------------------------------------------------------------------
type
  TIndex     = Integer;
  TName      = string;
  TScoreList = array of Double;

// -------------------------------------------------------------------------
//  Enumeration and set
// -------------------------------------------------------------------------
type
  TColor = (clRed, clGreen, clBlue, clYellow);
  TColorSet = set of TColor;

// -------------------------------------------------------------------------
//  Variables
// -------------------------------------------------------------------------
var
  I, J: Integer;
  X: Double;
  Name: TName;
  Score: Double;
  Colors: TColorSet;
  Scores: TScoreList;

// -------------------------------------------------------------------------
//  Simple function: add two integers
// -------------------------------------------------------------------------
function Add(A, B: Integer): Integer;
begin
  Result := A + B;
end;

// -------------------------------------------------------------------------
//  Function with const parameter
// -------------------------------------------------------------------------
function StringLength(const S: string): Integer;
begin
  Result := Length(S);
end;

// -------------------------------------------------------------------------
//  Procedure with var parameter (pass by reference)
// -------------------------------------------------------------------------
procedure Increment(var Value: Integer);
begin
  Value := Value + 1;
end;

// -------------------------------------------------------------------------
//  Procedure with out parameter
// -------------------------------------------------------------------------
procedure InitValue(out Value: Integer);
begin
  Value := 42;
end;

// -------------------------------------------------------------------------
//  Function demonstrating local inline variables
// -------------------------------------------------------------------------
function Factorial(N: Integer): Integer;
begin
  if N <= 1 then
    Result := 1
  else
    Result := N * Factorial(N - 1);
end;

// -------------------------------------------------------------------------
//  Arithmetic and logical expressions
// -------------------------------------------------------------------------
procedure TestExpressions;
var
  A, B, C: Integer;
  R: Double;
  Flag: Boolean;
begin
  A := 10;
  B := 3;

  (* Arithmetic *)
  C := A + B;
  C := A - B;
  C := A * B;
  R := A / B;
  C := A div B;
  C := A mod B;

  (* Comparison *)
  Flag := A = B;
  Flag := A <> B;
  Flag := A < B;
  Flag := A > B;
  Flag := A <= B;
  Flag := A >= B;

  (* Logical *)
  Flag := (A > 0) and (B > 0);
  Flag := (A > 0) or (B > 0);
  Flag := not Flag;
  Flag := (A > 0) xor (B < 0);

  (* Bitwise / shift *)
  C := A shl 2;
  C := A shr 1;

  WriteLn('Expressions passed');
end;

// -------------------------------------------------------------------------
//  Control flow: if/then/else
// -------------------------------------------------------------------------
procedure TestIfElse;
var
  X: Integer;
begin
  X := 5;

  if X > 10 then
    WriteLn('Greater than 10')
  else if X > 0 then
    WriteLn('Positive')
  else
    WriteLn('Non-positive');

  // Compound statement
  if X = 5 then
  begin
    WriteLn('X is five');
    WriteLn('Exactly five');
  end;
end;

// -------------------------------------------------------------------------
//  Control flow: case statement
// -------------------------------------------------------------------------
procedure TestCase;
var
  Day: Integer;
begin
  Day := 3;

  case Day of
    1: WriteLn('Monday');
    2: WriteLn('Tuesday');
    3: WriteLn('Wednesday');
    4: WriteLn('Thursday');
    5: WriteLn('Friday');
    6, 7: WriteLn('Weekend');
  else
    WriteLn('Invalid day');
  end;
end;

// -------------------------------------------------------------------------
//  Control flow: for loops (to, downto)
// -------------------------------------------------------------------------
procedure TestForLoop;
var
  I: Integer;
  Total: Integer;
begin
  Total := 0;

  // for..to
  for I := 1 to 10 do
    Total := Total + I;

  WriteLn('Sum 1..10 = ', Total);

  // for..downto
  for I := 10 downto 1 do
    Write(I, ' ');
  WriteLn;
end;

// -------------------------------------------------------------------------
//  Control flow: for-in loop
// -------------------------------------------------------------------------
procedure TestForIn;
var
  C: TColor;
  Colors: TColorSet;
begin
  Colors := [clRed, clGreen, clBlue];
  for C in Colors do
    WriteLn('Color ordinal: ', Ord(C));
end;

// -------------------------------------------------------------------------
//  Control flow: while loop
// -------------------------------------------------------------------------
procedure TestWhile;
var
  N: Integer;
begin
  N := 1;
  while N <= 5 do
  begin
    WriteLn('While: ', N);
    N := N + 1;
  end;
end;

// -------------------------------------------------------------------------
//  Control flow: repeat..until
// -------------------------------------------------------------------------
procedure TestRepeat;
var
  N: Integer;
begin
  N := 1;
  repeat
    WriteLn('Repeat: ', N);
    N := N + 1;
  until N > 5;
end;

// -------------------------------------------------------------------------
//  Nested function
// -------------------------------------------------------------------------
function OuterFunction(X: Integer): Integer;

  function InnerDouble(V: Integer): Integer;
  begin
    Result := V * 2;
  end;

begin
  Result := InnerDouble(X) + 1;
end;

// -------------------------------------------------------------------------
//  Main program block
// -------------------------------------------------------------------------
begin
  WriteLn(Greeting);
  WriteLn('AppName = ', AppName);
  WriteLn('MaxItems = ', MaxItems);
  WriteLn('Pi = ', Pi);
  WriteLn('HexValue = ', HexValue);

  // Test function calls
  WriteLn('Add(3, 4) = ', Add(3, 4));
  WriteLn('Factorial(6) = ', Factorial(6));
  WriteLn('StringLength(''Hello'') = ', StringLength('Hello'));

  // Test var/out parameters
  I := 10;
  Increment(I);
  WriteLn('After Increment: ', I);

  InitValue(J);
  WriteLn('After InitValue: ', J);

  // Test nested function
  WriteLn('OuterFunction(5) = ', OuterFunction(5));

  // Run control flow tests
  TestExpressions;
  TestIfElse;
  TestCase;
  TestForLoop;
  TestForIn;
  TestWhile;
  TestRepeat;

  WriteLn('All basic tests completed.');
end.
