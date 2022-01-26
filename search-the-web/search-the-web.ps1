$sUrls = cat "C:\scripts\search-the-web\search-urls"

if ($args[0].count -ne -0)
{
    $sItem = $sUrls | fzf --height 50% --reverse 
    $sEngine = $sItem | awk -F "-" '{print $1}'
    $sLink = $sItem | awk -F "-" '{print $2}'

    $searchT = ""
    foreach($arg in $args)
    {
        $searchT = $searchT + " " + $arg
    }

    $search = $sLink + $searchT

    echo "----------------"
    echo "$searchT - $sEngine"
    Start-Process $search.trim()
}
else 
{
    echo "-----------------"
    echo "No arguments"
    echo "-----------------"
}
