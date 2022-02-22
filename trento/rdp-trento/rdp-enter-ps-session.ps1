if ($args.count -eq 0)
{
    $dirs = cat "C:\Scripts\trento\rdp-trento\ip-list"
    $sText = $dirs | fzf --height 50% --reverse
    $output = $sText|%{$_.split('"')[1]}

    enter-pssession -computer $output -credential "mittuser"
}
