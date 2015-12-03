
function FuckYouBill(player)
	
	player:ChatPrint("Fuck you " .. player:Nick() .. ".")

	return false
end

hook.Add("CanPlayerSuicide","FUCK YOU BILL",FuckYouBill)