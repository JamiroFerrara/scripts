if ($args.Count -eq 1)
    {
        echo "------------------"
        echo "Local-Get Started --> $args" 
        echo "------------------"

        $term = $args[0]
        $res = es -path ./ $term
        echo $res

        md $term
        cd $term
        cp $res
        l
    }