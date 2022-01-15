if ($args.count -eq 0)
{
    wsl googler -x -c us
}
if ($args.count -eq 1)
{
    wsl googler -x -c us $args[0]
}
