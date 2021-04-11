unit NewDomain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Spin, Buttons;

type

  { TfmNewDomain }

  TfmNewDomain = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbCharset: TComboBox;
    cbCollation: TComboBox;
    cbType: TComboBox;
    cbNotNull: TCheckBox;
    edDefault: TEdit;
    edCheck: TEdit;
    edName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblCharset: TLabel;
    lblCollation: TLabel;
    seSize: TSpinEdit;
    seScale: TSpinEdit;
    procedure cbCharsetEditingDone(Sender: TObject);
    procedure cbTypeEditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
    FDBIndex: Integer;
  public
    { public declarations }
    procedure Init(ADBIndex: Integer);
  end; 

var
  fmNewDomain: TfmNewDomain = nil;

implementation

uses
  SysTables, turbocommon;

{$R *.lfm}

{ TfmNewDomain }

procedure TfmNewDomain.cbTypeEditingDone(Sender: TObject);
begin
  seSize.Value:= dmSysTables.GetDefaultTypeSize(FDBIndex, cbType.Text);

  {todo: (low priority) allow/disallow gui elements when using domain datatypes.
   Check what can be overridden (e.g. collate for text-type domain fields)}
  // Allow character set, lblCollation for text type fields; otherwise disable
  case cbType.Text of
    'CHAR','CSTRING','VARCHAR':
    begin
      // Allow character set/lblCollation for text type fields
      cbCharset.Enabled:= true;
      cbCollation.Enabled:= true;
      seScale.Enabled:= false;
    end;
    'DECIMAL','NUMERIC':
    begin
      // Allow scale for numeric, decimal
      seScale.Enabled:= true;
      cbCharset.Enabled:= false;
      cbCollation.Enabled:= false;
    end
    else
    begin
      cbCharset.Enabled:= false;
      cbCollation.Enabled:= false;
      seScale.Enabled:= false;
    end;
  end;
end;

procedure TfmNewDomain.FormCreate(Sender: TObject);
begin
  CbCharSet.Items.AddStrings(FBCharacterSets);
end;

procedure TfmNewDomain.cbCharsetEditingDone(Sender: TObject);
var
  Collations: TStringList;
begin
  // Available collations depend on the chosen character set,
  // so update that whenever user changes character set
  Collations:= TStringList.Create;
  try
    GetCollations(cbCharSet.Text,Collations);
    cbCollation.Items.Assign(Collations);
  finally
    Collations.Free;
  end;
end;

procedure TfmNewDomain.Init(ADBIndex: Integer);
begin
  FDBIndex := ADBIndex;
  edName.Clear;
  cbType.ItemIndex:= -1;
  edDefault.Clear;
  seSize.Value:= 0;
  edCheck.Clear;
  cbCharset.ItemIndex := -1;
  cbCollation.ItemIndex := -1;

end;

end.

