if ($args.count -eq 1)
{
  echo 'No arguments accepted'
}
else 
{
  msbuild /p:Configuration=debug
  cd bin/debug
  $path = es -path ./ *.exe | grep "Debug" | grep "bin"
  ii $path
}
