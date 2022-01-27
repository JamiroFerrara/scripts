if ($args.count -eq 2)
{
    $destination = es /ad $args[1] | fzf --height 50% --reverse
    cp -recurse $args[0] $destination
    rm -r -fo $args[0]

    echo $destination
    cd $destination
    cl
    l
}
