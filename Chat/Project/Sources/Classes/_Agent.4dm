property OpenAI : cs:C1710.AIKit.OpenAI
property ChatResult : Text
property model : Text
property preemptive : Boolean
property resultObjectName : Text
property continueObjectName : Text
property promptObjectName : Text
property messages : Collection
property _onResponse : 4D:C1709.Function
property stream : Boolean
property models : Object

Class constructor($baseURL : Text; $keyFile : 4D:C1709.File; $model : Text; $resultObjectName : Text; $continueObjectName : Text; $promptObjectName : Text)
	
	ASSERT:C1129(($keyFile.exists) && ($baseURL#""))
	
	This:C1470.model:=$model
	This:C1470.resultObjectName:=$resultObjectName
	This:C1470.continueObjectName:=$continueObjectName
	This:C1470.promptObjectName:=$promptObjectName
	This:C1470.stream:=True:C214  //over-ride if necessary
	This:C1470.models:={}
	
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
		baseURL: $baseURL})
	
	This:C1470.preemptive:=Process info:C1843(Current process:C322).preemptive
	
Function onModelsList($ModelListResult : cs:C1710.AIKit.OpenAIModelListResult)
	
	If (OB Instance of:C1731(This:C1470._onResponse; 4D:C1709.Function))
		This:C1470._onResponse.call(This:C1470; $chatCompletionsResult)
	End if 
/*
the following code is optional;
it is only to be executed when This=Form and Form#Null
*/
	If (Not:C34(This:C1470.preemptive))
		//%T-
		If (Form:C1466#Null:C1517)
			$index:=This:C1470.models.values.indexOf(This:C1470.model)
			If ($index#-1)
				This:C1470.models.index:=$index
			End if 
		End if 
		//%T-
	End if 
	
Function onModels($ModelListResult : cs:C1710.AIKit.OpenAIModelListResult)
	
	If ($ModelListResult.success)
		If ($ModelListResult.terminated)
			var $values : Collection
			$values:=[]
			For each ($model; $ModelListResult.models)
				
				Case of 
					: (Value type:C1509($model.capabilities)=Is object:K8:27)\
						 && (Value type:C1509($model.capabilities.completion_chat)=Is boolean:K8:9)
						If ($model.capabilities.completion_chat)  //Mistral
							$values.push($model.id)
						End if 
						
					: (Value type:C1509($model.supports_chat)=Is boolean:K8:9)
						If ($model.supports_chat)  //Fireworks
							$values.push($model.id)
						End if 
						
					: (Value type:C1509($model.pricing)=Is object:K8:27)\
						 && (Value type:C1509($model.pricing.completion)=Is text:K8:3)
						If ($model.pricing.completion="0")  //OpenRouter (:free)
							$values.push($model.id)
						End if 
						
					Else   //default
						$values.push($model.id)
				End case 
			End for each 
			This:C1470.models.values:=$values
			If ($values.length=0)
				This:C1470.models.index:=-1
				This:C1470.models.currentValue:="no models"
			Else 
				This:C1470.models.index:=0
			End if 
			This:C1470.onModelsList($ModelListResult)
		End if 
	End if 
	
Function getModels($onResponse : 4D:C1709.Function) : cs:C1710.AIKit.OpenAIModelListResult
	
	If (OB Instance of:C1731($onResponse; 4D:C1709.Function))
		This:C1470._onResponse:=$onResponse
	Else 
		This:C1470._onResponse:=Null:C1517
	End if 
	
	var $ModelListParameters : cs:C1710.AIKit.OpenAIParameters
/*
important!
by passing This to OpenAIParameters.new()
your This in the callback formula will actually be "This"
*/
	$ModelListParameters:=cs:C1710.AIKit.OpenAIParameters.new(This:C1470)
	//%W-550.26
	$ModelListParameters.stream:=False:C215  //force
	//%W+550.26
	$ModelListParameters.formula:=This:C1470.onModels
	
	return This:C1470.OpenAI.models.list($ModelListParameters)
	
Function focusUserPrompt()
	
	OBJECT SET ENABLED:C1123(*; Form:C1466.continueObjectName; True:C214)
	GOTO OBJECT:C206(*; Form:C1466.promptObjectName)
	
Function clearConversation() : cs:C1710._Agent
	
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
	
	If (This:C1470.ChatResult#"")
		This:C1470.ChatResult+="\r\r"
	End if 
	
	var $ChatCompletionsParameters : cs:C1710.AIKit.OpenAIChatCompletionsParameters
/*
important!
by passing This to OpenAIChatCompletionsParameters.new()
your This in the callback formula will actually be "This"
*/
	$ChatCompletionsParameters:=cs:C1710.AIKit.OpenAIChatCompletionsParameters.new(This:C1470)
	$ChatCompletionsParameters.model:=This:C1470.model
	$ChatCompletionsParameters.stream:=This:C1470.stream
	$ChatCompletionsParameters.formula:=This:C1470.onEventStream
	
	var $class : 4D:C1709.Class
	$class:=OB Class:C1730(This:C1470)
	
	Case of 
		: ($class.name="Cohere")
			OB REMOVE:C1226($ChatCompletionsParameters; "n")
	End case 
	
	var $ChatCompletionsResult : cs:C1710.AIKit.OpenAIChatCompletionsResult
	$ChatCompletionsResult:=This:C1470.OpenAI.chat.completions.create(This:C1470.messages; $ChatCompletionsParameters)
	
	return $ChatCompletionsResult
	
Function startConversation($messages : Collection; $onResponse : 4D:C1709.Function) : cs:C1710.AIKit.OpenAIChatCompletionsResult
	
	If (OB Instance of:C1731($onResponse; 4D:C1709.Function))
		This:C1470._onResponse:=$onResponse
	Else 
		This:C1470._onResponse:=Null:C1517
	End if 
	
	return This:C1470.clearConversation().continueConversation($messages)
	
Function onCompletion($chatCompletionsResult : cs:C1710.AIKit.OpenAIChatCompletionsResult)
	
	If (OB Instance of:C1731(This:C1470._onResponse; 4D:C1709.Function))
		This:C1470._onResponse.call(This:C1470; $chatCompletionsResult)
	End if 
/*
the following code is optional;
it is only to be executed when This=Form and Form#Null
*/
	If (Not:C34(This:C1470.preemptive))
		//%T-
		If (Form:C1466#Null:C1517)
			OBJECT SET PLACEHOLDER:C1295(*; This:C1470.promptObjectName; OBJECT Get value:C1743(This:C1470.promptObjectName))
			OBJECT SET VALUE:C1742(This:C1470.promptObjectName; "")
			var $pos : Integer
			$pos:=Length:C16(This:C1470.ChatResult)+1
			OBJECT SET VALUE:C1742(This:C1470.resultObjectName; This:C1470.ChatResult)
			HIGHLIGHT TEXT:C210(*; This:C1470.resultObjectName; $pos; $pos)
			CALL FORM:C1391(Current form window:C827; This:C1470.focusUserPrompt)
		End if 
		//%T-
	End if 
	
/*
do not use onData, onError, onResponse, onTerminate, etc. as custom callback function name!
the same property names are used internally by 
OpenAIChatCompletionsParameters > OpenAIParameters
*/
	
Function onEventStream($chatCompletionsResult : cs:C1710.AIKit.OpenAIChatCompletionsResult)
	
	If ($chatCompletionsResult.success)
		If ($chatCompletionsResult.terminated)
			//complete result
			If ($chatCompletionsResult.choice.message=Null:C1517)  //streaming
				$chatCompletionsResult:=JSON Parse:C1218(JSON Stringify:C1217($chatCompletionsResult))
				$chatCompletionsResult.choice.message:={role: "assistant"; content: This:C1470.ChatResult}
			Else   //not streaming
				This:C1470.ChatResult+=$chatCompletionsResult.choice.message.content
			End if 
			This:C1470.messages.push($chatCompletionsResult.choice.message)
			This:C1470.onCompletion($chatCompletionsResult)
		Else 
			//partial result
			This:C1470.ChatResult+=$chatCompletionsResult.choice.delta.text
		End if 
	Else 
		If ($chatCompletionsResult.terminated)
			This:C1470.ChatResult+=$chatCompletionsResult.errors.extract("message").join("\r")
		End if 
	End if 
	
	If (False:C215)  //to not abort on error
		OB REMOVE:C1226($chatCompletionsResult; "_decodingErrors")
	End if 
	
/*
the following code is optional;
it is only to be executed when This=Form and Form#Null
*/
	If (Not:C34(This:C1470.preemptive))
		//%T-
		If (Form:C1466#Null:C1517)
			var $pos : Integer
			$pos:=Length:C16(This:C1470.ChatResult)+1
			OBJECT SET VALUE:C1742(This:C1470.resultObjectName; This:C1470.ChatResult)
			HIGHLIGHT TEXT:C210(*; This:C1470.resultObjectName; $pos; $pos)
		End if 
		//%T-
	End if 