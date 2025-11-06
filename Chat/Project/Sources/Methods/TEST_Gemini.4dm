//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Gemini : cs:C1710.Gemini
	$Gemini:=cs:C1710.Gemini.new("gemini-2.5-flash"; "Chat Result (Gemini)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_Gemini")
	DIALOG:C40("TEST_Gemini"; $Gemini; *)
	
End if 