unit ViewDomain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, LCLType;

type

  { TfmViewDomain }

  TfmViewDomain = class(TForm)
    bbClose: TSpeedButton;
    cbNotNull: TCheckBox;
    edName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    laDefault: TLabel;
    laCheckConstraint: TLabel;
    laCharacterSet: TLabel;
    laCollation: TLabel;
    laType: TLabel;
    laSize: TLabel;
    procedure bbCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  fmViewDomain: TfmViewDomain;

implementation

{$R *.lfm}

{ TfmViewDomain }

procedure TfmViewDomain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:= caFree;
end;

procedure TfmViewDomain.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfmViewDomain.bbCloseClick(Sender: TObject);
begin
  Close;
  Parent.Free;
end;

end.

