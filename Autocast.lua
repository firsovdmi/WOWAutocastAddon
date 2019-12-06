
--local Autocast = LibStub("AceAddon-3.0"):NewAddon("Autocast", "AceConsole-3.0")

local b = CreateFrame("Button", "ButtonDebug", UIParent, "UIPanelButtonTemplate")
b:SetSize(80 ,22) -- width, height
b:SetText("DEBUG")
b:SetPoint("TOPRIGHT")
b:SetScript("OnClick", function()

--SetBinding("ALT-1", "cast Благословение могущества");
--SetBindingSpell("ALT-1", "Благословение могущества")
SetBindingClick("ALT-1","MyButton")
end)

local b = CreateFrame("Button", "ButtonReload", UIParent, "UIPanelButtonTemplate")
b:SetSize(80 ,22) -- width, height
b:SetText("Reload!")
b:SetPoint("TOP")
b:SetScript("OnClick", function()
    ReloadUI();
end)





function RegistSpell()
	local Button = CreateFrame("Button", "MyButton", UIParent,"SecureActionButtonTemplate")
	Button:SetAttribute("type", "spell")
	Button:SetAttribute("unit", "focus")
	Button:SetAttribute("spell", "Благословение могущества")
end
