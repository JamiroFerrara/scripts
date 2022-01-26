if ($args.Count -eq 1)
    {
        $res = es -path ./ $args[0]
        md $args[0]
        cd $args[0]
        cp $res
        cl
        l
    }