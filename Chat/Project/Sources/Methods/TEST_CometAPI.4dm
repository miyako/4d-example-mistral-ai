//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $CometAPI : cs:C1710.CometAPI
	$CometAPI:=cs:C1710.CometAPI.new("gpt-3.5-turbo"; "Chat Result (CometAPI)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_CometAPI")
	DIALOG:C40("TEST_CometAPI"; $CometAPI; *)
	
End if 