unit uTest;

interface

uses
  Windows, SysUtils, Classes, TestFramework, TestExtensions;

type
  BasicTests = class(TTestCase)
  published
    procedure LoadProject;
  end;

implementation

{ BasicTests }

procedure BasicTests.LoadProject;
begin

end;

initialization
  TestFramework.RegisterTest(BasicTests.Suite);

end.

