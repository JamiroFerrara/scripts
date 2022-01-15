if ($args.Count -eq 0)
{
    echo '----------------------------------'
    echo 'Input Script Name!'
    echo '----------------------------------'
}
else 
{
    cd 'C:/Scripts'
    l
    new $args[0]
}
