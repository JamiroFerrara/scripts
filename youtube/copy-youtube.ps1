$apikey = 'AIzaSyAxDppkljrWJy1TOKCmg_hpncUSlmdAaCc'

if ($args.count -eq 0)
{
    Start-Process "www.youtube.com"
}
else
{
    if ($args.count -eq 1)
    {
        $query = $args[0]

        $uri ="https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=40&q=$query&type=video&key=AIzaSyAxDppkljrWJy1TOKCmg_hpncUSlmdAaCc&"
        $w_uri = "https://www.youtube.com/watch?v="

        echo '--------------------------'
        echo "YOUTUBE SEARCH: $query"
        echo '--------------------------'

        $res = irm -uri $uri
        $items = $res.items.snippet

        $s_title = $items.title | fzf --height 50% --reverse 
        $s_video = $res.items | ? {$_.snippet.title -eq $s_title}
        $videoId = $s_video.id.videoId

        $VideoUrl = "start chrome " + $w_uri + $videoId
        Set-Clipboard $VideoUrl
    }
}
