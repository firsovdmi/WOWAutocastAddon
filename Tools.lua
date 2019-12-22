-- CastToTarget(spellName) Применяет способность на цель
-- CastToUnit(unit, spellName) Применяет способность на юнит
-- CheckBuff(unit, spellName) Проверяет, есть ли баф на юните
-- CheckBuffPlayer(spellName) Проверяет, есть ли баф на игроке
-- CheckBuffTarget(spellName) Проверяет, есть ли баф на цели
-- GetCooldownReamingPercent(spellName) Возвращает оставшееся время кулдауна способности в процентах
-- IsCanCast(unit, spellName) Проверяет, можно ли применить способность на юнит
-- IsCanCastToTarget(spellName) Проверяет, можно ли применить способность на цель
-- IsNoCooldown(spellName) Проверяет кулдаун способности


function IsCanCast(unit, spellName)
	usable, nomana = IsUsableSpell(spellName)
	if IsSpellInRange(spellName, unit)==1
		and usable and not nomana 
		and IsNoCooldown(spellName)
	then
		return true
	end
	return false
end

function IsCanCastToTarget(spellName)
	return IsCanCast("target", spellName)
end

function IsCanCastToPlayer(spellName)
	return IsCanCast("player", spellName)
end

function CastToTarget(spellName)
	CastToUnit("target", spellName)
end
function CastToUnit(unit, spellName)
	ActivateBinding("spell", unit, spellName)
end

function StopCast()
	ResetPixelColor()
end

function GetCooldownReamingPercent(spellName)
	local start, duration, enabled = GetSpellCooldown(spellName);
	return start + duration - GetTime()
end

function IsNoCooldown(spellName)
	return GetCooldownReamingPercent(spellName)<=0
end

function CheckBuff(unit, spellName)
	local i = 1
	local buff = UnitBuff("player", i);
	if buff == spellName then return true end 
	while buff do
	  i = i + 1;
	  buff = UnitBuff("player", i);
	  if buff == spellName then return true end
	end;	
	return false
end

function CheckBuffPlayer(spellName)
	return CheckBuff("player", spellName)
end

function CheckBuffTarget(spellName)
	return CheckBuff("target", spellName)
end