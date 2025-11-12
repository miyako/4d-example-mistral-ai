//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Moonshot : cs:C1710.Moonshot
	$Moonshot:=cs:C1710.Moonshot.new(""; "Chat Result (Moonshot)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_Moonshot")
	DIALOG:C40("TEST_Moonshot"; $Moonshot; *)
	
End if 