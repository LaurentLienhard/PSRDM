function New-Computer
<#
.SYNOPSIS
Create a new rdp entry

.DESCRIPTION
Create a new RDP entry for the computer pass as parameter in the folder pass as parameter

.PARAMETER ComputerName
Name for the RDP connection

.PARAMETER Folder
Folder where to create the RDP connexion

.PARAMETER CanonicalName
CanonicalName of the computer


.EXAMPLE
New-Computer -ComputerName "MyComputer" -Folder "Folder1/Folder2"

Create a RDP connection fot computer MyCOmputer in the folder Folder2 under Folder1

.EXAMPLE
New-Computer -CanonicalName "Folder1/Folder2/MyComputer"

Create a RDP connection fot computer MyComputer in the folder Folder2 under Folder1

.NOTES
General notes
#>
{
    [CmdletBinding(DefaultParameterSetName = 'ByCanonicalName')]
    param (
        [Parameter(ParameterSetName = 'ByComputerName')]
        [System.String]$ComputerName,
        [Parameter(ParameterSetName = 'ByComputerName')]
        [System.String]$Folder,
        [Parameter(ParameterSetName = 'ByCanonicalName')]
        [System.String]$CanonicalName
    )

    begin {

    }

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ByCanonicalName')
        {
            $ComputerName = Split-CanonicalName -CanonicalName $CanonicalName -Leaf
            $Folder = Split-CanonicalName -CanonicalName $CanonicalName -Parent
        }

        #Test if ComputerNName is ealredy used
        if (!(Test-Entry -Entry $ComputerName -Type Computer ))
        {
            #Test if folder don't exist
            if (!(Test-Entry -Entry $Folder -Type Folder))
            {
                #Create folder
                New-Folder -FolderName $Folder
            }
            $FormatFolder = ($Folder -replace ('/', '\'))
            $Session = New-RDMSession -Name $ComputerName -Group $FormatFolder -Type RDPConfigured -Host $ComputerName
            Set-RDMSession -Session $Session
        }
    }
    end {

    }
}
