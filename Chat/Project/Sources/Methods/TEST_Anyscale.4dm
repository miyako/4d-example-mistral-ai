//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	//CALL WORKER(1; Current method name; {})
	
/*
	
<html lang="en">
<head></head>
<meta charset="UTF-8">
<p>Thank you for using Anyscale's Public Endpoints API.</p>
<p>Effective August 1, 2024 Anyscale Endpoints API is available exclusively through the fully Hosted Anyscale Platform. Multi-tenant access to LLM models has been removed.</p>
<p>With the Hosted Anyscale Platform, you can access the latest GPUs billed by <a href="https://www.anyscale.com/pricing">the second</a>, and deploy models on your own dedicated instances. Enjoy full customization to build your end-to-end applications with Anyscale. <a href="https://console.anyscale.com/register/ha">Get started</a> today.</p>
</body>
</html>
	
*/
	
Else 
	
	var $Anyscale : cs:C1710.Anyscale
	$Anyscale:=cs:C1710.Anyscale.new("anyscale/meta‑llama/Llama‑2‑7b‑chat‑hf"; "Chat Result (Anyscale)"; "Continue Conversation"; "User Prompt")
	
	var $window : Integer
	$window:=Open form window:C675("TEST_Anyscale")
	DIALOG:C40("TEST_Anyscale"; $Anyscale; *)
	
End if 