if ($args.count -eq 0)
{
    ls $output -name -directory -recurse| fzf --height 50% --reverse | Set-Location
    l
}

if ($args.count -eq 1)
{
    cd $args[0]
    ls $output -name -directory -recurse| fzf --height 50% --reverse | Set-Location
    l
}
