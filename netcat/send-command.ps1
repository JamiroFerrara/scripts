if ($args.count -ne 0)
{
    $command = ""
    foreach($arg in $args)
    {
        $command = $command + " " + "$arg"
    }

    cd "c:\scripts\netcat"
    $sel = ls -name | grep ip | fzf --height 50% --reverse
    $selTarget = cat $sel | fzf --height 50% --reverse
    $ip = $selTarget | awk -F "-" '{print $2}'
    $port = $selTarget | awk -F "-" '{print $3}'

    echo $command | ncat $ip $port -d 2
}
