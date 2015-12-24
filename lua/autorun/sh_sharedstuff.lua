


for i=1,5 do
	util.PrecacheSound("ambient_mp3/bumper_car_quack"..i..".mp3")
end


function BetterFootsteps(ply,pos,foot,sound,volume,filter)

--[[
	local Velocity = ply:GetVelocity():Length()
	
	if Velocity > 450 and ply:KeyDown(IN_SPEED) then
		sound = "ambient_mp3/bumper_car_quack"..math.random(1,5)..".mp3"
		EmitSound(sound,pos,ply:EntIndex(),CHAN_BODY,volume,SNDLVL_180dB,SND_NOFLAGS,100)
		return true
	end
--]]

end

hook.Add("PlayerFootstep","Better Footsteps",BetterFootsteps)