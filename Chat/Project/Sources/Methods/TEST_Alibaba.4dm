//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $Alibaba : cs:C1710.Alibaba
	$Alibaba:=cs:C1710.Alibaba.new("qwen-max"; "Chat Result (Alibaba)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_Alibaba")
	DIALOG:C40("TEST_Alibaba"; $Alibaba; *)
	
End if 