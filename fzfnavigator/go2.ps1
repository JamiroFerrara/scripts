$dirs = cat "C:\Scripts\fzfnavigator\dirList"
$sText = $dirs | fzf --height 50% --reverse
$output = $sText|%{$_.split('"')[1]}

$name = ls $output -name -directory | fzf --height 50% --reverse
$finalDir = $output + "\" + $name
cd $finalDir
l
