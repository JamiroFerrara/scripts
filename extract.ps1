if ($args.count -ne 0)
{

}
else 
{
    $dest = get-location
    $dir = ls -name | fzf --height 50% --reverse
    cd $dir

    robocopy ./ $dest
    echo $dest
}

echo "-----------------"
echo "Extracted!"
echo "-----------------"
