if ($args.Count -eq 1)
	{
		md $args[0]
		cd $args[0]
		es *.dat $args[0] $args[0] | cp
	}
cl