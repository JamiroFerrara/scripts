if ($args.count -ne 0)
{
    $command = ""
    foreach($arg in $args)
    {
        $command = $command + " " + $arg
    }

    $fileDir = $command

}
