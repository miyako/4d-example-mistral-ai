//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $groq : cs:C1710.groq
	$groq:=cs:C1710.groq.new("llama-3.1-8b-instant"; "Chat Result (groq)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_groq")
	DIALOG:C40("TEST_groq"; $groq; *)
	
End if 