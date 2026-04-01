// ===========================================================================
//  test_oop.pas -- OOP and advanced features for Metamorf grammar validation
//
//  Exercises: classes (heritage, visibility, virtual/override/abstract),
//  interfaces with GUID, advanced records, constructors/destructors,
//  properties, enums/sets, exception handling (try/except/finally/raise),
//  anonymous methods, generics, type aliases, pointer types, dynamic arrays.
//
//  NOTE: Uses // and (* *) comments only -- no { } block comments.
//  Compile: Metamorf -l ObjectPascal.mor -s tests/test_oop.pas -r
// ===========================================================================

program TestOOP;

uses
  SysUtils;

// -------------------------------------------------------------------------
//  Forward declaration
// -------------------------------------------------------------------------
type
  TAnimal = class;

// -------------------------------------------------------------------------
//  Interface with GUID
// -------------------------------------------------------------------------
type
  INameable = interface
    ['{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}']
    function GetName: string;
    procedure SetName(const AName: string);
    property Name: string read GetName write SetName;
  end;

// -------------------------------------------------------------------------
//  Interface inheritance
// -------------------------------------------------------------------------
type
  IDescribable = interface(INameable)
    ['{B2C3D4E5-F6A7-8901-BCDE-F12345678901}']
    function Describe: string;
  end;

// -------------------------------------------------------------------------
//  Base class with virtual methods
// -------------------------------------------------------------------------
type
  TAnimal = class(TObject, INameable)
  private
    FName: string;
    FAge: Integer;
  protected
    function GetName: string;
    procedure SetName(const AName: string);
  public
    constructor Create(const AName: string; AAge: Integer);
    destructor Destroy; override;
    procedure Speak; virtual; abstract;
    function ToString: string; override;
    property Name: string read GetName write SetName;
    property Age: Integer read FAge write FAge;
  end;

// -------------------------------------------------------------------------
//  Derived class with override
// -------------------------------------------------------------------------
type
  TDog = class(TAnimal)
  private
    FBreed: string;
  public
    constructor Create(const AName: string; AAge: Integer; const ABreed: string);
    procedure Speak; override;
    property Breed: string read FBreed;
  end;

// -------------------------------------------------------------------------
//  Another derived class
// -------------------------------------------------------------------------
type
  TCat = class(TAnimal)
  public
    procedure Speak; override;
  end;

// -------------------------------------------------------------------------
//  Sealed class (cannot be inherited from)
// -------------------------------------------------------------------------
type
  TFinalDog = class sealed(TDog)
  public
    procedure Speak; override;
  end;

// -------------------------------------------------------------------------
//  Enum and set types
// -------------------------------------------------------------------------
type
  TLogLevel = (llDebug, llInfo, llWarning, llError, llFatal);
  TLogLevels = set of TLogLevel;

// -------------------------------------------------------------------------
//  Advanced record with methods
// -------------------------------------------------------------------------
type
  TPoint = record
    X: Double;
    Y: Double;
    function DistanceTo(const Other: TPoint): Double;
    class function Origin: TPoint; static;
  end;

// -------------------------------------------------------------------------
//  Record with constructor-like class function
// -------------------------------------------------------------------------
type
  TRect = record
    Left, Top, Right, Bottom: Integer;
    function Width: Integer;
    function Height: Integer;
    class function CreateRect(ALeft, ATop, ARight, ABottom: Integer): TRect; static;
  end;

// -------------------------------------------------------------------------
//  Generic class
// -------------------------------------------------------------------------
type
  TStack<T> = class
  private
    FItems: array of T;
    FCount: Integer;
  public
    constructor Create;
    procedure Push(const Item: T);
    function Pop: T;
    function Peek: T;
    function IsEmpty: Boolean;
    property Count: Integer read FCount;
  end;

// -------------------------------------------------------------------------
//  Generic interface
// -------------------------------------------------------------------------
type
  IComparer<T> = interface
    function Compare(const A, B: T): Integer;
  end;

// -------------------------------------------------------------------------
//  Type aliases and pointer types
// -------------------------------------------------------------------------
type
  PInteger = ^Integer;
  TIntArray = array of Integer;
  TMatrix = array of array of Double;
  TStringFunc = reference to function(const S: string): string;

// -------------------------------------------------------------------------
//  Custom exception class
// -------------------------------------------------------------------------
type
  EStackEmpty = class(Exception)
  public
    constructor Create;
  end;

// =========================================================================
//  IMPLEMENTATIONS
// =========================================================================

(* TAnimal *)

constructor TAnimal.Create(const AName: string; AAge: Integer);
begin
  inherited Create;
  FName := AName;
  FAge := AAge;
end;

destructor TAnimal.Destroy;
begin
  inherited Destroy;
end;

function TAnimal.GetName: string;
begin
  Result := FName;
end;

procedure TAnimal.SetName(const AName: string);
begin
  FName := AName;
end;

function TAnimal.ToString: string;
begin
  Result := FName + ' (age ' + IntToStr(FAge) + ')';
end;

(* TDog *)

constructor TDog.Create(const AName: string; AAge: Integer; const ABreed: string);
begin
  inherited Create(AName, AAge);
  FBreed := ABreed;
end;

procedure TDog.Speak;
begin
  WriteLn(Name, ' says: Woof!');
end;

(* TCat *)

procedure TCat.Speak;
begin
  WriteLn(Name, ' says: Meow!');
end;

(* TFinalDog *)

procedure TFinalDog.Speak;
begin
  WriteLn(Name, ' says: WOOF WOOF!');
end;

(* TPoint *)

function TPoint.DistanceTo(const Other: TPoint): Double;
var
  DX, DY: Double;
begin
  DX := Other.X - X;
  DY := Other.Y - Y;
  Result := Sqrt(DX * DX + DY * DY);
end;

class function TPoint.Origin: TPoint;
begin
  Result.X := 0.0;
  Result.Y := 0.0;
end;

(* TRect *)

function TRect.Width: Integer;
begin
  Result := Right - Left;
end;

function TRect.Height: Integer;
begin
  Result := Bottom - Top;
end;

class function TRect.CreateRect(ALeft, ATop, ARight, ABottom: Integer): TRect;
begin
  Result.Left := ALeft;
  Result.Top := ATop;
  Result.Right := ARight;
  Result.Bottom := ABottom;
end;

(* TStack<T> *)

constructor TStack<T>.Create;
begin
  FCount := 0;
  SetLength(FItems, 0);
end;

procedure TStack<T>.Push(const Item: T);
begin
  FCount := FCount + 1;
  SetLength(FItems, FCount);
  FItems[FCount - 1] := Item;
end;

function TStack<T>.Pop: T;
begin
  if FCount = 0 then
    raise EStackEmpty.Create;
  FCount := FCount - 1;
  Result := FItems[FCount];
  SetLength(FItems, FCount);
end;

function TStack<T>.Peek: T;
begin
  if FCount = 0 then
    raise EStackEmpty.Create;
  Result := FItems[FCount - 1];
end;

function TStack<T>.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

(* EStackEmpty *)

constructor EStackEmpty.Create;
begin
  inherited Create('Stack is empty');
end;

// -------------------------------------------------------------------------
//  Exception handling demonstration
// -------------------------------------------------------------------------
procedure TestExceptions;
var
  Stack: TStack<Integer>;
begin
  Stack := TStack<Integer>.Create;
  try
    Stack.Push(10);
    Stack.Push(20);
    WriteLn('Popped: ', Stack.Pop);
    WriteLn('Popped: ', Stack.Pop);

    // This should raise EStackEmpty
    try
      Stack.Pop;
    except
      on E: EStackEmpty do
        WriteLn('Caught expected error: ', E.Message);
      on E: Exception do
        WriteLn('Unexpected error: ', E.Message);
    end;
  finally
    Stack.Free;
  end;
end;

// -------------------------------------------------------------------------
//  Anonymous method demonstration
// -------------------------------------------------------------------------
procedure TestAnonymousMethods;
var
  Transform: TStringFunc;
  Input: string;
begin
  Transform := function(const S: string): string
  begin
    Result := '<<' + S + '>>';
  end;

  Input := 'Hello';
  WriteLn('Transformed: ', Transform(Input));
end;

// -------------------------------------------------------------------------
//  Polymorphism demonstration
// -------------------------------------------------------------------------
procedure TestPolymorphism;
var
  Animals: array of TAnimal;
  I: Integer;
begin
  SetLength(Animals, 3);
  Animals[0] := TDog.Create('Rex', 5, 'German Shepherd');
  Animals[1] := TCat.Create('Whiskers', 3);
  Animals[2] := TDog.Create('Buddy', 2, 'Labrador');

  for I := 0 to 2 do
  begin
    WriteLn(Animals[I].ToString);
    Animals[I].Speak;
  end;

  // Type checking with is/as
  for I := 0 to 2 do
  begin
    if Animals[I] is TDog then
      WriteLn(Animals[I].Name, ' is a ', (Animals[I] as TDog).Breed);
  end;

  // Cleanup
  for I := 0 to 2 do
    Animals[I].Free;
end;

// -------------------------------------------------------------------------
//  Record and set tests
// -------------------------------------------------------------------------
procedure TestRecordsAndSets;
var
  P1, P2: TPoint;
  R: TRect;
  ActiveLevels: TLogLevels;
  Level: TLogLevel;
begin
  P1 := TPoint.Origin;
  P2.X := 3.0;
  P2.Y := 4.0;
  WriteLn('Distance: ', P1.DistanceTo(P2));

  R := TRect.CreateRect(0, 0, 100, 50);
  WriteLn('Width: ', R.Width, ' Height: ', R.Height);

  ActiveLevels := [llInfo, llWarning, llError];
  if llDebug in ActiveLevels then
    WriteLn('Debug is active')
  else
    WriteLn('Debug is not active');
end;

// -------------------------------------------------------------------------
//  Pointer type demonstration
// -------------------------------------------------------------------------
procedure TestPointers;
var
  Value: Integer;
  P: PInteger;
begin
  Value := 99;
  P := @Value;
  WriteLn('Pointer value: ', P^);
  P^ := 100;
  WriteLn('Modified value: ', Value);
end;

// -------------------------------------------------------------------------
//  raise with a new exception
// -------------------------------------------------------------------------
procedure TestRaise;
begin
  try
    raise Exception.Create('Test raise');
  except
    on E: Exception do
      WriteLn('Raised and caught: ', E.Message);
  end;
end;

// -------------------------------------------------------------------------
//  Main program block
// -------------------------------------------------------------------------
begin
  WriteLn('=== OOP Tests ===');

  TestPolymorphism;
  TestRecordsAndSets;
  TestExceptions;
  TestAnonymousMethods;
  TestPointers;
  TestRaise;

  WriteLn('All OOP tests completed.');
end.
