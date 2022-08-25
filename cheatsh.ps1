$languages = @("powershell", "csharp", "javascript", "typescript", "scss", "node", "cmd", "nvim", "mysql", "react", "react-native","native-base", "git", "python", "go", "rust", "nginx", "prisma", "debian", "docker")

if ($args.count -eq 1)
{
  $url = "https://cht.sh/"
  $sTerm = $args[0]
  $sTerm = $sTerm.Replace(" ", "_")
  $selected = $languages | fzf --height 50% --reverse
  $url = $url + $selected + "/" + $sTerm
  curl $url

  Write-Output "Press any key to continue ..."
  $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

  Clear-Variable -name sTerm
  Clear-Variable -name url
  echo $sTerm
  clear
}
else 
{
  $selected = $languages | fzf --height 50% --reverse

  while ($true){
    $url = "https://cht.sh/"
    $sTerm = Read-Host "What would you like to know about $($selected)?"
    $sTerm = $sTerm.Replace(" ", "_")
    $url = $url + $selected + "/" + $sTerm
    curl $url

    Write-Output "Press any key to continue ..."
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

    Clear-Variable -name sTerm
    Clear-Variable -name url
    echo $sTerm
    clear
    }
}
