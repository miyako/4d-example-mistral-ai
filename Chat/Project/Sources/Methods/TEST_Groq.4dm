//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Groq : cs:C1710.Groq
	$Groq:=cs:C1710.Groq.new("llama-3.1-8b-instant"; "Chat Result (Groq)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_Groq")
	DIALOG:C40("TEST_Groq"; $Groq; *)
	
End if 