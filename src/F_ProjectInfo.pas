(***************************************************************************

    Copyright 1998-2010, Christian Aymon (cyamon software, www.cyamon.com)

    This file is part of ''Discover''.

    ''Discover'' is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    ''Discover'' is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Discover.  If not, see <http://www.gnu.org/licenses/>.

 
***************************************************************************)
unit F_ProjectInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TFormProjectInfo = class(TForm)
    GroupBox1: TGroupBox;
    EDITRunParameters: TEdit;
    GroupBox2: TGroupBox;
    BTNBrowse: TButton;
    CHKRunMaximized: TCheckBox;
    Panel1: TPanel;
    Button2: TButton;
    Button3: TButton;
    EDITStartupDirectory: TEdit;
    HostAppCfg: TGroupBox;
    btnHostApplication: TButton;
    edtHostApplication: TEdit;
    dlgHostApplication: TOpenDialog;
    procedure BTNBrowseClick(Sender: TObject);
    procedure btnHostApplicationClick(Sender: TObject);
  private
    
  public
    
  end;

var
  FormProjectInfo: TFormProjectInfo;

implementation
uses
  FileCtrl;

{$R *.DFM}

procedure TFormProjectInfo.BTNBrowseClick(Sender: TObject);
  var
    Folder : string;
begin
  if SelectDirectory('Startup Directory', '', Folder) then
    EDITStartupDirectory.Text := Folder;
end;

procedure TFormProjectInfo.btnHostApplicationClick(Sender: TObject);
begin
  if dlgHostApplication.Execute then
    edtHostApplication.Text := dlgHostApplication.FileName
end;

end.
