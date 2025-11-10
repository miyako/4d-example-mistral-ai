//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $NVIDIA : cs:C1710.NVIDIA
	$NVIDIA:=cs:C1710.NVIDIA.new("nvidia/nemotron-nano-12b-v2-vl"; "Chat Result (NVIDIA)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_NVIDIA")
	DIALOG:C40("TEST_NVIDIA"; $NVIDIA; *)
	
End if 