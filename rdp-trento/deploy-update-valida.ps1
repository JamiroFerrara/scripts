try
{
    clear

    #File Selection
    echo "--------------------------"
    echo "SELECT VALIDA VERSION"
    echo "--------------------------"

    $validaUpdates = "C:\Users\Jamiro Ferrara\Important Stuff\Versioni Validatrici"
    cd $validaUpdates
    $updateFile = ls -name | fzf --height 50% --reverse
    $updateDir = "$validaUpdates\$updateFile\validacode.img"

    clear

    echo "--------------------------"
    echo "SELECT SERVER TRENTO --> Versione Selezionata: $updateFile"
    echo "--------------------------"

    #Server Selection
    $dirs = cat "C:\Scripts\rdp-trento\ip-list"
    $sText = $dirs | fzf --height 50% --reverse
    $output = $sText|%{$_.split('"')[1]}

    clear

    echo "--------------------------"
    echo "SERVER $sText --> Versione Selezionata: $updateFile"
    echo "--------------------------"

    $remoteDir = "\\$output\MITT\HostToSta"
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
        }
        catch
        {
            echo "Failed"
            echo "--------------------------"
        }
    }

    echo "Done!"
}
catch
{

}
