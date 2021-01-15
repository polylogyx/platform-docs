On Error Resume Next

Set oShell = CreateObject("WScript.Shell")
Set oFSO = CreateObject("Scripting.FileSystemObject")

sCurDir = Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\") - 1)

sWinDir = oShell.ExpandEnvironmentStrings ("%WinDir%")
Alluser = oShell.ExpandEnvironmentStrings ("%AllUsersProfile%")

programfiles86=oShell.expandenvironmentstrings("%ProgramFiles(x86)%")
programfiles=oShell.expandenvironmentstrings("%ProgramFiles%")
sprgdata = oShell.expandenvironmentstrings("%ProgramData%")


oshell.Run chr(34) & sCurDir & "\plgx_cpt.exe" & chr(34) & " -p -i <PolyLogyx ESP Server IP address> -k " & chr(34) & sCurDir & "\certificate.crt" & chr(34), 1 ,True

