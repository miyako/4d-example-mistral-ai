//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Perplexity : cs:C1710.Perplexity
	$Perplexity:=cs:C1710.Perplexity.new("sonar"; "Chat Result (Perplexity)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_Perplexity")
	DIALOG:C40("TEST_Perplexity"; $Perplexity; *)
	
End if 