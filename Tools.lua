-- CastToPlayer(spellName) Применяет способность на игрока
-- CastToTarget(spellName) Применяет способность на цель
-- CastToUnit(unit, spellName) Применяет способность на юнит
-- CheckBuff(unit, spellName) Проверяет, есть ли баф на юните
-- CheckBuffPlayer(spellName) Проверяет, есть ли баф на игроке
-- CheckBuffTarget(spellName) Проверяет, есть ли баф на цели
-- GetCooldownReamingPercent(spellName) Возвращает оставшееся время кулдауна способности в процентах
-- IsCanCast(unit, spellName) Проверяет, можно ли применить способность на юнит
-- IsCanCastToTarget(spellName) Проверяет, можно ли применить способность на цель
-- IsNoCooldown(spellName) Проверяет кулдаун способности
-- TargetIsPlayer() Проверяет, что цель - живой игрок
-- TargetIsFriendlyPlayer() Проверяет, что цель - дружественный живой игрок
-- UnitPercentHP(unit) Процент здоровья юнита
-- UnitIsLess20PercentHP(unit) Проверяет, что здоровье юнита меньше 20%
-- PlayerIsLess20PercentHP() Проверяет, что здоровье игрока меньше 20%
-- IsUnitCastingSpell(unit, spellName) Проверяет, что юнит кастует спел
-- IsPlayerCastingSpell(spellName) Проверяет, что игрок кастует спел


function IsCanCast(unit, spellName)
	usable, nomana = IsUsableSpell(spellName)
	if (IsSpellInRange(spellName, unit)==1 or unit=="player")
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

function CastToUnit(unit, spellName)
	ActivateBinding("spell", unit, spellName)
end

function CastToTarget(spellName)
	CastToUnit("target", spellName)
end

function CastToPlayer(spellName)
	CastToUnit("player", spellName)
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
	local buff = UnitBuff(unit, i);
	if buff == spellName then return true end 
	while buff do
	  i = i + 1;
	  buff = UnitBuff(unit, i);
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

function TargetIsPlayer()
	if not UnitExists("target") then return false end
	if not UnitIsPlayer("target") then return false end
	return true
end

function TargetIsFriendlyPlayer()
	if not TargetIsPlayer() then return false end
	if not UnitIsFriend("player", "target") then return false end	
	return true
end

function UnitPercentHP(unit)
	if not UnitExists(unit) then return false end
	local maxHealth = UnitHealthMax(unit);
	local health = UnitHealth(unit);
	local healthPercent = health * 100 / maxHealth
	return healthPercent
end

function UnitIsLess20PercentHP(unit)
	if not UnitExists(unit) then return false end
	return UnitPercentHP(unit)<20
end

function PlayerIsLess20PercentHP()
	return UnitPercentHP("player")<20
end

function IsUnitCastingSpell(unit, spellName)
	spell = UnitCastingInfo(unit)
	if spell == spellName then
		return true
	end
	return false	
end

function IsPlayerCastingSpell(spellName)
	return IsUnitCastingSpell("player", spellName)	
end