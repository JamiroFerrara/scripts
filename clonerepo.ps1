if ($args.Count -eq 0)
{
    echo '------------------------------------'
    echo 'Repository Directory Missing'
    echo '------------------------------------'
}
else 
{
    if ($args.Count -eq 1)
    {
        gh repo clone $args[0]
    }
    else 
    {

    }
}