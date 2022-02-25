if ($args.count -eq 2)
{
    $destination = es -sort date-accessed /ad $args[1] | ? {$_ -notmatch "Windows"} | ? {$_ -notmatch "Microsoft"} | fzf -f $args[0]|fzf --height 20% --reverse
    cp -force $args[0] $destination
    
    echo $destination

    cd $destination
    cl
    l
}
