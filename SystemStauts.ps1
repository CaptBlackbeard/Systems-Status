#----------------------------------------------------------------
#Script: SystemStauts.ps1
#Auther: Zachary Zeilinger zzeilinger@gmail.com
#Date: March 27, 2013 09:44pm
#Source code: git://github.com/madhatter00/Systems-Status.git
#----------------------------------------------------------------
<#
.SYNOPSIS
    Displays with a system is up or down by ping

.DESCRIPTION
    Gives system admnistrators a real time view if a system is up or down by ping

.Example
    Servername1 is down!
    Servername2 is up!

.Notes
    Requires a computer.txt file to be n the same directory as the .ps1 file.
#>
#Sets window name and size
$a = (Get-Host).UI.RawUI
$a.WindowTitle = "Systems-Status"
$b = $a.WindowSize
$b.Width = 24
$b.Height = 32
$a.WindowSize = $b
#Gets script location
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$Computers = Get-Content $dir\Computers.txt
#Runs this section in an infinte loop until ctrl+c or the "X" is hit. This is where the real work happens!
for (;;)
{ 
$now=Get-Date -format HH:mm:ss #Gets the current time
Write-Host "Ping ran at $now" -Foreground Magenta #writes the current time
write-host
Foreach ($ComputerName in $Computers) 
    {
        If (Test-Connection $ComputerName -count 1 -BufferSize 16 -TimeToLive 4 -Quiet)
            {
                Write-Host "$ComputerName is UP!" -ForegroundColor Green
            }
                else
                    {
                        Write-Host "$ComputerName is DOWN!" -ForegroundColor Red
                    }
     }
Write-Host "--------------------" -Foreground Red
Start-Sleep -s 5
cls
}

