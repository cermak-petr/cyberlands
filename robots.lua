local immune_to = {
    {"cyberlands:ai_tech_blade", 15},
    {"cyberlands:alquillian_blade_1", 20},
    {"cyberlands:alquillian_blade_2", 30},
    {"cyberlands:alquillian_blade_3", 40},
    {"all"}
}

for name, tool in pairs(minetest.registered_tools) do
    if string.find(name, "sword") and string.find(name, "cyberlands:emp") then
        table.insert(immune_to, {name, 10})
    end
end

mobs:register_mob("cyberlands:robot_1", {
	type = "monster",
	passive = false,
	step_height = 2,
	fear_height = 4,
    attack_type = "dogfight",
	attack_animals = true,
	reach = 3,
    damage = 7,
	hp_min = 100,
	hp_max = 200,
	armor = 100,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.95, 0.5},
	visual = "mesh",
	mesh = "skinsdb_3d_armor_character_5.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"robot_1.png"}, {"robot_2.png"},
	},
	--[[sounds = {
		attack = "people_plundererstick3",
		random = "people_plunderersick",
		damage = "people_plundererstick2",
		distance = 15,
	},]]--
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 4,
    walk_chance = 10,
	runaway = false,
	jump = true,
	drops = {
		{name = "cyberlands:ai_tech_piece", chance = 2, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	animation = {
		speed_normal = 30,
		stand_start = 0,
		stand_end = 79,
		walk_speed = 30,
		walk_start = 168,
		walk_end = 187,
		punch_speed = 30,
		punch_start = 189,
		punch_end = 198,
        punch2_speed = 30,
		punch2_start = 200,
		punch2_end = 219,
	},
	view_range = 15,
    immune_to = immune_to,
    blood_texture = "cyberlands_ai_blood.png",

	--[[on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 5, 50, 80, false, nil) then return end
	end,]]--
})

mobs:spawn({
	name = "cyberlands:robot_1",
	nodes = {"scifi_nodes:bluetile"},
	--neighbors = {"people:bootynode"},
	min_light = 0,
	interval = 30,
	active_object_count = 5,
	chance = 10, -- 15000
	min_height = -25,
	max_height = 1000,
})