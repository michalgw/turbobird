unit ViewDdlTrigger;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  SynEdit, SynHighlighterSQL;

type

  { TfmViewDdlTrigger }

  TfmViewDdlTrigger = class(TForm)
    bbClose: TSpeedButton;
    edName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    laEnabled: TLabel;
    laPos: TLabel;
    laType: TLabel;
    mEvent: TMemo;
    seScript: TSynEdit;
    SynSQLSyn1: TSynSQLSyn;
    procedure bbCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public

  end;

var
  fmViewDdlTrigger: TfmViewDdlTrigger;

implementation

uses
  LCLType;

{$R *.lfm}

{ TfmViewDdlTrigger }

procedure TfmViewDdlTrigger.bbCloseClick(Sender: TObject);
begin
  Close;
  Parent.Free;
end;

procedure TfmViewDdlTrigger.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TfmViewDdlTrigger.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and
    ((Key=VK_F4) or (Key=VK_W)) then
  begin
    if MessageDlg('Do you want to close this query window?', mtConfirmation, [mbNo, mbYes], 0) = mrYes then
    begin
      // Close when pressing Ctrl-W or Ctrl-F4 (Cmd-W/Cmd-F4 on OSX)
      Close;
      Parent.Free;
    end;
  end;
end;

end.

