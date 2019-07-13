# Powershell Examples
## What is powershell ?
PowerShell is an automation platform and scripting language developed by Microsoft for simplifying and automating the management of Windows and Windows Server systems.While PowerShell is primarily a text-based shell, it utilizes Microsoft's .NET Framework of built-in functionality and objects for managing Windows environments
## Execute powershell script on current directory
```
Open powershell and execute as below
 .\backup_logs.ps1
```
## Define variable and value
```
$name = 'Jon'
$number = 12345
$location = 'Charlotte'
$listofnumbers = 6,7,8,9
$my_last_math_grade = 'D+'
$numberofcmdlets = (get-command).count
```
## Show variable value
```
Write-Host "There are $numberofcmdlets commands available for use on this system."
```
## String formatters
```
$NIC = Get-NetworkAdapter -Computer PC01
‘{0} has the IPAddress {1} and the MACAddress {2}’ -f $NIC.HostName, $NIC.IPAddress, $NIC.MACAddress
```
## Append file
```
$Time = $Today
"$Time : INFO: Copy started" | out-file .\backupscript.log -append
```
## Alias examples
```
 Get-Alias -Name ls
 Get-Alias -Definition Get-ChildItem  ## Find which alias assing Get-ChildItem
 New-Alias -Name ll -Value Get-ChildItem
 ```
## Test connection specific port
```
Test-NetConnection   ipOrhostname -Port port_number
Test-NetConnection   ipOrhostname,1.1.1.1 -Port port_number,44,55
```
## Making scripts useful: If/Then
```
$a = 10
$b = 11
If ( $a –gt $b) 
    { Write-Host "Yes1" }
elseif ($b –gt $a)
    { Write-Host "Yes2"}
else 
    { Write-Host "No"}
```
## Do While example
```
$numbers = 1
do { $numbers = $numbers + 1; Write-Host "The current value of the variable is $numbers" } While ($numbers –lt 10)
```
## For Each and for, wheel
```
$names = "Amy","Bob","Candice","Dick","Eunice","Frank"
$count = 0
ForEach ($singlename in $names) {
$count += 1
Write-Host "$singlename"
}
Write-Host "The total number of names is $count."

while($true)
{
    $i++
    Write-Host “We have counted up to $i”
}
```
## Send Email Example
```
Get-Help Send-MailMessage -Full
Get-Help Send-MailMessage -Examples
Send-MailMessage --Detailed  
```
## Disk operations, list drives and extract info and convert to gb
```
Get-PSDrive
Get-WmiObject win32_logicaldisk -Filter "DeviceID='C:'" -ComputerName $env:computername
$disk = Get-WmiObject Win32_LogicalDisk -ComputerName $env:computername  -Filter "DeviceID='C:'" | Select-Object Size,FreeSpace
$disk.Size
$disk.FreeSpace
$disk.FreeSpace/1GB   ## show as GB
```
## Create new file, directory and get  permission
```
New-Item -Path '.\file.txt' -ItemType File -Force
New-Item -Path '.\dir' -ItemType Directory -Force
$Outfile = "C:\Users\Babak\Desktop\file.txt"
(Get-Acl $Outfile).Access
```
## Example working  windows services
```
#It’ll wait indefinitely until the service has been started. So you continue on your quest to get rock-solid code and you build in a timeout:
> Get-Command -Name "*service*"
> Get-Help Set-Service
> $SpoolerService = Get-Service -Name Spooler
> $SpoolerService.StartType
> $SpoolerService.WaitForStatus("Running")

$Counter = 0
while ((Get-Service -Name Spooler).Status -ne "Stopped"){
    Start-Sleep -Seconds 2
    $Counter++
    if ($Counter -eq 5){break}
}
```
## Functions
```
function Get-PowerShellProcess {Get-Process PowerShell}
Get-PowerShellProcess
function Add-Numbers {
 $args[0] + $args[1]
}
C:\> Add-Numbers 5 10
A similar function with named parameters:
function Output-SalesTax {
 param( [int]$Price, [int]$Tax )
 $Price + $Tax
}
C:\> Output-SalesTax -price 1000 -tax 38
1038
```
## Try catch finally example
```
function Do-Something {
    param()
    $ErrorActionPreference = 'Stop'
    try {
        #### Do stuff here
        #### Return an error
        Write-Error -Message 'Oh no! An error!'
        Write-Host 'I am the code after the error'
    } catch {
        Write-Host $_.Exception.Message -ForegroundColor Green
    }
}
```
```
function Do-Something {
    param()
    $ErrorActionPreference = 'Stop'
    try {
        #### Do stuff here
        #### Return an error
        Write-Error -Message 'Oh no! An error!'
    } catch {
        Write-Host $_.Exception.Message -ForegroundColor Green
    } finally {
        Write-Host 'I am the code after the error'
    }
}
```
```
Try
{
    $AuthorizedUsers = Get-Content \\ FileServer\HRShare\UserList.txt -ErrorAction Stop
}
Catch [System.OutOfMemoryException]
{
    Restart-Computer localhost
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName
    Send-MailMessage -From ExpensesBot@MyCompany.Com -To WinAdmin@MyCompany.Com -Subject "HR File Read Failed!" -SmtpServer EXCH01.AD.MyCompany.Com -Body "We failed to read file $FailedItem. The error message was $ErrorMessage"
    Break
}
Finally
{
    $Time=Get-Date
    "This script made a read attempt at $Time" | out-file c:\logs\ExpensesScript.log -append
}
```
## Read file and do things
```
foreach($line in Get-Content .\file.txt) {
    if($line -match $regex){
        ## Work here
    }
}
```

## Links
[general basic commands](http://powershelltutorial.net/Commands/script/)<br/>
[get help about commands](https://www.techrepublic.com/blog/windows-and-office/basic-windows-powershell-commands-you-should-already-know/ )<br/>
[general links ](https://stackify.com/what-are-powershell-commands/)<br/>
[create module powershell and call them](https://sid-500.com/2017/11/10/powershell-functions-how-to-create-your-first-powershell-module-command/)<br/>
[stinrg operations](https://4sysops.com/archives/strings-in-powershell-replace-compare-concatenate-split-substring)<br/>
[reading file from powershell](https://www.sqlshack.com/reading-file-data-with-powershell/)<br/>
[practical examples 1](http://sonnypuijk.nl/wp/powershell-102/)<br/>
[practical examples 2](https://www.howtogeek.com/141495/geek-school-writing-your-first-full-powershell-script/)<br/>
[practical examples 3](http://powershell-guru.com/)<br/>
[github page useful examples](https://github.com/topics/powershell-scripts)
