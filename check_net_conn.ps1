$Server = "google.nl"				# Set ip or dns name to ping
$Loglocation = "C:\PingLog.csv"		# Location to save the log file
[int]$SleepTime = 5					# Amount of second to wait in between tests

while ("1" -ne "2"){
	# Retrieve the date and time
	$Time = get-date -UFormat %c
	# Test the connection and load into a variable
	$Connection = Test-Connection -ComputerName "$Server" -Count 2 -ea 0 -quiet
	# Output both date and results to the logfile
	$Time + ";"+ $Connection | Out-File -Append $Loglocation -Force
	# Wait for an X amount of seconds
	Start-Sleep -Seconds $SleepTime
}