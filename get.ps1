if ($args.Count -eq 1)
	{
		md $args[0]
		cd $args[0]
		gs $args[0] | cp 
	}
cl