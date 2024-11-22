@echo off
setlocal

echo Moving policy files...
set "source_dir=Sources\Policies\Templates"
set "admx_target=C:\Windows\PolicyDefinitions"
set "adml_target=C:\Windows\PolicyDefinitions\en-US"

for /d %%d in ("%source_dir%\*") do (
    echo Processing folder: %%d
    for %%f in ("%%d\*.admx") do (
        echo Copying %%f to %admx_target%
        copy "%%f" "%admx_target%"
    )
    for %%f in ("%%d\*.adml") do (
        echo Copying %%f to %adml_target%
        copy "%%f" "%adml_target%"
    )
)

echo Done moving policy files!
endlocal
exit
