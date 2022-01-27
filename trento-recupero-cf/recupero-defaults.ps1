$header = "TRANS"
$bus = 0000

$dirs = ls -name
foreach($dir in $dirs){
    cd $dir
    $bus = $dir
    foreach($file in ls -name -recurse){

        $time = get-date -format "yyMMddhhmm"
        $zero = "00"
        if ($bus.length -eq 3){
                    $zero = "000"     
                }
        $name = $header + $time + $zero + $bus + ".dat"

        if ($file -contains "trans_eterm.dat"){
                rni trans_eterm.dat $name
                echo $name
                }
        }
    cd ..
    }

lget *.dat (get-date -format "yyMM")
