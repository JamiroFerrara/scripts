$apikey = 'key=AIzaSyAxDppkljrWJy1TOKCmg_hpncUSlmdAaCc'
$part = "part=snippet"
$maxResults = "maxResults=40"
$type = "type=channel"
$fileds = "fields=items%2Fsnippet%2FchannelId"

if ($args.count -eq 1)
{
    $query = $args[0]
    $query = "q=$query"

    $uri ="https://www.googleapis.com/youtube/v3/search?"
    $uri = "$uri&$part&$query&$maxResults&$type&$fields&$apiKey"

    echo '--------------------------'
    echo "YOUTUBE SEARCH: $query"
    echo '--------------------------'

    $res = irm -uri $uri
    $items = $res.items.snippet

    $sChannel = $items.title | fzf --height 50% --reverse 
    $s_video = $res.items | ? {$_.snippet.title -eq $sChannel}
    
    echo $s_video.snippet.title
    echo $s_video.snippet.channelId
}
