object FormNewProject: TFormNewProject
  Left = 594
  Top = 404
  Width = 473
  Height = 382
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
  DesignSize = (
    457
    343)
  PixelsPerInch = 96
  TextHeight = 13
  object btnCreate: TButton
    Left = 296
    Top = 310
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'C&reate'
    ModalResult = 1
    TabOrder = 1
  end
  object Button1: TButton
    Left = 376
    Top = 310
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
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
      Left = 248
      Top = 24
      Width = 102
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'lblProjectFileMessage'
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
      Left = 248
      Top = 72
      Width = 102
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'lblProjectFileMessage'
      Visible = False
    end
    object lblBinary: TLabel
      Left = 16
      Top = 120
      Width = 53
      Height = 13
      Caption = 'Executable'
    end
    object lblBinaryMessage: TLabel
      Left = 248
      Top = 120
      Width = 102
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'lblProjectFileMessage'
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
    end
    object btnBrowseProjectFile: TButton
      Left = 366
      Top = 40
      Width = 59
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Browse'
      TabOrder = 0
    end
    object btnBrowseMapFile: TButton
      Left = 366
      Top = 88
      Width = 59
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Browse'
      TabOrder = 2
    end
    object edtMapFile: TEdit
      Left = 16
      Top = 88
      Width = 337
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object edtBinaryFile: TEdit
      Left = 16
      Top = 136
      Width = 337
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
    end
    object btnBrowseBinaryFile: TButton
      Left = 366
      Top = 136
      Width = 59
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Browse'
      TabOrder = 4
    end
  end
  object grpProjectOptions: TGroupBox
    Left = 8
    Top = 184
    Width = 441
    Height = 120
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Project options'
    TabOrder = 3
    DesignSize = (
      441
      120)
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
      Visible = False
    end
    object lblStartDir: TLabel
      Left = 16
      Top = 72
      Width = 84
      Height = 13
      Caption = 'Starting directory'
    end
    object lblHostMessage: TLabel
      Left = 243
      Top = 120
      Width = 102
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'lblProjectFileMessage'
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
      TabOrder = 2
      Visible = False
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
      TabOrder = 3
      Visible = False
    end
  end
end
