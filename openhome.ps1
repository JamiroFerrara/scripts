cd $user
clear
ls | ? {$_ -notmatch '.cisco'}| ? {$_ -notmatch '.omnisharp'}| ? {$_ -notmatch '.nuget'}| ? {$_ -notmatch '.template'}| ? {$_ -notmatch '.ueli'}| ? {$_ -notmatch '.vscode'}| ? {$_ -notmatch '3d'} | ? {$_ -notmatch '.cdHistory'}| ? {$_ -notmatch '.gitconfig'}| ? {$_ -notmatch 'Tracing'}| ? {$_ -notmatch '.dotnet'}