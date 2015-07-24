unit uTest;

interface

uses
  TestFramework, TestExtensions;

type
  TSetupDunit = class(TTestSetup)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  
  end;

  BasicTests = class(TTestCase)
  published
    procedure CreateProject;
  end;

implementation

uses
  Forms, Main, F_Options, F_Export, F_ProjectInfo;

{ BasicTests }

procedure BasicTests.CreateProject;
begin
  FormMain.LoadProject('Dummy\Dummy.dpr');
  While true do application.ProcessMessages();
end;

{ TSetupDunit }

procedure TSetupDunit.SetUp;
begin
  inherited;
  FormMain := TFormMain.Create(nil);
  FormOptions := TFormOptions.Create(nil);
  FormExport := TFormExport.Create(nil);
  FormProjectInfo := TFormProjectInfo.Create(nil);

  FormMain.Show();
end;

procedure TSetupDunit.TearDown;
begin
  inherited;
  FormMain.Free;
  FormOptions.Free;
  FormExport.Free;
  FormProjectInfo.Free;
end;

initialization
  TestFramework.RegisterTest(BasicTests.Suite);

end.

