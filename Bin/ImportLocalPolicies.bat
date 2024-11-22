@echo off
setlocal

set "policy_exports_dir=Sources\Policies\Local Policies"
set "lgpo_path=Bin\.\LGPO.exe"

if not exist "%lgpo_path%" (
    echo .\LGPO.exe not found at %lgpo_path%. Exiting.
    exit /b 1
)

for /f "tokens=4-5 delims=[.] " %%A in ('ver') do set "os_version=%%A"
for /f "tokens=3 delims=[()] " %%B in ('ver') do set "os_name=%%B"

if "%os_name%"=="Windows 10" set "version_folder=Windows 10"
if "%os_name%"=="Windows 11" set "version_folder=Windows 11"
if "%os_name%"=="Windows Server 2012 R2" set "version_folder=Server 2012"
if "%os_name%"=="Windows Server 2016" set "version_folder=Server 2016"
if "%os_name%"=="Windows Server 2019" set "version_folder=Server 2019"
if "%os_name%"=="Windows Server 2022" set "version_folder=Server 2022"

if not defined version_folder (
    echo Unable to determine version folder for OS. Exiting.
    exit /b 1
)

set "gpttmpl_path=%policy_exports_dir%\%version_folder%\GPOs\*\GptTmpl.inf"
for %%G in (%gpttmpl_path%) do (
    if exist "%%G" (
        echo Importing policy from %%G
        "%lgpo_path%" /s "%%G"
    )
)

echo Done importing Local Policies!
endlocal
exit
