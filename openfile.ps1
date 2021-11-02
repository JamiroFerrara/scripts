try
{
	$run = @()
	if ($args.count -eq 0)
	{
		ii ./
	}

	if ($args.count -eq 1)
	{
		$arg = $args
		$run = ls -path ./ | ? {$_ -match $arg}
		ii $run

		echo "Search Term: $($arg)"
		foreach($r in $run)
		{
			echo "File: $($r)"
		}
		echo ''
	}
	else 
	{
		foreach($a in $args)
		{
			$arg = $a
			$run = ls -path ./ | ? {$_ -match $arg}
			ii $run

			echo "Search Term: $($arg)"
			foreach($r in $run)
			{
				echo "File: $($r)"
			}
			echo ''
		}
	}

	echo -----------------------------------
}
catch
{
	echo 'File not found'
}
