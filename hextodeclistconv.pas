unit hextodeclistconv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  StrUtils;

type

  { TformWindow }

  TformWindow = class(TForm)
    buttonBegin: TButton;
    editBegin: TEdit;
    editEnd: TEdit;
    groupBegin: TGroupBox;
    groupEnd: TGroupBox;
    memoSource: TMemo;
    memoResult: TMemo;
    procedure buttonBeginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  formWindow: TformWindow;

implementation

{$R *.lfm}

{ TformWindow }

var
  tstrlistSource: TStringList;

procedure TformWindow.FormCreate(Sender: TObject);
begin
  tstrlistSource := TStringList.Create;

  tstrlistSource.Sorted := false;
end;


function GetHexString(strLine: string; iPos, iNumChars: integer): string;
var
  strHex: string;
begin
  strHex := copy(strLine, iPos, iNumChars);
  Result := strHex;
end;


procedure TformWindow.buttonBeginClick(Sender: TObject);
var
  iCounter, iDecimal, iPos, iNumchars, iHexLength: integer;
  strCurrentLine, strCurrentHex, strDecimal: string;
  tstrlistDest: TStringList;
begin

  tstrlistSource.Assign(memoSource.Lines);

  tstrlistDest := TStringList.Create;
  tstrlistDest := tstrlistSource;

  if editBegin.Text = '0' then
     editBegin.Text := '1';
  if editEnd.Text = '0' then
     editEnd.Text := '1';

  iPos := StrToInt(editBegin.Text);
  iNumChars := StrToInt(EditEnd.Text);


  for iCounter := 0 to tstrlistSource.Count - 1 do begin

      strCurrentHex := GetHexString(tstrlistSource[iCounter], iPos, iNumChars);

      iDecimal := Hex2Dec(strCurrentHex);
      strDecimal := IntToStr(iDecimal);

      iHexLength := Length(strCurrentHex);
      strCurrentLine := tstrlistSource[iCounter];

      Delete(strCurrentLine, Pos(strCurrentHex, strCurrentLine), iHexLength);
      Insert(strDecimal, strCurrentLine, iPos);

      tstrlistDest[iCounter] := strCurrentLine;

  end;

  memoResult.Lines.AddStrings(tstrlistDest);

end;


end.

