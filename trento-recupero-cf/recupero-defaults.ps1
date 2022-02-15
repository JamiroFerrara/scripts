$header = "TRANS"
$bus = 0000

$dirs = ls -name
foreach($dir in $dirs){
    cd $dir
    $bus = $dir

    if (test-path -path "datitx")
    {   }
    else 
    {
        md datitx
        Get-ChildItem -File | Move-Item -Destination "datitx"
    }

    cd datitx

    $i = 0
    foreach($file in ls -name ){
        $time = (get-date).AddMinutes($i).ToString("yyMMddhhmm")
        $zero = "00"
        if ($bus.length -eq 3){
                    $zero = "000"     
                }
        $name = $header + $time + $zero + $bus + ".dat"

        if (($file -eq "temp_log.dat") -or ($file -eq "trans_eterm.dat") -or ($file -eq "trans.dat")){
                rni $file $name
                echo $name
                $i++
                }
        }
    cd ..
    cd ..
    }

Start-Sleep -s 1
$date = (get-date).tostring("yyMMdd")
$date = "TRANS$date"
lget $date
