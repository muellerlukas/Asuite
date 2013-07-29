unit BaseGeneralPropertyPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasePropertyPage, Vcl.StdCtrls,
  BaseEntityPage;

type
  TfrmBaseGeneralPropertyPage = class(TfrmBasePropertyPage)
    gbItem: TGroupBox;
    lbName: TLabel;
    edtName: TEdit;
    lbPathIcon: TLabel;
    edtPathIcon: TEdit;
    btnBrowseIcon: TButton;
    procedure btnBrowseIconClick(Sender: TObject);
    procedure edtNameEnter(Sender: TObject);
  private
    { Private declarations }
  strict protected
    function GetTitle: string; override;
    function GetImageIndex: Integer; override;
    function InternalLoadData: Boolean; override;
    function InternalSaveData: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmBaseGeneralPropertyPage: TfrmBaseGeneralPropertyPage;

implementation

uses
  AppConfig, PropertyItem, ulSysUtils, ulCommonUtils, udImages;

{$R *.dfm}

{ TfrmGeneralPropertyPage }

procedure TfrmBaseGeneralPropertyPage.btnBrowseIconClick(Sender: TObject);
begin
  OpenDialog1.Filter     := 'Files supported (*.ico;*.exe)|*.ico;*.exe|All files|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(RelativeToAbsolute(edtPathIcon.Text));
  if (OpenDialog1.Execute) then
    edtPathIcon.Text := AbsoluteToRelative(OpenDialog1.FileName);
end;

procedure TfrmBaseGeneralPropertyPage.edtNameEnter(Sender: TObject);
begin
  TEdit(Sender).Color := clWindow;
end;

function TfrmBaseGeneralPropertyPage.GetImageIndex: Integer;
begin
  Result := IMAGELARGE_INDEX_PropGeneral;
end;

function TfrmBaseGeneralPropertyPage.GetTitle: string;
begin
  Result := 'General';
end;

function TfrmBaseGeneralPropertyPage.InternalLoadData: Boolean;
begin
  Result := inherited;
  if Assigned(CurrentNodeData) then
  begin
    edtName.Text     := CurrentNodeData.Name;
    edtPathIcon.Text := CurrentNodeData.PathIcon;
  end;
end;

function TfrmBaseGeneralPropertyPage.InternalSaveData: Boolean;
begin
  Result := CheckPropertyName(edtName);
  if Result then
  begin
    if Assigned(CurrentNodeData) then
    begin
      CurrentNodeData.Name     := edtName.Text;
      CurrentNodeData.PathIcon := edtPathIcon.Text;
    end;
  end;
end;

end.