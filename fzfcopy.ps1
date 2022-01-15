$name = ls -name | fzf --height 50% --reverse 
ls -directory | ? {$_.name -eq $name} 
