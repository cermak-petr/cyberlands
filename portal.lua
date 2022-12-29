local generate_name_default = function()
    return tostring(math.random(1, 1000))
end

local ng_path = minetest.get_modpath("namegen")
if ng_path then
    namegen.load("default", ng_path .. "/graphs/elf.json")
    generate_name_default = function()
        local name = namegen.generate("default")
        return name
    end
end

local function find_biomes(name, name_post, generate_name, floatlands)
    local id = minetest.get_biome_id(name)
    local g_table_name = tostring(id) .. "_locations"
    local results = global.get_table(g_table_name)
    local y_start = 1
    if floatlands then y_start = 1480 end
    if not results then
        results = {}
        for z = 0, 30000, 500 do 
            for x = 0, 30000, 500 do 
                local pos = {x = x, y = y_start, z = z}
                local biome = minetest.get_biome_data(pos)
                if biome and biome.biome == id then 
                    local name = generate_name()
                    if name_post then name = name .. " " .. name_post end
                    results[name] = pos
                end
            end
        end
        global.set_table(g_table_name, results)
    end
    return results
end

local function is_air(pos)
    local node = minetest.get_node(pos)
    if node.name == "ignore" then 
        print(node.name)
        minetest.get_voxel_manip():read_from_map(pos, pos)
        node = minetest.get_node(pos)
    end
    return node.name == 'air'
end

local function get_solid_below(pos)
    local new_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
    if not is_air(new_pos) then return pos else return nil end
end

local function get_air_above(pos)
    local new_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
    if is_air(new_pos) then return new_pos else return nil end
end

local function find_ground_between(pos1, pos2)
    local air1 = is_air(pos1)
    local air2 = is_air(pos2)
    if pos1.y == pos2.y then 
        if air1 then return get_solid_below(pos1)
        else return get_air_above(pos1) end
    end
    if pos2.y == (pos1.y + 1) and (air2 and not air1) then return pos2 end
    if pos2.y < 1000 then
        if air1 then return get_solid_below(pos1) end
        if not (air1 or air2) then return get_air_above(pos2) end
    end
    local mid_y = (pos1.y + pos2.y)*0.5
    local pos_mid_1 = {x = pos1.x, y = math.floor(mid_y), z = pos1.z}
    local pos_mid_2 = {x = pos1.x, y = math.ceil(mid_y), z = pos1.z}
    local gm1 = find_ground_between(pos1, pos_mid_1)
    if gm1 then return gm1 end
    return find_ground_between(pos_mid_2, pos2)
end

local function find_solid_below(pos)
    for y = pos.y, -30000, -10 do
        local new_pos = {x = pos.x, y = y, z = pos.z}
        if not is_air(new_pos) then return new_pos end
    end
    print("No solid below: ")
    print(dump(pos))
    return nil
end

local function find_air_above(pos)
    for y = pos.y, 30000, 10 do
        local new_pos = {x = pos.x, y = y, z = pos.z}
        if is_air(new_pos) then return new_pos end
    end
    print("No air above: ")
    print(dump(pos))
    return nil
end

local function find_min_max_pos(pos)
    local pos1 = find_solid_below(pos)
    local pos2 = find_air_above(pos)
    if not (pos1 and pos2) then return nil, nil end
    return pos1, pos2
end

local function get_emerge_bounds(pos)
    local pos1, pos2
    if pos.y > 1000 then
        pos1 = {x = pos.x, y = 1280, z = pos.z}
        pos2 = {x = pos.x, y = 5000, z = pos.z}
    else
        pos1 = {x = pos.x, y = -100, z = pos.z}
        pos2 = {x = pos.x, y = 100, z = pos.z}
    end
    if not (pos1 and pos2) then return nil, nil end
    return pos1, pos2
end

local function find_ground(start_pos)
    local pos1, pos2 = get_min_max_pos(start_pos)
    if not (pos1 and pos2) then return nil end
    return find_ground_between(pos1, pos2)
end

local function emerge_position(start_pos, callback)
    local pos1, pos2 = get_emerge_bounds(start_pos)
    local function emerge_callback(blockpos, action, calls_remaining, param)
        if calls_remaining == 0 then
            if start_pos.y < 1000 then 
                pos1, pos2 = find_min_max_pos(start_pos) 
            end
            if not (pos1 and pos2) then callback(nil)
            else
                --local ground = find_ground(start_pos)
                local ground = find_ground_between(pos1, pos2)
                callback(ground)
            end
        end
    end
    minetest.load_area(pos1, pos2)
    minetest.emerge_area(pos1, pos2, emerge_callback)
end

local function generate_formspec(locations, devices, name)
    local loc_drop_start = "dropdown[1.2,1;3;locations;"
    local dev_drop_start = "dropdown[1.2,2;3;devices;"
    local drop_end = ";1;false]"
    local loc_drop = loc_drop_start .. "test_item;" .. drop_end
    local dev_drop = dev_drop_start .. "test_item;" .. drop_end
    if locations then
        local items = {}
        for k, v in pairs(locations) do table.insert(items, k) end
        loc_drop = loc_drop_start .. table.concat(items, ',') .. drop_end
    end
    if devices then
        local items = {}
        for k, v in pairs(devices) do table.insert(items, k) end
        dev_drop = dev_drop_start .. table.concat(items, ',') .. drop_end
    end
    local formspec =
        "size[6,4.2]" ..
        default.gui_bg ..
        default.gui_bg_img ..
        default.gui_slots ..
        "label[1.4,0;Transport Device (" .. name .. ")]" ..
        "label[0,1.1;Locations:]" ..
        "label[0,2.1;Devices:]" ..
        loc_drop ..
        "button[4.2,0.92;2,1;location_button;Initiate]" ..
        dev_drop ..
        "button[4.2,1.91;2,1;device_button;Initiate]"
    return formspec
end

local function to_number_vector(vec)
    return {x = tonumber(vec.x), y = tonumber(vec.y), z = tonumber(vec.z)}
end

local function get_player_locations(player, device_name)
    local player_meta = player:get_meta()
    local table_name = device_name .. "_locations"
    return get_meta_table(player_meta, table_name)
end

local function set_player_locations(player, device_name, locations)
    local player_meta = player:get_meta()
    local table_name = device_name .. "_locations"
    return set_meta_table(player_meta, table_name, locations)
end

local function remove_player_device(player, device_name)
    local player_meta = player:get_meta()
    local devices = get_meta_table(player_meta, "devices")
    if not devices then return nil end
    devices[device_name] = nil
    set_meta_table(player_meta, "devices", devices)
end

local function transport_to(loc_type, player, device_name)
    local player_meta = player:get_meta()
    local dest_name = player_meta:get_string("selected_" .. loc_type)
    local destinations = {}
    if loc_type == "location" then 
        destinations = get_player_locations(player, device_name)
    else 
        destinations = get_meta_table(player_meta, 'devices') 
    end
    local dest_pos = destinations[dest_name]
    local player_name = player:get_player_name()
    minetest.chat_send_player(player_name, "Initiating transport to " .. dest_name)
    emerge_position(dest_pos, function(ground_pos)
        if ground_pos then player:set_pos(ground_pos)
        else 
            print('Ground not found!') 
            ask_yes_no(player, "Location unavailable, remove?", function(result)
                print(dump(result))
                if result then
                    destinations[dest_name] = nil
                    set_player_locations(player, device_name, destinations)
                end
            end)
        end
    end)
end

local function update_player_devices(player, device_name)
    local player_meta = player:get_meta()
    local devices = get_meta_table(player_meta, "devices")
    if not devices then devices = {} end
    if device_name then
        if not table_has_key(devices, device_name) then
            devices[device_name] = player:get_pos()
        end
    end
    set_meta_table(player_meta, "devices", devices)
    return devices
end

local function register_transport_device(device_id, def)
    
    if not device_id then error('Missing device_id!') end
    if not def.biome_name then error('Missing "biome_name" in transport device definition!"') end
    if not def.tiles then error('Missing "tiles" in transport device definition!"') end
    if not def.generate_name then def.generate_name = generate_name_default end
    
    local function show_formspec(player, device_name)
        local locations = get_player_locations(player, device_name)
        if not locations then
            locations = find_biomes(def.biome_name, def.biome_suffix, def.generate_name, def.floatlands)
            set_player_locations(player, device_name, locations)
        end

        local devices = {}
        if player then 
            devices = update_player_devices(player, device_name) 
        end

        local formspec = generate_formspec(locations, devices, device_name)
        local formname = device_id .. "-" .. device_name
        minetest.show_formspec(player:get_player_name(), formname, formspec)
    end

    local function place_node(pos, newnode, placer, oldnode, itemstack, pointed_thing)
        if newnode.name == device_id then
            local meta = minetest.get_meta(pos)
            retry_ask_for_name(placer, "Device Name", function(device_name)
                if def.device_suffix then device_name = device_name .. " " .. def.device_suffix end
                meta:set_string("device_name", device_name)
                meta:set_string("infotext", "Transport Device (" .. device_name .. ")") 
            end)
        end
    end

    local function player_receive_fields(player, formname, fields)
        local s_name = string_split(formname, "%-")
        if #(s_name) > 1 and s_name[1] == device_id then
            local device_name = s_name[2]
            local player_meta = player:get_meta()
            local player_name = player:get_player_name()
            if fields.locations then player_meta:set_string("selected_location", fields.locations) end
            if fields.devices then player_meta:set_string("selected_device", fields.devices) end
            if fields.location_button then
                transport_to("location", player, device_name)
                minetest.close_formspec(player_name, formname)
            end
            if fields.device_button then
                transport_to("device", player, device_name)
                minetest.close_formspec(player_name, formname)
            end
        end
    end

    local function right_click(pos, node, clicker, itemstack, pointed_thing)
        local meta = minetest.get_meta(pos)
        local device_name = meta:get_string("device_name")
        show_formspec(clicker, device_name)
    end
    
    local function dig(pos, node, digger)
        local meta = minetest.get_meta(pos)
        local device_name = meta:get_string("device_name")
        local result = minetest.node_dig(pos, node, digger)
        if result then 
            set_player_locations(digger, device_name, nil) 
            remove_player_device(digger, device_name)
        end
        return result
    end

    minetest.register_node(device_id, {
        description = "Transport Device",
        tiles = def.tiles,
        on_dig = dig,
        on_rightclick = right_click,
        paramtype = "light",
        paramtype2 = "facedir",
        groups = {cracky=1, oddly_breakable_by_hand=1}
    })
    
    minetest.register_on_placenode(place_node)
    minetest.register_on_player_receive_fields(player_receive_fields)
    
end
    
register_transport_device("cyberlands:transport_device", {
    floatlands = false,
    biome_name = "Alien Meadows",
    biome_suffix = "Compound",
    device_suffix = "Device",
    tiles = {
        "cyberlands_portal_top.png",
        "cyberlands_portal_top.png",
        "cyberlands_portal_side.png",
        "cyberlands_portal_side.png",
        "cyberlands_portal_side.png",
        "cyberlands_portal_front.png"
    }
})

register_transport_device("cyberlands:alquillian_transport_device", {
    floatlands = true,
    biome_name = "Alquillian Ruins",
    biome_suffix = "Ruins",
    device_suffix = "Device",
    tiles = {
        "cyberlands_alquillian_portal_top.png",
        "cyberlands_alquillian_portal_top.png",
        "cyberlands_alquillian_portal_side.png",
        "cyberlands_alquillian_portal_side.png",
        "cyberlands_alquillian_portal_back.png",
        "cyberlands_alquillian_portal_front.png"
    }
})