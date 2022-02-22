if ($args.count -eq 0)
{
    $sItem = cat "c:\scripts\trento\trento-commands" | fzf --height 50% --reverse
    $cmd = $sItem.Split("-")[1]
    invoke-expression $cmd
}
