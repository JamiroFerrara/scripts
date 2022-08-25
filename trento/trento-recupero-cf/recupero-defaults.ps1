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

        $i = 0
        $files = es -path ./ "trans_eterm.dat"
        $files = $files 
        echo $files

        foreach($file in $files)
        {
            $date = (get-date).addminutes($i).tostring("yyMMddhhmm")
            $fullName = "$header$date$zero$bus"
            $mittDepResult = mitttransdeploycli $file $fullName
            Copy-Item $mittDepResult ("./$fullName" + ".dat")
            $i++
        }

        cd ..
        }

    Start-Sleep -s 1
    $date = (get-date).tostring("yyMMdd")
    $date = "TRANS$date"
    lget $date
}
