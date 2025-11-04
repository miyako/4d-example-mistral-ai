property OpenAI : cs:C1710.AIKit.OpenAI
property ChatResult : Text
property model : Text
property preemptive : Boolean
property resultObjectName : Text
property continueObjectName : Text
property promptObjectName : Text
property messages : Collection

Class constructor($model : Text; $resultObjectName : Text; $continueObjectName : Text; $promptObjectName : Text)
	
	This:C1470.model:=$model
	This:C1470.resultObjectName:=$resultObjectName
	This:C1470.continueObjectName:=$continueObjectName
	This:C1470.promptObjectName:=$promptObjectName
	
	var $OpenAI : cs:C1710.AIKit.OpenAI
	var $keyFile : 4D:C1709.File
	$keyFile:=Folder:C1567(Folder:C1567("/PACKAGE/").platformPath; fk platform path:K87:2).parent.file("Mistral.token")
	If ($keyFile.exists)
/*
		
apiKey:        Text
baseURL:       Text
organization:  Text
project:       Text
timeout:       Real
maxRetries:    Real
httpAgent:     4D.HTTPAgent
customHeaders: Object 
		
https://developer.4d.com/docs/aikit/Classes/openai#configuration-properties
*/
		This:C1470.OpenAI:=cs:C1710.AIKit.OpenAI.new({\
			apiKey: $keyFile.getText(); \
			baseURL: "https://api.mistral.ai/v1"})
		//%W-550.26
		This:C1470.OpenAI.Mistral:=This:C1470
		//%W+550.26
	End if 
	
	This:C1470.preemptive:=Process info:C1843(Current process:C322).preemptive
	
Function focusUserPrompt()
	
	OBJECT SET ENABLED:C1123(*; Form:C1466.continueObjectName; True:C214)
	GOTO OBJECT:C206(*; Form:C1466.promptObjectName)
	
Function clearConversation() : cs:C1710.Mistral
	
	This:C1470.ChatResult:=""
	This:C1470.messages:=[]
	
	If (Not:C34(This:C1470.preemptive))
		//%T-
		If (Form:C1466#Null:C1517)
			OBJECT SET ENABLED:C1123(*; This:C1470.continueObjectName; False:C215)
		End if 
		//%T-
	End if 
	
	return This:C1470
	
Function continueConversation($messages : Collection) : cs:C1710.AIKit.OpenAIChatCompletionsResult
	
	This:C1470.messages.combine($messages)
	
	var $ChatCompletionsParameters : cs:C1710.AIKit.OpenAIChatCompletionsParameters
	$ChatCompletionsParameters:=cs:C1710.AIKit.OpenAIChatCompletionsParameters.new()
	$ChatCompletionsParameters.model:=This:C1470.model
	$ChatCompletionsParameters.formula:=This:C1470.onData
	$ChatCompletionsParameters.stream:=True:C214
	
	var $ChatCompletionsResult : cs:C1710.AIKit.OpenAIChatCompletionsResult
	$ChatCompletionsResult:=This:C1470.OpenAI.chat.completions.create(This:C1470.messages; $ChatCompletionsParameters)
	
	return $ChatCompletionsResult
	
Function startConversation($messages : Collection) : cs:C1710.AIKit.OpenAIChatCompletionsResult
	
	return This:C1470.clearConversation().continueConversation($messages)
	
Function onResponse($chatCompletionsResult : cs:C1710.AIKit.OpenAIChatCompletionsResult)
	
	//called on successful termination
	
	If (Not:C34(This:C1470.preemptive))
		//%T-
		If (Form:C1466#Null:C1517)
			OBJECT SET PLACEHOLDER:C1295(*; This:C1470.promptObjectName; OBJECT Get value:C1743(This:C1470.promptObjectName))
			OBJECT SET VALUE:C1742(This:C1470.promptObjectName; "")
			var $pos : Integer
			$pos:=Length:C16(This:C1470.ChatResult)+1
			HIGHLIGHT TEXT:C210(*; This:C1470.resultObjectName; $pos; $pos)
			CALL FORM:C1391(Current form window:C827; This:C1470.focusUserPrompt)
		End if 
		//%T-
	End if 
	
Function onData($chatCompletionsResult : cs:C1710.AIKit.OpenAIChatCompletionsResult)
	
	//%W-550.26
	var $that : cs:C1710.Mistral
	$that:=This:C1470.Mistral
	//%W+550.26
	
/*
"This" in this context is cs.AIKit.OpenAI
*/
	
	If ($chatCompletionsResult.success)
		If ($chatCompletionsResult.terminated)
			//complete result
			If ($chatCompletionsResult.choice.message=Null:C1517)  //streaming
				$chatCompletionsResult:=JSON Parse:C1218(JSON Stringify:C1217($chatCompletionsResult))
				$chatCompletionsResult.choice.message:={content: $that.ChatResult}
			End if 
			$that.onResponse($chatCompletionsResult)
		Else 
			//partial result
			$that.ChatResult+=$chatCompletionsResult.choice.delta.text
		End if 
	End if 
	
	If (Not:C34($that.preemptive))
		//%T-
		If (Form:C1466#Null:C1517)
			var $pos : Integer
			$pos:=Length:C16($that.ChatResult)+1
			HIGHLIGHT TEXT:C210(*; $that.resultObjectName; $pos; $pos)
		End if 
		//%T-
	End if 