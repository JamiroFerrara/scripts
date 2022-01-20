# Enables Powershell Remoting
Param ([Parameter(Mandatory=$true)]
[System.String[]]$Computer)
ForEach ($comp in $computer ) {
    Start-Process -Filepath "C:\Scripts\Pstools\psexec.exe" -Argumentlist "\\$comp -h -d winrm.cmd quickconfig -q" -Credential $cred
	Write-Host "Enabling WINRM Quickconfig" -ForegroundColor Green
	Write-Host "Waiting for 60 Seconds......." -ForegroundColor Yellow
	Start-Sleep -Seconds 60 -Verbose	
    Start-Process -Filepath "C:\Scripts\Pstools\psexec.exe" -Argumentlist "\\$comp -h -d powershell.exe enable-psremoting -force" -Credential $cred
	Write-Host "Enabling PSRemoting" -ForegroundColor Green
    Start-Process -Filepath "C:\Scripts\Pstools\psexec.exe" -Argumentlist "\\$comp -h -d powershell.exe set-executionpolicy RemoteSigned -force" -Credential $cred
	Write-Host "Enabling Execution Policy" -ForegroundColor Green	
    Test-Wsman -ComputerName $comp
}          
