if ($args.count -eq 1)
{
    rm -r -fo $args[0]
    echo "$args removed!"
}
else 
{
    $item = es -path ./ | fzf --height 50% --reverse 
    $item = $item | rm -r -fo 
    echo "$args removed!"
}
