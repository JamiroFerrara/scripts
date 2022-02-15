$sel = cat "c:\scripts\setallaliases.ps1" | fzf --height 80% --reverse | awk '{print $5}'
$sel = $sel.substring(1, $sel.length-2)
nvim $sel
