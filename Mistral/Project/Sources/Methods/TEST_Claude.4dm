//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Claude : cs:C1710.Claude
	$Claude:=cs:C1710.Claude.new("claude-sonnet-4-20250514"; "Chat Result (Claude)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_Claude")
	DIALOG:C40("TEST_Claude"; $Claude; *)
	
End if 