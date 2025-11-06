//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $OpenRouter : cs:C1710.OpenRouter
	$OpenRouter:=cs:C1710.OpenRouter.new("mistralai/mistral-7b-instruct:free"; "Chat Result (OpenRouter)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_OpenRouter")
	DIALOG:C40("TEST_OpenRouter"; $OpenRouter; *)
	
End if 