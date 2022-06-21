$url = "https://cheat.sh/"
$languages = @("powershell", "csharp", "javascript", "typescript", "scss", "node", "cmd", "nvim", "mysql")

if ($args.count -eq 1)
{
  $sTerm = $args[0]
  $sTerm = $sTerm.Replace(" ", "_")
  $selected = $languages | fzf --height 50% --reverse
}
else 
{
  $selected = $languages | fzf --height 50% --reverse
  $sTerm = Read-Host "What would you like to know about $($selected)?"
  $sTerm = $sTerm.Replace(" ", "_")
}

$url = $url + $selected + "/" + $sTerm
curl $url

Write-Output "Press any key to continue ..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
