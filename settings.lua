data:extend({
	{
		name = "number_of_cs_to_check_per_update",
		setting_type = "runtime-global",
		type = "int-setting",
		default_value = 50,
        minimum_value = 1
	},
    {
		name = "update_every_x_tickcs",
		setting_type = "runtime-global",
		type = "int-setting",
		default_value = 5
	},
	--{
	--	name = "alarm-on-color",
	--	setting_type = "runtime-global",
	--	type = "color-setting",
	--	default_value = {r=0.9,  g=0.1,  b=0.1, a=0.85}
	--},
	--{
	--	name = "alarm-off-color",
	--	setting_type = "runtime-global",
	--	type = "color-setting",
	--	default_value = {r=0.1,  g=0.8,  b=0.1, a=0.99}
	--},
	{
		name = "lamp-on-color",
		setting_type = "runtime-global",
		type = "color-setting",
		--default_value = {r=0.1,  g=0.8,  b=0.1, a=0.99}
		default_value = {r=0.0,  g=0.9,  b=0.1, a=0.95}
	},
	{
		name = "lamp-off-color",
		setting_type = "runtime-global",
		type = "color-setting",
		--default_value = {r=0.99,  g=0.7,  b=0.0, a=0.99}
		default_value = {r=0.99,  g=0.1,  b=0.1, a=0.99}
	}
})
