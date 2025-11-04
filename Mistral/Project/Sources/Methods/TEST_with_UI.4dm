//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Mistral : cs:C1710.Mistral
	$Mistral:=cs:C1710.Mistral.new("mistral-small-latest"; "Chat Result"; "Continue Conversation"; "User Prompt")
	
	$window:=Open form window:C675("TEST")
	DIALOG:C40("TEST"; $Mistral; *)
	
End if 