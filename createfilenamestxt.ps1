$list = ls -name | ? {$_ -notmatch '.txt'} 
$list >./names.txt
echo $list
ii ./names.txt