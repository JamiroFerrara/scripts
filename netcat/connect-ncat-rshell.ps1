if ($args.count -eq 0)
{
    cd "c:\scripts\netcat"
    $sel = ls -name | grep ip | fzf --height 50% --reverse
    $selTarget = cat $sel | fzf --height 50% --reverse
    $ip = $selTarget | awk -F "-" '{print $2}'
    $port = $selTarget | awk -F "-" '{print $3}'

    ncat $ip $port
}
