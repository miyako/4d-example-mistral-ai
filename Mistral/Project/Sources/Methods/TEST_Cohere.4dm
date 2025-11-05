//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Cohere : cs:C1710.Cohere
	$Cohere:=cs:C1710.Cohere.new("command-a-03-2025"; "Chat Result (Cohere)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_Cohere")
	DIALOG:C40("TEST_Cohere"; $Cohere; *)
	
End if 