local mainCycle = 0.3


local autocastControlFrameIsVisible=true
local b = CreateFrame("Button", "ButtonDebug", UIParent, "UIPanelButtonTemplate")
b:SetSize(80 ,22) -- width, height
b:SetText("DEBUG")
b:SetPoint("TOPRIGHT")
b:SetScript("OnClick", function()
	if autocastControlFrameIsVisible then
		AutocastControlFrame:Hide()
	else
		AutocastControlFrame:Show()
	end
	autocastControlFrameIsVisible= not autocastControlFrameIsVisible
end)

OnOffState=true
function OnOffCast()
	OnOffState= not OnOffState
	if OnOffState then
		OnOffCastButton:SetText("Autocast ON")
	else
		OnOffCastButton:SetText("Autocast OFF")
	end
end

local checkSumPixel = CreateFrame("Frame", "checkSumPixel", UIparent)
checkSumPixel:SetWidth(1)
checkSumPixel:SetHeight(1)
checkSumPixel:SetPoint("TOPLEFT",1,0)
checkSumPixel:SetFrameStrata("BACKGROUND")
local texturecheckSumPixel = checkSumPixel:CreateTexture("BACKGROUND")
texturecheckSumPixel:SetTexture(42/255, 0, 42/255, 1)
texturecheckSumPixel:SetAllPoints(checkSumPixel)

local commandPixel = CreateFrame("Frame", "commandPixel", UIparent)
commandPixel:SetWidth(1)
commandPixel:SetHeight(1)
commandPixel:SetPoint("TOPLEFT")
commandPixel:SetFrameStrata("BACKGROUND")
local texturecommandPixel = commandPixel:CreateTexture("TexturecommandPixel", "BACKGROUND")
texturecommandPixel:SetTexture(0, 0, 0, 1)
texturecommandPixel:SetAllPoints(commandPixel)

local b = CreateFrame("Button", "ButtonReload", UIParent, "UIPanelButtonTemplate")
b:SetSize(80 ,22) -- width, height
b:SetText("Reload!")
b:SetPoint("TOP")
b:SetScript("OnClick", function()
    ReloadUI();
end)



local eventFrame = CreateFrame("FRAME", nil);
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
eventFrame:RegisterEvent("CURSOR_UPDATE");
local function eventHandler(self, event, p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		CombatLogEventText(p12)		
	end	
end
eventFrame:SetScript("OnEvent", eventHandler);

local random = math.random
local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

function RegistUnitSpell(unit, spell)
	RegistBind("spell", unit, spell)
end

KeyCastMap={}
KeyCodeIndex=1
function RegistBind(actionType, unit, spell)
	local Button = CreateFrame("Button", uuid(), UIParent,"SecureActionButtonTemplate")
	Button:SetAttribute("type", actionType)
	Button:SetAttribute("unit", unit)
	Button:SetAttribute("spell", spell)
	SetBindingClick(KeyCode[KeyCodeIndex],Button:GetName())
	local newItem={}	
	newItem.Type=actionType
	newItem.Unit=unit
	newItem.Spell=spell
	KeyCastMap[KeyCodeIndex]=newItem
	KeyCodeIndex=KeyCodeIndex + 1
end

local function SetPixelColor(pixelColor)
	CurrentActionText:SetText(tostring(pixelColor))
	if pixelColor>=510 then
		TexturecommandPixel:SetTexture(1, 1, (pixelColor-510)/255, 1)
		return
	end
	if pixelColor>=255 then
		TexturecommandPixel:SetTexture(1, (pixelColor-255)/255, 0, 1)
		return
	end
	TexturecommandPixel:SetTexture(pixelColor/255, 0, 0, 1)
end

function ActivateBinding(actionType, unit, spell)
	table.foreach(KeyCastMap, function(k,v)
		if v.Type==actionType
			and v.Unit==unit
			and v.Spell==spell
		then
			SetPixelColor(k)
			return true 
		end
	end)
	return false
end


function ResetPixelColor()
	SetPixelColor(0)
end


local currentTimeElapse=mainCycle
local ft = CreateFrame("Frame")
ft:SetScript("OnUpdate", function(self, elapsed)
     currentTimeElapse = currentTimeElapse - elapsed
	 if OnOffState then UpdateCycle(elapsed) end
     if currentTimeElapse <= 0 then
		if OnOffState then MainCycle() end
		currentTimeElapse=mainCycle
     end
end)

function PrintDebugText(text)
	DebugText:SetText(tostring(text))
end
function PrintDebugFiveText(t1,t2,t3,t4,t5)
	PrintDebugText(tostring(t1).."|"..tostring(t2).."|"..tostring(t3).."|"..tostring(t4).."|"..tostring(t5))
end
function PrintDebug15Text(t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15)
	PrintDebugText("t1="..tostring(t1).."t2="..tostring(t2).."t3="..tostring(t3).."t4="..tostring(t4).."t5="..tostring(t5).."t6="..tostring(t6).."t7="..tostring(t7).."t8="..tostring(t8).."t9="..tostring(t9).."t10="..tostring(t10).."t11="..tostring(t11).."t12="..tostring(t12).."t13="..tostring(t13).."t14="..tostring(t14).."t15="..tostring(t15))
end