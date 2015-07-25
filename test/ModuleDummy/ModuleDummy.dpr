library ModuleDummy;

uses
  SysUtils,
  Classes,
  Windows,
  strUtils;

{$R *.res}

begin
  AllocConsole();
  writeln('Module load start');

  if AnsiContainsText('Dummy text', 'Not present') then
    writeln('Place holder')
  else
    writeln('Execution done');
end.
