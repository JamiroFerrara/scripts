$dirs = cat "C:\Scripts\rtv\subreddits"
$sText = $dirs | fzf --height 50% --reverse
wsl rtv -s $sText
