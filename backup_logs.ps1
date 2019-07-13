## Find 3 day ago file and move them another disk


#Set-ExecutionPolicy RemoteSigned 
#Powershell.exe -File .\bakcup.ps1

#Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy UnRestricted
# If happen any error and stop script
#$ErrorActionPreference = 'Continue'

$script_dir = "C:\Users\Mammadov\Desktop\scripts"
$source_dir = "C:\logs"
$backup_dir = "D:\another_disk_location"

$Time=Get-Date
#Write-Host $Time


# Stop Opened Notepadd and notepad files
 Get-Process notepad, notepad++ | Stop-Process -Force  -errorAction continue

# Find before 3 days ago files
$copy_files = Get-ChildItem -Path $source_dir   -Recurse -Force | Where{$_.LastWriteTime -lt (Get-Date).AddDays(-3)}
#Write-Host $copy_files 

# Enter source directories
cd $source_dir
"$Time : INFO: Script started" | out-file $script_dir\backupscript.log -append 
#Write-Host "show copied files " $copy_files 

if ( Test-Path -Path $backup_dir -PathType Container ) {

   "$Time : INFO: Copy started" | out-file $script_dir\backupscript.log -append 

    Try{
        Copy-Item -Path  $copy_files  -Destination $backup_dir   -errorAction stop
       "$Time : INFO: Copy finished" | out-file $script_dir\backupscript.log -append

        Remove-Item -Path  $copy_files  -errorAction stop
        "$Time : INFO: Deleted old files" | out-file $script_dir\backupscript.log -append
    }
    Catch{
        $ErrorMessage = $_.Exception.Message
        "$Time : Error: $ErrorMessage" | out-file $script_dir\backupscript.log -append }

}
else{
    "$Time : Error: this  $backup_dir doesn't exist or mount failed " | out-file $script_dir\backupscript.log -append
}

"$Time : INFO: Script Finished" | out-file $script_dir\backupscript.log -append