//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $OpenAI : cs:C1710.OpenAI
	$OpenAI:=cs:C1710.OpenAI.new("gpt-4.1"; "Chat Result (OpenAI)"; "Continue Conversation"; "User Prompt")
	
	$window:=Open form window:C675("TEST_OpenAI")
	DIALOG:C40("TEST_OpenAI"; $OpenAI; *)
	
End if 