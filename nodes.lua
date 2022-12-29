local stone_sounds = default.node_sound_stone_defaults()

minetest.register_node("cyberlands:ai_infected_rock", {
    description = "AI Infected Rock",
    tiles = { "scifi_nodes_rock.png^cyberlands_infection_2.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    drop = "cyberlands:ai_tech_fragment",
    --light_source = 3,
})

minetest.register_node("cyberlands:ai_infected_stone", {
    description = "AI Infected Stone",
    tiles = { "default_stone.png^cyberlands_infection_2.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    drop = "cyberlands:ai_tech_fragment",
    --light_source = 3,
})

minetest.register_node("cyberlands:alquillium_rock_ore", {
    description = "Alquillium Ore",
    tiles = { "scifi_nodes_rock.png^cyberlands_alquillium_ore.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    drop = "cyberlands:alquillium_crystal",
    --light_source = 3,
})

minetest.register_node("cyberlands:alquillium_ore", {
    description = "Alquillium Ore",
    tiles = { "default_stone.png^cyberlands_alquillium_ore.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    drop = "cyberlands:alquillium_crystal",
    --light_source = 3,
})

minetest.register_node("cyberlands:alquillian_device", {
    description = "Alquillian Device",
    tiles = { "cyberlands_alquillian_device.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    drop = "cyberlands:alquillian_tech_fragment",
    --light_source = 3,
})

minetest.register_node("cyberlands:alquillian_floor_tile", {
    description = "Alquillian Floor Tile",
    tiles = { "cyberlands_alquillian_box_plain.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    --light_source = 3,
})

minetest.register_node("cyberlands:alquillian_light_tile", {
    description = "Alquillian Light Tile",
    tiles = { "cyberlands_alquillian_box_light.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    paramtype = "light",
    paramtype2 = "facedir",
    light_source = 11,
})

minetest.register_node("cyberlands:alquillian_wall_1", {
    description = "Alquillian Wall 1",
    tiles = { "cyberlands_alquillian_box_1.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    --light_source = 3,
})

minetest.register_node("cyberlands:alquillian_wall_2", {
    description = "Alquillian Wall 2",
    tiles = { "cyberlands_alquillian_box_2.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    --light_source = 3,
})

minetest.register_node("cyberlands:alquillian_wall_3", {
    description = "Alquillian Wall 3",
    tiles = { "cyberlands_alquillian_box_3.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    --light_source = 3,
})


minetest.register_node("cyberlands:alquillian_wall_4", {
    description = "Alquillian Wall 4",
    tiles = { "cyberlands_alquillian_box_4.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    --light_source = 3,
})


minetest.register_node("cyberlands:alquillian_wall_5", {
    description = "Alquillian Wall 5",
    tiles = { "cyberlands_alquillian_box_5.png" },
    is_ground_content = true,
    groups = {cracky=3},
    sounds = stone_sounds,
    --light_source = 3,
})
