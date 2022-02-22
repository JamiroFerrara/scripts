if ($args.count -eq 0)
{
    $nodes = cat "c:\scripts\linode\nodes"
    $selected = $nodes | fzf --height 50% --reverse | awk '{print $2}'
    wsl sshpass -p $password ssh "root@$selected"
}
