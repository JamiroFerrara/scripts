if ($args.count -eq 1)
{
  echo 'No arguments accepted'
}
else 
{
  msbuild /p:Configuration=debug
  start-sleep 0.7
  $path = es -path ./ *.exe | grep "Debug" | grep "bin"
  ii $path
}
