if ($args.count -ne 0)
{

}
else 
{
    $header = "TRANS"
    $staz = 0000

    $dirs = ls -name
    foreach($dir in $dirs){
        cd $dir
        $staz = $dir

        $i = 0

        $files = es -path ./ "trans_eterm.dat"
        $files2 = es -path ./ "trans_backup.dat"
        $files = $files + $files2
        echo $files

        foreach($file in $files)
        {
            $date = (get-date).addminutes($i).tostring("yyMMddhhmm")
            $fullName = "$header$date$staz.dat"
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
