$a = (Get-Host).UI.RawUI
$a.WindowTitle = "Systems-Status"
$b = $a.WindowSize
$b.Width = 24
$b.Height = 32
$a.WindowSize = $b
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$Computers = Get-Content $dir\Computers.txt

for (;;)
{ 
$now=Get-Date -format HH:mm:ss
Write-Host "Ping ran at $now" -Foreground Magenta
write-host
Foreach ($ComputerName in $Computers) 
    {
        If (Test-Connection $ComputerName -count 1 -BufferSize 16 -TimeToLive 4 -Quiet) {
        Write-Host "$ComputerName is UP!" -ForegroundColor Green
         }
        else {
        Write-Host "$ComputerName is DOWN!" -ForegroundColor Red
         }
     }
Write-Host "--------------------" -Foreground Red
Start-Sleep -s 5
cls
}

