Class extends _Agent

Class constructor($model : Text; $resultObjectName : Text; $continueObjectName : Text; $promptObjectName : Text)
	
	var $keyFile : 4D:C1709.File
	$keyFile:=Folder:C1567(Folder:C1567("/PACKAGE/").platformPath; fk platform path:K87:2).parent.file("DeepInfra.token")
	
	Super:C1705("https://api.deepinfra.com/v1/openai"; $keyFile; \
		$model; $resultObjectName; $continueObjectName; $promptObjectName)