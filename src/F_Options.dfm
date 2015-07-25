object FormOptions: TFormOptions
  Left = 552
  Top = 276
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 156
  ClientWidth = 400
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
    Top = 123
    Width = 400
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 98
      Top = 7
      Width = 60
      Height = 20
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 241
      Top = 7
      Width = 61
      Height = 20
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object CHKStayOnTop: TCheckBox
    Left = 7
    Top = 91
    Width = 163
    Height = 14
    Caption = 'Stay on Top'
    TabOrder = 1
  end
  object CHKNoDisplaySourceLessUnits: TCheckBox
    Left = 7
    Top = 65
    Width = 329
    Height = 14
    Caption = 
      'Don'#39't display UNITS without accessible source or without routine' +
      's'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object CHKLoadState: TCheckBox
    Left = 7
    Top = 39
    Width = 234
    Height = 14
    Caption = 'At startup, reload the last saved state'
    TabOrder = 3
  end
  object CHKSaveState: TCheckBox
    Left = 7
    Top = 13
    Width = 286
    Height = 14
    Caption = 'At shutdown, save then current state'
    TabOrder = 4
  end
end
