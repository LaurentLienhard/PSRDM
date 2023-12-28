class RDMEntry
{
    [System.String]$Name
    [System.Object]$Entry

    RDMEntry([System.String]$Name)
    {
        $this.Name = $Name
    }

    [System.Boolean] TestIfEntryExist ()
    {
        if ($null -eq (Get-RDMEntry -Name $this.Name))
        {
            return $false
        }
        else
        {
            return $true
        }
    }
}

class RDMEntryFolder : RDMEntry
{
    [System.String]$ConnectionType
    [System.String]$Group
    [System.String]$GroupMain

    RDMEntryFolder([System.String]$Name) : base ($Name) # Call the base constructor 'RDMEntry'
    {
        $this.ConnectionType = "Group"
        $this.Group = $this.Name
        $this.GroupMain = $this.Name
    }

    RDMEntryFolder([System.String]$Name, [System.String]$Group, [System.String]$GroupMain) : base ($Name) # Call the base constructor 'RDMEntry'
    {
        $this.ConnectionType = "Group"
        $this.Group = $Group
        $this.GroupMain = $Group
    }
}

class RDMEntryConnection : RDMEntry
{
    [System.String]$ConnectionType
    [System.Boolean]$Console = $true
    [System.Boolean]$UsesClipboard = $true
    [System.Boolean]$UsesDevices = $false
    [System.Boolean]$UsesHardDrives = $false
    [System.Boolean]$UsesPrinters = $false
    [System.Boolean]$UsesSerialPorts = $false
    [System.Boolean]$UsesSmartDevices = $false

    RDMEntryConnection([System.String]$Name) : base ($Name) # Call the base constructor 'RDMEntry'
    {
        $this.ConnectionType = "RDPConfigured"
    }

    [void] CreateEntry ()
    {
        if (!($this.TestIfEntryExist()))
        {
            Write-Host "Create new RDMEntryConnection: $($this.Name)"
            $Parameter = @{
                Name = $this.Name
                Type = $this.ConnectionType
            }
            $this.Entry = New-RDMEntry @Parameter
        }
        else {
            Write-Host "RDMEntryConnection already exist: $($this.Name)"
        }
    }

    [void] SetEntry ()
    {
        if ($this.Entry)
        {
            Write-Host "Set RDMEntry"
            $this.Entry.Console = $this.Console
            $this.Entry.UsesClipboard = $this.UsesClipboard
            $this.Entry.UsesDevices = $this.UsesDevices
            $this.Entry.UsesHardDrives = $this.UsesHardDrives
            $this.Entry.UsesPrinters = $this.UsesPrinters
            $this.Entry.UsesSerialPorts = $this.UsesSerialPorts
            $this.Entry.UsesSmartDevices = $this.UsesSmartDevices
            Set-RDMEntry -InputObject $this.Entry
        }
        else
        {
            Write-Host "Create entry before set"
        }
    }

    [void] UpdateEntry ()
    {
        if ($this.TestIfEntryExist())
        {
            $this.SetEntry()
        }
    }
}
