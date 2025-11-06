Class extends _Agent

Class constructor($model : Text; $resultObjectName : Text; $continueObjectName : Text; $promptObjectName : Text)
	
	var $keyFile : 4D:C1709.File
	$keyFile:=Folder:C1567(Folder:C1567("/PACKAGE/").platformPath; fk platform path:K87:2).parent.file("Cohere.token")
	
	Super:C1705("https://api.cohere.ai/compatibility/v1"; $keyFile; \
		$model; $resultObjectName; $continueObjectName; $promptObjectName)