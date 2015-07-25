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
  FormMain.SaveStateFile('Teste.dps');

  for i := 1 to 25 do
    begin
      FormMain.MMProjectClearStateClick(nil);
      CheckEquals(0, ProjectDataBase_.Units.Count, 'Unit count');
      CheckEquals(0, ProjectDataBase_.Routines.Count, 'Routine count');
      CheckEquals(0, ProjectDataBase_.CoveragePoints.Count, 'Unit count');
      FormMain.LoadState('Teste.dps');
    end;
end;

procedure BasicTests.CreateProjectAbsolutePath;
begin
  FormMain.LoadProject(ExpandFileName('Dummy\Dummy.dpr'));
  CheckEquals(59, ProjectDataBase_.Units.Count, 'Unit count');
  CheckEquals(2873, ProjectDataBase_.Routines.Count, 'Routine count');
  CheckEquals(14, ProjectDataBase_.CoveragePoints.Count, 'Unit count');
end;

procedure BasicTests.CreateProjectRelativePath;
begin
  FormMain.LoadProject('Dummy\Dummy.dpr');
  CheckEquals(59, ProjectDataBase_.Units.Count, 'Unit count');
  CheckEquals(2873, ProjectDataBase_.Routines.Count, 'Routine count');
  CheckEquals(14, ProjectDataBase_.CoveragePoints.Count, 'Unit count');  
end;

procedure BasicTests.SaveLoadStress;
var
  i : integer;
begin
  FormMain.LoadProject('Dummy\Dummy.dpr');
  FormMain.SaveStateFile('Teste.dps');

  for i := 1 to 25 do
    begin
      FormMain.LoadState('Teste.dps');
      CheckEquals(ProjectDataBase_.Units.Count, 59, 'Unit count');
      CheckEquals(ProjectDataBase_.Routines.Count, 2873, 'Routine count');
      CheckEquals(ProjectDataBase_.CoveragePoints.Count, 14, 'Unit count');
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

