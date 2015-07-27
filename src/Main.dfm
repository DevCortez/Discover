object FormMain: TFormMain
  Left = 478
  Top = 183
  Width = 513
  Height = 452
  Caption = 'Discover'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 375
    Width = 497
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
    SizeGrip = False
    OnResize = StatusBarResize
  end
  object PNLMain: TPanel
    Left = 0
    Top = 0
    Width = 497
    Height = 375
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter: TSplitter
      Left = 222
      Top = 0
      Width = 2
      Height = 375
      Color = clBtnFace
      ParentColor = False
    end
    object PNLLeft: TPanel
      Left = 0
      Top = 0
      Width = 222
      Height = 375
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object PCLeft: TPageControl
        Left = 0
        Top = 0
        Width = 222
        Height = 375
        ActivePage = TSOverView
        Align = alClient
        TabOrder = 0
        OnChange = PCLeftChange
        object TSSummary: TTabSheet
          Caption = 'Summary'
          object MEMOSummary: TMemo
            Left = 0
            Top = 0
            Width = 214
            Height = 346
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object TSUnits: TTabSheet
          Caption = 'Units'
          object LBUnits: TListBox
            Left = 0
            Top = 14
            Width = 214
            Height = 311
            Style = lbOwnerDrawFixed
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            Ctl3D = False
            ItemHeight = 16
            MultiSelect = True
            ParentCtl3D = False
            PopupMenu = PUUnits
            TabOrder = 0
            OnClick = LBUnitsClick
            OnDrawItem = LBUnitsDrawItem
            OnKeyPress = LBUnitsKeyPress
          end
          object HCUnits: THeaderControl
            Left = 0
            Top = 0
            Width = 214
            Height = 14
            Sections = <
              item
                ImageIndex = -1
                Text = 'Units'
                Width = 50
              end
              item
                ImageIndex = -1
                Text = 'Size (bytes)'
                Width = 50
              end
              item
                ImageIndex = -1
                Text = 'R.Qty'
                Width = 50
              end
              item
                ImageIndex = -1
                Text = 'R.0%'
                Width = 50
              end
              item
                ImageIndex = -1
                Text = 'R.100%'
                Width = 50
              end
              item
                ImageIndex = -1
                Text = 'Coverage'
                Width = 50
              end>
            OnSectionClick = HCUnitsSectionClick
            OnSectionResize = HCUnitsSectionResize
            OnSectionTrack = HCSectionTrack
          end
          object SearchPane: TPanel
            Left = 0
            Top = 325
            Width = 214
            Height = 22
            Align = alBottom
            BevelOuter = bvNone
            Caption = 'SearchPane'
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 2
            Visible = False
            DesignSize = (
              214
              22)
            object edtUnitSearch: TEdit
              Left = 0
              Top = -1
              Width = 214
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSelect = False
              AutoSize = False
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              Text = 'edtUnitSearch'
            end
          end
        end
        object TSRoutines: TTabSheet
          Caption = 'Routines'
          object HCRoutines: THeaderControl
            Left = 0
            Top = 0
            Width = 214
            Height = 14
            Sections = <
              item
                ImageIndex = -1
                Text = 'Name'
                Width = 50
              end
              item
                ImageIndex = -1
                Text = 'Unit'
                Width = 50
              end
              item
                ImageIndex = -1
                Text = 'Points'
                Width = 50
              end
              item
                ImageIndex = -1
                Text = 'Coverage'
                Width = 50
              end>
            OnSectionClick = HCRoutinesSectionClick
            OnSectionTrack = HCSectionTrack
            OnResize = HCRoutinesResize
          end
          object LBRoutines: TListBox
            Left = 0
            Top = 14
            Width = 214
            Height = 311
            Style = lbOwnerDrawFixed
            Align = alClient
            Ctl3D = False
            ItemHeight = 16
            MultiSelect = True
            ParentCtl3D = False
            PopupMenu = PURoutines
            TabOrder = 1
            OnClick = LBRoutinesClick
            OnDrawItem = LBRoutinesDrawItem
            OnKeyPress = LBRoutinesKeyPress
            OnMouseDown = LBRoutinesMouseDown
          end
          object RoutineSearchPane: TPanel
            Left = 0
            Top = 325
            Width = 214
            Height = 22
            Align = alBottom
            BevelOuter = bvNone
            Caption = 'SearchPane'
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 2
            Visible = False
            DesignSize = (
              214
              22)
            object edtRoutineSearch: TEdit
              Left = 0
              Top = -1
              Width = 214
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSelect = False
              AutoSize = False
              Ctl3D = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              Text = 'edtUnitSearch'
            end
          end
        end
        object TSOverView: TTabSheet
          Caption = 'Overview'
          object PBOverView: TPaintBox
            Left = 0
            Top = 0
            Width = 214
            Height = 323
            Align = alClient
            ParentShowHint = False
            ShowHint = True
            OnMouseUp = PBOverViewMouseUp
            OnPaint = PBOverViewPaint
          end
          object PBLegend: TPaintBox
            Left = 0
            Top = 323
            Width = 214
            Height = 24
            Align = alBottom
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Small Fonts'
            Font.Style = []
            ParentFont = False
            OnPaint = PBLegendPaint
          end
        end
      end
    end
    object PNLRight: TPanel
      Left = 224
      Top = 0
      Width = 273
      Height = 375
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 273
        Height = 375
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel6'
        TabOrder = 0
        object PCRight: TPageControl
          Left = 0
          Top = 0
          Width = 273
          Height = 375
          ActivePage = TSCode
          Align = alClient
          TabOrder = 0
          OnChanging = PCRightChanging
          object TSCode: TTabSheet
            Caption = 'Source code'
            object LBFile: TListBox
              Left = 0
              Top = 0
              Width = 265
              Height = 347
              Style = lbOwnerDrawFixed
              Align = alClient
              Ctl3D = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ItemHeight = 17
              ParentCtl3D = False
              ParentFont = False
              PopupMenu = PUSource
              TabOrder = 0
              OnClick = LBFileClick
              OnDrawItem = LBFileDrawItem
              OnKeyPress = LBFileKeyPress
              OnMouseDown = LBFileMouseDown
            end
          end
        end
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 464
    object MMProject: TMenuItem
      Caption = '&Project'
      OnClick = MMProjectClick
      object MMProjectNew: TMenuItem
        Caption = '&Load...'
        OnClick = MMProjectNewClick
      end
      object MMProjectSettings: TMenuItem
        Caption = '&Settings...'
        OnClick = MMProjectSettingsClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MMProjectSave: TMenuItem
        Caption = '&Save State...'
        ShortCut = 16467
        OnClick = MMProjectSaveClick
      end
      object MMProjectReload: TMenuItem
        Caption = '&Reload State...'
        ShortCut = 16460
        OnClick = MMProjectReloadClick
      end
      object MMProjectMerge: TMenuItem
        Caption = '&Merge State...'
        ShortCut = 16461
        OnClick = MMProjectMergeClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MMProjectClearState: TMenuItem
        Caption = 'Clear State...'
        OnClick = MMProjectClearStateClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object MMExportData: TMenuItem
        Caption = '&Export Data...'
        OnClick = MMExportDataClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MMProjectExit: TMenuItem
        Caption = 'E&xit'
        OnClick = MMProjectExitClick
      end
    end
    object MMApplication: TMenuItem
      Caption = '&Application'
      OnClick = MMApplicationClick
      object MMApplicationRun: TMenuItem
        Caption = '&Run'
        ShortCut = 120
        OnClick = MMApplicationRunClick
      end
      object MMApplicationTerminate: TMenuItem
        Caption = '&Terminate...'
        OnClick = MMApplicationTerminateClick
      end
    end
    object MMOptions: TMenuItem
      Caption = '&Options'
      OnClick = MMOptionsClick
    end
    object MMHelp: TMenuItem
      Caption = '&Help'
      Visible = False
      OnClick = MMHelpClick
      object MMHelpHelp: TMenuItem
        Caption = '&Help'
        OnClick = MMHelpHelpClick
      end
      object MMHelpAbout: TMenuItem
        Caption = '&About...'
        OnClick = MMHelpAboutClick
      end
    end
  end
  object OpenDelphiProjectDialog: TOpenDialog
    Filter = '*.dpr|*.dpr|*.bdsproj|*.bdsproj'
    Options = [ofReadOnly, ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Left = 488
    Top = 56
  end
  object PURoutines: TPopupMenu
    OnPopup = PURoutinesPopup
    Left = 384
    Top = 56
    object PURoutinesEnable: TMenuItem
      Caption = '&Foreground'
      ShortCut = 16454
      OnClick = PURoutinesEnableDisableClick
    end
    object PURoutinesDisable: TMenuItem
      Caption = '&Background'
      ShortCut = 16450
      OnClick = PURoutinesEnableDisableClick
    end
  end
  object PUSource: TPopupMenu
    Left = 536
    Top = 56
    object PUSourceNextGreen: TMenuItem
      Caption = 'Goto Next Green'
      ShortCut = 16455
      OnClick = PUSourceNextGreenClick
    end
    object PUSourceNextRed: TMenuItem
      Caption = 'Goto Next Red'
      ShortCut = 16466
      OnClick = PUSourceNextRedClick
    end
  end
  object OpenStateDialog: TOpenDialog
    Filter = '*.xxx|*.xxx'
    Left = 448
    Top = 56
  end
  object PUUnits: TPopupMenu
    OnPopup = PUUnitsPopup
    Left = 416
    Top = 56
    object PUUnitsEnable: TMenuItem
      Caption = '&Foreground'
      ShortCut = 16454
      OnClick = PUUnitsEnableDisableClick
    end
    object PUUnitsDisable: TMenuItem
      Caption = '&Background'
      ShortCut = 16450
      OnClick = PUUnitsEnableDisableClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object PUUnitsSelectAll: TMenuItem
      Caption = 'Select &all'
      ShortCut = 16449
      OnClick = PUUnitsSelectAllClick
    end
    object PUUnitsSelectGroup: TMenuItem
      Caption = 'Select &directory'
      ShortCut = 16452
      OnClick = PUUnitsSelectGroupClick
    end
  end
  object OpenLibDialog: TOpenDialog
    Filter = '*.yyy|*.yyy'
    Left = 376
    Top = 112
  end
  object SaveLibDialog: TSaveDialog
    Filter = '*.yyy|*.yyy'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 416
    Top = 112
  end
  object ILLibImages: TImageList
    Left = 336
  end
  object SaveStateDialog: TSaveDialog
    Filter = '*.dps|*.dps'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 289
    Top = 36
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 289
    Top = 68
  end
  object TIMERResize: TTimer
    Enabled = False
    Interval = 150
    OnTimer = TIMERResizeTimer
    Left = 288
    Top = 99
  end
end
