Class extends _Agent

Class constructor($model : Text; $resultObjectName : Text; $continueObjectName : Text; $promptObjectName : Text)
	
	var $keyFile : 4D:C1709.File
	$keyFile:=Folder:C1567(Folder:C1567("/PACKAGE/").platformPath; fk platform path:K87:2).parent.file("Perplexity.token")
	
	Super:C1705("https://api.perplexity.ai"; $keyFile; \
		$model; $resultObjectName; $continueObjectName; $promptObjectName)
	
	This:C1470.stream:=False:C215
	
Function getModels()
/*
models endpoint unavailable
*/
	This:C1470.models:={values: [This:C1470.model]; index: 0}