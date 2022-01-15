$item = fzf --reverse --height 50% --preview="more {}"
if ($item -ne $null)
{
    nvim $item
}
