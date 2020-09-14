local addonName = ...
local addon, events = CreateFrame('Frame', addonName), {}

-- API Imports
local SetBinding, GetBinding = SetBinding, GetBinding

-- -----------------------------------------------------------------------------
-- > ADDON FUNCTIONS
-- -----------------------------------------------------------------------------

local function loadBindings(self)
	local spec = GetSpecialization()
	local _, name = GetSpecializationInfo(spec)
	local binds = addon.db[spec]
	if (not binds) then
		return
	end
	if (InCombatLockdown()) then
		self:RegisterEvent('PLAYER_REGEN_ENABLED')
		return
	end
	print(string.format('Loaded keybinds for spec %d: %s', spec, name))

	for i = 1, GetNumBindings() do
		local cmd, _, key1, key2 = GetBinding(i)
		local newKey1, newKey2 = (binds[cmd] and unpack(binds[cmd]))
		if (key1 ~= newKey1) then
			if (key1) then
				SetBinding(key1) -- clear
			end
			if (newKey1) then
				SetBinding(newKey1, cmd)
			end
		end
		if (key2 ~= newKey2) then
			if (key2) then
				SetBinding(key2) -- clear
			end
			if (newKey2) then
				SetBinding(newKey2, cmd)
			end
		end
	end
	SaveBindings(GetCurrentBindingSet())
end

local function saveBindings(button)
	local spec = GetSpecialization()
	local _, name = GetSpecializationInfo(spec)

	if (button == QuickKeybindFrame.okayButton or button:GetParent().bindingsChanged) then
		print(string.format('Saved keybinds for spec %d: %s', spec, name))
	end

	local binds = {}
	for i = 1, GetNumBindings() do
		local cmd, _, key1, key2 = GetBinding(i)
		if (key1) then
			binds[cmd] = { key1, key2 }
		end
	end
	addon.db[spec] = binds
end

function addon:OnEnable()
	self:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
end

function addon:OnAddonLoaded(name)
	if (name == 'Blizzard_BindingUI') then
		KeyBindingFrame.okayButton:HookScript('OnClick', saveBindings)
		QuickKeybindFrame.okayButton:HookScript('OnClick', saveBindings)
	end
end

function events:PLAYER_REGEN_ENABLED(...)
	self:UnregisterEvent('PLAYER_REGEN_ENABLED')
	loadBindings()
end

function events:PLAYER_SPECIALIZATION_CHANGED(...)
	local unit = ...
	if (unit == 'player') then
		loadBindings()
	end
end

-- ---------------------
-- > ADDON SETUP
-- ---------------------

function events:ADDON_LOADED(...)
	local name = ...
	if (name == addonName) then
		if (not _G[self.dbName]) then
			_G[self.dbName] = {}
		end
		self.db = _G[self.dbName]
		self:OnEnable()
	else
		self:OnAddonLoaded(name)
	end
end

function addon:Initialize(db, ev)
	self.events = ev
	self.dbName = db

	-- do not register everything just yet
	self:RegisterEvent('ADDON_LOADED')

	self:SetScript('OnEvent', function(self, event, ...)
		events[event](self, ...)
	end)
end

addon:Initialize(addonName .. 'DB', events)
