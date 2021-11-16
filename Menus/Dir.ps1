function Show-DirMenu
{
    param (
        [string]$Title = 'Current Directory'

    )

    Clear-Host
    Write-Host "================ $Title ================"
    
    $directory = ls

    $count = 0
    foreach($dir in $directory)
    {
        Write-Host $count - $dir
        $count++
    }

    Write-Host "Q: Press 'Q' to quit."
}

Show-DirMenu –Title 'Go To?'
 $selection = Read-Host "Where do you want to go?"
 switch ($selection)
 {

     '1' {r}
 }