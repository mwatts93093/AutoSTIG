:: Run this script to copy over the adml and admx files for Group Policy,
:: Apply Local Group Policy, Fix services, and install Root Certs
:: Run as Administrator to make it work
                                                                        																													
@ECHO off																																							
pushd %~dp0


:: Places the .adml and .admx template files from stored directory to C:\Windows\PolicyDefinitions.
::@echo.
@copy "Windows OS Group Policy Templates\en-US\*.adml" "c:\Windows\PolicyDefinitions\en-US"
@copy "Windows OS Group Policy Templates\*.admx" "c:\Windows\PolicyDefinitions"
::@echo.


:: Copies STIG'ed GPO's to the appropriate directory.
@LGPO.exe /g "GPO\Windows 10"
@LGPO.exe /s "GPO\Windows 10\DomainSysvol\GPO\Machine\microsoft\windows nt\SecEdit\GptTmpl.inf"
@auditpol /restore /file:AuditPolicy
@gpupdate /force


:: Windows PowerShell Scripts
@Powershell -ExecutionPolicy remotesigned -Command "& %CD%\Win10.ps1"

@powercfg -SETACTIVE e9a42b02-d5df-448d-aa00-03f14749eb61

:: Reboots the machine to apply all changes.
@shutdown /r /t 15
popd
exit
