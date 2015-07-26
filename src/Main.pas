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
unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, DataBase, ComCtrls, Objects,
  Process, Buttons, ImgList, ProjectInfo, StrUtils, Types;

type
  THeaderTrackingInfo = record
    TrackingRect : TRect;
    TrackingRectDrawn : boolean;
  end ;
  PHeaderTrackingInfo = ^THeaderTrackingInfo;

  // The very first version of Discover was able to record and play journaling events...
  // However, this featunre has never been completely implemented but several (non huring)
  // declarations still exist here ant there...
  TJournalEvent = (jeWMCancelJournal, jeApplRestored, jeCtrlBreak,
    jeProcessJustRunning, jeTimerElapsed, jeProcessJustTerminated, jePlayStream,
    jePlayStreamsToPlay, jeRecord, jePlayNodesToPlay, jeRecordContinue,
    jeDebugString);
  TStateMachineState = (stIdle, stPlaying, stRecording, stWaitForProcessNotRunning,
    stWaitForProcessRunning, stWaitForProcessReadyForPlaying);

  TFormMain = class(TForm)
    edtUnitSearch: TEdit;
    SearchPane: TPanel;
  published
    MainMenu: TMainMenu;
    MMProject: TMenuItem;
    MMProjectNew: TMenuItem;
    OpenDelphiProjectDialog: TOpenDialog;
    StatusBar: TStatusBar;
    PNLMain: TPanel;
    PNLLeft: TPanel;
    Splitter: TSplitter;
    PNLRight: TPanel;
    PCLeft: TPageControl;
    TSRoutines: TTabSheet;
    TSOverView: TTabSheet;
    Panel6: TPanel;
    HCRoutines: THeaderControl;
    LBRoutines: TListBox;
    TSUnits: TTabSheet;
    LBUnits: TListBox;
    HCUnits: THeaderControl;
    PURoutines: TPopupMenu;
    PURoutinesDisable: TMenuItem;
    PCRight: TPageControl;
    TSCode: TTabSheet;
    LBFile: TListBox;
    PUSource: TPopupMenu;
    PUSourceNextGreen: TMenuItem;
    PUSourceNextRed: TMenuItem;
    OpenStateDialog: TOpenDialog;
    TSSummary: TTabSheet;
    MEMOSummary: TMemo;
    PUUnits: TPopupMenu;
    PUUnitsEnable: TMenuItem;
    N3: TMenuItem;
    PUUnitsSelectAll: TMenuItem;
    OpenLibDialog: TOpenDialog;
    SaveLibDialog: TSaveDialog;
    MMApplication: TMenuItem;
    MMApplicationRun: TMenuItem;
    MMApplicationTerminate: TMenuItem;
    MMOptions: TMenuItem;
    MMHelp: TMenuItem;
    PBOverView: TPaintBox;
    ILLibImages: TImageList;
    MMHelpAbout: TMenuItem;
    PUUnitsDisable: TMenuItem;
    MMProjectSave: TMenuItem;
    MMProjectReload: TMenuItem;
    PURoutinesEnable: TMenuItem;
    N4: TMenuItem;
    MMProjectExit: TMenuItem;
    PUUnitsSelectGroup: TMenuItem;
    MMHelpHelp: TMenuItem;
    SaveStateDialog: TSaveDialog;
    MMProjectMerge: TMenuItem;
    Timer1: TTimer;
    N5: TMenuItem;
    MMExportData: TMenuItem;
    N1: TMenuItem;
    MMProjectSettings: TMenuItem;
    N2: TMenuItem;
    MMProjectClearState: TMenuItem;
    PBLegend: TPaintBox;
    TIMERResize: TTimer;


    procedure MMProjectNewClick(Sender: TObject);
    procedure PBOverViewPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LBFileDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure HCSectionTrack(HeaderControl: THeaderControl;
      Section: THeaderSection; Width: Integer; State: TSectionTrackState);
    procedure LBRoutinesDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure HCRoutinesSectionClick(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure LBRoutinesClick(Sender: TObject);
    procedure HCRoutinesResize(Sender: TObject);
    procedure LBUnitsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure LBFileClick(Sender: TObject);
    procedure StatusBarResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure HCUnitsSectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure HCUnitsSectionClick(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure TimerTimer(Sender: TObject);
    procedure PCLeftChange(Sender: TObject);
    procedure PUUnitsEnableDisableClick(Sender: TObject);
    procedure PUUnitsPopup(Sender: TObject);
    procedure PUUnitsSelectAllClick(Sender: TObject);
    procedure MMProjectClick(Sender: TObject);
    procedure MMApplicationClick(Sender: TObject);
    procedure MMApplicationRunClick(Sender: TObject);
    procedure MMApplicationTerminateClick(Sender: TObject);
    procedure MMMacroRecordNewClick(Sender: TObject);
    procedure MMOptionsClick(Sender: TObject);
    procedure MMHelpAboutClick(Sender: TObject);
    procedure PURoutinesPopup(Sender: TObject);
    procedure PURoutinesEnableDisableClick(Sender: TObject);
    procedure MMProjectSaveClick(Sender: TObject);
    procedure MMProjectReloadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LBRoutinesKeyPress(Sender: TObject; var Key: Char);
    procedure LBUnitsKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MMProjectExitClick(Sender: TObject);
    procedure PUUnitsSelectGroupClick(Sender: TObject);
    procedure PCRightChanging(Sender: TObject; var AllowChange: Boolean);
    procedure MMHelpHelpClick(Sender: TObject);
    procedure MMHelpClick(Sender: TObject);
    procedure MMProjectMergeClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure MMExportDataClick(Sender: TObject);
    procedure LBUnitsClick(Sender: TObject);
    procedure LBRoutinesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LBFileKeyPress(Sender: TObject; var Key: Char);
    procedure PUSourceNextGreenClick(Sender: TObject);
    procedure PUSourceNextRedClick(Sender: TObject);
    procedure LBFileMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PBOverViewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MMProjectSettingsClick(Sender: TObject);
    procedure MMProjectClearStateClick(Sender: TObject);
    procedure PBLegendPaint(Sender: TObject);
    procedure TIMERResizeTimer(Sender: TObject);
  private
    SquaresPerLine : integer;
    CurrentUnit : TUnit;
    CurrentRoutine : TRoutine;
    SortedRoutines : TSortedRoutines;
    SortedUnits : TSortedUnits;
    CurrentSourceFileName, LoadedStatesStr : string;
    CoveredBitMap, UnCoveredBitMap, EnabledBitMap, DisabledBitMap,
      LockShutBitmap : TBitMap;
    HeaderRoutinesInfo, HeaderUnitsInfo : THeaderTrackingInfo;
    Process : TProcess;
    PrevPerCent : integer;
    FStateMachineState : TStateMachineState;
    DeltaCovered : integer;
    AppearanceArray : array [0..14] of integer;
    LastChangedCount : integer;
    CaptureBitmapStream : TMemoryStream;
    InitialScreenDone : boolean;
    ProjectInfo : TProjectInfo;
    StateFileName, InfoFileName : string;
    Resizing : boolean;
    function ReadExeFileName: string;
    procedure WriteExeFileName(const Value: string);

    property ExeFileName : string read ReadExeFileName write WriteExeFileName;
    procedure FillLBRoutines;
    procedure FillLBUnits;
    procedure FillSummary;
    procedure UpdateOverView(Routine : TRoutine);
    procedure UpdateFileLine(Point : TCoveragePoint);
    procedure UpdateCoverageOnStatusBar;
    procedure UpdateOnActivate;
    procedure FillSortedRoutineList;
    procedure FillSortedUnitList;
    procedure FillSortedFilteredUnitList;
    procedure DisplayStatusFilename;
    procedure AdjustStatusbar;
    procedure DrawStringInColumn(Canvas : TCanvas; R : TRect; const s : string;
      RightJustify : boolean);
    function MainHook(var Message: TMessage): Boolean;

    procedure HandlePointCovered (Point : TCoveragePoint);
    procedure HandleProcessRunning;
    procedure HandleProcessTerminated;
    procedure HandleProgress(Percent : integer; const ActionString : string);
    procedure HandleMessage(var Msg: TMsg; var Handled: Boolean);
    procedure HandleApplActivate(Sender : TObject);
    procedure HandleApplDeActivate(Sender : TObject);
    procedure HandleProcessDebugString(DebugString : PChar);
    procedure HandleIdleApplication (Sender: TObject; var Done: Boolean);
    procedure HandleErrorCode(ErrorCode, Address : integer);
    procedure HandleExceptions(Sender : TObject; E : Exception);
    procedure GotoNextCoveragePoint(RedGreen : boolean);
    procedure PositionRoutineViewToPoint(C : TCoveragePoint);
    procedure DoCommandLineInitialActions;
    procedure DoCommandLineFinalActions;
    procedure LoadInformationFile;
    procedure SaveInformationFile;
    procedure RunApplication;
    procedure MakeReport;
    function AllowsNewState : boolean;
    procedure SaveDataBase(const FileName : string);
    procedure InitAfterLoadingDatabase;
    procedure HandleJournalEvent(Event:TJournalEvent);
    procedure SetStateMachineState(aState : TStateMachineState);
    property StateMachineState : TStateMachineState read FStateMachineState
      write SetStatemachineState;
  public
    
    procedure LoadProject(const DelphiProjectFileName : string);
    procedure LoadState(const StateFileName : string);
    procedure SaveStateFile(const FileName : string);
    procedure MergeWithStateFile(const FileName : string);    
    procedure LoadLastSavedState;
    procedure AdjustStayOnTop;
    procedure Sleep(Delay : integer);
  end;

var
  FormMain: TFormMain;

implementation
  uses
    CodeParser, Config, Exceptions, Globals, IniFiles, MapFile,
    Util, F_Options, F_About,  F_Edit, CRC32, ShellAPI,
    FileCtrl, F_Export, F_ProjectInfo, Math;

{$R *.DFM}
const
  StateMachineStrings : array [TStateMachineState] of string = (
    'Idle', 'Playing', 'Recording', 'WaitForProcessNotRunning',
    'WaitForProcessRunning', 'WaitForProcessReadyForPlaying');
  JournalEventString : array [TJournalEvent] of string = (
    'WMCancelJournal', 'ApplRestored',  'CtrlBreak',
    'ProcessJustRunning', 'TimerElapsed', 'ProcessJustTerminated',
    'PlayStream', 'PlayStreamsToPlay', 'Record', 'PlayNodesToPlay',
    'RecordContinue', 'DebugString'
  );
  pProgress = 4;
  pFilePos = 4;
  pValidEnabledCoveredPoints = 0;
  pDeltaCovered = 1;
  pProcessState = 2;
var
  OverviewPointSquareSide : integer = 1;

function MergeColor(ASource, ATarget, AThreshold : cardinal):TColor;
var
  lR, lG, lB : integer;
begin
  AThreshold := Min(100, AThreshold);

  lB := ((ATarget shr 16 and $FF) - (ASource shr 16 and $FF));
  lB := trunc(lB * (AThreshold / 100));

  lG := ((ATarget shr 8 and $FF) - (ASource shr 8 and $FF));
  lG := trunc(lG * (AThreshold / 100));

  lR := ((ATarget and $FF) - (ASource and $FF));
  lR := trunc(lR * (AThreshold / 100));

  lB := (ASource shr 16 and $FF) + lB;
  lG := (ASource shr 8 and $FF) + lG;
  lR := (ASource and $FF) + lR;

  result := RGB(lR, lG, lB);
end;

{~t}
(*****************************)
(* TFormmain.AdjustStatusbar *)
(*****************************)

procedure TFormmain.AdjustStatusbar;
  var
    w, i : integer;
begin
  w := 0;
  with StatusBar, Panels do begin
    Panels[pProcessState].Width := Canvas.TextWidth('HHHHHHH');
    for i := 0 to Count - 2 do
      inc(w, Panels[i].Width);
    Panels[pred(Count)].Width := Width - w - GetSystemMetrics(SM_CXHSCROLL);
  end ;
end ;


(*****************************)
(* TFormMain.AdjustStayOnTop *)
(*****************************)

procedure TFormMain.AdjustStayOnTop;
begin
  if FormOptions.CHKStayOnTop.Checked then
    SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
      SWP_NOSIZE)
    // FormStyle := fsStayOnTop
  else
    SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
      SWP_NOSIZE)
    // FormStyle := fsNormal;
end ;


(****************************)
(* TFormMain.AllowsNewState *)
(****************************)

function TFormMain.AllowsNewState;
begin
  Result := true;
  if (ProjectDatabase_ <> nil) and (ProjectDataBase_.ChangedCount <> 0) then
    case MessageDlg('Do you want to save the current state?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: begin
        if ExecDialog(SaveStateDialog, State_Key) then begin
          Refresh;
          SaveStateFile(SaveStateDialog.FileName);
          Result := true;
        end else
          Result := false;
      end;
      mrNo:
        Result := true;
      mrCancel:
        Result := false;
    end ;
end ;


(***********************************)
(* TFormMain.DisplayStatusFilename *)
(***********************************)

procedure TFormMain.DisplayStatusFilename;
  var
    s,t : string;
begin
  if CurrentSourceFileName <> '' then
    with StatusBar.Panels[pFilePos] do begin
      t := ' ('+IntToStr(succ(LBFile.ItemIndex))+')';
      s := MinimizeName(CurrentSourceFileName, Canvas, Width-Canvas.TextWidth(t)) + t;
      Text := s;
    end ;
end ;


(***************************************)
(* TFormMain.DoCommandLineFinalActions *)
(***************************************)

procedure TFormMain.DoCommandLineFinalActions;
begin
  if CommandLineParams_.SaveStateOnAppTerminate then
    SaveStateFile(StateFileName);

  if CommandLineParams_.ReportWhenAppTerminated then
    MakeReport;

  if CommandLineParams_.CloseWhenAppTerminated then
    Close
  else begin
    CommandLineParams_.Action := caNoAction; // Command line ignored
    Application.Restore;
  end ;
end ;


(*****************************************)
(* TFormMain.DoCommandLineInitialActions *)
(*****************************************)

procedure TFormMain.DoCommandLineInitialActions;
begin
  if CommandLineParams_.Action = caDPR then begin
    // DPR started
    // Load the project
    LoadProject(CommandLineParams_.FileName);

    StateFileName := ChangeFileExt(ProjectDataBase_.ModuleFileName,ProjectStateExtension);
    InfoFileName := ChangeFileExt(StateFileName, ProjectInformationExtension);

    // Check if an information file exists and if yes take its infos
    LoadInformationFile;

    if CommandLineParams_.Merge then begin
      if FileExists(StateFileName) then
        MergeWithStateFile(StateFileName);
    end ;

    // Run the application
    RunApplication;

  end else begin
    // DPS started
    LoadState(CommandLineParams_.FileName);

    StateFileName := CommandLineParams_.FileName;
    InfoFileName := ChangeFileExt(StateFileName, ProjectInformationExtension);

    // Check if an information file exists and if yes take its infos
    LoadInformationFile;

    RunApplication;
  end ;
end ;


(********************************)
(* TFormmain.DrawStringInColumn *)
(********************************)

procedure TFormmain.DrawStringInColumn(Canvas : TCanvas; R : TRect; const s : string;
  RightJustify : boolean);
  var
    t : string;
    StripCount : integer;
begin
  with Canvas do begin
    t := s;
    StripCount := 1;
    if RightJustify then
      dec(R.Right, 5);
    while (StripCount < Length(s)) and (TextWidth(t) > (R.Right - R.Left)) do begin
      t := Copy(s,1,Length(s)-StripCount)+'...';
      inc(StripCount);
    end ;
    if RightJustify then
      TextOut(R.Right-TextWidth(t), R.Top, t)
    else
      TextOut(R.Left, R.Top, t);
  end ;
end ;


(****************************)
(* TFormMain.FillLBRoutines *)
(****************************)

procedure TFormMain.FillLBRoutines;
  var
    i : integer;
    R : TRoutine;
begin
  LBRoutines.Items.BeginUpdate;
  LBRoutines.Items.Clear;

  with SortedRoutines do
    for i := 0 to pred(Count) do
      begin
        R := At(i);
        LBRoutines.Items.AddObject('',R);
      end ;

  LBRoutines.Items.EndUpdate;
end ;


(*************************)
(* TFormMain.FillLBUnits *)
(*************************)

procedure TFormMain.FillLBUnits;
  var
    U : TUnit;
    i : integer;
begin
  LBUnits.Items.BeginUpdate;
  LBUnits.Items.Clear;

  with SortedUnits do
    for i := 0 to pred(Count) do
      begin
        U := At(i);

        LBUnits.Items.AddObject('',U);
      end ;
  LBUnits.Items.EndUpdate;
end ;


(***********************************)
(* TFormMain.FillSortedRoutineList *)
(***********************************)

procedure TFormMain.FillSortedRoutineList;
  var
    i : integer;
    R : TRoutine;
    U : TUnit;
begin
  SortedRoutines.DeleteAll;
  
  if ProjectDatabase_ <> nil then
    begin
      ProjectDataBase_.UpDateStatistics;
      for i := 0 to pred(ProjectDataBase_.Routines.Count) do
        begin
          R := ProjectDataBase_.Routines.At(i);
          U := ProjectDataBase_.Units.At(R.UnitIndex);

          if (R.FirstPointIndex >= 0) and U.IsSourceAvailable and (not U.Disabled) and (R.ValidPointsQty > 0) then
            SortedRoutines.Insert(R);
        end ;
    end ;
end ;


(********************************)
(* TFormMain.FillSortedUnitList *)
(********************************)

procedure TFormMain.FillSortedUnitList;
var
  i : integer;
    U : TUnit;
begin
  // Update Statistical info
  if ProjectDatabase_ <> nil then
    begin
      ProjectDataBase_.UpDateStatistics;
      SortedUnits.DeleteAll;

      with ProjectDataBase_.Units do
        for i := 0 to pred(Count) do
          begin
            U := At(i);

            if (U.IsSourceAvailable or not FormOptions.CHKNoDisplaySourceLessUnits.Checked) and
                (U.ValidPointsQty > 0) then
              SortedUnits.Insert(U);
          end ;
    end ;
end ;


(*************************)
(* TFormMain.FillSummary *)
(*************************)

procedure TFormMain.FillSummary;
  const
    R100s = 'R.100%';
    R0s = 'R.0%';
  var
    R100, R0 : integer;
begin
  if ProjectDataBase_ <> nil then
    with ProjectDataBase_ do begin
      GetR100R0(R100, R0);
      MEMOSummary.Lines.Clear;
      MEMOSummary.Lines.Add(ProjectDataBase_.ModuleFileName);
      MEMOSummary.Lines.Add(LoadedStatesStr);
      MEMOSummary.Lines.Add('UNITS');
      MEMOSummary.Lines.Add(Format('  Total:      %5d',[Units.Count]));
      MEMOSummary.Lines.Add(Format('  Source:     %5d',[UnitsWithSource]));
      MEMOSummary.Lines.Add(Format('  Foreground: %5d', [EnabledUnitsQty]));
      MEMOSummary.Lines.Add('');

      MEMOSummary.Lines.Add('ROUTINES');
      MEMOSummary.Lines.Add(Format('  Total:      %5d',[Routines.Count]));
      MEMOSummary.Lines.Add(Format('  Source:     %5d', [RoutinesWithSource]));
      MEMOSummary.Lines.Add(Format('  Foreground: %5d', [EnabledRoutinesQty]));
      MEMOSummary.Lines.Add(Format('  %s:     %5d', [R100s, R100]));
      MEMOSummary.Lines.Add(Format('  %s:       %5d', [R0s, R0]));
      MEMOSummary.Lines.Add('');

      MEMOSummary.Lines.Add('POINTS');
      MEMOSummary.Lines.Add(Format('  Source:     %5d',[CoveragePoints.ValidPointsQty]));
      MEMOSummary.Lines.Add(Format('  Foreground: %5d', [CoveragePoints.ValidEnabledPointsQty]));
      MEMOSummary.Lines.Add('');

      MEMOSummary.Lines.Add('COVERAGE');
      MEMOSummary.Lines.Add(Format('  Source:     %5.1f',[TotalCoverage])+'%');
      MEMOSummary.Lines.Add(Format('  Foreground: %5.1f', [EnabledCoverage])+'%');
    end ;
end ;


(***********************)
(* TFormMain.FormClose *)
(***********************)

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
  var
    I : TIniFile;
begin
  if ProjectDataBase_ <> nil then begin
    if (ProjectDataBase_.ChangedCount <> 0) then begin
      if FormOptions.CHKSaveState.Checked and (CommandLineParams_.Action = caNoAction)then begin
        SaveStateFile(StateFileName);
        I := TIniFile.Create(PrivateProfileFileName_);
        try
          I.WriteString(ProfileSectionStrings[psLastFiles],DefaultState_Key,StateFileName);
        finally
          I.Free;
        end ;
      end ;
    end ;
    SaveInformationFile;
  end ;
end ;


(****************************)
(* TFormMain.FormCloseQuery *)
(****************************)

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Process.Running then begin
    MessageDlg('Please, close the application before closing Discover.' ,mtError, [mbOk], 0);
    CanClose := false
  end else
    CanClose := True;
end ;


(************************)
(* TFormMain.FormCreate *)
(************************)

procedure TFormMain.FormCreate(Sender: TObject);
  var
    i, j : integer;

begin
  SortedRoutines := TSortedRoutines.Create;
  SortedRoutines.Duplicates := true;
  SortedUnits := TSortedUnits.Create;
  CoveredBitMap := TBitMap.Create;
  CoveredBitMap.Handle := LoadBitMap(hInstance, 'B_PT_COVERED');

  UnCoveredBitMap := TBitMap.Create;
  UnCoveredBitMap.Handle := LoadBitMap(hInstance, 'B_PT_UNCOVERED');

  EnabledBitMap := TBitMap.Create;
  EnabledBitMap.Handle := LoadBitMap(hInstance, 'B_ENABLED');

  DisabledBitMap := TBitmap.Create;
  DisabledBitMap.Handle := LoadBitMap(hInstance, 'B_DISABLED');

  LockShutBitMap := TBitMap.Create;
  LockShutBitmap.Handle := LoadBitMap(hInstance, 'B_LOCKSHUT');

  SendMessage(LBFile.Handle, LB_SETHORIZONTALEXTENT, Screen.Width, 0);
  Application.Title := ApplicationName;
  Application.ShowHint := true;
  Application.HookMainWindow(MainHook);
  Application.OnMessage := HandleMessage;
  Application.OnActivate := HandleApplActivate;
  Application.OnDeactivate := HandleApplDeActivate;
  Application.OnIdle := HandleIdleApplication;
  Application.OnException := HandleExceptions;
  MainWindowHandle_ := Handle;
  Process := TProcess.Create(Self);
  PCLeft.ActivePage := TSSummary;

  PCRight.ActivePage := TSCode;

  Config.GetIntegerArray(Appearence_Key, AppearanceArray);
  {This is driving me NUTS
  if AppearanceArray[0] <> -MaxInt then
    SetBounds(AppearanceArray[0], AppearanceArray[1], AppearanceArray[2], AppearanceArray[3]);
  if AppearanceArray[4] <> -MaxInt then
    PNLLeft.Width := AppearanceArray[4]; }

  j := 5;
  
  with HCRoutines.Sections do
    for i := 0 to pred(Count) do begin
      if AppearanceArray[j] <> -MaxInt then
        Items[i].Width := AppearanceArray[j];
      inc(j);
    end ;

  with HCUnits.Sections do
    for i := 0 to pred(Count) do begin
      if AppearanceArray[j] <> -MaxInt then
        Items[i].Width := AppearanceArray[j];
      inc(j);
    end ;

  CaptureBitmapStream := TMemoryStream.Create;
  OpenLibDialog.Filter := '*'+LibraryExtension+'|*'+LibraryExtension;
  SaveLibDialog.Filter := '*'+LibraryExtension+'|*'+LibraryExtension;
  OpenStateDialog.Filter := '*'+ProjectStateExtension+'|*'+ProjectStateExtension;
  ProjectInfo := TProjectInfo.Create;
end ;


(*************************)
(* TFormMain.FormDestroy *)
(*************************)

procedure TFormMain.FormDestroy(Sender: TObject);
  var
    i, j : integer;
begin
  SortedRoutines.DeleteAll;
  SortedRoutines.Free;
  SortedUnits.DeleteAll;
  SortedUnits.Free;
  CoveredBitMap.Free;
  UnCoveredBitMap.Free;
  EnabledBitMap.Free;
  DisabledBitMap.Free;
  LockShutBitMap.Free;
  AppearanceArray[0] := Left;
  AppearanceArray[1] := Top;
  AppearanceArray[2] := Width;
  AppearanceArray[3] := Height;
  AppearanceArray[4] := PNLLeft.Width;
  j := 5;
  with HCRoutines.Sections do
    for i := 0 to pred(Count) do begin
      AppearanceArray[j] := Items[i].Width;
      inc(j);
    end ;
  with HCUnits.Sections do
    for i := 0 to pred(Count) do begin
      AppearanceArray[j] := Items[i].Width;
      inc(j);
    end ;
  Config.SetIntegerArray(Appearence_Key, AppearanceArray);
  CaptureBitmapStream.Free;
  ProjectInfo.Free;

  Application.OnMessage := nil;
  Application.OnActivate := nil;
  Application.OnDeactivate := nil;
  Application.OnIdle := nil;
  Application.OnException := nil;
end ;


(************************)
(* TFormMain.FormResize *)
(************************)

procedure TFormMain.FormResize(Sender: TObject);
begin
  AdjustStatusbar;
  Resizing := true;
  if not TIMERResize.Enabled then
    TIMERResize.Enabled := true;
end ;


(***********************************)
(* TFormMain.GotoNextCoveragePoint *)
(***********************************)

function TFormMain.ReadExeFileName: string;
begin
  result := ProjectDataBase_.ModuleFileName
end;

procedure TFormMain.GotoNextCoveragePoint(RedGreen: boolean);
  var
    n : integer;
    C : TCoveragePoint;

  function NextGreenCoveragePoint : TCoveragePoint;
  begin
    Result := nil;
    while (n < LBFile.Items.Count) do begin
      Result := TCoveragePoint(LBFile.Items.Objects[n]);
      if (Result <> nil) and (Result.Valid) and
        (((Result.Counter = 0) and (RedGreen) ) or ((Result.Counter <> 0) and (not RedGreen))) then
        break;
      inc(n);
    end ;
  end ;

begin
  n := LBFile.ItemIndex;
  if n >= 0 then begin
    inc(n);
    C := NextGreenCoveragePoint;
    if C <> nil then begin
      LBFile.ItemIndex := n;
      LBFile.TopIndex := n - 10;
      DisplayStatusFilename;
      PositionRoutineViewToPoint(C);
    end ;
  end ;
end ;


(********************************)
(* TFormMain.HandleApplActivate *)
(********************************)

procedure TFormMain.HandleApplActivate;
begin
  if (ProjectDataBase_ <> nil) and (ProjectDataBase_.ChangedCount <> LastChangedCount) then
    UpdateOnActivate;
end ;


(**********************************)
(* TFormMain.HandleApplDeActivate *)
(**********************************)

procedure TFormMain.HandleApplDeActivate;
begin
  if (ProjectDataBase_ <> nil) then begin
    LastChangedCount := ProjectDataBase_.ChangedCount;
    DeltaCovered := 0;
    UpdateCoverageOnStatusBar;
  end ;
end ;


(*****************************)
(* TFormMain.HandleErrorCode *)
(*****************************)

procedure TFormMain.HandleErrorCode(ErrorCode, Address : integer);
  var
    s : string;
begin
  s := Format('Cannot access process at %s. GetLastError=%d, "%s"' ,
   [IntToHex(Address,8), ErrorCode, SysErrorMessage(ErrorCode)]);;
  if LogFileEnabled_ then
    Writeln(LogFile_, s);
end ;


(******************************)
(* TFormMain.HandleExceptions *)
(******************************)

procedure TFormMain.HandleExceptions(Sender: TObject; E: Exception);
begin
  Application.Restore;
  MessageDlg(E.Message, mtError, [mbOk], 0); 
end ;


(***********************************)
(* TFormMain.HandleIdleApplication *)
(***********************************)

procedure TFormMain.HandleIdleApplication;
begin
  if not InitialScreenDone then begin
    InitialScreenDone := true;
  end ;

  // Do we have an autorun
  if CommandLineActionEnabled_ then begin
    CommandLineActionEnabled_ := false;
    DoCommandLineInitialActions;
  end ;
end ;


(********************************)
(* TFormMain.HandleJournalEvent *)
(********************************)

procedure TFormMain.HandleJournalEvent;

  procedure DefaultHandling;
  begin
    case Event of
      jeTimerElapsed:;

      jeProcessJustTerminated: begin
        if (WindowState <> wsMinimized) or not CommandLineParams_.RunMinimized then
          Application.Restore;
        StateMachineState := stIdle;
      end;

      jeApplRestored: begin
        Application.Restore;
        CommandLineParams_.Action := caNoAction;
        StateMachineState := stIdle;
      end;

      jeWMCancelJournal,  jeCtrlBreak,
         jeDebugString: begin
        StateMachineState := stIdle;
        Application.Restore;
      end;
    end 
  end ;

  procedure StateIdle;
  begin
    case Event of

      jePlayStream: begin
      end;

      jePlayStreamsToPlay: begin
      end;

      jePlayNodesToPlay: begin
      end;

      jeRecord, jeRecordContinue: begin
      end;
    else 
      DefaultHandling;
    end ;
  end ;

  procedure StateWaitForProcessRunning;
  begin
    case Event of

      jeProcessJustRunning: begin
        // We wait again for the process to be really ready to accept input
        StateMachineState := stWaitForProcessReadyForPlaying;
      end;

      jeTimerElapsed: begin
        // The process doesn't run, complain
        StateMachineState := stIdle;
        raise Exception.Create('The application will not run')
      end;

      jeApplrestored:
        // ignore it...

    else
      DefaultHandling;
    end ;
  end;

  procedure StateWaitForProcessReadyForPlaying;
  begin
    case Event of
      jeTimerElapsed: begin
        StateMachineState := stIdle;
        HandleJournalEvent(jePlayStream);
      end;

      jeApplRestored:
        // Just ignore it
    else
      DefaultHandling;
    end ;
  end;

begin
  if LogFileEnabled_ then begin
    WriteLn(LogFile_, Format('%d Event=%s, in state=%s',
     [GetTickCount, JournalEventString[Event],
     StateMachineStrings[StateMachineState]
     ]));
  end ;
  case StateMachineState of
    stIdle:
      StateIdle;
    stWaitForProcessRunning:
      StateWaitForProcessRunning;
  end ;
end ;


(***************************)
(* TFormMain.HandleMessage *)
(***************************)

procedure TFormMain.HandleMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.Message = WM_CANCELJOURNAL then
    HandleJournalEvent(jeWMCancelJournal);
end ;


(********************************)
(* TFormMain.HandlePointCovered *)
(********************************)

procedure TFormMain.HandlePointCovered(Point : TCoveragePoint);
  var
    R : TRoutine;
begin
  with ProjectDataBase_ do begin
    SetCovered(Point);
    R := Routines.At(Point.RoutineIndex);
    UpdateOverView(R);
    UpdateFileLine(Point);
    inc(DeltaCovered);
    UpdateCoverageOnStatusBar;
  end ;
 end ;


(**************************************)
(* TFormMain.HandleProcessDebugString *)
(**************************************)

procedure TFormMain.HandleProcessDebugString;
begin
  HandleJournalEvent(jeWMCancelJournal);
  if LogFileEnabled_ then
    Writeln(LogFile_, Format('Debug string received: "%s"',[DebugString]));
  // MessageDlg(Format('Debug string received: "%s"',[DebugString]), mtWarning, [mbOk], 0);
end ;


(**********************************)
(* TFormMain.HandleProcessRunning *)
(**********************************)

procedure TFormMain.HandleProcessRunning;
begin
  HandleJournalEvent(jeProcessJustRunning);
  StatusBar.Panels[pProcessState].Text := 'Running';
end ;


(*************************************)
(* TFormMain.HandleProcessTerminated *)
(*************************************)

procedure TFormMain.HandleProcessTerminated;
begin
  HandleJournalEvent(jeProcessJustTerminated);
  StatusBar.Panels[pProcessState].Text := '';
  MMApplicationTerminate.Enabled := false;
  UpdateOnActivate;
  Timer1.Enabled := true;
end ;


(****************************)
(* TFormMain.HandleProgress *)
(****************************)

procedure TFormMain.HandleProgress(Percent : integer; const ActionString : string);
  var
    s : string;
begin
  if PerCent <> PrevPerCent then begin
    if ActionString <> '' then
      s := Format('%s (%d%s)',[ActionString, PerCent,'%'])
    else
      s := '';
    Statusbar.Panels[pProgress].Text := s;
    Statusbar.Refresh;
    PRevPerCent := PerCent;
  end ;
end ;


(******************************)
(* TFormMain.HCRoutinesResize *)
(******************************)

procedure TFormMain.HCRoutinesResize(Sender: TObject);
begin
  LBRoutines.Refresh;
end ;


(************************************)
(* TFormMain.HCRoutinesSectionClick *)
(************************************)

procedure TFormMain.HCRoutinesSectionClick(
  HeaderControl: THeaderControl; Section: THeaderSection);
begin
  case Section.Index of
    0: begin
      if SortedRoutines.Mode = srByName then
        SortedRoutines.Inverted := not SortedRoutines.Inverted
      else begin
        SortedRoutines.Mode := srByName;
        SortedRoutines.Inverted := false;
      end ;
    end;

    1: begin
      if SortedRoutines.Mode = srByUnit then
        SortedRoutines.Inverted := not SortedRoutines.Inverted
      else begin
        SortedRoutines.Mode := srByUnit;
        SortedRoutines.Inverted := false;
      end ;
    end;

    2: begin
      if SortedRoutines.Mode = srByPoints then
        SortedRoutines.Inverted := not SortedRoutines.Inverted
      else begin
        SortedRoutines.Mode := srByPoints;
        SortedRoutines.Inverted := false;
      end ;
    end;

    3: begin
      if SortedRoutines.Mode = srByCoverage then
        SortedRoutines.Inverted := not SortedRoutines.Inverted
      else begin
        SortedRoutines.Mode := srByCoverage;
        SortedRoutines.Inverted := false;
      end ;
    end;
  end ;
  Screen.Cursor := crHourGlass;
  try
    FillSortedRoutineList;
    FillLBRoutines;
    PBOverViewPaint(PBOverView);
  finally
    Screen.Cursor := crDefault;
  end ;
end ;


(****************************)
(* TFormMain.HCSectionTrack *)
(****************************)

procedure TFormMain.HCSectionTrack(
  HeaderControl: THeaderControl; Section: THeaderSection; Width: Integer;
  State: TSectionTrackState);

  var
    H : PHeaderTrackingInfo;
    LB : TListBox;

  procedure DrawTrackingRect(Draw : boolean);
    var
      P : TPoint;
    begin
      if Draw then begin
        with LB, Canvas, H^, TrackingRect do begin
          GetCursorPos(P);
          P := ScreenToClient(P);
          Left := P.X;
          Right := succ(Left);
          Top := 0;
          Bottom := ClientRect.Bottom;
          InvertRect(Handle, TrackingRect);
        end ;
      end else
        InvertRect(LB.Canvas.Handle, H.TrackingRect);
      H.TrackingRectDrawn := Draw;
  end ;

begin
  if HeaderControl = HCRoutines then begin
    H := @HeaderRoutinesInfo;
    LB := LBRoutines;
  end else begin
    H := @HeaderUnitsInfo;
    LB := LBUnits;
  end ;
  case State of
    tsTrackBegin:
      DrawTrackingRect(true);
    tsTrackEnd: begin
      DrawTrackingRect(false);
      InvalidateRect(LB.Handle, nil, true);
    end;
    tsTrackMove: begin
      DrawTrackingRect(false);
      DrawTrackingRect(true);
    end;
  end ;
end ;


(*********************************)
(* TFormMain.HCUnitsSectionClick *)
(*********************************)

procedure TFormMain.HCUnitsSectionClick(HeaderControl: THeaderControl;
  Section: THeaderSection);
begin
  case Section.Index of
    0: begin
      if SortedUnits.Mode = suByName then
        SortedUnits.Inverted := not SortedUnits.Inverted
      else begin
        SortedUnits.Mode := suByName;
        SortedUnits.Inverted := false;
      end ;
    end;

    1: begin
      if SortedUnits.Mode = suBySize then
        SortedUnits.Inverted := not SortedUnits.Inverted
      else begin
        SortedUnits.Mode := suBySize;
        SortedUnits.Inverted := false;
      end ;
    end;

    2: begin
      if SortedUnits.Mode = suByRQty then
        SortedUnits.Inverted := not SortedUnits.Inverted
      else begin
        SortedUnits.Mode := suByRQty;
        SortedUnits.Inverted := false;
      end ;
    end;

    3: begin
      if SortedUnits.Mode = suByR0Pc then
        SortedUnits.Inverted := not SortedUnits.Inverted
      else begin
        SortedUnits.Mode := suByR0Pc;
        SortedUnits.Inverted := false;
      end ;
    end;

    4: begin
      if SortedUnits.Mode = suByR100Pc then
        SortedUnits.Inverted := not SortedUnits.Inverted
      else begin
        SortedUnits.Mode := suByR100Pc;
        SortedUnits.Inverted := false;
      end ;
    end;

    5: begin
      if SortedUnits.Mode = suByCoverage then
        SortedUnits.Inverted := not SortedUnits.Inverted
      else begin
        SortedUnits.Mode := suByCoverage;
        SortedUnits.Inverted := false;
      end ;
    end;
  end ;
  Screen.Cursor := crHourGlass;
  try
    FillSortedUnitList;
    FillLBUnits;
  finally
    Screen.Cursor := crDefault;
  end ;
end ;


(**********************************)
(* TFormMain.HCUnitsSectionResize *)
(**********************************)

procedure TFormMain.HCUnitsSectionResize(HeaderControl: THeaderControl;
  Section: THeaderSection);
begin
  LBUnits.Refresh;
end ;


(**************************************)
(* TFormMain.InitAfterLoadingDatabase *)
(**************************************)

procedure TFormMain.InitAfterLoadingDatabase;
begin
  StatusBar.Panels[pFilePos].Text := 'Initializing data';
  try
    ProjectDatabase_.InitStatistics;
    SortedRoutines.Mode := srByName;
    FillSortedRoutineList;
    SortedUnits.Mode := suByName;
    CurrentSourceFileName := '';
    FillSortedUnitList;

    FillLBRoutines;
    FillLBUnits;
    LBFile.Clear;

    // Set the active pages
    PCLeft.ActivePage := TSSummary;
    // PCRight.ActivePage := TSCode;

    PBOverViewPaint(PBOverView);

    if ProjectDataBase_.ModuleFileName <> '' then
      Caption := Format('%s - %s',[ApplicationName, ProjectDataBase_.ModuleFileName])
    else
      Caption := ApplicationName;

    Application.Title := Caption;
    FillSummary;
    DeltaCovered := 0;
    UpdateCoverageOnStatusBar;
    
    if ProjectDataBase_.Routines.Count < 1000 then
      OverviewPointSquareSide := 8
    else
      OverviewPointSquareSide := 5;
  finally
    StatusBar.Panels[pFilePos].Text := '';
  end ;
end ;


(*************************)
(* TFormMain.LBFileClick *)
(*************************)

procedure TFormMain.LBFileClick(Sender: TObject);
  var
    C : TCoveragePoint;
begin
  // Align the routine list with the selected line
  with LBFile do
    if LBRoutines.Visible and (ItemIndex >= 0) then begin
      C := TCoveragePoint(Items.Objects[ItemIndex]);
      PositionRoutineViewToPoint(C);
    end ;
  DisplayStatusFilename;
end ;


(****************************)
(* TFormMain.LBFileDrawItem *)
(****************************)

procedure TFormMain.LBFileDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
  const
    HOffset = 20;
    MarkSide = 16;
  var
    C : TCoveragePoint;
    R1, R2 : TRect;

  function ExpandTabs(const s : string) : string;
    var
      i,j : integer;
  begin
    Setlength(Result,length(s));
    Result := '';
    i := 1;
    while i <= Length(s) do begin
      if s[i] = TAB then begin
        j := 8*succ(length(Result) div 8);
        while Length(Result) < j do
          Result := Result + ' ';
      end else
        Result := Result + s[i];
      inc(i);
    end ;
  end ;

begin
  with Control as TListBox, Canvas do
    begin
      if odFocused in State then
        DrawFocusRect(Rect);

      if odSelected in State then
        Brush.Color := clHighLight
      else
        Brush.Color := clWindow;

      FillRect(Rect);
      C :=  TCoveragePoint(Items.Objects[Index]);

      if (C <> nil) and C.Valid then
        begin
          with R1 do
            begin
              Left := (HOffset - MarkSide) div 2;
              Right := Left + MarkSide;
              Top := Rect.Top + (ItemHeight - MarkSide) div 2;
              Bottom := Top + MarkSide;
            end ;

          with R2 do
            begin
              Top := 0;
              Left := 0;
              Right := MarkSide;
              Bottom := MarkSide;
            end ;

          if C.Counter > 0 then
            BrushCopy(R1, CoveredBitMap, R2, clWhite)
          else
            BrushCopy(R1, UncoveredBitMap, R2, clWhite);
        end
      else
        Font.Color := MergeColor(Font.Color, clWhite, 50);

      TextOut(Rect.Left+HOffset, Rect.Top, ExpandTabs(Items[Index]));
    end ;
end ;


(****************************)
(* TFormMain.LBFileKeyPress *)
(****************************)

procedure TFormMain.LBFileKeyPress(Sender: TObject; var Key: Char);

begin
  case Key of
    #7:
      GotoNextCoveragePoint(false);
    #18:
      GotoNextCoveragePoint(true);
  else
  end ;
end ;


(*****************************)
(* TFormMain.LBFileMouseDown *)
(*****************************)

procedure TFormMain.LBFileMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbRight) then begin;
    if LBFile.ItemIndex = - 1 then
      LBFile.ItemIndex := LBFile.ItemAtPos(Point(X, Y), True);
  end ;
end ;


(*****************************)
(* TFormMain.LBRoutinesClick *)
(*****************************)

procedure TFormMain.LBRoutinesClick(Sender: TObject);
  var
    C : TCoveragePoint;
    S : TStringList;
    R : TRoutine;
    i, LineNr, PointIndex, RoutineIndex : integer;
begin
  if LBRoutines.ItemIndex >= 0 then
    CurrentRoutine := SortedRoutines.At(LBRoutines.ItemIndex);
    CurrentUnit := ProjectDataBase_.Units.At(CurrentRoutine.UnitIndex);
    // Update LBFile
    if (CurrentRoutine.FileIndex >= 0) and (CurrentSourceFileName <> CurrentUnit.FileNames[CurrentRoutine.FileIndex]) then begin
      CurrentSourceFileName := ProjectDataBase_.RelativePath + CurrentUnit.FileNames[CurrentRoutine.FileIndex];
      S := TStringList.Create;
      Screen.Cursor := crHourGlass;
      try
        S.LoadFromFile(CurrentSourceFileName);
        RoutineIndex := CurrentUnit.FirstRoutineIndex;
        R := ProjectDataBase_.Routines.At(RoutineIndex);
        // Move until the first routine in this file
        while (R.FileIndex <> CurrentRoutine.FileIndex) and
          (RoutineIndex < ProjectDataBase_.Routines.Count) do begin
          inc(RoutineIndex);
          if RoutineIndex < ProjectDataBase_.Routines.Count then
            R := ProjectDataBase_.Routines.At(RoutineIndex);
        end ;
        PointIndex := R.FirstPointIndex;
        if PointIndex >= 0 then
          C := ProjectDataBase_.CoveragePoints.At(PointIndex)
        else
          // Must be a finalization routine without explicit code
          C := nil;
        LBFile.Items.BeginUpdate;
        LBFile.Clear;
        // Scan all file lines
        with S do
          for i := 0 to pred(Count) do begin
            LineNr := succ(i);
            if (C <> nil) and (LineNr = C.LineNumber) then begin
              LBFile.Items.AddObject(S[i], C);
              C := nil;
              inc(PointIndex);
              if PointIndex < ProjectDataBase_.CoveragePoints.Count then
                C := ProjectDataBase_.CoveragePoints.At(PointIndex);
            end else
              LBFile.Items.AddObject(S[i],nil)
          end ;
        LBFile.Items.EndUpdate;
      finally
        S.Free;
        Screen.Cursor := crDefault;
      end ;
    end ;
    // Scroll into position
    if CurrentRoutine.FileIndex >= 0 then begin
      C := ProjectDataBase_.CoveragePoints.At(CurrentRoutine.FirstPointIndex);
      SendMessage(LBFile.Handle, LB_SETTOPINDEX, C.LineNumber-10, 0);
      LBFile.ItemIndex := pred(C.LineNumber);
      DisplayStatusFilename;
      // Set LBUnit item index
      LBUnits.TopIndex := SortedUnits.IndexOf(CurrentUnit);
    end ;
end ;


(********************************)
(* TFormMain.LBRoutinesDrawItem *)
(********************************)

procedure TFormMain.LBRoutinesDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
  var
    Routine, PreviousRoutine, NextRoutine : TRoutine;
    R : TRect;
    U : TUnit;
    x : single;
    s : string;
    p, q : integer;
begin
  with (Control as TListBox), Canvas do
    begin
      Routine := SortedRoutines.At(Index);
    
      if Index > 0 then
        PreviousRoutine := SortedRoutines.At(pred(Index))
      else
        PreviousRoutine := nil;

      U := ProjectDataBase_.Units.At(Routine.UnitIndex);

      if odSelected in State then
        begin
          Brush.Color := clHighLight;
          Font.Color := clHighLightText;
        end
      else
        begin
          Brush.Color := clWindow;
          Font.Color := clWindowText;
        end ;

      FillRect(Rect);

      Font.Color := MergeColor(clRed, clGreen, trunc(100.0*(Routine.CoveredPointsQty / Routine.ValidPointsQty)));

      if odSelected in State then
        Font.Color := MergeColor(Font.Color, clWhite, 80);

      if Routine.Disabled then
        Font.Color := clGrayText;

      with R do
        begin
          Top := Rect.Top;
          Bottom := Rect.Bottom;
          Left := HCRoutines.Sections[0].Left + 5;
          Right := HCRoutines.Sections[0].Right;
        end ;

      FillRect(R);

      s := Routine.Name;
      
      if PreviousRoutine <> nil then
        begin
          Pen.Color := MergeColor(Font.Color, clWhite, 60);

          p := Pos('.', PreviousRoutine.Name);
          q := Pos('.', Routine.Name);

          if (p <> 0) and (q <> 0) and (p = q) and
            (Copy(PreviousRoutine.Name, 1,p)=Copy(Routine.Name,1,p)) then
            begin
              R.Left := R.Left + 13;

              if Index < SortedRoutines.Count - 1 then
                begin
                  NextRoutine := SortedRoutines.At(Index + 1);
                  p := Pos('.', Routine.Name);
                  q := Pos('.', NextRoutine.Name);

                  if (p <> 0) and (q <> 0) and (p = q) and
                    (Copy(Routine.Name, 1,p)=Copy(NextRoutine.Name,1,p)) then
                    begin
                      Canvas.MoveTo(7, R.Top);
                      Canvas.LineTo(7, R.Bottom);
                      Canvas.MoveTo(7, R.Top + ((R.Bottom - R.Top) div 2));
                      Canvas.LineTo(17, R.Top + ((R.Bottom - R.Top) div 2));
                    end
                  else
                    begin
                      Canvas.MoveTo(7, R.Top);
                      Canvas.LineTo(7, R.Top + ((R.Bottom - R.Top) div 2));
                      Canvas.LineTo(17, R.Top + ((R.Bottom - R.Top) div 2));
                    end;
                end
              else
                begin
                  Canvas.MoveTo(7, R.Top);
                  Canvas.LineTo(7, R.Top + ((R.Bottom - R.Top) div 2));
                  Canvas.LineTo(17, R.Top + ((R.Bottom - R.Top) div 2));
                end;
            end;
        end ;

      DrawStringInColumn(Canvas, R, s, false);

      with R do
        begin
          Left := HCRoutines.Sections[1].Left;
          Right := HCRoutines.Sections[1].Right;
        end ;

      DrawStringInColumn(Canvas, R, U.Name, false);

      with R do
        begin
          Left := HCRoutines.Sections[2].Left;
          Right := HCRoutines.Sections[2].Right;
        end ;

      DrawStringInColumn(Canvas, R, IntToStr(Routine.ValidPointsQty), true);

      with R do
        begin
          Left := HCRoutines.Sections[3].Left;
          Right := HCRoutines.Sections[3].Right;
        end ;

      if Routine.ValidPointsQty = 0 then
        s := '?'
      else
        begin
          x := Routine.CoveredPointsQty;
          x := 100.0*(x / Routine.ValidPointsQty);
          s := Format('%3.0f',[x])+'%';
        end ;
      
      DrawStringInColumn(Canvas, R, s, true);
    end ;
end ;


(********************************)
(* TFormMain.LBRoutinesKeyPress *)
(********************************)

procedure TFormMain.LBRoutinesKeyPress(Sender: TObject; var Key: Char);
  var
    R : TRoutine;
    i : integer;
    FormEdit : TFormEdit;
begin
  if not (Key in ['a'..'z', 'A'..'Z','_']) then begin
    case Key of
      #2: // Ctrl-B
        PURoutinesEnableDisableClick(PURoutinesDisable);
      #6: // Ctrl-F
        PURoutinesEnableDisableClick(PURoutinesEnable);
    else
    end ;
  end else begin
    FormEdit := TFormEdit.Create(Self);
    try
      // Position the list box to the required routines
      if Key in ['a'..'z', 'A'..'Z','_'] then
        FormEdit.Edit1.Text := Key
      else
        FormEdit.Edit1.Text := '';
      if FormEdit.ShowModal = mrOk then begin
        R := TRoutine.Create;
        try
          R.Name := FormEdit.Edit1.Text;
          SortedRoutines.Search(R,i);
          LBRoutines.ItemIndex := i;
        finally
          R.Free;
        end ;
      end ;
    finally
      FormEdit.Free;
    end ;
  end ;
end ;


(*********************************)
(* TFormMain.LBRoutinesMouseDown *)
(*********************************)

procedure TFormMain.LBRoutinesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    i : integer;
begin
  if Button = mbRight then begin
    i := LBRoutines.ItemAtPos(Point(x,y), true);
    if i >= 0 then begin
      LBRoutines.ItemIndex := i;
      LBRoutinesClick(LBRoutines);
    end ;
  end ;
end ;


(**************************)
(* TFormMain.LBUnitsClick *)
(**************************)

procedure TFormMain.LBUnitsClick(Sender: TObject);
  var
    S : TStringList;
    RoutineIndex, PointIndex, i, LineNr : integer;
    R : TRoutine;
    C : TCoveragePoint;
begin
  if LBUnits.Items.Count = 0 then
    exit;

  if LBUnits.ItemIndex >= 0 then
    CurrentUnit := LBUnits.Items.Objects[LBUnits.ItemIndex] as TUnit;

  // Update LBFile
  if (CurrentUnit.FileNames.Count > 0) then begin
    CurrentSourceFileName := ProjectDataBase_.RelativePath + CurrentUnit.FileNames[0];
    S := TStringList.Create;
    Screen.Cursor := crHourGlass;
    try
      S.LoadFromFile(CurrentSourceFileName);
      RoutineIndex := CurrentUnit.FirstRoutineIndex;
      R := ProjectDataBase_.Routines.At(RoutineIndex);
      PointIndex := R.FirstPointIndex;
      if PointIndex >= 0 then
        C := ProjectDataBase_.CoveragePoints.At(PointIndex)
      else
        // Must be a finalization routine without explicit code
        C := nil;
      LBFile.Items.BeginUpdate;
      LBFile.Clear;
      // Scan all file lines
      with S do
        for i := 0 to pred(Count) do begin
          LineNr := succ(i);
          if (C <> nil) and (LineNr = C.LineNumber) then begin
            LBFile.Items.AddObject(S[i], C);
            C := nil;
            inc(PointIndex);
            if PointIndex < ProjectDataBase_.CoveragePoints.Count then
              C := ProjectDataBase_.CoveragePoints.At(PointIndex);
          end else
            LBFile.Items.AddObject(S[i],nil)
        end ;
      LBFile.Items.EndUpdate;
    finally
      S.Free;
      Screen.Cursor := crDefault;
      DisplayStatusFilename;
    end ;
  end ;
end ;


(*****************************)
(* TFormMain.LBUnitsDrawItem *)
(*****************************)

procedure TFormMain.LBUnitsDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
  var
    U : TUnit;
    R : TRect;
    s : string;
    x : single;

  procedure DrawCheckBox(const R : TRect; Canvas : TCanvas);
    var
      CheckBoxRect, BitMapRect : TRect;
      B : TBitmap;
  begin
    with Canvas do begin
      if not U.IsSourceAvailable then
        B := LockShutBitMap
      else if U.Disabled then
        B := DisabledBitMap
      else
        B := EnabledBitMap;
      with CheckBoxRect do begin
        Left := R.Left + 2;
        Top := R.Top;
        Right := Left + B.Width;
        Bottom := Top + B.Height;
      end ;
      with BitMapRect do begin
        Left := 0;
        Top := 0;
        Right := B.Width;
        Bottom := B.Height;
      end ;
      BrushCopy(CheckBoxRect, B, BitMapRect, clOlive);
    end ;
  end ;

begin
  with (Control as TListBox), Canvas do begin
    Brush.Style := bsSolid;

    if odSelected in State then
      Brush.Color := clHighLight
    else
      Brush.Color := clWindow;

    FillRect(Rect);
    U := SortedUnits.At(Index);

    Font.Color := MergeColor(clRed, clGreen, trunc(100.0*(U.CoveredPointsQty / U.ValidPointsQty)));

    if odSelected in State then
      Font.Color := MergeColor(Font.Color, clWhite, 80);

    with R do
      begin
        Top := Rect.Top;
        Bottom := Rect.Bottom;
        Left := HCUnits.Sections[0].Left;
        Right := HCUnits.Sections[0].Right;
      end ;
      
    DrawCheckBox(R, Canvas);
    inc(R.Left, EnabledBitMap.Width+4);

    if U.Disabled then
      Pen.Color := clGrayText;

    DrawStringInColumn(Canvas, R, U.Name, false);

    with R do
      begin
        Left := HCUnits.Sections[1].Left;
        Right := HCUnits.Sections[1].Right;
      end ;
      
    DrawStringInColumn(Canvas, R, IntToStr(U.Size), true);

    with R do
      begin
        Left := HCUnits.Sections[2].Left;
        Right := HCUnits.Sections[2].Right;
      end ;
      
    DrawStringInColumn(Canvas, R, IntToStr(U.RoutinesQty), true);

    if U.IsSourceAvailable then
      begin
        with R do
          begin
            Left := HCUnits.Sections[3].Left;
            Right := HCUnits.Sections[3].Right;
          end
          ;
        DrawStringInColumn(Canvas, R, IntToStr(U.R0Pc), true);

        with R do
          begin
            Left := HCUnits.Sections[4].Left;
            Right := HCUnits.Sections[4].Right;
          end ;
          
        DrawStringInColumn(Canvas, R, IntToStr(U.R100Pc), true);

        with R do
          begin
            Left := HCUnits.Sections[5].Left;
            Right := HCUnits.Sections[5].Right;
          end ;
          
        if U.ValidPointsQty = 0 then
          s := ''
        else
          begin
            x := U.CoveredPointsQty;
            x := 100.0*(x / U.ValidPointsQty);
            s := Format('%3.0f',[x])+'%';
          end ;
          
        DrawStringInColumn(Canvas, R, s, true);
      end ;
  end ;
end ;


(*****************************)
(* TFormMain.LBUnitsKeyPress *)
(*****************************)

procedure TFormMain.LBUnitsKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['a'..'z', 'A'..'Z', '0'..'9', '_', ' ', char(VK_RETURN), char(VK_BACK), char(VK_ESCAPE)]) then
    begin
      case Key of
        #1: // Ctrl-A
          PUUnitsSelectAllClick(Sender);
        #2: // Ctrl-B
          PUUnitsEnableDisableClick(PUUnitsDisable);
        #6: // Ctrl-F
          PUUnitsEnableDisableClick(PUUnitsEnable);
        #4: // Ctrl-f
          PUUnitsSelectGroupClick(LBUnits);
      end ;
    end
  else
    begin
      if Key in ['a'..'z', 'A'..'Z', '0'..'9', '_', ' ', char(VK_BACK)] then
        begin
          if not SearchPane.Visible then
            begin
              edtUnitSearch.Clear;
              SearchPane.Show;
            end;
            
          if Key <> char(VK_BACK) then
            edtUnitSearch.Text := edtUnitSearch.Text + Key
          else
            edtUnitSearch.Text := Copy(edtUnitSearch.Text, 0, Length(edtUnitSearch.Text) - 1);

          if Length(edtUnitSearch.Text) > 0 then
            FillSortedFilteredUnitList
          else
            FillSortedUnitList;
            
          FillLBUnits;

          if LBUnits.Items.Count > 0 then
            LBUnits.ItemIndex := 0
          else
            LBUnits.ItemIndex := -1;
        end
      else
        begin
          SearchPane.Hide;
          FillSortedUnitList;            
          FillLBUnits;
        end;
    end ;
end ;


(*********************************)
(* TFormMain.LoadInformationFile *)
(*********************************)

procedure TFormMain.LoadInformationFile;
  var
    U : TUnit;
    R : TRoutine;
    i : integer;
begin
  if not FileExists(InfoFileName) then
    exit;
  ProjectInfo.LoadFromFile(InfoFileName);
  FormProjectInfo.EDITRunParameters.Text := ProjectDataBase_.RunParameters;
  FormProjectInfo.EDITStartupDirectory.Text := ProjectDataBase_.StartupDirectory;
  FormProjectInfo.CHKRunMaximized.Checked := ProjectDataBase_.RunMaximized;
  for i := 0 to pred(ProjectInfo.BackGndUnits.Count) do begin
    U := ProjectDataBase_.Units.AtName(ProjectInfo.BackGndUnits[i]);
    if U <> nil then
      ProjectDataBase_.EnableDisableUnit(U, false);
  end ;
  for i := 0 to pred(ProjectInfo.BackGndRoutines.Count) do begin
    R := ProjectDataBase_.Routines.AtName(ProjectInfo.BackGndRoutines[i]);
    if R <> nil then
      ProjectDataBase_.EnableDisableRoutine(R, false);
  end ;
end ;


(********************************)
(* TFormMain.LoadLastSavedState *)
(********************************)

procedure TFormMain.LoadLastSavedState;
  var
    I : TIniFile;
    FileName : string;
begin
  I := TIniFile.Create(PrivateProfileFileName_);
  try
    FileName := I.ReadString(ProfileSectionStrings[psLastFiles],DefaultState_Key,'');
    if (FileName <> '') and FileExists(FileName) then begin
      LoadState(FileName);
      StateFileName := FileName;
      InfoFileName := ChangeFileExt(StateFileName, ProjectInformationExtension);;
      LoadInformationFile;
    end ;
  finally
    I.Free;
  end ;
end ;


(*************************)
(* TFormMain.LoadProject *)
(*************************)

procedure TFormMain.LoadProject(const DelphiProjectFileName: string);
  var
    ProjectPath : string;
    MapFileName: string;
    IsBDS : boolean;
    s1, s2, s3 : string;
    NotFoundFiles : TStringList;

    // Information taken either in the 'dof' or the 'bdsproj' or the dproj file
    ProjectInfos : record
      OutputDir : string;
      Conditionals : string;
      SearchPath : string;
      ImageBase : integer;
    end;

  procedure BuildSearchPath(s : string);
    var
      p : integer;

    procedure AddPath(Path : string);
      const
        MacroName = '$(DELPHI)';
      var
        s : string;
    begin
      s := ExpandFileName(Path);
      SearchPath_.Add(s);
    end ;

  begin
    SearchPath_.Clear;
    SearchPath_.Add(Copy(ProjectPath, 1, pred(Length(ProjectPath))));
    while s <> '' do begin
      p := Pos(';',s);
      if p > 0 then begin
        AddPath(Copy(s,1, pred(p)));
        s := Copy(s,succ(p),Length(s));
      end else begin
        AddPath(s);
        s := '';
      end ;
    end ;
  end ;

  procedure BuildConditionnals(s : string);
    var
      p : integer;
  begin
    GlobalDefinedConditionnals_.Clear;
    while s <> '' do begin
      p := Pos(';',s);
      if p > 0 then begin
        GlobalDefinedConditionnals_.Add(Copy(s,1,pred(p)));
        s := Copy(s,succ(p),Length(s));
      end else begin
        GlobalDefinedConditionnals_.Add(s);
        s := '';
      end ;
    end ;
  end ;

  procedure FilterOutCovereagePoints;
    var
      Parser : TCodeParser;
  begin
    Parser := TCodeParser.Create;
    Parser.OnProgressEvent := HandleProgress;
    try
      Parser.Parse;
    finally
      Parser.Free;
    end ;
  end ;

  procedure LogDataBase;
  begin
    with TIniFile.Create(PrivateProfileFileName_) do
      try
        if ReadBool('Misc', 'LogDb', false) then begin
          ProjectDataBase_.Units.Print(LogFile_, 0);
          ProjectDataBase_.Routines.Print(LogFile_, 0);
        end ;
      finally
        Free;
      end ;
  end ;

  procedure ShowNotFoundSrcFiles;
   const
     MaxMissingFiles = 5;
    var
      s : string;
      i : integer;
  begin
    if NotFoundFiles.Count > 0 then begin
      s := '';
      i := 0;
      while (i < NotFoundFiles.Count) and (i <= MaxMissingFiles) do begin
       if Length(s) > 0 then
         s := s +CR+LF;
       s := s + NotFoundFiles.Strings[i];
       inc(i);
      end ;

      if NotFoundFiles.Count > MaxMissingFiles then
       s := s + CR + LF +'And more...';

      MessageDlg(Format('The %d file(s):'+CR+LF+'%s'+CR+LF+
       'could not be found on the Delphi project search path.', [NotFoundFiles.Count, s]),
       mtWarning, [mbOk], 0);
    end ;
  end ;

  procedure ExtractFromDof(const FileName : string);
    var
      ProjectOptions : TIniFile;
  begin
    if LogFileEnabled_ then
      Writeln(LogFile_, Format('Option file: %s', [FileName]));
    ProjectOptions := TIniFile.Create(FileName);
    try
      ProjectInfos.OutputDir := ProjectOptions.ReadString('Directories', 'OutputDir', '');
      if ProjectInfos.OutputDir <> '' then
        ProjectInfos.OutputDir := ProjectInfos.OutputDir + '/';
      ProjectInfos.SearchPath := ProjectOptions.ReadString('Directories', 'SearchPath', '');
      ProjectInfos.Conditionals := ProjectOptions.ReadString('Directories', 'Conditionals', '');
      ProjectInfos.ImageBase := ProjectOptions.ReadInteger('Linker', 'ImageBase',0);
    finally
      ProjectOptions.Free;
    end ;
    IsBDS := false;
  end ;

  procedure ExtractFromBdsProj(const FileName : string);
    var
      F : TFileStream;
      s, Dp : string;
      p : integer;

    procedure LogError(const s : string);
    begin
      if LogFileEnabled_ then
        Writeln(LogFile_,s);
      raise Exception.Create(s);
    end ;

    function PosEnd(const Substr, Str : string) : integer;
    begin
      Result := Pos(SubStr, Str);
      if Result > 0 then
        inc(Result, length(SubStr));
    end ;

    function ExtractElement(const From, Element : string) : string;
      var
        b, e : integer;
        s : string;
    begin
      s := Format('<%s>', [Element]);
      b := Pos(s, From);
      if b = 0 then
        LogError(Format('%s not found', [s]));
      Result := Copy(From, b+length(s), Length(From));
      s := Format('</%s>', [Element]);
      e := Pos(s, Result);
      if e = 0 then
        LogError(Format('%s not found', [s]));
      Result := Copy(Result, 1, pred(e));
    end ;

    procedure SetDirElem(const ElemName : string; var Result : string);
      var
        p : integer;
        s : string;
    begin
      Result := '';
      p := PosEnd(Format('<Directories Name="%s">', [ElemName]), Dp);
      if p = 0 then
        exit;

      s := Copy(Dp, p, length(Dp));
      p := Pos('</Directories>', s);
      if p = 0 then
        exit;

      Result := Copy(s, 1, p-1);
    end ;

  begin
    if LogFileEnabled_ then
      Writeln(LogFile_, Format('Option file: %s', [FileName]));
    F := TFileStream.Create(Filename, fmOpenRead);
    try
      SetLength(s, F.Size);
      F.Read(s[1], F.Size);
      Dp := ExtractElement(s, 'Delphi.Personality');

      p := PosEnd('<Linker Name="ImageBase">', Dp);
      if p = 0 then
        LogError('ImageBase');
      s := Copy(Dp, p, length(Dp));
      p := Pos('</Linker>', s);
      if p = 0 then
        LogError('ImageBase');
      ProjectInfos.ImageBase := StrToInt(Copy(s, 1, p-1));

      SetDirElem('OutputDir', ProjectInfos.OutputDir);
      if ProjectInfos.OutputDir <> '' then
        ProjectInfos.OutputDir := ProjectInfos.OutputDir + '/';
      SetDirElem('SearchPath', ProjectInfos.SearchPath);
      SetDirElem('Conditionals', ProjectInfos.Conditionals);

    finally
      F.Free;
    end ;
    IsBDS := true; // Bds map file format
  end ;

  procedure ExtractFromDProj(const FileName : string);
    var
      F : TextFile;
      s, t : string;
      p : integer;
      Done : boolean;
  begin
    if LogFileEnabled_ then
      Writeln(LogFile_, Format('Option file: %s', [FileName]));
    FillChar(ProjectInfos, SizeOf(ProjectInfos), 0);
    ProjectInfos.ImageBase := $400000; // Assume it
    AssignFile(F, FileName);
    Reset(F);
    try
(**)
        // Locate the ''PropertyGroup Condition'' block with Debug
        while not Eof(F) do begin
          Readln(F, s);
          if (Pos('PropertyGroup Condition', s) > 0) and (Pos('Debug', s) > 0) then
            break;
        end ;

(**)
      // Locate one of the required info
      Done := false;
      while (not Eof(F)) and not Done do begin
        Readln(F, s);
        repeat
          // Output Dir
          t := '<DCC_ExeOutput>';
          p := Pos(t, s);
          if p > 0 then begin
            s := Copy(s, p + length(t), length(s));
            p := Pos('<', s);
            ProjectInfos.OutputDir := Copy(s, 1, pred(p));
            break;
          end ;

          // SearchPath
          t := '<DCC_IncludePath>';
          p := Pos(t, s);
          if p > 0 then begin
            s := Copy(s, p + length(t), length(s));
            p := Pos('<', s);
            ProjectInfos.SearchPath := Copy(s, 1, pred(p));
            break;
          end ;

          // Conditionnals
          t := '<DCC_Define>';
          p := Pos(t, s);
          if p > 0 then begin
            s := Copy(s, p + length(t), length(s));
            p := Pos('<', s);
            ProjectInfos.Conditionals := Copy(s, 1, pred(p));
            break;
          end ;

          // Imagebase, if defined
          t := '<DCC_ImageBase>';
          p := Pos(t, s);
          if p > 0 then begin
            s := Copy(s, p + length(t), length(s));
            p := Pos('<', s);
            ProjectInfos.ImageBase := StrToInt('$' + Copy(s, 1, pred(p)));
            break;
          end ;

          // Is that the end of the group
(**)
            Done := Pos('</PropertyGroup>', s) > 0;

(**)
        until true;

      end ;

      if ProjectInfos.OutputDir <> '' then
        ProjectInfos.OutputDir := ProjectInfos.OutputDir + '/';

    finally
      CloseFile(F);
    end ;
    IsBDS := true; // BDS map file format
  end ;

  procedure LogWindowsVersion;
    var
      VersionInfo : TOsVersionInfo;
  begin
    VersionInfo.dwOSVersionInfoSize := SizeOf(VersionInfo);
    if Windows.GetVersionEx(VersionInfo) then begin
      Writeln(LogFile_, Format('Windows version Maj=%d Min=%d, BNr=%d, PId=%d %s ',
        [VersionInfo.dwMajorVersion, VersionInfo.dwMinorVersion,
        VersionInfo.dwBuildNumber, VersionInfo.dwPlatformId, StrPas(VersionInfo.szCSDVersion)]));
    end ;

  end ;

begin 
  if LogFileEnabled_ then
    begin
      Writeln(LogFile_,'-');
      LogWindowsVersion;
      Writeln(LogFile_, Format('Opening project: %s', [DelphiProjectFileName]));
    end ;
  
  ProjectPath := ExpandFileName(ExtractFilePath(DelphiProjectFileName));

  // Locate the option file
  s1 := ChangeFileExt(DelphiProjectFileName, '.bdsproj');
  s2 := ChangeFileExt(DelphiProjectFileName, '.dof');
  s3 := ChangeFileExt(DelphiProjectFileName, '.dproj');

  // Discover takes the dproj file, then the bdsproj file and finally the dof file
  if FileExists(s3) then begin
    ExtractFromDProj(s3)
  end else if FileExists(s1) then begin
    ExtractFromBdsProj(s1);
  end else if FileExists(s2) then begin
    ExtractFromdof(s2)
  end else
    raise Exception.Create(Format('File "%s" or "%s" or "%s" not found.', [s3, s1, s2]));

  if LogFileEnabled_ then begin
    Writeln(LogFile_, Format('  OutputDir=%s', [ProjectInfos.OutputDir]));
    Writeln(LogFile_, Format('  Conditionals=%s', [ProjectInfos.Conditionals]));
    Writeln(LogFile_, Format('  SearchPath=%s', [ProjectInfos.SearchPath]));
    Writeln(LogFile_, Format('  ImageBase=$%s', [IntToHex(ProjectInfos.ImageBase, 8)]));
  end ;

  try
    // Reset the DataBase
    ProjectDataBase_.Free;
    ProjectDataBase_ := TProjectDataBase.Create;
    InitAfterLoadingDatabase;

    if FileExists(ProjectPath + ChangeFileExt(ExtractFileName(DelphiProjectFileName), '.exe')) then
      ProjectDataBase_.ModuleFileName := ProjectPath + ChangeFileExt(ExtractFileName(DelphiProjectFileName), '.exe')
    else
      if FileExists(ProjectPath + ChangeFileExt(ExtractFileName(DelphiProjectFileName), '.dll')) then
        ProjectDataBase_.ModuleFileName := ProjectPath + ChangeFileExt(ExtractFileName(DelphiProjectFileName), '.dll')
      else
        if FileExists(ProjectPath + ChangeFileExt(ExtractFileName(DelphiProjectFileName), '.bpl')) then
          ProjectDataBase_.ModuleFileName := ProjectPath + ChangeFileExt(ExtractFileName(DelphiProjectFileName), '.bpl');

    ProjectDataBase_.ModuleFileCRC := CRC32.FileCRC32(ProjectDataBase_.ModuleFileName);
    ProjectDataBase_.RelativePath := ProjectPath;

    MapFileName := ProjectPath + ChangeFileExt(ExtractFileName(DelphiProjectFileName), '.map');

    if LogFileEnabled_ then
      Writeln(LogFile_, Format('Map file: %s', [MapFileName]));

    GlobalDefinedConditionnals_.Clear;

    BuildSearchPath(ProjectInfos.SearchPath);

    if  FileExists(MapFileName) then
      begin
        StatusBar.Panels[pFilePos].Text := 'Processing map-file';
        NotFoundFiles := TStringList.Create;
        try
          HandleMapFile( MapFileName, HandleProgress, NotFoundFiles, IsBDS, ProjectPath);
          // Don't show these files anymore!
          //ShowNotFoundSrcFiles;
        finally
          NotFoundFiles.Free;
        end ;
      end
    else
      begin
        FreeAndNil(ProjectDataBase_);
        raise Exception.Create(Format('Map file "%s" not found.', [MapFileName]));
      end ;

    // Extract the predefined conditionnals
    if ProjectInfos.Conditionals <> '' then
      BuildConditionnals(ProjectInfos.Conditionals);

    // Get image base
    ProjectDataBase_.ImageBase := ProjectInfos.ImageBase;

    LogDataBase;

    // Filter out the coverage points
    FilterOutCovereagePoints;
    InitAfterLoadingDataBase;

    inc(ProjectDataBase_.ChangedCount); // force dirty
  finally
  end ;
end ;


(***********************)
(* TFormMain.LoadState *)
(***********************)

procedure TFormMain.LoadState(const StateFileName: string);
var
  lFileStream : TFileStream;
  lFileBuffer : TMemoryStream;
  lConfigurations : TIniFile;
begin
  lFileBuffer := TMemoryStream.Create;
  Screen.Cursor := crHourGlass;
  try
    lFileStream := TFileStream.Create(StateFileName, fmOpenRead);
    try
      lFileBuffer.LoadFromStream(lFileStream);
    finally
      lFileStream.Free();
    end;
    
    if LogFileEnabled_ then
      WriteLn(LogFile_, 'Loading state: '+StateFileName);

    StatusBar.Panels[pFilePos].Text := 'Loading state';

    ProjectDataBase_.Free;
    ProjectDataBase_ := TProjectDataBase.Load(lFileBuffer);

    LoadedStatesStr := ExtractFileName(StateFileName);
    InitAfterLoadingDataBase;

    lConfigurations := TIniFile.Create(ChangeFileExt(StateFileName, '.cfg'));
    try
      ProjectDataBase_.RelativePath := lConfigurations.ReadString('Path', 'RelativePath', '');
      ProjectDataBase_.ModuleFileName := lConfigurations.ReadString('Path', 'Executable', '');
      ProjectDataBase_.StartupDirectory := lConfigurations.ReadString('Run', 'CurrentDir', '');
      ProjectDataBase_.RunParameters := lConfigurations.ReadString('Run', 'Params', '');
      ProjectDataBase_.HostApplication := lConfigurations.ReadString('Run', 'Host', '');
    finally                                          
      lConfigurations.Free();
    end;

    FormProjectInfo.EDITRunParameters.Text := ProjectDataBase_.RunParameters;
    FormProjectInfo.EDITStartupDirectory.Text := ProjectDataBase_.StartupDirectory;
    FormProjectInfo.edtHostApplication.Text := ProjectDataBase_.HostApplication;
  finally
    lFileBuffer.Free;
    Screen.Cursor := crDefault;
  end ;
end ;


(**********************)
(* TFormMain.MainHook *)
(**********************)

function TFormMain.MainHook;
begin
  Result := false;
  case Message.Msg of
    WM_ACTIVATE:
      with TWMACTIVATE(Message) do
        if (Active = WA_ACTIVE) and Minimized and (FStateMachineState<>stPlaying) then
          HandleJournalEvent(jeApplRestored);
    XM_COVEREDPOINT:
      HandlePointCovered(TCoveragePoint(Message.lParam));
    XM_DEBUGSTRING:
      // HandleProcessDebugString(PChar(Message.lParam))
      ;
    XM_RUNNING:
      HandleProcessRunning;
    XM_TERMINATED:
      HandleProcessTerminated;
    XM_PROCESSNOTCREATED: begin
      if LogFileEnabled_ then
        Writeln(LogFile_, Format('Process not created. Errorcode: 0x%s(%s)',
          [IntToHex(Message.lParam, 8), IntToStr(Message.lParam)]));
      raise Exception.Create(
        Format('Cannot create process, check if file "%s" exists or if the (options) startup directory "%s" exists.',
        [Process.ExeName, Process.StartupDirectory]));
      end;
    XM_ERRORCODE:
      HandleErrorCode(Message.WParam, Message.lParam);
  end ;
end ;


(************************)
(* TFormMain.MakeReport *)
(************************)

procedure TFormMain.MakeReport;
  const
    Section = 'FormExport';
  var
    F : TextFile;
    i : integer;
    U : TUnit;
    R : TRoutine;
    UnitFileName, s, t : string;
    x : single;
    IniFile : TIniFile;
begin
  IniFile := TIniFile.Create(PrivateProfileFileName_);
  try
    if IniFile.ReadBool(Section, 'CHKExportUnits', false) then begin
      t := IniFile.ReadString(Section, 'EDITUnitFileName', 'UnitsReport.txt');
      AssignFile(F, t);
      Rewrite(F);
      try
        with SortedUnits do
          for i := 0 to pred(Count) do begin
            U := At(i);
            if U.FileNames.Count > 0 then
              UnitFileName := U.FileNames.Strings[0]
            else
              UnitFileName := '?';
            if IniFile.ReadBool(Section, 'CHKStripPath', false) then
              UnitFileName := ExtractFileName(UnitFileName);
            if U.ValidPointsQty = 0 then
              s := '?'
            else begin
              x := U.CoveredPointsQty;
              x := 100.0*(x / U.ValidPointsQty);
              s := Format('%3.0f',[x])+'%';
            end ;
            while s [1] = ' ' do s := Copy(s, 2, length(s));
            t := IniFile.ReadString(Section, 'EDITUnitFormatString','%0:s;%1:s;%2:s;%3:s;%4:s;%5:s;%6:s');
            Writeln(F, Format(t,
              [UnitFileName, U.Name, IntToStr(U.Size), IntToStr(U.RoutinesQty),
                IntToStr(U.R0Pc), IntToStr(U.R100Pc), s]));
          end ;
      finally
        CloseFile(F);
      end ;
    end ;

    if IniFile.ReadBool(Section, 'CHKExportRoutines', false) then begin
      t := IniFile.ReadString(Section, 'EDITRoutineFileName', 'RoutinesReport.txt');
      AssignFile(F, t);
      Rewrite(F);
      try
        with SortedRoutines do
          for i := 0 to pred(Count) do begin
            R := At(i);
            U := ProjectDataBase_.Units.At(R.UnitIndex);
            if R.ValidPointsQty = 0 then
              s := '?'
            else begin
              x := R.CoveredPointsQty;
              x := 100.0*(x / R.ValidPointsQty);
              s := Format('%3.0f',[x])+'%';
            end ;
            while s [1] = ' ' do s := Copy(s, 2, length(s));
            t := IniFile.ReadString(Section, 'EDITRoutineFormatString','%0:s;%1:s;%2:s;%3:s');
            Writeln(F, Format(t,
              [R.Name, U.Name, IntToStr(R.ValidPointsQty), s]));
          end ;
      finally
        CloseFile(F);
      end ;
    end ;
  finally
    IniFile.Free;
  end ;
end ;


(********************************)
(* TFormMain.MergeWithStateFile *)
(********************************)

procedure TFormMain.MergeWithStateFile(const FileName : string);
  var
    StateStream : TFileStream;
    OldDataBase : TProjectDataBase;
begin
  StatusBar.Panels[pFilePos].Text := 'Merging states';
  StatusBar.Update;
  StateStream := TFileStream.Create(FileName, fmOpenRead);
  OldDataBase := TProjectDataBase.Load(StateStream);
  try
    ProjectDataBase_.MergeCoverage(OldDataBase);
    //ProjectDataBase_.Update(OldDataBase);
  finally
    OldDataBase.Free;
    StateStream.Free;
    InitAfterLoadingDataBase;
  end ;
end ;


(********************************)
(* TFormMain.MMApplicationClick *)
(********************************)

procedure TFormMain.MMApplicationClick(Sender: TObject);
begin
  MMApplicationRun.Enabled := (ProjectDataBase_ <> nil) and not
    Process.Created;
  MMApplicationTerminate.Enabled := Process.Running;
end ;


(***********************************)
(* TFormMain.MMApplicationRunClick *)
(***********************************)

procedure TFormMain.MMApplicationRunClick(Sender: TObject);
begin
  RunApplication;
end ;


(*****************************************)
(* TFormMain.MMApplicationTerminateClick *)
(*****************************************)

procedure TFormMain.MMApplicationTerminateClick(Sender: TObject);
begin
  Process.Reset;
end ;


(*******************************)
(* TFormMain.MMExportDataClick *)
(*******************************)

procedure TFormMain.MMExportDataClick(Sender: TObject);
begin
  if FormExport.ShowModal = mrOk then begin
    Screen.Cursor := crHourGlass;
    try
      MakeReport;
    finally
      Screen.Cursor := crDefault;
    end ;
  end ;
end ;


(******************************)
(* TFormMain.MMHelpAboutClick *)
(******************************)

procedure TFormMain.MMHelpAboutClick(Sender: TObject);
begin
  FillSummary;
  FormAbout_ := TFormAbout.Create(Self);
  FormAbout_.ShowModal;
  FormAbout_.Free;
end ;


(*************************)
(* TFormMain.MMHelpClick *)
(*************************)

procedure TFormMain.MMHelpClick(Sender: TObject);
begin
end ;


(*****************************)
(* TFormMain.MMHelpHelpClick *)
(*****************************)

procedure TFormMain.MMHelpHelpClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open',
    PChar(ChangeFileExt(Application.ExeName, '.rtf')), nil, nil, SW_SHOWNORMAL) ;
end ;


(***********************************)
(* TFormMain.MMMacroRecordNewClick *)
(***********************************)

procedure TFormMain.MMMacroRecordNewClick(Sender: TObject);
begin
  HandleJournalEvent(jeRecord);
end ;


(****************************)
(* TFormMain.MMOptionsClick *)
(****************************)

procedure TFormMain.MMOptionsClick(Sender: TObject);
begin
  if FormOptions.ShowModal = mrOk then begin
    AdjustStayOnTop;
    FillSortedUnitList;
    FillLBUnits;
  end ;
end ;


(**************************************)
(* TFormMain.MMProjectClearStateClick *)
(**************************************)

procedure TFormMain.MMProjectClearStateClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    ProjectDataBase_.Clear;
    InitAfterLoadingDatabase;
  finally
    Screen.Cursor := crDefault;
  end ;
end ;


(****************************)
(* TFormMain.MMProjectClick *)
(****************************)

procedure TFormMain.MMProjectClick(Sender: TObject);
begin
  MMProjectNew.Enabled := not Process.Running;
  MMProjectReload.Enabled := not Process.Running;
  MMProjectSave.Enabled := ProjectDatabase_ <> nil;
  MMProjectMerge.Enabled := (ProjectDatabase_ <> nil) and not Process.Running;
  MMProjectClearState.Enabled := (ProjectDatabase_ <> nil) and not Process.Running;
end ;


(********************************)
(* TFormMain.MMProjectExitClick *)
(********************************)

procedure TFormMain.MMProjectExitClick(Sender: TObject);
begin
  Close;
end ;


(*********************************)
(* TFormMain.MMProjectMergeClick *)
(*********************************)

procedure TFormMain.MMProjectMergeClick(Sender: TObject);
  var
    OldDataBase : TProjectDataBase;
    S : TFileStream;
begin
  if Config.ExecDialog(OpenStateDialog,State_Key) then begin
    Refresh;
    Screen.Cursor := crHourGlass;
    S := TFileStream.Create(OpenStateDialog.FileName, fmOpenRead);
    try
      StatusBar.Panels[pFilePos].Text := 'Merging state';
      OldDataBase := TProjectDataBase.Load(S);
      try
        if LogFileEnabled_ then
          WriteLn(LogFile_, 'Merging with state: '+OpenStateDialog.FileName);
        ProjectDataBase_.MergeCoverage(OldDataBase);
        if LoadedStatesStr <> '' then
          LoadedStatesStr := LoadedStatesStr + ' ';
        LoadedStatesStr := LoadedStatesStr + '+' + ExtractFileName(OpenStateDialog.FileName);
        InitAfterLoadingDataBase;
        inc(ProjectDataBase_.ChangedCount); // force dirty
      finally
        OldDataBase.Free;
      end ;
    finally
      S.Free;
      Screen.Cursor := crDefault;
    end ;
  end ;
end ;


(*******************************)
(* TFormMain.MMProjectNewClick *)
(*******************************)

procedure TFormMain.MMProjectNewClick(Sender: TObject);
begin
  if AllowsNewState and Config.ExecDialog(OpenDelphiProjectDialog, DelphiProject_Key) then begin
    Refresh;
    Screen.Cursor := crHourGlass;
    try
      LoadedStatesStr := '';
      LoadProject(OpenDelphiProjectDialog.FileName);

      StateFileName := ChangeFileExt(ProjectDataBase_.ModuleFileName,ProjectStateExtension);
      InfoFileName := ChangeFileExt(StateFileName, ProjectInformationExtension);

      if FileExists(StateFileName) then begin
        if MessageDlg('Do you want to include (merge) the existing saved state?',
          mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
          Refresh;
          Screen.Cursor := crHourGlass;
          try
            MergeWithStateFile(StateFileName);
          finally
            Screen.Cursor := crDefault;
          end ;
        end ;
      end ;
      LoadInformationFile;
    finally
      Screen.Cursor := crDefault;
      HandleProgress(-1, '');
    end ;
  end ;
end ;


(**********************************)
(* TFormMain.MMProjectReloadClick *)
(**********************************)

procedure TFormMain.MMProjectReloadClick(Sender: TObject);
begin
  if AllowsNewState then begin
    if Config.ExecDialog(OpenStateDialog, State_Key) then begin
      Refresh;
      LoadState(OpenStateDialog.FileName);

      StateFileName := OpenStateDialog.FileName;
      InfoFileName := ChangeFileExt(StateFileName, ProjectInformationExtension);;
      LoadInformationFile;
    end ;
  end ;
end ;


(********************************)
(* TFormMain.MMProjectSaveClick *)
(********************************)

procedure TFormMain.MMProjectSaveClick(Sender: TObject);
begin
  if (ProjectDataBase_ <> nil) and
    Config.ExecDialog(SaveStateDialog, State_Key) then begin
    SaveStateFile(ChangeFileExt(SaveStateDialog.FileName,ProjectStateExtension));
  end ;
end ;


(************************************)
(* TFormMain.MMProjectSettingsClick *)
(************************************)

procedure TFormMain.MMProjectSettingsClick(Sender: TObject);
begin
  if FormProjectInfo.ShowModal = mrOk then begin
    ProjectDataBase_.RunParameters := FormProjectInfo.EDITRunParameters.Text;
    ProjectDataBase_.StartupDirectory := FormProjectInfo.EDITStartupDirectory.Text;
    ProjectDataBase_.RunMaximized := FormProjectInfo.CHKRunMaximized.Checked;
    ProjectDataBase_.HostApplication := FormProjectInfo.edtHostApplication.Text;
  end ;
end ;


(***************************)
(* TFormMain.PBLegendPaint *)
(***************************)

procedure TFormMain.PBLegendPaint(Sender: TObject);
  const
    Offset = 5;
    MaxColors = 3;
    Colors : array [1..MaxColors] of TColor =
      (clRed, clYellow, clGreen);
    Strings : array [1..MaxColors] of string =
      ('0%', '50%', '100%');
  var
    w, h, i, x, dx, y, dy : integer;
    P : TPaintBox;
    R : TRect;
    t : string;
begin
  P := Sender as TPaintBox;
  w := P.Width;
  h := P.Height;
  dx := (w - 2*Offset) div MaxColors;
  x := Offset;
  dy := 24;
  y := (h - dy) div 2;
  for i := 1 to MaxColors do begin
    y := Offset;
    P.Canvas.Brush.Color := Colors[i];
    R := Rect(x, y, x+dx, y+dy);
    P.Canvas.FillRect(R);
    P.Canvas.Font.Color := (not Colors[i]) and $FFFFFF;
    t := Strings[i];
    w := P.Canvas.TextWidth(t);
    h := P.Canvas.TextHeight(t);
    P.Canvas.TextOut(x + ((dx-w) div 2), y + ((dy-h) div 2), t);
    inc(x, dx);
  end ;
end ;


(*******************************)
(* TFormMain.PBOverViewMouseUp *)
(*******************************)

procedure TFormMain.PBOverViewMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    LineNr, ColumnNr, RoutineIndex : integer;
begin
  // Display the source of the selected routine
  LineNr := Y div OverviewPointSquareSide;
  ColumnNr := X div OverviewPointSquareSide;
  RoutineIndex := LineNr * SquaresPerLine + ColumnNr;
  if RoutineIndex < LBRoutines.Items.Count then begin
    LBRoutines.ItemIndex := RoutineIndex;
    LBRoutinesClick(LBRoutines);
  end ;
end ;


(*****************************)
(* TFormMain.PBOverViewPaint *)
(*****************************)

procedure TFormMain.PBOverViewPaint(Sender: TObject);
  var
    i : integer;
begin
  with Sender as TPaintBox do begin
    SquaresPerLine := PBOverView.Width div OverviewPointSquareSide;
    if not Resizing then begin
      if ProjectDataBase_ <> nil then begin
        with SortedRoutines do
          for i := 0 to pred(Count) do
            UpdateOverView(At(i))
      end else begin
        Canvas.FillRect(ClientRect);
      end ;
    end ;
  end ;
end ;


(**************************)
(* TFormMain.PCLeftChange *)
(**************************)

procedure TFormMain.PCLeftChange(Sender: TObject);
begin
  if PCLeft.ActivePage = TSSummary then
    FillSummary;
end ;


(*****************************)
(* TFormMain.PCRightChanging *)
(*****************************)

procedure TFormMain.PCRightChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
{$IfDef NOMacros}
  AllowChange := false;
{$EndIf}
end ;


(****************************************)
(* TFormMain.PositionRoutineViewToPoint *)
(****************************************)

procedure TFormMain.PositionRoutineViewToPoint(C: TCoveragePoint);
  var
    Routine : TRoutine;
    RoutineIndex : integer;
begin
  if C <> nil then begin
    // In which routine is this point?
    Routine := ProjectDataBase_.Routines.At(C.RoutineIndex);
    // Which is the index of this routine?
    RoutineIndex := SortedRoutines.IndexOf(Routine);
    // Is it another routine
    if (RoutineIndex <> LBRoutines.ItemIndex) and (RoutineIndex >= 0) and
     (RoutineIndex < LBRoutines.Items.Count) then begin
      // Is this item displayed?
      LBRoutines.ItemIndex := RoutineIndex;
      LBRoutines.Refresh;
      LBRoutinesDrawItem(LBRoutines, RoutineIndex, LBRoutines.ItemRect(RoutineIndex),
        [odSelected]);
    end ;
  end ;
end ;


(******************************************)
(* TFormMain.PURoutinesEnableDisableClick *)
(******************************************)

procedure TFormMain.PURoutinesEnableDisableClick(Sender: TObject);
  var
    Routine : TRoutine;
    i, j : integer;
begin
  if LBRoutines.ItemIndex >=0 then begin

    j := LBRoutines.ItemIndex;
    LBRoutines.Items.BeginUpdate;
    try
      for i := 0 to pred(LBRoutines.Items.Count) do
        if LBRoutines.Selected[i] then
          with SortedRoutines do begin
            Routine := SortedRoutines.At(i);
            // Enable only items that have a source file
            if Routine.FileIndex >= 0 then
              ProjectDataBase_.EnableDisableRoutine(Routine,
                Sender = PURoutinesEnable);
          end ;
    finally
      LBRoutines.Items.EndUpdate;
    end ;

    Screen.Cursor := crHourGlass;
    try
      FillSortedRoutineList;
      FillLBRoutines;
    finally
      Screen.Cursor := crDefault;
    end ;
    
    LBRoutines.ItemIndex := j;
    LBRoutinesClick(LBRoutines);
    UpdateCoverageOnStatusBar;
  end ;
end ;


(*****************************)
(* TFormMain.PURoutinesPopup *)
(*****************************)

procedure TFormMain.PURoutinesPopup(Sender: TObject);
begin
  with LBRoutines do begin
    PURoutinesEnable.Enabled := (ItemIndex >= 0) and
      (TRoutine(SortedRoutines.At(ItemIndex)).Disabled);
    PURoutinesDisable.Enabled := (ItemIndex >= 0) and
      not (TRoutine(SortedRoutines.At(ItemIndex)).Disabled);
  end ;
end ;


(************************************)
(* TFormMain.PUSourceNextGreenClick *)
(************************************)

procedure TFormMain.PUSourceNextGreenClick(Sender: TObject);
begin
  GotoNextCoveragePoint(false);
end ;


(**********************************)
(* TFormMain.PUSourceNextRedClick *)
(**********************************)

procedure TFormMain.PUSourceNextRedClick(Sender: TObject);
begin
  GotoNextCoveragePoint(true)
end ;


(***************************************)
(* TFormMain.PUUnitsEnableDisableClick *)
(***************************************)

procedure TFormMain.PUUnitsEnableDisableClick(Sender: TObject);
  var
    U : TUnit;
    R : TRect;
    i : integer;
begin
  with LBUnits do
    if SelCount > 0 then begin
      Screen.Cursor := crHourGlass;
      try
        for i := 0 to pred(Items.Count) do
          if Selected[i] then begin
            U := SortedUnits.At(i);
            if U.IsSourceAvailable then begin
              ProjectDataBase_.EnableDisableUnit(U, Sender = PUUnitsEnable);
              R := ItemRect(i);
              InvalidateRect(Handle, @R, true);
            end ;
          end ;
        FillSortedRoutineList;
        FillLBRoutines;
        FillSummary;
        PBOverviewPaint(PBOverView);
      finally
        Screen.Cursor := crDefault;
      end ;
    end ;
    UpdateCoverageOnStatusBar;
end ;


(**************************)
(* TFormMain.PUUnitsPopup *)
(**************************)

procedure TFormMain.PUUnitsPopup(Sender: TObject);
begin
  PUUnitsSelectAll.Enabled := (ProjectDatabase_ <> nil) and
    (Projectdatabase_.Units.Count > 0);
  PUUnitsEnable.Enabled := LBUnits.SelCount > 0;
  PUUnitsDisable.Enabled := LBUnits.SelCount > 0;
  PUUnitsSelectGroup.Enabled := LBUnits.SelCount = 1;
end ;


(***********************************)
(* TFormMain.PUUnitsSelectAllClick *)
(***********************************)

procedure TFormMain.PUUnitsSelectAllClick(Sender: TObject);
  var
    i, n : integer;
begin
  with LBUnits do begin
    if Items.Count > 0 then begin
      n := TopIndex;
      Items.BeginUpdate;
      for i := 0 to Pred(Items.Count) do
        Selected[i] := true;
      TopIndex := n;
      Items.EndUpdate;
    end ;
  end ;
end ;


(*************************************)
(* TFormMain.PUUnitsSelectGroupClick *)
(*************************************)

procedure TFormMain.PUUnitsSelectGroupClick(Sender: TObject);
  var
    RefU, U : TUnit;
    i,n : integer;
begin
  with LBUnits do
    if SelCount = 1 then begin
      Screen.Cursor := crHourGlass;
      n := TopIndex;
      Items.Beginupdate;
      try
        RefU := nil;
        for i := 0 to pred(Items.Count) do
          if Selected[i] then begin
            RefU := SortedUnits.At(i);
            break;
          end ;
        if (RefU <> nil) and (RefU.FileNames.Count > 0) then begin
          with SortedUnits do
            for i := 0 to pred(Count) do begin
              U := At(i);
              if (U.FileNames.Count >0) and
                (ExtractFilePath(UpperCase(RefU.FileNames[0])) =
                 ExtractFilePath(UpperCase(U.FileNames[0]))) then
                Selected[i] := true;
           end ;
        end ;
      finally
        Screen.Cursor := crDefault;
        TopIndex := n;
        Items.EndUpdate;
      end ;
    end ;
    UpdateCoverageOnStatusBar;
end ;


(****************************)
(* TFormMain.RunApplication *)
(****************************)

procedure TFormMain.RunApplication;
begin
  // Check that the loaded state and exe are uptodate
  DeltaCovered := 0;
  UpdateCoverageOnStatusBar;
  if not FileExists(ExeFileName) then
    raise Exception.Create(Format('File "%s" does not exist.', [ExeFileName]));

  if CRC32.FileCRC32(ExeFileName) <> ProjectDatabase_.ModuleFileCRC then
    raise Exception.Create('The loaded state doesn''t match with the actual map and exe files. '+
      'The application has probably been recompiled. '+
      'You must load your project again.');

  Process.RunParameters := ProjectDataBase_.RunParameters;
  Process.StartupDirectory := ProjectDataBase_.StartupDirectory;
  Process.RunMaximized := ProjectDataBase_.RunMaximized;

  if AnsiContainsText(ProjectDataBase_.ModuleFileName, '.exe') then
    Process.ExeName := ProjectDataBase_.ModuleFileName
  else
    begin
      Process.DynamicModule := ProjectDataBase_.ModuleFileName;
      Process.ExeName := ProjectDataBase_.HostApplication;
    end;

  Process.Run;
end ;


(**************************)
(* TFormMain.SaveDataBase *)
(**************************)

procedure TFormMain.SaveDataBase(const FileName : string);
var
  lFileBuffer : TMemoryStream;
  lDpsFile : TFileStream;
  lConfigurations : TIniFile;
begin
  Screen.Cursor := crHourGlass;
  StatusBar.Panels[pFilePos].Text := 'Saving state';
  StatusBar.Refresh;
  lFileBuffer := TMemoryStream.Create();
  try
    if LogFileEnabled_ then
      WriteLn(LogFile_, 'Saving state: '+FileName);
      
    ProjectDataBase_.Save(lFileBuffer);

    lDpsFile := TFileStream.Create(FileName, fmCreate);
    try
      lFileBuffer.SaveToStream(lDpsFile);
    finally
      lDpsFile.Free;
    end;

    lConfigurations := TIniFile.Create(ChangeFileExt(FileName, '.cfg'));
    try
      lConfigurations.WriteString('Path', 'RelativePath', ProjectDataBase_.RelativePath);
      lConfigurations.WriteString('Path', 'Executable', ProjectDataBase_.ModuleFileName);
      lConfigurations.WriteString('Run', 'CurrentDir', ProjectDataBase_.StartupDirectory);
      lConfigurations.WriteString('Run', 'Params', ProjectDataBase_.RunParameters);
      lConfigurations.WriteString('Run', 'Host', ProjectDataBase_.HostApplication);
    finally
      lConfigurations.Free;
    end;
  finally
    lFileBuffer.Free();
    Screen.Cursor := crDefault;
    StatusBar.Panels[pFilePos].Text := '';
  end ;
end ;


(*********************************)
(* TFormMain.SaveInformationFile *)
(*********************************)

procedure TFormMain.SaveInformationFile;
  var
    U : TUnit;
    R : TRoutine;
    i : integer;
begin
  ProjectInfo.BackGndUnits.Clear;
  for i := 0 to pred(ProjectDataBase_.Units.Count) do begin
    U := ProjectDataBase_.Units.At(i);
    if (U.IsSourceAvailable) and U.Disabled then
      ProjectInfo.BackGndUnits.Add(U.Name);
  end ;
  ProjectInfo.BackGndRoutines.Clear;
  for i := 0 to pred(ProjectDataBase_.Routines.Count) do begin
    R := ProjectDataBase_.Routines.At(i);
    U := ProjectDataBase_.Units.At(R.UnitIndex);
    
    if (U.IsSourceAvailable) and (not U.Disabled) and R.Disabled then
      ProjectInfo.BackGndRoutines.Add(R.Name);
  end ;
  if InfoFileName <> '' then
    ProjectInfo.SaveToFile(InfoFileName);
end ;


(***************************)
(* TFormMain.SaveStateFile *)
(***************************)

procedure TFormMain.SaveStateFile(const FileName : string);
begin
  SaveDataBase(FileName);
end ;


(**********************************)
(* TFormMain.SetStateMachineState *)
(**********************************)

procedure TFormMain.WriteExeFileName(const Value: string);
begin
  ProjectDataBase_.ModuleFileName := Value
end;

procedure TFormMain.SetStateMachineState;
begin
  FStateMachineState := aState;
  if LogFileEnabled_ then
    Writeln(LogFile_, Format('%d %s',[GetTickCount,
    StateMachineStrings[StateMachineState]]));
end ;


(*******************)
(* TFormMain.Sleep *)
(*******************)

procedure TFormMain.Sleep(Delay: integer);
begin
  Windows.Sleep(Delay);
end ;


(*****************************)
(* TFormMain.StatusBarResize *)
(*****************************)

procedure TFormMain.StatusBarResize(Sender: TObject);
begin
  AdjustStatusbar;
  DisplayStatusFilename;
end ;


(*************************)
(* TFormMain.Timer1Timer *)
(*************************)

procedure TFormMain.Timer1Timer(Sender: TObject);
begin
  // Come here when the application is terminated
  Timer1.Enabled := false;
  UpdateOnActivate;
  if PCLeft.ActivePage = TSOverView then
    PBOverViewPaint(PBOverView);
  if Globals.CommandLineParams_.Action <> caNoAction then
    DoCommandLineFinalActions;
end ;


(******************************)
(* TFormMain.TIMERResizeTimer *)
(******************************)

procedure TFormMain.TIMERResizeTimer(Sender: TObject);
begin
  if not Resizing then begin
    TIMERResize.Enabled := false;
    PBOverViewPaint(PBOverView);
  end else
    Resizing := false;
end ;


(************************)
(* TFormMain.TimerTimer *)
(************************)

procedure TFormMain.TimerTimer(Sender: TObject);
begin
  HandleJournalEvent(jeTimerElapsed);
end ;


(***************************************)
(* TFormMain.UpdateCoverageOnStatusBar *)
(***************************************)

procedure TFormMain.UpdateCoverageOnStatusBar;
begin
  if ProjectDataBase_ <> nil then begin
    with ProjectDataBase_.CoveragePoints do
      StatusBar.Panels[pValidEnabledCoveredPoints].Text :=
        IntToStr(ValidEnabledCoveredPointsQty);
    StatusBar.Panels[pDeltaCovered].Text := '+'+IntToStr(DeltaCovered);
  end ;
end ;


(****************************)
(* TFormMain.UpdateFileLine *)
(****************************)

procedure TFormMain.UpdateFileLine(Point : TCoveragePoint);
  var
    U : TUnit;
    Routine : TRoutine;
    TopLineNr, BottomLineNr : integer;
    Index : integer;
    R : TRect;
begin
  Routine := ProjectDataBase_.Routines.At(Point.RoutineIndex);
  U := ProjectDataBase_.Units.At(Routine.UnitIndex);
  if (Routine.FileIndex >= 0) and
    (CompareText(CurrentSourceFileName, U.FileNames[Routine.FileIndex]) = 0) then begin
    // Is the line corresponding to the coverage point displayed?
    TopLineNr := succ(SendMessage(LBFile.Handle, LB_GETTOPINDEX, 0, 0));
    BottomLineNr := (LBFile.Height div LBFile.ItemHeight) + TopLineNr;
    if (Point.LineNumber >= TopLineNr) and
      (Point.LineNumber <= BottomLineNr) then begin
      Index := pred(Point.LineNumber);
      SendMessage(LBFile.Handle, LB_GETITEMRECT, Index, integer(@R));
      InvalidateRect(LBFile.handle, @R, true);
    end ;
  end ;
end ;


(******************************)
(* TFormMain.UpdateOnActivate *)
(******************************)

procedure TFormMain.UpdateOnActivate;
begin
  if ProjectDataBase_ <> nil then begin
    Screen.Cursor := crHourGlass;
    try
      UpdateCoverageOnStatusBar;
      FillSummary;
      FillSortedRoutineList;
      FillLBRoutines;
      FillSortedUnitList;
      FillLBUnits;
    finally
      Screen.Cursor := crDefault;
    end ;
  end ;
end ;


(****************************)
(* TFormMain.UpdateOverView *)
(****************************)

procedure TFormMain.UpdateOverView(Routine : TRoutine);
  var
    RoutineIndex, LineNr, RowNr, x : integer;
    R : TRect;
begin
  RoutineIndex := SortedRoutines.IndexOf(Routine);
  if RoutineIndex >= 0 then begin
    LineNr := RoutineIndex div SquaresPerLine;
    RowNr := RoutineIndex mod SquaresPerLine;
    with R do begin
      Left := RowNr*OverviewPointSquareSide;
      Top := LineNr*OverviewPointSquareSide;
      Bottom := Top + OverviewPointSquareSide;
      Right := Left + OverviewPointSquareSide;
    end ;
    if not Routine.Disabled then begin
      if Routine.ValidPointsQty = 0 then
        x := 0
      else
        x := (100*Routine.CoveredPointsQty) div Routine.ValidPointsQty;
      if x >= 50 then
        PBOverView.Canvas.Brush.Color := MergeColor(clYellow, clGreen, x * 2 - 100)
      else
        PBOverView.Canvas.Brush.Color := MergeColor(clRed, clYellow, x * 2);
    end else
      PBOverView.Canvas.Brush.Color := clGray;

    PBOverView.Canvas.Pen.Color := clGray;
    with R do
      PBOverView.Canvas.Rectangle(pred(R.Left), pred(R.Top), R.Right, R.Bottom);
  end ;
end ;


{~b}

procedure TFormMain.FillSortedFilteredUnitList;
var
  i : integer;
    U : TUnit;
begin
  // Update Statistical info
  if ProjectDatabase_ <> nil then
    begin
      SortedUnits.DeleteAll;

      with ProjectDataBase_.Units do
        for i := 0 to pred(Count) do
          begin
            U := At(i);

            if (U.IsSourceAvailable or not FormOptions.CHKNoDisplaySourceLessUnits.Checked) and
                AnsiContainsText(U.Name, edtUnitSearch.Text) and (U.ValidPointsQty > 0) then
              SortedUnits.Insert(U);
          end ;
    end ;
end ;

end.
