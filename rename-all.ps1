if ($args.count -eq 2)
{
    Get-ChildItem -File -Recurse | % { Rename-Item -Path $_.PSPath -NewName $_.Name.replace($args[0],$args[1])}
}
else 
{
    echo '------------------------'
    echo 'Please input source and target'
    echo '------------------------'
}
