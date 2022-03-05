//%attributes = {"invisible":true}
#DECLARE()->$name : Text
/*

録画を開始

*/

If (Not:C34(QuickTimePlayerX_isBusy))
	
	$scptFolder:=Folder:C1567(Get 4D folder:C485(Current resources folder:K5:16; *); fk platform path:K87:2).folder("scpt")
	$scptFile:=$scptFolder.file("qtp_record.scpt")
	
	$systemInfo:=Get system info:C1571
	If ($systemInfo.osVersion="macOS 10.14.@")  //Mojave
		$command:="osascript "+escape_param($scptFile.path)
	Else 
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; $scptFolder.platformPath)
		$command:="osascript "+$scptFile.fullName
	End if 
	
	var $stdIn; $stdOut; $stdErr : Blob
	LAUNCH EXTERNAL PROCESS:C811($command; $stdIn; $stdOut; $stdErr)
	
	If (BLOB size:C605($stdOut)#0)
		$lines:=Split string:C1554(Convert to text:C1012($stdOut; "utf-8"); "\n"; sk trim spaces:K86:2 | sk ignore empty strings:K86:1)
		If ($lines.length#0)
			$name:=$lines[0]
			QuickTimePlayerX_setBusy(True:C214)
		End if 
	End if 
	
End if 