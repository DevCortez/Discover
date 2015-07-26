unit F_NewProject;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormNewProject = class(TForm)
    btnCreate: TButton;
    Button1: TButton;
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
  private
  public
  end;

var
  FormNewProject: TFormNewProject;

implementation

{$R *.dfm}

end.
