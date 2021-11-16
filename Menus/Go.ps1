function Show-GoToMenu
{
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Root."
    Write-Host "2: Home."
    Write-Host "3: Scripts."
    Write-Host "4: GitHub."
    Write-Host "5: Documents."
    Write-Host "6: Images."
    Write-Host "7: Music."
    Write-Host "Q: Press 'Q' to quit."
}

Show-GoToMenu –Title 'Go To?'
 $selection = Read-Host "Where do you want to go?"
 switch ($selection)
 {
     '1' {r} 
     '2' {h}
     '3' {sc}
     '4' {GitHub}
     '5' {documents}
     '6' {images}
     '7' {music}
     'q' {return}
 }
 o