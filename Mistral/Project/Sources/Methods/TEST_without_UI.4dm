//%attributes = {"invisible":true}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Mistral : cs:C1710.Mistral
	$Mistral:=cs:C1710.Mistral.new("mistral-small-latest")
	
	var $messages:=[]
	$messages.push({role: "system"; content: "You are a helpful assistant."})
	$messages.push({role: "user"; content: "Who is the best French painter? Answer in one short sentence."})
	
/*
async call
result accumulate in .ChatResult
see .onData() callback function
*/
	
	$Mistral.startConversation($messages)
	
End if 