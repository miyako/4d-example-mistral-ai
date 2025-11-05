//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $HuggingFace : cs:C1710.HuggingFace
	$HuggingFace:=cs:C1710.HuggingFace.new("openai/gpt-oss-120b:cerebras"; "Chat Result (HuggingFace)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_HuggingFace")
	DIALOG:C40("TEST_HuggingFace"; $HuggingFace; *)
	
End if 