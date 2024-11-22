@echo off
setlocal

set "base_dir=Sources\Policies"
set "lgpo_path=Bin\.\LGPO.exe"

if not exist "%lgpo_path%" (
    echo .\LGPO.exe not found at %lgpo_path%. Exiting.
    exit /b 1
)

set "categories=Application Office OS Security"

for %%C in (%categories%) do (
    set "category_dir=%base_dir%\%%C"
    if not exist "%%category_dir%%" (
        echo Directory not found: %%category_dir%%. Skipping.
        next
    )
    for /d %%P in ("%%category_dir%%\*") do (
        echo Importing policies from %%P
        if exist "%%P\Machine" (
            "%lgpo_path%" /g "%%P\Machine"
        )
        if exist "%%P\User" (
            "%lgpo_path%" /g "%%P\User"
        )
    )
)

echo Done importing Group Policies!
endlocal
exit
