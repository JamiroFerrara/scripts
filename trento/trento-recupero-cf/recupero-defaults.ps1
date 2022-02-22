if ($args.count -eq 0)
{
    $header = "TRANS"
    $bus = 0000

    $dirs = ls -name
    foreach($dir in $dirs){
        cd $dir
        $bus = $dir
        $zero = "00"
        if ($bus.length -eq 3)
        {
            $zero = "000"     
        }

        $name = $header + $time + $zero + $bus + ".dat"

        $i = 0
        $files = es -path ./ "trans_eterm.dat"
        $files2 = es -path ./ "trans_backup.dat"
        $files = $files + $files2 + $files3
        echo $files

        foreach($file in $files)
        {
            $date = (get-date).addminutes($i).tostring("yyMMddhhmm")
            $fullName = "$header$date$bus.dat"
            Copy-Item $file "./$fullName"
            $i++
        }

        cd ..
        }

    Start-Sleep -s 1
    $date = (get-date).tostring("yyMMdd")
    $date = "TRANS$date"
    lget $date
}
