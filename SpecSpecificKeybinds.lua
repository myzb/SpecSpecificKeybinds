local addonName = ...
local addon, events = CreateFrame('Frame', addonName), {}

-- API Imports
local SetBinding, GetBinding = SetBinding, GetBinding
local GetSpecialization = GetSpecialization

-- -----------------------------------------------------------------------------
-- > ADDON FUNCTIONS
-- -----------------------------------------------------------------------------

local function loadBindings(self, spec)
	local _, name = GetSpecializationInfo(spec)
	if (not self.db.binds[spec]) then
		self.db.binds[spec] = self.db.binds[self.lastSpec]
	end
	local binds = self.db.binds[spec]

	if (InCombatLockdown()) then
		self:RegisterEvent('PLAYER_REGEN_ENABLED')
		return
	end

	self:UnregisterEvent('UPDATE_BINDINGS')
	for i = 1, GetNumBindings() do
		local cmd, _, key1, key2 = GetBinding(i)
		local newKey1, newKey2 = unpack(binds[cmd] or {})
		if (key1 ~= newKey1) then
			if (key1) then
				SetBinding(key1) -- clear
			end
			if (newKey1) then
				SetBinding(newKey1, cmd)
			end
		end
		if (key2 ~= newKey2) then
			if (key2 and key2 ~= newKey1) then
				SetBinding(key2) -- clear
			end
			if (newKey2) then
				SetBinding(newKey2, cmd)
			end
		end
	end
	SaveBindings(GetCurrentBindingSet())
	self:RegisterEvent('UPDATE_BINDINGS')
	self.lastSpec = spec
	print(string.format('|cffffff00Key Bindings set to Specialization: %s|r', name))
end

local function saveBindings(self, spec)
	local binds = {}
	for i = 1, GetNumBindings() do
		local cmd, _, key1, key2 = GetBinding(i)
		if (key1) then
			binds[cmd] = { key1, key2 }
		end
	end
	self.db.binds[spec] = binds
end

local function cmdHandler(msg, ...)
	local actions = {
		['help'] = function()
			-- nothing for now
		end,
		['load'] = function(arg)
			local spec = tonumber(arg)
			if (not spec or spec < 1 or spec > GetNumSpecializations()) then
				return
			end
			loadBindings(addon, spec)
		end
	}
	local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
	local func = actions[cmd] or actions['help']
	func(args)
end

function addon:OnEnable()
	if (next(self.db) == nil) then
		self.db.config = {}
		self.db.binds = {}
	end
	-- chat commands
	local cmdName = GetAddOnMetadata(addonName, 'X-SlashCmdList'):gsub('%s+', '')
	_G['SLASH_'.. cmdName .. '1'] = cmdName
	SlashCmdList[cmdName] = cmdHandler

	self:RegisterEvent('PLAYER_LOGIN')
end

function events:PLAYER_LOGIN(...)
	local spec = GetSpecialization()
	if (not self.db.binds[spec]) then
		saveBindings(self, spec)
	end
	self.lastSpec = spec
	self:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
	self:RegisterEvent('UPDATE_BINDINGS')
end

function events:PLAYER_REGEN_ENABLED(...)
	self:UnregisterEvent('PLAYER_REGEN_ENABLED')
	loadBindings(self, GetSpecialization())
end

function events:ACTIVE_TALENT_GROUP_CHANGED(...)
	local spec = GetSpecialization()
	if (self.lastSpec ~= spec) then
		loadBindings(self, spec)
	end
end

function events:UPDATE_BINDINGS(...)
	saveBindings(self, GetSpecialization())
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
