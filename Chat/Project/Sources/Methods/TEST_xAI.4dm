//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $xAI : cs:C1710.xAI
	$xAI:=cs:C1710.xAI.new("grok-2-latest"; "Chat Result (xAI)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_xAI")
	DIALOG:C40("TEST_xAI"; $xAI; *)
	
End if 