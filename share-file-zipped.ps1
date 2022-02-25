if ($args.count -eq 0)
{   
    $file = ls -name | fzf --height 50% --reverse 
    $compressedFile = $file.substring(0, $file.length-4)
    Compress-Archive -force $file $compressedFile
    $compressedFile = $compressedFile + ".zip"

    $link = curl -F "file=@$compressedFile" 0x0.st
    rm $compressedFile

    $linkAndName = $link
    Set-Clipboard $linkAndName

    echo "---------------------------"
    echo "$linkAndName Copied To Clipboard!"
    echo "---------------------------"
}
else 
{
    if ($args.count -eq 1)
    {
        $file = $args[0].substring(2)
        $compressedFile = $file.substring(0, $file.length-4)
        Compress-Archive -force $file $compressedFile
        $compressedFile = $compressedFile + ".zip"

        $link = curl -F "file=@$compressedFile" 0x0.st
        rm $compressedFile

        $linkAndName = $link
        Set-Clipboard $linkAndName

        echo "---------------------------"
        echo "$link Copied To Clipboard!"
        echo "---------------------------"
    }
    else 
    {
        echo "---------------------------"
        echo "Too Many Params"
        echo "---------------------------"
    }
}
