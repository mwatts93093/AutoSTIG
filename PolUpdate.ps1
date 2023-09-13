$month = (Get-Date).AddMonths(-1).ToString('MMMM')
$year = Get-Date -format yyyy
$dir = pwd
Invoke-WebRequest -Uri https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_STIG_GPO_Package_$month_$year.zip -OutFile $dir

Expand-Archive -Path $dir\U_STIG_GPO_Package_$month_$year.zip -DestinationPath $dir\Temp
Move-Item $dir'\Temp\ADMX Templates\*' $dir\PolicyTemplates

foreach ($item in Get-ChildItem $dir\Temp\DoD*){
Move-Item GPOs\* $dir\Policies
}