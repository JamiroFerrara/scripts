try
{
    clear

    #File Selection
    echo "--------------------------"
    echo "SELECT VALIDA VERSION"
    echo "--------------------------"

    $validaUpdates = "C:\scripts\trento\files\Versioni Validatrici"
    cd $validaUpdates
    $updateFile = ls -name | fzf --height 50% --reverse
    $updateDir = "$validaUpdates\$updateFile\validacode.img"

    clear

    echo "--------------------------"
    echo "SELECT SERVER TRENTO --> Versione Selezionata: $updateFile"
    echo "--------------------------"

    #Server Selection
    $dirs = cat "C:\Scripts\trento\rdp-trento\ip-list"
    $sText = $dirs | fzf --height 50% --reverse
    $output = $sText|%{$_.split('"')[1]}

    clear

    echo "--------------------------"
    echo "SERVER $sText --> Versione Selezionata: $updateFile"
    echo "--------------------------"

    $remoteDir = "\\$output\MITT\HostToSta"
    $staMonDir = "\\$output\MITT\StaMon"
    cd $remoteDir

    $concDir = ls -name

    foreach ($dir in $concDir)
    {
        try
        {
            $fullDir = "$remoteDir\$dir"
            cd $fullDir
            Copy-Item -force $updateDir "validacode.img"
            cd ..

            echo "Update Copied!"
            echo $fullDir
            echo "--------------------------"

            $updateCmdDir = "C:\scripts\trento\files\Concentratore Commands\new-code\sta-cmdxxxxxx.dat" 
            $updateCmdDirBin = "C:\scripts\trento\files\Concentratore Commands\new-code\bin\sta-cmdxxxxxx.dat"

            Copy-Item -force $updateCmdDir $updateCmdDirBin
            $oName = "sta-cmdxxxxxx.dat"
            $concId = $dir
            $newName = $oName.replace("xxxxxx", $concId)
            rni -force $updateCmdDirBin $newName

            echo "Update Command Renamed.."

            $newNameDir = $updateCmdDirBin.replace("sta-cmdxxxxxx.dat", $newName)
            echo $newNameDir $staMonDir
            Copy-Item -force $newNameDir $staMonDir

            echo "Update Command Sent.."

        }
        catch
        {
            echo "Failed"
            echo "--------------------------"
        }
    }

    echo "Done!"
    cd "c:\scripts\trento\files\concentratore commands\new-code\bin"
    wipe
}
catch
{

}
