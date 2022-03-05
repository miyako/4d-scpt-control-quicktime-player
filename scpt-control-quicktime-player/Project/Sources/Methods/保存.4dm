//%attributes = {"invisible":true}
#DECLARE($name : Text; $path : Text)
/*

録画を保存

*/

$scptFolder:=Folder:C1567(Get 4D folder:C485(Current resources folder:K5:16; *); fk platform path:K87:2).folder("scpt")
$scptFile:=$scptFolder.file("qtp_close.scpt")

$systemInfo:=Get system info:C1571
If ($systemInfo.osVersion="macOS 10.14.@")  //Mojave
	$command:="osascript "+escape_param($scptFile.path)
Else 
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; $scptFolder.platformPath)
	$command:="osascript "+$scptFile.fullName
End if 

$command:=$command+" "+escape_param($name)+" "+escape_param(Convert path system to POSIX:C1106($path))

var $stdIn; $stdOut; $stdErr : Blob
LAUNCH EXTERNAL PROCESS:C811($command; $stdIn; $stdOut; $stdErr)

QuickTimePlayerX_setBusy(False:C215)