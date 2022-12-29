local a_i3 = minetest.get_modpath("i3")
local a_ui = minetest.get_modpath("unified_inventory")

function register_craft_type(name, description, icon)
    if a_i3 then
        i3.register_craft_type(name, {
            description = description,
            icon = icon,
        })
    end
    if a_ui then
        unified_inventory.register_craft_type(name, {
            description = description,
            icon = icon,
            width = 1,
            height = 1,
            uses_crafting_grid = false,
        })
    end 
end

function register_custom_craft(type, name, new_name)
    if a_i3 then
        i3.register_craft({
            type = type,
            result = new_name,
            items = {name}
        })
    end
    if a_ui then
        unified_inventory.register_craft({
            type = type,
            output = new_name,
            items = {name}
        })
    end
end

function table_to_string(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" or type(v) == "number" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "{" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end

function string_to_table(string)
    local t_func = loadstring("return " .. string)
    if not t_func then return nil end
    return t_func()
end

function get_meta_table(meta, name)
    local s_tbl = meta:get_string(name)
    local table = string_to_table(s_tbl)
    return table
end

function set_meta_table(meta, name, data)
    if data then
        local s_tbl = table_to_string(data)
        meta:set_string(name, s_tbl)
    else meta:set_string(name, nil) end
end

function table_has_key(table, key)
    for k, v in pairs(table) do
        if k == key then return true end
    end
    return false
end

function table_has_value(table, value)
    for k, v in pairs(table) do
        if v == value then return true end
    end
    return false
end

function string_split(inputstr, sep)
   if sep == nil then
      sep = "%s"
   end
   local t={}
   for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
   end
   return t
end

function copy_table(table)
    local new_table = {}
    for key, value in pairs(table) do
        new_table[key] = table[key]
    end
    return new_table
end

function concat_tables(t1, t2)
    local result = {}
    for _, v in ipairs(t1) do table.insert(result, v) end
    for _, v in ipairs(t2) do table.insert(result, v) end
    return result
end

local player_form_data = {}
local name_form = "cyberlands:name_form"
local yes_no_form = "cyberlands:yes_no_form"
local function player_receive_fields(player, formname, fields)
    if formname == name_form then
        local player_name = player:get_player_name()
        local form_data = player_form_data[player_name]
        if fields.name then form_data.name = fields.name end
        if fields.quit then 
            local callback = form_data.callback
            local result_name = form_data.name
            player_form_data[player_name] = nil
            callback(result_name)
        end
    end
    if formname == yes_no_form then
        local player_name = player:get_player_name()
        local form_data = player_form_data[player_name]
        if fields.yes then form_data.accept = true end
        if fields.no then form_data.accept = false end
        if fields.quit then 
            local callback = form_data.callback
            local result = form_data.accept
            player_form_data[player_name] = nil
            callback(result)
        end
    end
end
minetest.register_on_player_receive_fields(player_receive_fields)

function ask_yes_no(player, text, callback)
    local player_name = player:get_player_name()
    player_form_data[player_name] = {callback = callback}
    
    minetest.show_formspec(player_name, yes_no_form,
        "size[3.5,2]" ..
        "label[0,0;" .. text .. "]" ..
        "button_exit[0.75,1;1,1;yes;Yes]" ..
        "button_exit[1.75,1;1,1;no;No]"
    )
end

function ask_for_name(player, text, callback)
    local player_name = player:get_player_name()
    player_form_data[player_name] = {callback = callback}
    
    minetest.show_formspec(player_name, name_form,
        "size[3.5,2]" ..
        "field[0.5,0.5;3,1;name;" .. text .. ";]" ..
        "button_exit[0.75,1;2,1;exit;Save]"
    )
end


function retry_ask_for_name(player, text, callback)
    local function ask_callback(name)
        if name and (#(name) > 0) and (name ~= "") then 
            callback(name)
        else 
            minetest.after(0.25, retry_ask_for_name, player, text, callback)
        end
    end
    ask_for_name(player, text, ask_callback)
end