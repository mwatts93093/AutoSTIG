@echo off
pushd %~dp0
setlocal

echo Running STIG automation...
call Bin\CopyTemplates.bat
call Bin\ImportLocalPolicies.bat
call Bin\ImportGroupPolicies.bat
call Bin\ConfigureSystem.bat

echo Rebooting to apply changes...
shutdown /r /t 15
endlocal
popd
exit
