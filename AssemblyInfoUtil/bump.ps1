$AssemblyInfoUtil = "C:\Scripts\AssemblyInfoUtil\AssemblyInfoUtil.exe"
$ProjectInfo = es -path ./ AssemblyInfo.cs

if ($args.count -eq 1)
{
  $versionPos = $args[0]
  & $AssemblyInfoUtil -inc:$versionPos $ProjectInfo
}
else 
{
  & $AssemblyInfoUtil -inc:3 $ProjectInfo
}
