minetest.register_biome({
    name = "Dark City",

    -- node_dust = "default:snow",
    -- Node dropped onto upper surface after all else is generated

    node_top = "scifi_nodes:bluetile",
    depth_top = 1,
    -- Node forming surface layer of biome and thickness of this layer

    node_filler = "scifi_nodes:black",
    depth_filler = 3,
    -- Node forming lower layer of biome and thickness of this layer

    node_stone = "scifi_nodes:rock",
    -- Node that replaces all stone nodes between roughly y_min and y_max.

    -- node_water_top = "default:ice",
    -- depth_water_top = 10,
    -- Node forming a surface layer in seawater with the defined thickness

    -- node_water = "",
    -- Node that replaces all seawater nodes not in the surface layer

    -- node_river_water = "default:ice",
    -- Node that replaces river water in mapgens that use
    -- default:river_water

    node_riverbed = "default:gravel",
    -- depth_riverbed = 2,
    -- Node placed under river water and thickness of this layer

    node_cave_liquid = "default:lava_source",
    node_cave_liquid = {"default:water_source", "default:lava_source"},
    -- Nodes placed inside 50% of the medium size caves.
    -- Multiple nodes can be specified, each cave will use a randomly
    -- chosen node from the list.
    -- If this field is left out or 'nil', cave liquids fall back to
    -- classic behaviour of lava and water distributed using 3D noise.
    -- For no cave liquid, specify "air".

    node_dungeon = "scifi_nodes:tile",
    -- Node used for primary dungeon structure.
    -- If absent, dungeon nodes fall back to the 'mapgen_cobble' mapgen
    -- alias, if that is also absent, dungeon nodes fall back to the biome
    -- 'node_stone'.
    -- If present, the following two nodes are also used.

    node_dungeon_alt = "scifi_nodes:whitetile",
    -- Node used for randomly-distributed alternative structure nodes.
    -- If alternative structure nodes are not wanted leave this absent.

    node_dungeon_stair = "scifi_nodes:slope_white",
    -- Node used for dungeon stairs.
    -- If absent, stairs fall back to 'node_dungeon'.

    y_max = 31000,
    y_min = -50,
    -- Upper and lower limits for biome.
    -- Alternatively you can use xyz limits as shown below.

    -- max_pos = {x = 31000, y = 128, z = 31000},
    -- min_pos = {x = -31000, y = 9, z = -31000},
    -- xyz limits for biome, an alternative to using 'y_min' and 'y_max'.
    -- Biome is limited to a cuboid defined by these positions.
    -- Any x, y or z field left undefined defaults to -31000 in 'min_pos' or
    -- 31000 in 'max_pos'.

    vertical_blend = 0,
    -- Vertical distance in nodes above 'y_max' over which the biome will
    -- blend with the biome above.
    -- Set to 0 for no vertical blend. Defaults to 0.

    heat_point = 0,
    humidity_point = 50,
    -- Characteristic temperature and humidity for the biome.
    -- These values create 'biome points' on a voronoi diagram with heat and
    -- humidity as axes. The resulting voronoi cells determine the
    -- distribution of the biomes.
    -- Heat and humidity have average values of 50, vary mostly between
    -- 0 and 100 but can exceed these values.
})

minetest.register_ore({
    ore_type = "scatter",
    ore = "cyberlands:ai_infected_rock",
    wherein = "scifi_nodes:rock",
    clust_scarcity = 10*10*10,
    clust_num_ores = 4,
    clust_size = 3,
    y_min = -50,
    y_max = 30000,
    biomes = {"Dark City"},
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.0005,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/pyramid_1.mts",
    place_offset_y = 0,
    rotation = "random",
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.00035,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/tech_pylon_1.mts",
    place_offset_y = 0,
    rotation = "random",
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.00035,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/tech_pylon_2.mts",
    place_offset_y = 0,
    rotation = "random",
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.00015,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/tech_bulb_tower_1.mts",
    place_offset_y = 0,
    rotation = "random",
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.00015,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/tech_bulb_tower_2.mts",
    place_offset_y = 0,
    rotation = "random",
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.0003,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/tech_tower_1.mts",
    place_offset_y = 0,
    rotation = "random",
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.0003,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/tech_tower_2.mts",
    place_offset_y = 0,
    rotation = "random",
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.0003,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/tech_tower_3.mts",
    place_offset_y = 0,
    rotation = "random",
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.0002,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/tech_cube_1.mts",
    place_offset_y = 30,
    rotation = "random",
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.0002,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/tech_cube_2.mts",
    place_offset_y = 30,
    rotation = "random",
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.0001,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/tech_cube_3.mts",
    place_offset_y = 30,
    rotation = "random",
})

minetest.register_decoration({
    deco_type = "schematic",
    place_on = "scifi_nodes:bluetile",
    sidelen = 8,
    fill_ratio = 0.0001,
    biomes = {"Dark City"},
    y_min = 1,
    y_max = 31000,
    flags = "force_placement, place_center_x, place_center_z",
    schematic = "schems/tech_cube_4.mts",
    place_offset_y = 30,
    rotation = "random",
})