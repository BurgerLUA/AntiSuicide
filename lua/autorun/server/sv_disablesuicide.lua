local RudeTable = {"Eva Braun","Kurt Colbain","Christopher Dorner","Adolf Hitler","Robin Williams"}

function FuckYouBill(player)
	player:ChatPrint("Calm down there " .. RudeTable[math.random(1,#RudeTable)] .. "." )
	return false
end

hook.Add("CanPlayerSuicide","FUCK YOU BILL",FuckYouBill)


function SuperSpawnProtectionPlayerSpawn(ply)
	ply.ImmuneFromDamage = true
	ply.SpawnImmunityTime = CurTime() + 3
end

hook.Add( "PlayerSpawn", "Spawn Protection Spawn", SuperSpawnProtectionPlayerSpawn )


function SuperSpawnProtectionThink()
	for k,ply in pairs(player.GetAll()) do
		if ply:Alive() == true then
			if ply.ImmuneFromDamage == true then
			
				if ply.SpawnImmunityTime <= CurTime() then
					ply:ChatPrint("Your spawn protection has worn off.")
					ply.ImmuneFromDamage = false
					ply:SetHealth(100)
				end
				
				if ply:KeyDown(IN_ATTACK) and ply.SpawnImmunityTime - 1 <= CurTime() then
					ply:ChatPrint("Your spawn protection has worn off.")
					ply.ImmuneFromDamage = false
					ply:SetHealth(100)
				end
				
			end
		end
	end
end

hook.Add( "Think", "Spawn Protection Think", SuperSpawnProtectionThink )


function SuperSpawnProtectionPlayerShouldTakeDamage(ply,attacker)

	if ply.ImmuneFromDamage == true then
		return false
	end

end

hook.Add( "PlayerShouldTakeDamage", "Spawn Protection PlayerShouldTakeDamage", SuperSpawnProtectionPlayerShouldTakeDamage )


local GlobalCritChance = 10
local GlobalCritMul	= 2
local GlobalCritAdd = 1

function BurCritDamage(victim,hitgroup,dmginfo)

	local attacker = dmginfo:GetAttacker()

	if victim:IsPlayer() and attacker:IsPlayer() then

		if not attacker.CritChance then
			attacker.CritChance = GlobalCritChance
		end
		
		if math.random(1,100) <= attacker.CritChance then
			dmginfo:ScaleDamage(2)
			print(attacker:Name() .. " scored a critical hit on " .. victim:Name())
			
			victim:EmitSound("player/crit_received"..math.random(1,3)..".wav")
			attacker:EmitSound("player/crit_hit"..math.random(2,5)..".wav")
			
			
			attacker.CritChance = GlobalCritChance
		else
			attacker.CritChance = attacker.CritChance + GlobalCritAdd
		end
		
	end

end

hook.Add("ScalePlayerDamage","Burger Crits",BurCritDamage)





