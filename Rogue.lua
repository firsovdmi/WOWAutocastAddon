local behindBanCycleCount=2
local behindBanCycleCountCurrent=0
local behindBanRequest=false

function BindRogue()
	RegistUnitSpell("target", "Бросок")
	RegistUnitSpell("target", "Коварный удар")
	RegistUnitSpell("target", "Потрошение")
	RegistUnitSpell("target", "Удар в спину")
end

function RogueHandler()

	if behindBanRequest then
		behindBanCycleCountCurrent=behindBanCycleCount+1
		behindBanRequest=false
	end
	if behindBanCycleCountCurrent>0 then behindBanCycleCountCurrent=behindBanCycleCountCurrent-1 end
	
--	if IsCanCastToTarget("Удар в спину") and CheckBehind() then
--		CastToTarget("Удар в спину")
--		return
--	end
	if IsCanCastToTarget("Потрошение") and GetComboPoints("player","target")>=3 then
		CastToTarget("Потрошение")
		return
	end
	if IsCanCastToTarget("Коварный удар") then
		CastToTarget("Коварный удар")
		return
	end
	if IsCanCastToTarget("Бросок") then
		CastToTarget("Бросок")
		return
	end
	StopCast()
end

function CheckBehind()
	return behindBanCycleCountCurrent<=0
end

function RogueCombatLogEventText(text)
	if text=="Вы должны находиться позади цели." then
		behindBanRequest=true
	end
end