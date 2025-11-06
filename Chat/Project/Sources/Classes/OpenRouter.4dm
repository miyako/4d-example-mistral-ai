Class extends _Agent

Class constructor($model : Text; $resultObjectName : Text; $continueObjectName : Text; $promptObjectName : Text)
	
	var $keyFile : 4D:C1709.File
	$keyFile:=Folder:C1567(Folder:C1567("/PACKAGE/").platformPath; fk platform path:K87:2).parent.file("OpenRouter.token")
	
	Super:C1705("https://openrouter.ai/api/v1"; $keyFile; \
		$model; $resultObjectName; $continueObjectName; $promptObjectName)
	
	This:C1470.stream:=False:C215  //same as gemini