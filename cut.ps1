if ($args.count -eq 2)
{
    $destination = es -sort date-accessed /ad $args[1] | sort -descending |? {$_ -notmatch "Windows"} | ? {$_ -notmatch "Microsoft"}| fzf -f $args[1]|fzf --height 20% --reverse --select-1 --preview "tree {}"
    cp -recurse $args[0] $destination
    rm -r -fo $args[0]

    echo $destination
    cd $destination
    l
}
