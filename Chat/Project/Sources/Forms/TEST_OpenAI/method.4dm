var $event : Object
$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1)
		
		Form:C1466.systemPrompt:="You are a helpful assistant."
		Form:C1466.userPrompt:="Who is the best French painter? Answer in one short sentence."
		Form:C1466.clearConversation().getModels()
		
	: ($event.code=On Unload:K2:2)
		
End case 