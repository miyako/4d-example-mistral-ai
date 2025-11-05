//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $DeepInfra : cs:C1710.DeepInfra
	$DeepInfra:=cs:C1710.DeepInfra.new("meta-llama/Llama-2-70b-chat-hf"; "Chat Result (DeepInfra)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_DeepInfra")
	DIALOG:C40("TEST_DeepInfra"; $DeepInfra; *)
	
End if 