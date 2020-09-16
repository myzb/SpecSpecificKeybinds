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
	addon.modified = true
	SaveBindings(GetCurrentBindingSet())
	addon.modified = false
	print(string.format('Loaded keybinds for spec %d: %s', spec, name))
end

local function saveBindings()
	if (addon.modified) then
		return
	end
	local spec = GetSpecialization()
	local _, name = GetSpecializationInfo(spec)

	local binds = {}
	for i = 1, GetNumBindings() do
		local cmd, _, key1, key2 = GetBinding(i)
		if (key1) then
			binds[cmd] = { key1, key2 }
		end
	end
	addon.db[spec] = binds
	print(string.format('Saved keybinds for spec %d: %s', spec, name))
end

function addon:OnEnable()
	self:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
	hooksecurefunc('SaveBindings', saveBindings)
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
	end
end

function addon:Initialize(dbName, events)
	self.events = events
	self.dbName = dbName

	-- do not register everything just yet
	self:RegisterEvent('ADDON_LOADED')

	self:SetScript('OnEvent', function(self, event, ...)
		events[event](self, ...)
	end)
end

addon:Initialize(addonName .. 'DB', events)
