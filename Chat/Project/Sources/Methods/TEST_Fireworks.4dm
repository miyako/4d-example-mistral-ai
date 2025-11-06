//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Fireworks : cs:C1710.Fireworks
	$Fireworks:=cs:C1710.Fireworks.new("accounts/fireworks/models/llama-v3p1-8b-instruct"; "Chat Result (Fireworks)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_Fireworks")
	DIALOG:C40("TEST_Fireworks"; $Fireworks; *)
	
End if 