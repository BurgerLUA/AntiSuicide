--[[
function IKnowIShouldntDoThis()
	
	local ply = LocalPlayer()
		
	if ply:Alive() == false and ply:IsSpeaking() then
	
	end

end

hook.Add("Think","Ragdoll Mod Think 2",IKnowIShouldntDoThis)
--]]