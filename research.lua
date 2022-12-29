math.randomseed(os.time())

local research_formspec =
	"size[8,7]" ..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
    "label[3.12,0;Research Desk]" ..
    "label[2.15,0.55;Input]" ..
    "label[5.1,0.55;Output]" ..
	"list[current_name;input;2,1;1,1;]" ..
    "image[3,1;1,1;cyberlands_research_icon_2.png]" ..
    "image[4,1;1,1;cyberlands_research_arrow.png]" ..
	"list[current_name;output;5,1;1,1;]" ..
	"list[current_player;main;0,3;8,1;]" ..
	"list[current_player;main;0,4.25;8,3;8]" ..
	"listring[current_name;input]" ..
	"listring[current_name;output]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0,3)

if minetest.get_modpath("i3") then
    research_formspec =
	"size[9,7]" ..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
    "label[3.62,0;Research Desk]" ..
    "label[2.15,0.55;Input]" ..
    "label[6.1,0.55;Output]" ..
	"list[current_name;input;2,1;1,1;]" ..
    "image[3,1;1,1;cyberlands_research_arrow.png]" ..
    "image[4,1;1,1;cyberlands_research_icon_2.png]" ..
    "image[5,1;1,1;cyberlands_research_arrow.png]" ..
	"list[current_name;output;6,1;1,1;]" ..
	"list[current_player;main;0,3;9,1;]" ..
	"list[current_player;main;0,4.25;9,3;9]" ..
	"listring[current_name;input]" ..
	"listring[current_name;output]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0,3)
end

local input_items = {}
player_research_results = {}

function register_research_desk(device_id, def)
    minetest.register_node(device_id, {
        description = def.description,
        tiles = def.tiles,
        on_construct = function(pos)
            local meta = minetest.get_meta(pos)
            meta:set_string("formspec", research_formspec)
            meta:set_string("infotext", def.description)
            local inv = meta:get_inventory()
            inv:set_size("output", 1 * 1)
            inv:set_size("input", 1 * 1)
        end,
        allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
            return 0
        end,
        on_metadata_inventory_put = function(pos, listname, index, stack, player)
            local results = player_research_results
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local player_inv = player:get_inventory()
            local player_name = player:get_player_name()
            if listname == "output" then
                player_inv:add_item("main", stack)
                inv:set_stack("output", index, "")
            end
            if listname == "input" then
                for _, row in ipairs(input_items) do
                    local item = row[1]
                    if inv:contains_item("input", item) then
                        local result = nil
                        local player_result = results[player_name]
                        if player_result and player_result[item] then
                            result = player_result[item]
                        else
                            local result_index = math.random(2, #row)
                            result = row[result_index]
                            if not results[player_name] then results[player_name] = {} end
                            if not results[player_name][item] then results[player_name][item] = result end
                        end
                        inv:set_stack("output", 1, result)
                    end
                end
            end
        end,
        on_metadata_inventory_take = function(pos, listname, index, stack, player)
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local istack = inv:get_stack("input", 1)
            local stack_name = istack:get_name()
            local results = player_research_results
            local player_name = player:get_player_name()
            if listname == "output" and results[player_name] and results[player_name][stack_name] then
                results[player_name][stack_name] = nil
            end
            inv:remove_item("input", stack_name.." 1")
            inv:set_stack("output", 1, "")
        end,
        paramtype = "light",
        paramtype2 = "facedir",
        groups = {cracky=1, oddly_breakable_by_hand=1}
    })
end

register_research_desk("cyberlands:research_desk", {
    description = "Research Desk",
    tiles = {
        "cyberlands_research_top.png",
        "cyberlands_research_top.png",
        "cyberlands_research_side.png",
        "cyberlands_research_side.png",
        "cyberlands_research_side.png",
        "cyberlands_research_front.png"
    }
})

register_craft_type("researching", "Researching", "cyberlands_research_icon_2.png")

function register_research_results(input, results)
    local tmp = copy_table(results)
    table.insert(tmp, 1, input)
    table.insert(input_items, tmp)
    for _, result in ipairs(results) do
        register_custom_craft("researching", input, result) 
    end
end