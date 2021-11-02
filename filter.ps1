foreach ($i in $input) {
    $arg = $args
    $res = $i | ? {$_ -match $arg}
    echo $res
}
