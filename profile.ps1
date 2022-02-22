using namespace System.Management.Automation
using namespace System.Management.Automation.Language
 
Set-Executionpolicy remotesigned -Scope CurrentUser

if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
}
Import-Module -Name Terminal-Icons

$user = "C:\Users\$env:UserName"
$tace_server = "\\192.168.11.54\applicazioni"
$token = "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"
$password = "jf19973007"

# $serverCert = New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My -DnsName $env:COMPUTERNAME
# New-Item -Path WSMan:\localhost\Listener\ -Transport HTTPS -Address * -CertificateThumbPrint $serverCert.Thumbprint -Force
# $sessionOptions = New-PSSessionOption -SkipCACheck

oh-my-posh --init --shell pwsh --config 'C:\Users\Jamiro Ferrara\AppData\Local\Programs\oh-my-posh\themes\ohmyposhv3-v2.json' | Invoke-Expression

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
     param($commandName, $wordToComplete, $cursorPosition)
         dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
         }
 }

#Sub Profiles  
."C:\scripts\setallaliases.ps1"
."C:\scripts\profile-modules\ip.ps1"
."C:\scripts\profile-modules\wsl.ps1"
."C:\scripts\profile-modules\keys.ps1"
."C:\scripts\profile-modules\functions.ps1"
."C:\scripts\profile-modules\cmatrix.ps1"

cd $user
clear
