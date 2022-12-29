local uses = 200
local damage_multiplier = 1
local full_punch_interval = 0.5

local MODNAME = minetest.get_current_modname()
local MODPATH = minetest.get_modpath(MODNAME)

minetest.register_tool("cyberlands:alquillian_blade_1", {
    description = "Alquillian Blade 1",
    inventory_image = "cyberlands_alquillian_blade_1.png",
    light_source = 5,
    tool_capabilities = {
        full_punch_interval = full_punch_interval,
        max_drop_level = 3,
        groupcaps = {
            cracky = {times = {[1] = 2.25, [2] = 0.55, [3] = 0.35}, uses = uses, maxlevel = 3},
            crumbly = {times = {[1] = 0.70, [2] = 0.35, [3] = 0.20}, uses = uses, maxlevel = 3},
            choppy = {times = {[1] = 1.75, [2] = 0.45, [3] = 0.45}, uses = uses, maxlevel = 3},
            fleshy = {times = {[2] = 0.65, [3] = 0.25}, uses = uses, maxlevel = 2},
            snappy = {times = {[1] = 1.70, [2] = 0.70, [3] = 0.25}, uses = uses, maxlevel = 3},
        },
        damage_groups = {fleshy = 12*damage_multiplier},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {sword = 1, axe = 1, shovel = 1, pickaxe = 1},
    range = 8.0,
    wield_scale = {x = 1.5, y = 1.5, z = 1},
})

minetest.register_tool("cyberlands:alquillian_blade_2", {
    description = "Alquillian Blade 2",
    inventory_image = "cyberlands_alquillian_blade_2.png",
    light_source = 5,
    tool_capabilities = {
        full_punch_interval = full_punch_interval,
        max_drop_level = 3,
        groupcaps = {
            cracky = {times = {[1] = 2.25, [2] = 0.55, [3] = 0.35}, uses = uses, maxlevel = 3},
            crumbly = {times = {[1] = 0.70, [2] = 0.35, [3] = 0.20}, uses = uses, maxlevel = 3},
            choppy = {times = {[1] = 1.75, [2] = 0.45, [3] = 0.45}, uses = uses, maxlevel = 3},
            fleshy = {times = {[2] = 0.65, [3] = 0.25}, uses = uses, maxlevel = 2},
            snappy = {times = {[1] = 1.70, [2] = 0.70, [3] = 0.25}, uses = uses, maxlevel = 3},
        },
        damage_groups = {fleshy = 14*damage_multiplier},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {sword = 1, axe = 1, shovel = 1, pickaxe = 1},
    range = 8.0,
    wield_scale = {x = 1.5, y = 1.5, z = 1},
})

minetest.register_tool("cyberlands:alquillian_blade_3", {
    description = "Alquillian Blade 3",
    inventory_image = "cyberlands_alquillian_blade_3.png",
    light_source = 5,
    tool_capabilities = {
        full_punch_interval = full_punch_interval,
        max_drop_level = 3,
        groupcaps = {
            cracky = {times = {[1] = 2.25, [2] = 0.55, [3] = 0.35}, uses = uses, maxlevel = 3},
            crumbly = {times = {[1] = 0.70, [2] = 0.35, [3] = 0.20}, uses = uses, maxlevel = 3},
            choppy = {times = {[1] = 1.75, [2] = 0.45, [3] = 0.45}, uses = uses, maxlevel = 3},
            fleshy = {times = {[2] = 0.65, [3] = 0.25}, uses = uses, maxlevel = 2},
            snappy = {times = {[1] = 1.70, [2] = 0.70, [3] = 0.25}, uses = uses, maxlevel = 3},
        },
        damage_groups = {fleshy = 16*damage_multiplier},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {sword = 1, axe = 1, shovel = 1, pickaxe = 1},
    range = 8.0,
    wield_scale = {x = 1.5, y = 1.5, z = 1},
})

minetest.register_tool("cyberlands:ai_tech_blade", {
    description = "AI Tech Blade",
    inventory_image = "cyberlands_tech_blade.png",
    light_source = 5,
    tool_capabilities = {
        full_punch_interval = full_punch_interval,
        max_drop_level = 3,
        groupcaps = {
            cracky = {times = {[1] = 2.25, [2] = 0.55, [3] = 0.35}, uses = uses, maxlevel = 3},
            crumbly = {times = {[1] = 0.70, [2] = 0.35, [3] = 0.20}, uses = uses, maxlevel = 3},
            choppy = {times = {[1] = 1.75, [2] = 0.45, [3] = 0.45}, uses = uses, maxlevel = 3},
            fleshy = {times = {[2] = 0.65, [3] = 0.25}, uses = uses, maxlevel = 2},
            snappy = {times = {[1] = 1.70, [2] = 0.70, [3] = 0.25}, uses = uses, maxlevel = 3},
        },
        damage_groups = {fleshy = 10*damage_multiplier},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {sword = 1, axe = 1, shovel = 1, pickaxe = 1},
    range = 8.0,
    wield_scale = {x = 1.5, y = 1.5, z = 1},
})

minetest.register_craft({
    output = "cyberlands:alquillian_blade_1",
    recipe = {
        {"", "cyberlands:alquillium_crystal", ""},
        {"", "cyberlands:alquillian_ai_deflector", ""},
        {"", "cyberlands:alquillium_crystal", ""},
    }
})

minetest.register_craft({
    output = "cyberlands:alquillian_blade_2",
    recipe = {
        {"", "cyberlands:alquillian_particle_converter", ""},
        {"", "cyberlands:alquillian_ai_deflector", ""},
        {"", "cyberlands:alquillium_crystal", ""},
    }
})

minetest.register_craft({
    output = "cyberlands:alquillian_blade_3",
    recipe = {
        {"", "cyberlands:alquillian_particle_converter", ""},
        {"cyberlands:alquillian_quantum_disruptor", "cyberlands:alquillian_ai_deflector", "cyberlands:alquillian_quantum_disruptor"},
        {"", "cyberlands:alquillium_crystal", ""},
    }
})

minetest.register_craft({
    output = "cyberlands:ai_tech_blade",
    recipe = {
        {"", "cyberlands:ai_tech_diffuser", ""},
        {"", "cyberlands:ai_tech_resonator", ""},
        {"", "cyberlands:ai_tech_polarizer", ""},
    }
})

--register_craft_type("enhancing", "Enhancing")


local function create_emp_swords()
    for name, tool in pairs(minetest.registered_tools) do
        if string.find(name, "sword") and string.find(name, "default:") then
            local new_tool = copy_table(tool)
            local spl = string_split(name, '%:')
            local new_name = "cyberlands:emp_" .. spl[2]
            new_tool["name"] = new_name
            new_tool["description"] = "EMP " .. tool["description"]
            --new_tool["wield_image"] = tool["wield_image"] .. "^cyberlands_emp_sword.png"
            new_tool["wield_image"] = nil
            new_tool["inventory_image"] = tool["inventory_image"] .. "^cyberlands_emp_sword.png"
            minetest.register_tool(new_name, new_tool)
            --register_custom_craft("enhancing", name, new_name)
            minetest.register_craft({
                output = new_name,
                type = "shapeless",
                recipe = {name, "cyberlands:emp_coil"}
            })
        end
    end
end

create_emp_swords()