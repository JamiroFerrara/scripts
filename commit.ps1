if ($args.count -eq 0)
{
    git add .
    git commit -m 'Update'
    git push
}
else
{
    $searchT = ""
    foreach($arg in $args)
    {
        $searchT = $searchT + " " + $arg
    }

    git add .
    git commit -m $searchT
    git push
}
