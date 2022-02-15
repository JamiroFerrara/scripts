if ($args.count -eq 1) {
    #es -path ./ -sort date-accessed /ad $args[0] | fzf --height 50% --reverse | cd
    es -sort date-accessed /ad $args[0] | ? {$_ -notmatch "Windows"} | ? {$_ -notmatch "Microsoft"}| fzf --height 20% --reverse | cd
    cl
    l
}
