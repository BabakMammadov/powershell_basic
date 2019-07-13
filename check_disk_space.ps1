## I created a PowerShell script that checks all drives from a list of servers. If the script detect less 20 GB it sends and e-mail to devops@yourcompany.az
## Change the following values accordingly to your server farm
$smtp = "192.168.1.1"
$from = "devops@yourcompany.com"
$to = "administrators@yourcompany.com"
$subject = "WARNING Low disk space detected"
$body = ""
$send = $false
## This is the list of servers to check for free disk space
$servers = @('Server1','Server2', $env:COMPUTERNAME)
## Loop through all servers
foreach ($server in $servers){
    ## Check for free disk space
    Get-WmiObject win32_logicaldisk -Filter "Drivetype=3" -ComputerName $server | % {
         ## if free space is less then 20 GB create a mail message.
         ## the script creates a row for each drive with low free disk space.
         if ($_.FreeSpace/1GB -lt 20){
            $body += "<p style='font-family: Calibri, Arial; line-height: 18px;'>SERVER: <b>" + $server + "</b><br/>"
            $body += "DRIVE: <b>" + $_.DeviceID + "</b><br/>"
            $body += "FREE SPACE: <b>" + [math]::truncate($_.FreeSpace/1GB) + " GB</b></p>"
            $send = $true
         }
    }
}
## Send the mail message if low free disk space is detected
if ($send -eq $true){
    Send-MailMessage -To $to -Subject $subject -BodyAsHtml $body -SmtpServer $smtp -From $from
}