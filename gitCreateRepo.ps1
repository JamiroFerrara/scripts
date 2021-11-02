if ($args.Count -eq 1)
{
    git init -b main
    gh repo create $args
    git pull --set-upstream origin main
    git add . && git commit -m "initial commit" && git push
}
else {
    echo --------------------------
    echo 'PLEASE INPUT NAME OF REPOSITORY'
    echo --------------------------
}