@echo off
setlocal

:: Run PowerShell configurations
echo Running PowerShell configurations...
powershell -ExecutionPolicy remotesigned -Command "& %CD%\localconfig.ps1"

:: Configure power policy
echo Setting power policies...
powercfg -SETACTIVE e9a42b02-d5df-448d-aa00-03f14749eb61
echo Power policies set!

:: Update group policy
echo Forcing group policy update...
gpupdate /force

echo Configuration complete.
endlocal
exit
