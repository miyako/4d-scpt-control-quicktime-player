//%attributes = {"invisible":true}
#DECLARE()->$QuickTimePlayerX : Object

$QuickTimePlayerX:=Storage:C1525.QuickTimePlayerX

If ($QuickTimePlayerX=Null:C1517)
	$QuickTimePlayerX:=New shared object:C1526("isBusy"; False:C215)
	Use (Storage:C1525)
		Storage:C1525.QuickTimePlayerX:=$QuickTimePlayerX
	End use 
End if 