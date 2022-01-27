if ($args.Count -eq 0)
{
    $path = es -path ./ *.exe $args[0] | awk '$0 ~ /Debug/ && $0 ~ /bin/ && $0 !~ /obj/' | awk '$0 !~ /Executables/ {print $0}'| fzf --height 50% --reverse
    ii $path
}
