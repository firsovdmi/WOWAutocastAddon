
local currentSpec
function MainCycle()
	local _, className = UnitClass("player")
	if currentSpec ~= className then
		currentSpec = className
		if currentSpec=="ROGUE" then BindRogue() end
		if currentSpec=="PALADIN" then BindPaladin() end
	end
	if currentSpec=="ROGUE" then RogueHandler() end
	if currentSpec=="PALADIN" then PaladinHandler() end
end
function UpdateCycle(timeElapse)
	local _, className = UnitClass("player")
	if currentSpec=="PALADIN" then PaladinFastUpdate(timeElapse) end
end

function CombatLogEventText(text)
	if currentSpec=="ROGUE" then RogueCombatLogEventText(text) end
end