if ($args.count -eq 0)
{
    echo '------------------------------'
    echo 'NO ARGS'
    echo '------------------------------'
}
if ($args.count -eq 1)
{
    wsl googler -w amazon.com -w ebay.com $args[0]
}
