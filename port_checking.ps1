function Test-OpenPort {
    <#
    .SYNOPSIS
    Test-OpenPort is an advanced Powershell function. Test-OpenPort acts like a port scanner. 
    .DESCRIPTION
    Uses Test-NetConnection. Define multiple targets and multiple ports. 
    .PARAMETER
    Target
    Define the target by hostname or IP-Address. Separate them by comma. Default: localhost 
    .PARAMETER
    Port
    Mandatory. Define the TCP port. Separate them by comma. 
    .EXAMPLE
    Test-OpenPort -Target sid-500.com,cnn.com,10.0.0.1 -Port 80,443 
    .LINK
    None.
    .INPUTS
    None.
    .OUTPUTS
    None.
    Make it permanent
    if you like my approach open PowerShell ISE. Copy the function into your ISE session. 
    Create a folder in C:\Program Files\Windows PowerShell\Modules and save the code as psm1 file. 
    Make sure that your file name and folder name match.
    #>

    [CmdletBinding()]

    param

    (

    [Parameter(Position=0)]
    $Target='localhost',

    [Parameter(Mandatory=$true, Position=1, Helpmessage = 'Enter Port Numbers. Separate them by comma.')]
    $Port

    )

    $result=@()

    foreach ($t in $Target)

    {

    foreach ($p in $Port)

    {

    $a=Test-NetConnection -ComputerName $t -Port $p -WarningAction SilentlyContinue

    $result+=New-Object -TypeName PSObject -Property ([ordered]@{
    'Target'=$a.ComputerName;
    'RemoteAddress'=$a.RemoteAddress;
    'Port'=$a.RemotePort;
    'Status'=$a.tcpTestSucceeded

    })

    }

    }

    Write-Output $result

    }