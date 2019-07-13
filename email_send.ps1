 # Configuration
 $emailFrom = "test@gmail.com"
 $emailTo = "babakmammadov15@gmail.com"
 $emailSubject = "my subject"
 $emailMessage = "my message"
 $smtpServer = "smtp.gmail.com"
 $smtpUserName = "" # This could be also in e-mail address format
 $smtpPassword = ""
 $smtpDomain = ""
 # SMTP Object
 $smtp = New-Object System.Net.Mail.SmtpClient($smtpServer, 487)
 $mailCredentials = New-Object System.Net.NetworkCredential
 $mailCredentials.Domain = $smtpDomain
 $mailCredentials.UserName = $smtpUserName
 $mailCredentials.Password = $smtpPassword
 $smtp.Credentials = $mailCredentials
 
 # Send E-Mail
 $smtp.Send($emailFrom, $emailTo, $emailSubject, $emailMessage)