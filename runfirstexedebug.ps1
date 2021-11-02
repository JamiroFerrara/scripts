if ($args.Count -eq 0)
{
	$vars1 = getfirstexerecursive
	$run1 = $vars1 | ? {$_ -match "bin"} | ? {$_ -match "debug"}
	ii $run1

	#cl
	echo $run1
}
else 
{
	$arg = $args
	$run2 = getfirstexe | ? {$_ -match $arg}
	ii $run2

	#cl
	echo $args[0]
	echo $run2
}
