Import-Module PSRDM,Devolutions.PowerShell -Force
#Get-Command -Module PSRDM

#$Servers = Get-AdComputer -identity "caw1trdsrdcb01" -properties CanonicalName -Server vmsdc1 | Select-Object -ExpandProperty CanonicalName

#list all computers in active directory with windows server in operatingsystem
$Servers = Get-ADComputer -Identity tkvpdhcp01 -Server tkvdc1 -Properties operatingsystem,CanonicalName | Where-Object {$_.operatingsystem -like "*Windows*Server*"} | Select-Object -ExpandProperty CanonicalName

foreach ($Server in $Servers)
{
    New-Computer -CanonicalName $Server -Verbose
}

#$creds =New-RDMSession -Name "creds" -Type Credential -Group "fmlogistic.fr"
#$creds.Credentials.UserName= (Get-Secret FMAdminAccount).UserName
#Set-RDMSession $creds -Refresh
#Set-RDMSessionPassword -ID $creds.ID -Password (Get-Secret FMAdminAccount).password
#Update-RDMUI
