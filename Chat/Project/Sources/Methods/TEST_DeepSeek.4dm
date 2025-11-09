//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $DeepSeek : cs:C1710.DeepSeek
	$DeepSeek:=cs:C1710.DeepSeek.new("deepseek-chat"; "Chat Result (DeepSeek)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_DeepSeek")
	DIALOG:C40("TEST_DeepSeek"; $DeepSeek; *)
	
End if 