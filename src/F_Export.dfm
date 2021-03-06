object FormExport: TFormExport
  Left = 276
  Top = 139
  BorderStyle = bsDialog
  Caption = 'Export data'
  ClientHeight = 322
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 288
    Width = 492
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BTNOk: TButton
      Left = 109
      Top = 7
      Width = 61
      Height = 20
      Caption = '&OK'
      Default = True
      TabOrder = 0
      OnClick = BTNOkClick
    end
    object Button4: TButton
      Left = 323
      Top = 7
      Width = 61
      Height = 20
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 492
    Height = 288
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Bevel1: TBevel
      Left = 0
      Top = 159
      Width = 492
      Height = 4
      Align = alTop
      Shape = bsTopLine
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 492
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object CHKExportUnits: TCheckBox
        Left = 7
        Top = 13
        Width = 286
        Height = 14
        Caption = 'Export units'#39' data'
        TabOrder = 0
      end
    end
    object GroupBox4: TGroupBox
      Left = 0
      Top = 33
      Width = 492
      Height = 53
      Align = alTop
      Caption = 'File name'
      TabOrder = 1
      object EDITUnitFileName: TEdit
        Left = 7
        Top = 16
        Width = 397
        Height = 24
        TabOrder = 0
      end
      object BTNUnitBrowse: TButton
        Left = 410
        Top = 16
        Width = 60
        Height = 21
        Caption = 'Browse...'
        TabOrder = 1
        OnClick = BTNBrowseClick
      end
    end
    object GroupBox5: TGroupBox
      Left = 0
      Top = 86
      Width = 492
      Height = 73
      Align = alTop
      Caption = 'Format string'
      TabOrder = 2
      object EDITUnitFormatString: TEdit
        Left = 7
        Top = 16
        Width = 397
        Height = 30
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object BTNUnitDefault: TButton
        Left = 410
        Top = 16
        Width = 60
        Height = 21
        Caption = 'Set default'
        TabOrder = 1
        OnClick = BTNUnitDefaultClick
      end
      object CHKStripPath: TCheckBox
        Left = 7
        Top = 46
        Width = 397
        Height = 13
        Caption = 'Strip path'
        TabOrder = 2
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 163
      Width = 492
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object CHKExportRoutines: TCheckBox
        Left = 7
        Top = 13
        Width = 286
        Height = 14
        Caption = 'Export routines'#39' data'
        TabOrder = 0
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 196
      Width = 492
      Height = 53
      Align = alTop
      Caption = 'File name'
      TabOrder = 4
      object BTNRoutineBrowse: TButton
        Left = 410
        Top = 16
        Width = 60
        Height = 21
        Caption = 'Browse...'
        TabOrder = 0
        OnClick = BTNBrowseClick
      end
      object EDITRoutineFileName: TEdit
        Left = 7
        Top = 16
        Width = 397
        Height = 24
        TabOrder = 1
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 249
      Width = 492
      Height = 52
      Align = alTop
      Caption = 'Format string'
      TabOrder = 5
      object EDITRoutineFormatString: TEdit
        Left = 7
        Top = 16
        Width = 397
        Height = 30
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object BTNRoutineDefault: TButton
        Left = 410
        Top = 16
        Width = 60
        Height = 21
        Caption = 'Set default'
        TabOrder = 1
        OnClick = BTNRoutineDefaultClick
      end
    end
  end
  object ExportFileNameDialog: TSaveDialog
    Filter = '*.txt|*.txt|*.*|*.*'
    Left = 32
    Top = 355
  end
end
