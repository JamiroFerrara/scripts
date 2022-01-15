if ($args.count -eq 0)
{
    wsl googler -x
}
if ($args.count -eq 1)
{
    wsl googler -x -j $args[0]
}
