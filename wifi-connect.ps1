if ($args.count -eq 0)
{
    $sWifi = Get-WifiNetwork| foreach {$_.SSID} | fzf --height 50% --reverse

    echo "---------------------------------"
    $selection = Read-Host "Please Input Password"
    echo "---------------------------------"

    netsh wlan connect ssid=$sWifi key="!Tecnoace2018!"
}
