unit uTest;

interface

uses
  TestFramework, TestExtensions;

type
  TSetupDiscover = class(TTestSetup)
  protected
    procedure SetUp; override;
    procedure TearDown; override;  
  end;

  BasicTests = class(TTestCase)
  published
    procedure CreateProjectRelativePath;
    procedure CreateProjectAbsolutePath;
    procedure SaveLoadStress;
    procedure ClearStateStress;
    procedure ModalTest;
    procedure CoverageTest;
    procedure ModuleCoverageTest;
  end;

implementation

uses
  Forms, Main, F_Options, F_Export, F_ProjectInfo, SysUtils, DataBase;

{ BasicTests }

procedure BasicTests.ClearStateStress;
var
  i : integer;
begin
  FormMain.LoadProject('Dummy\Dummy.dpr');
  FormMain.SaveStateFile(ExpandFileName('Teste.dps'));

  for i := 1 to 25 do
    begin
      FormMain.MMProjectClearStateClick(nil);
      CheckEquals(59, ProjectDataBase_.Units.Count, 'Unit count');
      CheckEquals(2873, ProjectDataBase_.Routines.Count, 'Routine count');
      CheckEquals(14, ProjectDataBase_.CoveragePoints.Count, 'Coverage count');
      FormMain.LoadState(ExpandFileName('Teste.dps'));
    end;
end;

procedure BasicTests.CoverageTest;
var
  i : integer;
begin
  FormMain.LoadProject(ExpandFileName('Dummy\Dummy.dpr'));
  FormMain.MMApplicationRunClick(nil);

  {
    This is a tricky test since the program depends to be running to process messages
    and do the actual coverage. The dummy test should also take no longer than 2
    seconds, so it will be this way by default but may vary a lot in other
    scenarios.
  }
  for i := 1 to 500 do
    begin
      Sleep(1);
      Application.ProcessMessages();
    end;

  FormMain.MMApplicationTerminateClick(nil);
  CheckEquals(100, ProjectDataBase_.TotalCoverage, 'Coverage percentage');
end;

procedure BasicTests.CreateProjectAbsolutePath;
begin
  FormMain.LoadProject(ExpandFileName('Dummy\Dummy.dpr'));
  CheckEquals(59, ProjectDataBase_.Units.Count, 'Unit count');
  CheckEquals(2873, ProjectDataBase_.Routines.Count, 'Routine count');
  CheckEquals(14, ProjectDataBase_.CoveragePoints.Count, 'Coverage count');
end;

procedure BasicTests.CreateProjectRelativePath;
begin
  FormMain.LoadProject('Dummy\Dummy.dpr');
  CheckEquals(59, ProjectDataBase_.Units.Count, 'Unit count');
  CheckEquals(2873, ProjectDataBase_.Routines.Count, 'Routine count');
  CheckEquals(14, ProjectDataBase_.CoveragePoints.Count, 'Coverage count');
end;

procedure BasicTests.ModalTest;
begin
  FormMain.MMProjectClearStateClick(nil);
  // Only when necessary interaction
  // while FormMain.Visible do Application.ProcessMessages();
end;

procedure BasicTests.ModuleCoverageTest;
var
  i : integer;
begin
  FormMain.LoadProject('ModuleDummy\ModuleDummy.dpr');
  ProjectDataBase_.HostApplication := ExpandFileName('ModuleDummy\Loader.exe');
  FormMain.MMApplicationRunClick(nil);

  {
    For the same reason as before, this loop waits coverage to end.
    This coverage should actually end before the delay, but thats not
    really an issue for the test at all
  }
  for i := 1 to 500 do
    begin
      Sleep(1);
      Application.ProcessMessages();
    end;

  FormMain.MMApplicationTerminateClick(nil);
  CheckEquals(trunc(66.6666641235352), Trunc(ProjectDataBase_.TotalCoverage), 'Coverage percentage');
end;

procedure BasicTests.SaveLoadStress;
var
  i : integer;
begin
  FormMain.LoadProject('Dummy\Dummy.dpr');
  FormMain.SaveStateFile(ExpandFileName('Teste.dps'));

  for i := 1 to 25 do
    begin
      FormMain.LoadState(ExpandFileName('Teste.dps'));
      CheckEquals(ProjectDataBase_.Units.Count, 59, 'Unit count');
      CheckEquals(ProjectDataBase_.Routines.Count, 2873, 'Routine count');
      CheckEquals(ProjectDataBase_.CoveragePoints.Count, 14, 'Coverage count');
    end;
end;

{ TSetupDunit }

procedure TSetupDiscover.SetUp;
begin
  inherited;
  FormMain := TFormMain.Create(nil);
  FormOptions := TFormOptions.Create(nil);
  FormExport := TFormExport.Create(nil);
  FormProjectInfo := TFormProjectInfo.Create(nil);
  FormMain.Show();
end;

procedure TSetupDiscover.TearDown;
begin
  inherited;
  FormMain.Free;
  FormOptions.Free;
  FormExport.Free;
  FormProjectInfo.Free;
end;

initialization
  TestFramework.RegisterTest(TSetupDiscover.Create(BasicTests.Suite));

end.

