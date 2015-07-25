//{$DEFINE DUNIT_CONSOLE_MODE}

program discover_test;

uses
  SysUtils,
  TestFramework,
  TestExtensions,
  GUITestRunner,
  TextTestRunner,
  uTest in 'uTest.pas',
  poMain in 'poMain.pas';

{$IFDEF DUNIT_CONSOLE_MODE}
  {$APPTYPE CONSOLE}
{$ELSE}
  //{$R *.RES}
{$ENDIF}

{$R ..\src\Discover.RES}

begin
{$IFDEF DUNIT_CONSOLE_MODE}
  if not FindCmdLineSwitch('Graphic', ['-','/'], True) then
    TextTestRunner.RunRegisteredTests(rxbHaltOnFailures)
  else
{$ENDIF}
    GUITestRunner.RunRegisteredTests;
end.
