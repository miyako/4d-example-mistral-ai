//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Azure : cs:C1710.Azure
	$Azure:=cs:C1710.Azure.new("gpt-oss-120b"; "Chat Result (Azure)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_Azure")
	DIALOG:C40("TEST_Azure"; $Azure; *)
	
End if 