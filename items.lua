local MODNAME = minetest.get_current_modname()
local MODPATH = minetest.get_modpath(MODNAME)

--[[minetest.register_craftitem("cyberlands:adapted_ai_tech", {
    description = "Adapted AI Tech",
    inventory_image = "cyberlands_adapted_tech.png",
})]]--

minetest.register_craftitem("cyberlands:ai_tech_fragment", {
    description = "AI Tech Fragment",
    inventory_image = "cyberlands_tech_piece_2.png",
})

minetest.register_craftitem("cyberlands:ai_tech_resonator", {
    description = "AI Tech Resonator",
    inventory_image = "cyberlands_tech_resonator.png",
})

minetest.register_craftitem("cyberlands:ai_tech_diffuser", {
    description = "AI Tech Diffuser",
    inventory_image = "cyberlands_tech_diffuser.png",
})

minetest.register_craftitem("cyberlands:ai_tech_polarizer", {
    description = "AI Tech Polarizer",
    inventory_image = "cyberlands_tech_polarizer.png",
})

minetest.register_craftitem("cyberlands:alquillian_tech_fragment", {
    description = "Alquillian Tech Fragment",
    inventory_image = "cyberlands_alquillian_piece.png",
})

minetest.register_craftitem("cyberlands:alquillian_ai_deflector", {
    description = "Alquillian AI Deflector",
    inventory_image = "cyberlands_alquillian_ai_deflector.png",
})

minetest.register_craftitem("cyberlands:alquillian_quantum_disruptor", {
    description = "Alquillian Quantum Disruptor",
    inventory_image = "cyberlands_alquillian_quantum_disruptor.png",
})

minetest.register_craftitem("cyberlands:alquillian_particle_converter", {
    description = "Alquillian Particle Converter",
    inventory_image = "cyberlands_alquillian_particle_convertor.png",
})

minetest.register_craftitem("cyberlands:alquillium_crystal", {
    description = "Alquillium Crystal",
    inventory_image = "cyberlands_alquillium_crystal.png",
})

minetest.register_craftitem("cyberlands:blue_wire", {
    description = "Blue Wire",
    inventory_image = "cyberlands_blue_wire.png",
})

minetest.register_craftitem("cyberlands:emp_coil", {
    description = "EMP Coil",
    inventory_image = "cyberlands_emp_coil.png",
})

minetest.register_craftitem("cyberlands:log_disc", {
    description = "Log Disc",
    inventory_image = "cyberlands_regular_log_disc.png",
})

minetest.register_craftitem("cyberlands:alquillian_log_disc", {
    description = "Alquillian Log Disc",
    inventory_image = "cyberlands_alquillian_log_disc.png",
})

minetest.register_craftitem("cyberlands:alquillian_artifact", {
    description = "Alquillian Artifact",
    inventory_image = "cyberlands_alquillian_artifact.png",
})

minetest.register_craft({
    output = "cyberlands:blue_wire",
    recipe = {
        {"", "default:tin_ingot", ""},
        {"", "dye:blue", ""},
        {"", "default:tin_ingot", ""},
    }
})

minetest.register_craft({
    output = "cyberlands:emp_coil",
    recipe = {
        {"", "cyberlands:blue_wire", ""},
        {"cyberlands:blue_wire", "default:steelblock", "cyberlands:blue_wire"},
        {"", "cyberlands:blue_wire", ""},
    }
})

--[[
register_craft_type("researching", "Researching", "cyberlands_research_icon_2.png")
register_custom_craft("researching", "cyberlands:alquillian_tech_fragment", "cyberlands:alquillian_ai_deflector")
register_custom_craft("researching", "cyberlands:alquillian_tech_fragment", "cyberlands:alquillian_quantum_disruptor")
register_custom_craft("researching", "cyberlands:alquillian_tech_fragment", "cyberlands:alquillian_particle_converter")
--register_custom_craft("researching", "cyberlands:ai_tech_fragment", "cyberlands:adapted_ai_tech")
register_custom_craft("researching", "cyberlands:ai_tech_fragment", "cyberlands:ai_tech_resonator")
register_custom_craft("researching", "cyberlands:ai_tech_fragment", "cyberlands:ai_tech_diffuser")
register_custom_craft("researching", "cyberlands:ai_tech_fragment", "cyberlands:ai_tech_polarizer")
]]--

register_research_results("cyberlands:ai_tech_fragment", {
    "cyberlands:ai_tech_resonator",
    "cyberlands:ai_tech_diffuser",
    "cyberlands:ai_tech_polarizer",
})
register_research_results("cyberlands:alquillian_tech_fragment", {
    "cyberlands:alquillian_ai_deflector",
    "cyberlands:alquillian_quantum_disruptor",
    "cyberlands:alquillian_particle_converter",
})