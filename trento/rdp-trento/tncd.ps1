$dirs = cat "C:\Scripts\trento\rdp-trento\ip-list"
$sText = $dirs | fzf --height 50% --reverse
$output = $sText|%{$_.split('"')[1]}

$remoteDir = "\\$output\MITT"
cd $remoteDir
