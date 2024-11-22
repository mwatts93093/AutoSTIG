Set-LocalUser -Name Administrator -PasswordNeverExpires $FALSE
Set-LocalUser -Name Guest -PasswordNeverExpires $FALSE
Set-LocalUser -Name DefaultAccount -PasswordNeverExpires $FALSE

Rename-LocalUser -Name Guest -NewName xGuest
Rename-LocalUser -Name Administrator -NewName xAdministrator

foreach ($line in Get-Content Sources\Services.txt)
{
	Set-Service "$line" -StartupType Disabled

}

Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root

bcdedit /set "{current}" nx OptOut
