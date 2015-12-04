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

