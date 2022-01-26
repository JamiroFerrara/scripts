if ($args.count -eq 2)
{
    $destination = es /ad $args[1] | fzf --height 50% --reverse
    robocopy $args[0] $destination
    
    echo $destination

    cd $destination
    cl
    l
}
