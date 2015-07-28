object FormNewProject: TFormNewProject
  Left = 478
  Top = 216
  Width = 473
  Height = 432
  Caption = 'Create a new project'
  Color = clBtnFace
  Constraints.MaxHeight = 432
  Constraints.MinHeight = 382
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  DesignSize = (
    457
    393)
  PixelsPerInch = 96
  TextHeight = 13
  object btnCreateNew: TButton
    Left = 296
    Top = 360
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'C&reate'
    Enabled = False
    ModalResult = 1
    TabOrder = 2
    OnClick = btnCreateNewClick
  end
  object btnCancel: TButton
    Left = 376
    Top = 360
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object grpBasics: TGroupBox
    Left = 8
    Top = 8
    Width = 441
    Height = 169
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Basic informations'
    TabOrder = 0
    DesignSize = (
      441
      169)
    object lblProjectFile: TLabel
      Left = 16
      Top = 24
      Width = 83
      Height = 13
      Caption = 'Delphi project file'
    end
    object lblProjectFileMessage: TLabel
      Left = 205
      Top = 24
      Width = 145
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'lblProjectFileMessage'
      ParentBiDiMode = False
      Visible = False
    end
    object lblMapFile: TLabel
      Left = 16
      Top = 72
      Width = 75
      Height = 13
      Caption = 'Project MAP file'
    end
    object lblMapFileMessage: TLabel
      Left = 205
      Top = 72
      Width = 145
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'lblProjectFileMessage'
      ParentBiDiMode = False
      Visible = False
    end
    object lblBinary: TLabel
      Left = 16
      Top = 120
      Width = 30
      Height = 13
      Caption = 'Binary'
    end
    object lblBinaryMessage: TLabel
      Left = 205
      Top = 120
      Width = 145
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'lblProjectFileMessage'
      ParentBiDiMode = False
      Visible = False
    end
    object cbbProjectFile: TComboBox
      Left = 16
      Top = 40
      Width = 337
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 1
      OnChange = cbbProjectFileChange
    end
    object btnBrowseProjectFile: TButton
      Left = 366
      Top = 40
      Width = 59
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Browse'
      TabOrder = 0
      OnClick = btnBrowseProjectFileClick
    end
    object btnBrowseMapFile: TButton
      Left = 366
      Top = 88
      Width = 59
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Browse'
      TabOrder = 2
      OnClick = btnBrowseMapFileClick
    end
    object edtMapFile: TEdit
      Left = 16
      Top = 88
      Width = 337
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      OnChange = edtMapFileChange
    end
    object edtBinaryFile: TEdit
      Left = 16
      Top = 136
      Width = 337
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      OnChange = edtBinaryFileChange
    end
    object btnBrowseBinaryFile: TButton
      Left = 366
      Top = 136
      Width = 59
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Browse'
      TabOrder = 4
      OnClick = btnBrowseBinaryFileClick
    end
  end
  object grpProjectOptions: TGroupBox
    Left = 8
    Top = 184
    Width = 441
    Height = 170
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Project options'
    TabOrder = 1
    DesignSize = (
      441
      170)
    object lblParams: TLabel
      Left = 16
      Top = 24
      Width = 77
      Height = 13
      Caption = 'Run parameters'
    end
    object lblHost: TLabel
      Left = 16
      Top = 120
      Width = 76
      Height = 13
      Caption = 'Host application'
    end
    object lblStartDir: TLabel
      Left = 16
      Top = 72
      Width = 84
      Height = 13
      Caption = 'Starting directory'
    end
    object lblHostMessage: TLabel
      Left = 136
      Top = 120
      Width = 209
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'lblProjectFileMessage'
      ParentBiDiMode = False
      Visible = False
    end
    object cbbParams: TComboBox
      Left = 16
      Top = 40
      Width = 404
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
    end
    object cbbHost: TComboBox
      Left = 16
      Top = 136
      Width = 332
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 3
      OnChange = cbbHostChange
    end
    object edtStartDir: TEdit
      Left = 16
      Top = 88
      Width = 404
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object Button2: TButton
      Left = 366
      Top = 136
      Width = 59
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Browse'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object btnExportZombie: TButton
    Left = 8
    Top = 360
    Width = 121
    Height = 25
    Caption = '&Export zombie project'
    TabOrder = 4
    OnClick = btnExportZombieClick
  end
  object dlgFindFile: TOpenDialog
    Filter = 'exe|*.exe|potato|*.potato'
    Options = [ofFileMustExist, ofEnableSizing]
    Left = 184
    Top = 176
  end
  object dlgExportZombie: TSaveDialog
    DefaultExt = '.zp'
    Filter = 'Zombie coverage project|*.zp'
    Left = 160
    Top = 360
  end
end
