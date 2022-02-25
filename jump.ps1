if ($args.count -eq 1) {
    #es -path ./ -sort date-accessed /ad $args[0] | fzf --height 50% --reverse | cd
    es -sort date-accessed /ad $args[0] | sort -descending |? {$_ -notmatch "Windows"} | ? {$_ -notmatch "Microsoft"}| fzf -f $args[0]|fzf --height 20% --reverse --select-1| cd
    cl
    l
}
