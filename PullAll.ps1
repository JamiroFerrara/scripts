if ($args.count -eq 0)
{
  write-host -foregroundcolor green "Pulling all repositories.. Please wait"
  $repos = ls -Name -Directory
  foreach ($repo in $repos)
  {
    if ($repo -inotmatch "plugin"){
      cd $repo
      git pull
      cd ..
    }
  }
}
else
{
  write-host -foregroundcolor green ""
}
