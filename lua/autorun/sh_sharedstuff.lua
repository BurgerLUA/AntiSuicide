


--[[
local NextTick = 0

function ReamadeMouthMoveAnimation( ply,mv )

	if CLIENT then
		if NextTick <= CurTime() then
		
			if not ply:Alive() then
			
				local Ragdoll = ply:GetNWEntity("FakeRagdoll")
				--local Ragdoll = ply:GetRagdollEntity()		
				local Volume = 0
				
				if ply:IsSpeaking() then
					Volume = ply:VoiceVolume()
				else
					Volume = 0
				end

				RagdollCheckFlexes(Ragdoll,Volume)
				SendVolume(Volume)
				
			end
			
			NextTick = CurTime() + 0.01
			
		end
	end

end

hook.Add("PlayerTick","Ragdoll Stuff",ReamadeMouthMoveAnimation)

print("LOADED")

function RagdollCheckFlexes(Ragdoll,Value)

	if IsValid(Ragdoll) then
		local FlexNum = Ragdoll:GetFlexNum() - 1
						
		if ( FlexNum <= 0 ) then return end

		for i = 0, FlexNum - 1 do
			local Name = Ragdoll:GetFlexName( i )
			if ( Name == "jaw_drop" || Name == "right_part" || Name == "left_part" || Name == "right_mouth_drop" || Name == "left_mouth_drop" ) then
				Ragdoll:SetFlexWeight( i, Value )	
				--print(Value)
			end
		end
		
	end
	
end

if SERVER then
	util.AddNetworkString( "RagdollDeathFace" )
end

if CLIENT then
	function SendVolume(Volume)
		net.Start("RagdollDeathFace")
			net.WriteFloat(Volume)
		net.SendToServer()
	end
end


if SERVER then
	net.Receive("RagdollDeathFace", function(len,ply)
	
		local Ragdoll = ply:GetNWEntity("FakeRagdoll")
		local Value = net.ReadFloat()
		
		RagdollCheckFlexes(Ragdoll,Value)

	end)
end

--]]

