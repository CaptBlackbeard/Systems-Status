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
    Requires a srvlst.txt file to be in the same directory as the .ps1 file.
#>

#Turns off error messages
$ErrorActionPreference = 'silentlycontinue'

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

#Tests for text file with list of server names. If none exists in the directory the script will create the text file, open it, and the user must then populate the list. 
$path = "$dir\srvlst.txt"
    if(!(Test-Path -path $path))
        {
            new-item -path $path -Value "Please populate srvlst.txt with server names. One per line then save and close" -itemtype file
            Invoke-Item $dir\srvlst.txt
            Write-Host "Press the any key to continue..."
            $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            cls
        }
            Else
                {
                    cls
                }
$srvlst = Get-Content "$dir\srvlst.txt"

#Runs this section in an infinte loop until ctrl+c or the "X" is hit. This is where the real work happens!
for (;;)
{ 
$now=Get-Date -format HH:mm:ss #Gets the current time
Write-Host "Ping ran at $now" -Foreground Magenta #writes the current time
write-host "--------------------" -Foreground Red
Foreach ($s in $srvlst) 
    {
        If (Test-Connection $s -count 1 -BufferSize 16 -TimeToLive 4 -Quiet)
            {
                Write-Host "$s is UP!" -ForegroundColor Green
            }
                else
                    {
                        Write-Host "$s is DOWN!" -ForegroundColor Red
                    }
     }
Write-Host "--------------------" -Foreground Red
Start-Sleep -s 3
cls
}

<#
Systems-Status
Copyright (C) 2013  Zachary Zeilinger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
GNU General Public License, version 3 (http://opensource.org/licenses/GPL-3.0)
Disclaimer of Warranty
THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
Limitation of Liability
IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
#>
