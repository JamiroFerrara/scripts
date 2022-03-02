if ($args.count -eq 1)
{
    $file = $args[0]
    $tFile = $file.Substring(2)
    pscp -pw jf19973007 $file root@213.168.249.164:uploads/$tFile
}
