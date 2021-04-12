unit CreateDbTrigger;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls;

type

  { TfmCreateDbTrigger }

  TfmCreateDbTrigger = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbDbEvent: TComboBox;
    edTriggerName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private

  public

  end;

var
  fmCreateDbTrigger: TfmCreateDbTrigger;

implementation

{$R *.lfm}

{ TfmCreateDbTrigger }

procedure TfmCreateDbTrigger.BitBtn1Click(Sender: TObject);
begin
  if (Trim(edTriggerName.Text) = '') or (cbDbEvent.ItemIndex < 0) then
    MessageDlg('Incorrect configuration', mtError, [mbOk], 0)
  else
    ModalResult:= mrOK;
end;

end.

