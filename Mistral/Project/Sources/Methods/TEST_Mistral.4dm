//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Mistral : cs:C1710.Mistral
	$Mistral:=cs:C1710.Mistral.new("mistral-small-latest"; "Chat Result (Mistral)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_Mistral")
	DIALOG:C40("TEST_Mistral"; $Mistral; *)
	
End if 