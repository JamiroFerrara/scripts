if ($args.count -eq 1)
{
  echo 'No arguments accepted'
}
else 
{
  msbuild /p:Configuration=release
}
