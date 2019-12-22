local behindBanCycleCount=2
local behindBanCycleCountCurrent=0
local behindBanRequest=false

function BindPaladin()
	RegistUnitSpell("target", "Правосудие света")
	RegistUnitSpell("player", "Благословение могущества")
	RegistUnitSpell("player", "Печать праведности")
	RegistUnitSpell("target", "Печать праведности")
end

function PaladinHandler()
	if IsCanCastToTarget("Правосудие света") then
		CastToTarget("Правосудие света")
		return
	end
	if IsCanCastToPlayer("Печать праведности") and not CheckBuffPlayer("Печать праведности") then
		CastToPlayer("Печать праведности")
		return
	end
	StopCast()
end
