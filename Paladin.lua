local behindBanCycleCount=2
local behindBanCycleCountCurrent=0
local behindBanRequest=false
local healCastLock = false
local healCastLockTimeout = 0.5
local healCastLockRemaingTimeout = 0

function BindPaladin()
	RegistUnitSpell("target", "Правосудие света")
	RegistUnitSpell("player", "Благословение могущества")
	RegistUnitSpell("player", "Печать праведности")
	RegistUnitSpell("player", "Божественная защита")
	RegistUnitSpell("player", "Свет небес")
	RegistUnitSpell("target", "Благословение могущества")
end

function PaladinHandler()


	PrintDebugFiveText(healCastLockRemaingTimeout)
	
	
	if PlayerIsLess20PercentHP() then
		if IsCanCastToPlayer("Божественная защита") then
			CastToPlayer("Божественная защита")
			return
		end
		if not healCastLock and IsCanCastToPlayer("Свет небес") then
			CastToPlayer("Свет небес")
			return
		end
	end
	if IsCanCastToTarget("Правосудие света") then
		CastToTarget("Правосудие света")
		return
	end
	if IsCanCastToPlayer("Печать праведности") and not CheckBuffPlayer("Печать праведности") then
		CastToPlayer("Печать праведности")
		return
	end
	if IsCanCastToPlayer("Благословение могущества") and not CheckBuffPlayer("Благословение могущества") then
		CastToPlayer("Благословение могущества")
		return
	end
	if TargetIsFriendlyPlayer() and IsCanCastToTarget("Благословение могущества") and not CheckBuffTarget("Благословение могущества") then
		CastToTarget("Благословение могущества")
		return
	end
	StopCast()
end

function PaladinFastUpdate(timeElapse)
	CheckHeal(timeElapse)
end

function CheckHeal(timeElapse)
	if IsPlayerCastingSpell("Свет небес") then
		healCastLock = true
		healCastLockRemaingTimeout = healCastLockTimeout
		return
	end
	if not healCastLock then return end
	healCastLockRemaingTimeout = healCastLockRemaingTimeout - timeElapse
	if healCastLockRemaingTimeout <=0 then
		healCastLock = false
	end
end