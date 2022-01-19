$wDir = "C:/Scripts/deploy-unify/"
$lDir = "C:/Scripts/deploy-unify/application-list"

$proj = cat $lDir | fzf --reverse --height 50% 

$pName = $proj | %{$_.split('"')[0]}
$pName = $pName.substring(0, $pName.length-3)
$pBin = $proj | %{$_.split('"')[1]}

cd $pBin

$compress = @{
  Path = "./*"
  CompressionLevel = "Fastest"
  DestinationPath = "./Release.zip"
}

Compress-Archive -Force @compress
Copy-Item -Force -Path ./Release.zip -Destination $tace_server/unify_packages/$pName.zip
cd $tace_server/unify_packages
cl
l

vim ./versions.txt
