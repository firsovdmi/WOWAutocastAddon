
--local Autocast = LibStub("AceAddon-3.0"):NewAddon("Autocast", "AceConsole-3.0")
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
--SetBinding("ALT-1", "cast Благословение могущества");
--SetBindingSpell("ALT-1", "Благословение могущества")
--SetBindingClick(KeyCode[1],"MyButton")
end)

local b = CreateFrame("Button", "ButtonReload", UIParent, "UIPanelButtonTemplate")
b:SetSize(80 ,22) -- width, height
b:SetText("Reload!")
b:SetPoint("TOP")
b:SetScript("OnClick", function()
    ReloadUI();
end)



local eventFrame = CreateFrame("FRAME", nil);
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
local function eventHandler(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		PLAYER_ENTERING_WORLD()
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

KeyCodeIndex=1
function RegistBind(actionType, unit, spell)
	local Button = CreateFrame("Button", uuid(), UIParent,"SecureActionButtonTemplate")
	Button:SetAttribute("type", actionType)
	Button:SetAttribute("unit", unit)
	Button:SetAttribute("spell", spell)
	SetBindingClick(KeyCode[KeyCodeIndex],Button:GetName())
	KeyCodeIndex=KeyCodeIndex + 1
end

local t = 5 -- do something 5 seconds from now
local ft = CreateFrame("Frame")
ft:SetScript("OnUpdate", function(self, elapsed)
     t = t - elapsed
     if t <= 0 then
          -- do something
     end
end)