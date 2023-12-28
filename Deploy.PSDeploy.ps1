$ps7 = [environment]::getfolderpath("mydocuments") + "\PowerShell\Modules\PSRDM"
$ps5 = [environment]::getfolderpath("mydocuments") + "\WindowsPowerShell\Modules\PSRDM"

Deploy PowerShell {
    By FileSystem Scripts {
        FromSource "C:\01-DEV\PSRDM\output\module\PSRDM"
        To $ps7 , $ps5
        WithOptions @{
            Mirror = $true
        }
    }
}
