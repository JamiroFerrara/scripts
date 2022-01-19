if ($args.count -eq 0)
{   
    $sItem = ls -name | fzf --height 50% --reverse 

    $link = wsl curl -F "file=@$sItem" 0x0.st
    $linkAndName = $link + " - " + $sItem
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
        $link = wsl curl -F "file=@$file" 0x0.st
        $linkAndName = $link + " " + $sItem
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
