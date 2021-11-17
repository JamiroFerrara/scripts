if ($args.count -eq 1)
	{
		try
		{
			$arg = $args[0]
			$res = ls | ? {$_ -match $arg}
			rm -force $res
			
			echo "------------ Folder Deleted! ------------ "
			cl
		}
		catch
		{
			echo "------------ Error ------------ "
		}
	}
else 
	{
		echo 'No parameters Specified for deletion'
	}