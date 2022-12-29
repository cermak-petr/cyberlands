local g_meta = minetest.get_mod_storage()

local function set_string(key, value) return g_meta:set_string(key, value) end
local function get_string(key) return g_meta:get_string(key) end
local function set_int(key, value) return g_meta:set_int(key, value) end
local function get_int(key) return g_meta:get_int(key) end
local function set_float(key, value) return g_meta:set_float(key, value) end
local function get_float(key) return g_meta:get_float(key) end
local function set_table(key, value) return set_meta_table(g_meta, key, value) end
local function get_table(key) return get_meta_table(g_meta, key) end

global = {
    set_string = set_string,
    get_string = get_string,
    set_int = set_int,
    get_int = get_int,
    set_float = set_float,
    get_float = get_float,
    set_table = set_table,
    get_table = get_table
}