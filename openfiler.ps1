$arg = $args
	$run = ls -path -recursive ./ | ? {$_ -match $arg}
	ii $run

	GetFoundFileMessage $arg
