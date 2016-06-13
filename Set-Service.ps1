$Date = Get-Date
$LogPath = "$PSScriptRoot\ServiceRestart.log"
$ComputerName = (Read-Host "Please type in the FQDN of the system you wish to restart the service on" -Verbose)
$TestResult = (Test-Connection -ComputerName $ComputerName -Quiet)

Write-Output "***Script Executed on $Date by $env:USERNAME***" | Out-File -Append $LogPath

IF($TestResult -eq $true)
    {

        Get-Service -ServiceName WinRM -ComputerName $ComputerName | Set-Service -Status Running

        Write-Output "The service has been set on system $ComputerName" -Verbose | Out-File -Append $LogPath

        Write-Host "Success. Service has been set on $ComputerName" -ForegroundColor Green -BackgroundColor Black

    }


IF($TestResult -eq $false)
    {
        
        Write-Output "System $ComputerName could not be reached. Check endpoint and try again" -Verbose | Out-File -Append $LogPath

        Write-Host "Failed to set service on $ComputerName. System is unreachable. Check endpoint and try again." -ForegroundColor Red -BackgroundColor Black

    }# REMOTESERVICE
