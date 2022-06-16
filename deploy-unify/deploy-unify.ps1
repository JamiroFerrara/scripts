$wDir = "C:/Scripts/deploy-unify/"
$lDir = "C:/Scripts/deploy-unify/application-list"

$proj = cat $lDir | fzf --reverse --height 50% 

$pName = $proj | %{$_.split('"')[0]}
$pName = $pName.substring(0, $pName.length-3)
$pBin = $proj | %{$_.split('"')[1]}

#Build Project using MSBuild --> Build == MsBuild
cd ("./" + $pName);
bump

$isNested = 0
if ($pName -eq "WPF_HOURSHEET"){
    cd "Apollo_HourSheet_WPF"
    $isNested = 1
  }
if ($pName -eq "WPF_HOURSHEET_VIEWER"){
    cd "HourSheet_Viewer"
    $isNested = 1
  }

build

$version = cat .\Properties\AssemblyInfo.cs | grep "AssemblyVersion" | awk '$0 !~ /*/'
$version = $version.substring(0, $version.length - 5)
$version = $version.substring(28)
echo $version

if ($isNested){
    cd ..
  }
cd ..

cd $pBin

$compress = @{
  Path = "./*"
  CompressionLevel = "Fastest"
  DestinationPath = "./Release.zip"
}

if ($pName -eq "WPF_MANAGER_V2"){
    $pName = $pName.substring(0, $pName.length - 3)
  }

Compress-Archive -Force @compress
Copy-Item -Force -Path ./Release.zip -Destination $tace_server/unify_packages/$pName.zip
cd $tace_server/unify_packages
cl
l

$line = ""
$lineN = 0 
$file = "./VERSIONS.txt"

if ($pName -contains "WPF_GESTIONE_MAGAZZINO"){
  $line = "WAREHOUSE = "
  $line = $line + $version
}
if ($pName -contains "WPF_HOURSHEET"){
  $line = "HOURSHEET = "
  $line = $line + $version
  $lineN = 1
}
if ($pName -contains "WPF_HOURSHEET_VIEWER"){
  $line = "HOURSHEET_VIEWER = "
  $line = $line + $version
  $lineN = 2
}
if ($pName -contains "WPF_MANAGER"){
  $line = "MANAGER = "
  $line = $line + $version
  $lineN = 3
}
if ($pName -contains "WPF_ADMINISTRATION"){
  $line = "ADMINISTRATION = "
  $line = $line + $version
  $lineN = 4
}

$content = Get-Content $file
$content[$lineN] = $line
$content | Set-Content $file
