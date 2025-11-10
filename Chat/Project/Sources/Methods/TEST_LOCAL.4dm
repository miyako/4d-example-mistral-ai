//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Claude : cs:C1710.LOCAL
	$Claude:=cs:C1710.LOCAL.new(""; "Chat Result (LOCAL)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_LOCAL")
	DIALOG:C40("TEST_LOCAL"; $Claude; *)
	
End if 