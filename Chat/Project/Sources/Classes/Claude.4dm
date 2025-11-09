Class extends _Agent

Class constructor($model : Text; $resultObjectName : Text; $continueObjectName : Text; $promptObjectName : Text)
	
	var $keyFile : 4D:C1709.File
	$keyFile:=Folder:C1567(Folder:C1567("/PACKAGE/").platformPath; fk platform path:K87:2).parent.file("Claude.token")
	
	Super:C1705("https://api.anthropic.com/v1"; $keyFile; \
		$model; $resultObjectName; $continueObjectName; $promptObjectName)
	
	This:C1470.OpenAI.customHeaders:={}
	This:C1470.OpenAI.customHeaders["x-api-key"]:=This:C1470.OpenAI.apiKey
	This:C1470.OpenAI.customHeaders["anthropic-version"]:="2023-06-01"