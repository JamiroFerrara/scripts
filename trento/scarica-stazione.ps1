if ($args.count -eq 0)
{
    $matR = cat "c:\scripts\trento\rdp-trento\associazione-matricole-reali"
    $sConc = $matR | fzf --height 50% --reverse
    $Staz = $sConc.split("-")[0].trim()
    $IpC = $sConc.split("-")[1].trim()
    $IpPC = $sConc.split("-")[2].trim()
    $Id = $sConc.split("-")[3].trim()
    $IdConc = $sConc.split("-")[4].trim()

    echo $staz
    echo $ippc
    echo "$id $idconc"

    echo "Copying.."
    $fileDir = "c:\scripts\trento\files\concentratore commands\scarica-dati\sta-cmd001001.dat"
    $file = cat $fileDir
    $fileName = "sta-cmd$Id$IdConc.dat"
    $dest = "\\$IpPC\MITT\HostToSta"

    $file | out-file "$dest\$fileName"
    echo "Done!"
}
