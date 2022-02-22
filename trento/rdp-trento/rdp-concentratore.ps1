if ($args.count -eq 0)
{
    $matR = cat "c:\scripts\trento\rdp-trento\associazione-matricole-reali"
    $sConc = $matR | fzf --height 50% --reverse
    $Staz = $sConc.split("-")[0].trim()
    $IpC = $sConc.split("-")[1].trim()
    $IpPC = $sConc.split("-")[2].trim()
    $port = 23

    echo $Staz
    echo $IpPC
    if(($IpPC -eq "172.29.27.10") -or ($IpPC -eq "172.29.70.10") -or ($IpPC -eq "172.29.119.10") -or ($IpPC -eq "172.29.36.10") -or ($IpPC -eq "172.29.58.10") -or ($IpPC -eq "172.29.67.10") -or ($IpPC -eq "172.29.120.10") -or ($IpPC -eq "172.29.81.10"))
    {
        psexec "\\$IpPC" "c:\programmi\nmap\ncat.exe" -t $IpC $port
    }
    if(($IpPC -eq "172.29.100.10") )
    {
        psexec "\\$IpPC" ncat -t $IpC $port
    }
}
