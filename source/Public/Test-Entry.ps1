function Test-Entry
{
    <#
.SYNOPSIS
Test if a entry already exist

.DESCRIPTION
Test if entry passe as paramter already exist

.PARAMETER Entry
Name of the entry to test
For Folder under format "Folder1" for root folder or "Folder1/Folder2/Folder3" for subfolder
For Computer wit hthe name of the computer

.EXAMPLE
Test-Entry -Entry 'Folder1' -Type Folder

test if root folder 'Fodler1' exist

.EXAMPLE
Test-Entry -Entry 'Folder1/Folder2' -Type Folder

test if folder2 exist under folder 1

.EXAMPLE
Test-Entry -Entry 'MyComputer' -Type Computer

test if computer with name MyCOmputer exist

.NOTES
General notes
#>
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param (
        [Parameter()]
        [System.String]$Entry,
        [Parameter()]
        [ValidateSet("Folder", "Computer")]
        [System.String]$Type
    )

    switch ($Type)
    {
        "Folder"
        {
            $FormatEntry = ($Entry -replace ('/', '\'))
            if (Get-RDMEntry -Type Group | Select-Object Group | Where-Object { $_.Group -eq $FormatEntry })
            {
                return $true
            }
            else
            {
                return $false
            }
        }
        "Computer"
        {
            if (Get-RDMEntry -Type RDPConfigured | Select-Object Name | Where-Object { $_.Name -eq $Entry })
            {
                return $true
            }
            else
            {
                return $false
            }
        }
    }
}
