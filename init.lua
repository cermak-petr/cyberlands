local MODNAME = minetest.get_current_modname()
local MODPATH = minetest.get_modpath(MODNAME)
local S = minetest.get_translator(MODNAME)

function get_setting(key, default)
	local value = minetest.settings:get("cyberlands." .. key)
	local num_value = tonumber(value)
	if value and not num_value then
		print("Invalid value for setting %s: %q. Using default %q.", key, value, default)
	end
	return num_value or default
end

dofile(MODPATH .. "/util.lua")
dofile(MODPATH .. "/research.lua")
dofile(MODPATH .. "/items.lua")
dofile(MODPATH .. "/global.lua")
dofile(MODPATH .. "/nodes.lua")
dofile(MODPATH .. "/tools.lua")
dofile(MODPATH .. "/alq_ruins.lua")
--dofile(MODPATH .. "/dark_city.lua")
dofile(MODPATH .. "/alien_meadows.lua")
dofile(MODPATH .. "/robots.lua")
dofile(MODPATH .. "/portal.lua")
dofile(MODPATH .. "/log_reader.lua")