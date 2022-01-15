$dirs = cat "C:\Scripts\bookmarks\bookmarks"
$sText = $dirs | fzf --height 50% --reverse
$output = $sText|%{$_.split('"')[1]}
Start-Process $output
cl
l
