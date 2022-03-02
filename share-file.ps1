if ($args.count -eq 0)
{   
    $file = ls -name | fzf --height 50% --reverse 

    $link = curl -F "file=@$file" 0x0.st

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

        $link = curl -F "file=@$file" 0x0.st

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
