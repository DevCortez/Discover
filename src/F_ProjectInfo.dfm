object FormProjectInfo: TFormProjectInfo
  Left = 497
  Top = 318
  BorderStyle = bsDialog
  Caption = 'Project settings'
  ClientHeight = 228
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 372
    Height = 59
    Align = alTop
    Caption = 'Application run parameters'
    TabOrder = 0
    object EDITRunParameters: TEdit
      Left = 7
      Top = 26
      Width = 358
      Height = 24
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 59
    Width = 372
    Height = 46
    Align = alTop
    Caption = 'Application startup directory'
    TabOrder = 1
    object BTNBrowse: TButton
      Left = 306
      Top = 20
      Width = 60
      Height = 20
      Caption = 'Browse...'
      TabOrder = 0
      OnClick = BTNBrowseClick
    end
    object EDITStartupDirectory: TEdit
      Left = 7
      Top = 20
      Width = 293
      Height = 24
      TabOrder = 1
    end
  end
  object CHKRunMaximized: TCheckBox
    Left = 13
    Top = 172
    Width = 170
    Height = 13
    Caption = 'Run application maximized'
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 194
    Width = 372
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Button2: TButton
      Left = 72
      Top = 7
      Width = 60
      Height = 20
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button3: TButton
      Left = 241
      Top = 7
      Width = 60
      Height = 20
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object HostAppCfg: TGroupBox
    Left = 0
    Top = 105
    Width = 372
    Height = 46
    Align = alTop
    Caption = 'Host application'
    TabOrder = 4
    object btnHostApplication: TButton
      Left = 306
      Top = 20
      Width = 60
      Height = 20
      Caption = 'Browse...'
      TabOrder = 0
      OnClick = btnHostApplicationClick
    end
    object edtHostApplication: TEdit
      Left = 7
      Top = 20
      Width = 293
      Height = 21
      TabOrder = 1
    end
  end
  object dlgHostApplication: TOpenDialog
    DefaultExt = '*.exe'
    Filter = 'exe|*.exe|Any?|*.*'
    Options = [ofFileMustExist, ofEnableSizing]
    Title = 'Host application'
    Left = 176
    Top = 129
  end
end
