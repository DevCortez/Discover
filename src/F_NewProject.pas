unit F_NewProject;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormNewProject = class(TForm)
    btnCreateNew: TButton;
    btnCancel: TButton;
    grpBasics: TGroupBox;
    lblProjectFile: TLabel;
    cbbProjectFile: TComboBox;
    btnBrowseProjectFile: TButton;
    lblProjectFileMessage: TLabel;
    lblMapFile: TLabel;
    lblMapFileMessage: TLabel;
    btnBrowseMapFile: TButton;
    edtMapFile: TEdit;
    lblBinary: TLabel;
    edtBinaryFile: TEdit;
    lblBinaryMessage: TLabel;
    btnBrowseBinaryFile: TButton;
    grpProjectOptions: TGroupBox;
    lblParams: TLabel;
    cbbParams: TComboBox;
    lblHost: TLabel;
    cbbHost: TComboBox;
    lblStartDir: TLabel;
    edtStartDir: TEdit;
    Button2: TButton;
    lblHostMessage: TLabel;
    dlgFindFile: TOpenDialog;
    procedure cbbProjectFileChange(Sender: TObject);
    procedure cbbProjectFileExit(Sender: TObject);
    procedure cbbHostChange(Sender: TObject);
    procedure edtMapFileChange(Sender: TObject);
    procedure edtBinaryFileChange(Sender: TObject);
    procedure btnBrowseProjectFileClick(Sender: TObject);
    procedure btnBrowseMapFileClick(Sender: TObject);
    procedure btnBrowseBinaryFileClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure ValidateInformation;
  public
  end;

var
  FormNewProject: TFormNewProject;

implementation

uses
  StrUtils;

{$R *.dfm}

procedure TFormNewProject.cbbProjectFileChange(Sender: TObject);
begin
  If not FileExists(cbbProjectFile.Text) then
    begin
      lblProjectFileMessage.Font.Color := clRed;
      lblProjectFileMessage.Caption := 'File does not exist';
      lblProjectFileMessage.Visible := true;
    end
  else
    lblProjectFileMessage.Visible := false;

  ValidateInformation();
end;

procedure TFormNewProject.cbbProjectFileExit(Sender: TObject);
begin
  if FileExists(cbbProjectFile.Text) then
    begin
      if FileExists(ChangeFileExt(cbbProjectFile.Text, '.map')) and (Length(edtMapFile.Text) = 0) then
        edtMapFile.Text := ChangeFileExt(cbbProjectFile.Text, '.map');

      if Length(edtBinaryFile.Text) = 0 then
        if AnsiContainsText(cbbProjectFile.Text, '.dpk') and
           FileExists(ChangeFileExt(cbbProjectFile.Text, '.bpl')) then
          edtBinaryFile.Text := ChangeFileExt(cbbProjectFile.Text, '.bpl')
        else
          if FileExists(ChangeFileExt(cbbProjectFile.Text, '.exe')) then
            edtBinaryFile.Text := ChangeFileExt(cbbProjectFile.Text, '.exe')
          else
            if FileExists(ChangeFileExt(cbbProjectFile.Text, '.dll')) then
              edtBinaryFile.Text := ChangeFileExt(cbbProjectFile.Text, '.dll');
    end;
end;

procedure TFormNewProject.cbbHostChange(Sender: TObject);
begin
  if not FileExists(cbbHost.Text) then
    begin
      lblHostMessage.Font.Color := clRed;
      lblHostMessage.Caption := 'File not found';
      lblHostMessage.Visible := True;
    end
  else
    lblHostMessage.Visible := False;
end;

procedure TFormNewProject.edtMapFileChange(Sender: TObject);
begin
  if not FileExists(edtMapFile.Text) then
    begin
      lblMapFileMessage.Font.Color := clRed;
      lblMapFileMessage.Caption := 'File not found';
      lblMapFileMessage.Visible := True;
    end
  else
    lblMapFileMessage.Visible := False;

  ValidateInformation();
end;

procedure TFormNewProject.edtBinaryFileChange(Sender: TObject);
begin
  if not FileExists(edtBinaryFile.Text) then
    begin
      lblBinaryMessage.Font.Color := clRed;
      lblBinaryMessage.Caption := 'File not found';
      lblBinaryMessage.Visible := True;
    end
  else
    lblBinaryMessage.Visible := False;

  ValidateInformation();
end;

procedure TFormNewProject.btnBrowseProjectFileClick(Sender: TObject);
begin
  dlgFindFile.Title := 'Find project file';
  dlgFindFile.Filter := 'Delphi project|*.dpr|Delphi package|*.dpk';

  if dlgFindFile.Execute then
    begin
      cbbProjectFile.Text := dlgFindFile.FileName;
      cbbProjectFile.SetFocus();
    end;
end;

procedure TFormNewProject.btnBrowseMapFileClick(Sender: TObject);
begin
  dlgFindFile.Title := 'Find map file';
  dlgFindFile.Filter := 'Detailed map file|*.map';

  if dlgFindFile.Execute then
    begin
      edtMapFile.Text := dlgFindFile.FileName;
      edtMapFile.SetFocus();
    end;
end;

procedure TFormNewProject.btnBrowseBinaryFileClick(Sender: TObject);
begin
  dlgFindFile.Title := 'Find binary file';
  dlgFindFile.Filter := 'Executable|*.exe|Dynamic link library|*.dll|Delphi package|*.bpl';

  if dlgFindFile.Execute then
    begin
      edtBinaryFile.Text := dlgFindFile.FileName;
      edtBinaryFile.SetFocus();
    end;
end;

procedure TFormNewProject.Button2Click(Sender: TObject);
begin
  dlgFindFile.Title := 'Find host application';
  dlgFindFile.Filter := 'Executable|*.exe|Unknown PE format|*.*';

  if dlgFindFile.Execute then
    begin
      cbbHost.Text := dlgFindFile.FileName;
      cbbHost.SetFocus();
    end;
end;

procedure TFormNewProject.ValidateInformation;
begin
  btnCreateNew.Enabled := FileExists(cbbProjectFile.Text) and FileExists(edtMapFile.Text) and FileExists(edtBinaryFile.Text)
end;

end.
