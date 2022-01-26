if ($args.Count -eq 0)
{
    es -path ./ *.exe $args[0] | awk '$0 ~ /Debug/ && $0 ~ /bin/ && $0 !~ /obj/' | awk '$0 !~ /Executables/ {print $NF}'| fzf --height 50% --reverse
}
