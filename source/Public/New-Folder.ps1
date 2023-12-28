function New-Folder
{
    <#
.SYNOPSIS
Create a foler structure in RDM

.DESCRIPTION
Create a racine folder and subfolder in RDM if parent folder exist

.PARAMETER FolderName
Name of the folder to create under format "Folder1" for root folder and "Folder1/Folder2/Folder3" for subfolder

.EXAMPLE
New-Folder -FolderName "Folder1/Folder2/Folder3"
Create Folder1,Folder2 under Folder1 and Folder3 under Folder2

.EXAMPLE
New-Folder -FolderName "Folder1"
Create Folder1 as root folder

.NOTES
General notes
#>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [System.String]$FolderName
    )

    $Folders = Split-CanonicalName -CanonicalName $FolderName -Token
    foreach ($Folder in $Folders)
    {
        if ($PSCmdlet.ShouldProcess($Folder))
        {
            #Start-Sleep -Milliseconds 100
            if (!($Parent))
            {
                $parent = $Folder
                if (!(Test-Entry -Entry $parent -Type Folder))
                {
                    $session = New-RDMSession -Type "Group" -Name $Folder
                    $session.Group = $Parent
                    $session.GroupMain = $Parent
                    $session.ColorMode = "Inherited"
                    $session.TabGroupMode = "Inherited"
                    $Session.CredentialInheritedMode = 'Default'
                    $session.CredentialConnectionID = "1310CF82-6FAB-4B7A-9EEA-3E2E451CA2CF"
                    Set-RDMSession $session
                    Start-Sleep -Milliseconds 100
                }
            }
            else
            {
                $parent = $Parent + "\" + $Folder
                if (!(Test-Entry -Entry $parent -Type Folder))
                {
                    $session = New-RDMSession -Type "Group" -Name $Folder
                    $session.Group = $Parent
                    $session.GroupMain = $Parent
                    $session.ColorMode = "Inherited"
                    $session.TabGroupMode = "Inherited"
                    $Session.CredentialInheritedMode = 'Default'
                    $session.CredentialConnectionID = "1310CF82-6FAB-4B7A-9EEA-3E2E451CA2CF"
                    Set-RDMSession $session
                    Start-Sleep -Milliseconds 100
                }
            }
        }
    }
}
