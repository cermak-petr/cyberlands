FORM_NAME = "cyberlands:log_reader"

item_logs = {
    {name = "Test Log 1", text = "Log Text 1"}, 
    {name = "Test Log 2", text = "Log Text 2"}, 
    {name = "Test Log 3", text = "Log Text 3"}, 
}

default_logs = {
    {name = "Test Default Log 1", text = "Log Default Text 1"}, 
    {name = "Test Default Log 2", text = "Log Default Text 2"}, 
    {name = "Test Default Log 3", text = "Log Default Text 3"}, 
}

function test_log_item(player_name)
    local stack = ItemStack("cyberlands:log_disc")
    local meta = stack:get_meta()
    set_meta_table(meta, "log", {name = "Test Item Log", text = "Item Log Text"})
    local player = minetest.get_player_by_name(player_name)
    local inv = player:get_inventory()
    local leftover = inv:add_item("main", stack)
end

local function generate_formspec(log_text, logs, name, index, log_inv_name)
    if not index then index = #(logs) end
    if not log_text then log_text = " " end
    local log_list_start = "textlist[9,1;2.8,6.5;log_list;"
    local log_list_end = ";" .. index .. ";false]"
    local log_list = nil
    if logs then
        local items = {}
        for _, v in ipairs(logs) do table.insert(items, v.name) end
        log_list = log_list_start .. table.concat(items, ',') .. log_list_end
    end
    local a_i3 = minetest.get_modpath("i3")
    local size = "size[12,8]"
    if log_inv_name then size = "size[12,12]" end
    local formspec =
        size .. -- "size[8,8]"
        default.gui_bg ..
        default.gui_bg_img ..
        default.gui_slots ..
        "box[0,1;8.8,6.5;#1E1E1E]" .. 
        "hypertext[0.4,1.1;8.4,6.4;log_text;" .. log_text .. "]" .. 
        "label[1.4,0;" .. name .. "]" ..
        log_list
    if log_inv_name then
        local hbw = 8
        if a_i3 then hbw = 9 end
        formspec = formspec ..
        "label[10.35,8.1;Log:]" ..
        "list[detached:" .. log_inv_name .. ";log_input;11,7.95;1,1]" ..
        "list[current_player;main;0,7.95;" .. hbw .. ",1;]" ..
        "list[current_player;main;0,9.2;" .. hbw .. ",3;" .. hbw .. "]" ..
        "listring[current_player;main]" ..
        "listring[detached:" .. log_inv_name .. ";log_input]"
    end
    return formspec
end

local function optional_prefix(string, prefix)
    if prefix then return prefix .. ':' .. string end
    return string
end

local function get_player_logs(player, domain)
    local logs_key = optional_prefix("logs", domain)
    local player_meta = player:get_meta()
    local player_logs = get_meta_table(player_meta, logs_key)
    if not player_logs then 
        player_logs = {} 
        set_meta_table(player_meta, logs_key, player_logs)
    end
    return player_logs
end

local function set_player_logs(player, logs, domain)
    local logs_key = optional_prefix("logs", domain)
    local player_meta = player:get_meta()
    set_meta_table(player_meta, logs_key, logs)
end

local function index_of_log(logs, new_log)
    for i, log in ipairs(logs) do 
        if log.name == new_log.name then return i end
    end
    return -1
end

local function add_player_log(player, new_log, domain)
    local player_logs = get_player_logs(player, domain)
    table.insert(player_logs, new_log)
    set_player_logs(player, player_logs, domain)
end

local function update_player_log_index(player, item_name, max, domain)
    local indices_key = optional_prefix("log_indices", domain)
    local player_meta = player:get_meta()
    local indices = get_meta_table(player_meta, indices_key)
    if not indices then indices = {[item_name] = 0} end
    if not indices[item_name] then indices[item_name] = 0 end
    if indices[item_name] < max then
        indices[item_name] = indices[item_name] + 1
    end
    set_meta_table(player_meta, indices_key, indices)
    return indices[item_name]
end

function create_sequential_log_func(logs, domain)
    return function(player, stack)
        local item_name = stack:get_name()
        local item_logs = logs[item_name]
        if not item_logs then return nil end
        local index = update_player_log_index(player, item_name, #(item_logs), domain)
        return item_logs[index]
    end
end

log_controller = {
    get_logs = "function(player)",
    add_log = "function(player, log)",
    get_item_log = "function(player, stack)",
}

function create_list_log_controller(logs)
    local function get_logs() return logs end
    return {get_logs = get_logs}
end

function create_player_log_controller(default_logs, domain)
    local get_logs = nil
    if default_logs then
        get_logs = function(player)
            local player_logs = get_player_logs(player, domain)
            return concat_tables(default_logs, player_logs) 
        end
    else
        get_logs = function(player) 
            return get_player_logs(player, domain) 
        end
    end
    return {get_logs = get_logs}
end

function create_addable_player_log_controller(default_logs, log_func, domain)
    local controller = create_player_log_controller(default_logs, domain)
    controller.add_log = function(player, log) 
        return add_player_log(player, log, domain) 
    end
    controller.get_item_log = function(player, stack)
        local meta = stack:get_meta()
        local meta_log = get_meta_table(meta, "log")
        if meta_log then return meta_log end
        if log_func then
            local log = log_func(player, stack)
            if log then return log end
        end
        return nil
    end
    return controller
end

function LogReader(name, controller)
    
    local object = {
        name = name
    }
    
    local function set_name(name)
        object.name = name 
    end
    object.set_name = set_name
    
    local function get_name()
        return object.name
    end
    object.get_name = get_name
    
    local function get_form_name()
        return FORM_NAME .. '-' .. object.name
    end
    
    local function on_log_inv_put(inv, listname, index, stack, player)
        local log = controller.get_item_log(player, stack)
        if log then
            print(dump(log))
            local player_name = player:get_player_name()
            local logs = controller.get_logs(player)
            local index = index_of_log(logs, log)
            if index == -1 then
                controller.add_log(player, log)
                local rem_stack = ItemStack(stack:get_name())
                inv:remove_item(listname, rem_stack)
                object.show_for(player_name, log.text, #(logs) + 1)
            else 
                object.show_for(player_name, log.text, index) 
            end
        end
    end
    
    local function create_player_log_inv(log_inv_name)
        local inv = minetest.get_inventory({type="detached", name=log_inv_name})
        if not inv then
            inv = minetest.create_detached_inventory(log_inv_name, {on_put = on_log_inv_put})
            inv:set_list("log_input", {[1] = nil})
            inv:set_size("log_input", 1)
        end
    end
    
    local function show_for(player_name, log_text, index)
        local player = minetest.get_player_by_name(player_name)
        local form_name = get_form_name()
        local logs = controller.get_logs(player)
        local log_inv_name = nil
        if controller.add_log then
            log_inv_name = player_name .. "_log_inv"
            create_player_log_inv(log_inv_name)
            logs = controller.get_logs(player)
        end
        local fspec = generate_formspec(log_text, logs, object.name, index, log_inv_name)
        minetest.show_formspec(player_name, form_name, fspec)
    end
    object.show_for = show_for
    
    local function player_receive_fields(player, formname, fields)
        local form_name = get_form_name()
        if formname == form_name then
            if fields.log_list and not fields.quit then
                local s_log = string_split(fields.log_list, "%:")
                local index = tonumber(s_log[2])
                local logs = controller.get_logs(player)
                if not index then index = #(logs) end
                local selected_log = logs[index]
                local selected_text = ""
                if selected_log then selected_text = selected_log.text end
                local player_name = player:get_player_name()
                show_for(player_name, selected_text, index)
            end
        end
    end

    minetest.register_on_player_receive_fields(player_receive_fields)
    
    return object
    
end

minetest.register_privilege("logs", {
	description = "Can use log commands"
})

local personal_log = LogReader("Personal Log Reader", create_player_log_controller())
local function show_personal_log(player_name, param)
    local log_func = create_sequential_log_func({["cyberlands:alquillian_log_disc"] = item_logs}, "test_domain")
    local controller = create_addable_player_log_controller(default_logs, log_func, "test_domain")
    local reader = LogReader("Log Reader", controller)
    reader.show_for(player_name)
    --personal_log.show_for(player_name)
end
minetest.register_chatcommand("logs", {
	privs = {logs = true},
	func = show_personal_log
})

local function clear_player_logs(player_name, param)
    local player = minetest.get_player_by_name(player_name)
    local player_meta = player:get_meta()
    set_meta_table(player_meta, "logs", {})
    set_meta_table(player_meta, "log_indices", {})
end
minetest.register_chatcommand("logs_clear", {
	privs = {logs = true},
	func = clear_player_logs
})