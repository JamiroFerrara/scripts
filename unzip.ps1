$zips = ls *.zip
$zips | Expand-Archive -DestinationPath ./ -Force
rm $zips
l