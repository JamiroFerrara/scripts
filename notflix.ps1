if ($args.count -eq 0)
{
    echo "---------------------"
    echo "NO QUERY"
    echo "---------------------"
}
else 
{
    if ($args.count -eq 1)
    {

        echo "---------------------"
        echo "NOTFLIX: $args[0]"
        echo "---------------------"

        wsl notflix $args[0]
    }
    else 
    {
        $cArgs = ""
        foreach($arg in $args)
        {
            $cArgs = $cArgs + " " + $arg
        }

        echo "---------------------"
        echo "NOTFLIX: $cArgs"
        echo "---------------------"

        wsl notflix $cArgs
    }
}
