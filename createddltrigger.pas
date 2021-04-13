unit CreateDdlTrigger;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  ExtCtrls, Grids, Types;

type

  { TfmCreateDdlTrigger }

  TfmCreateDdlTrigger = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbAnyDDL: TCheckBox;
    edTriggerName: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    rbAfter: TRadioButton;
    rbBefor: TRadioButton;
    sgEvents: TStringGrid;
    procedure BitBtn1Click(Sender: TObject);
    procedure cbAnyDDLChange(Sender: TObject);
    procedure sgEventsDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure sgEventsValidateEntry(sender: TObject; aCol, aRow: Integer;
      const OldValue: string; var NewValue: String);
  private
    function ColRowActive(C, R: Integer): Boolean;
  public
    function GetEvents: String;
  end;

var
  fmCreateDdlTrigger: TfmCreateDdlTrigger;

implementation

{$R *.lfm}

{ TfmCreateDdlTrigger }

procedure TfmCreateDdlTrigger.sgEventsDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
Var
  LCellRect: TRect;
begin
  if not ColRowActive(aCol, aRow) then
  begin
    LCellRect:= sgEvents.CellRect(ACol, ARow);
    sgEvents.Canvas.FillRect(LCellRect);
  end;
end;

procedure TfmCreateDdlTrigger.sgEventsValidateEntry(sender: TObject; aCol,
  aRow: Integer; const OldValue: string; var NewValue: String);
begin
  if not ColRowActive(aCol, aRow) then
    NewValue := '';
end;

function TfmCreateDdlTrigger.ColRowActive(C, R: Integer): Boolean;
begin
  Result := not (((R in [12, 15]) and (C = 2)) or ((R = 13) and (C in [1, 3])));
end;

function TfmCreateDdlTrigger.GetEvents: String;

procedure AddOr(var S: String; AVal: String);
begin
  if S <> '' then
    S := S + ' OR ';
  S := S + AVal;
end;

var
  C, R: Integer;
begin
  Result := '';
  if cbAnyDDL.Checked then
    Result := 'ANY DDL STATEMENT'
  else
    for R := 1 to 15 do
      for C := 1 to 3 do
        if ColRowActive(C, R) and (sgEvents.Cells[C, R] = '1') then
          AddOr(Result, sgEvents.Cells[C, 0] + ' ' + sgEvents.Cells[0, R]);
end;

procedure TfmCreateDdlTrigger.cbAnyDDLChange(Sender: TObject);
begin
  sgEvents.Enabled := not cbAnyDDL.Checked;
end;

procedure TfmCreateDdlTrigger.BitBtn1Click(Sender: TObject);
begin
  if (Trim(edTriggerName.Text) = ''){ or (cbDbEvent.ItemIndex < 0)} then
    MessageDlg('Incorrect configuration', mtError, [mbOk], 0)
  else
    ModalResult:= mrOK;
end;

end.

