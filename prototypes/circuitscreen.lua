require("circuit-connector-sprites")

empty_sprite = { 
    filename = "__core__/graphics/empty.png", 
    size = 1, 
    frame_count = 1 
  }

  circuit_screen = util.table.deepcopy(data.raw["programmable-speaker"]["programmable-speaker"])
  circuit_screen.name = "circuit-screen"
  circuit_screen.icon = "__CircuitConditionScreen__/graphics/icons/circ_screen_64.png"
  circuit_screen.icon_size = 64
  circuit_screen.flags = {"placeable-player", "player-creation", "placeable-neutral", "placeable-enemy"}
  circuit_screen.minable = {mining_time = 0.1, result = "circuit-screen"}
  circuit_screen.collision_box = {{-0.75, -0.75}, {0.75, 0.75}} -- needs tested
  circuit_screen.selection_box = {{-0.75, -0.75}, {0.75, 0.75}} -- needs to be tested
  circuit_screen.apply_runtime_tint = false
  --circuit_screen.corpse = "__CircuitConditionScreen__/graphics/corpse/attempt1_screen_corpse2_image_64.png"
  circuit_screen.corpse = "small-remnants"
  circuit_screen.dying_explosion = "pump-explosion" -- test explosion
  circuit_screen.circuit_wire_connection_points = circuit_connector_definitions.create
(
  universal_connector_template,
  {
    { variation = 12, main_offset = util.by_pixel(12, 12), shadow_offset = util.by_pixel(4.5, -1), show_shadow = true }
  }
)
  --circuit_screen.circuit_wire_connection_points = circuit_connector_definitions["programmable-speaker"].points --test this
  --circuit_screen.circuit_connector_sprites = circuit_connector_definitions["programmable-speaker"].sprites --test this too
  circuit_screen.circuit_wire_max_distance = default_circuit_wire_max_distance
  circuit_screen.se_allow_in_space = true
  circuit_screen.water_reflection = 
  {
    pictures =
    {
      filename = "__CircuitConditionScreen__/graphics/entities/circ_refl.png",
      priority = "extra-high",
      width = 32,
      height = 32,
      shift = util.by_pixel(5, 35), --test this
      variation_count = 1,
      scale = 5
    },
    rotate = false,
    orientation_to_variation = false
  }

  circuit_screen.energy_usage_per_tick = "2KW"

  circuit_screen.sprite =
  {
    layers =
    {
      {
        filename = "__CircuitConditionScreen__/graphics/entities/screen.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        shift = util.by_pixel(0, 0),
        hr_version =
        {
          filename = "__CircuitConditionScreen__/graphics/entities/screen_hr.png",
          priority = "extra-high",
          width = 64,
          height = 64,
          shift = util.by_pixel(0, 0),
          scale = 1
        }
      },
      {
        filename = "__CircuitConditionScreen__/graphics/entities/shadow.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        shift = util.by_pixel(52.5, -2.5),
        draw_as_shadow = true,
        hr_version =
        {
          filename = "__CircuitConditionScreen__/graphics/entities/shadow_hr.png",
          priority = "extra-high",
          width = 64,
          height = 64,
          shift = util.by_pixel(52.75, -3),
          draw_as_shadow = true,
          scale = 1
        }
      }
    }
  }



  empty_sprite.name = "emptysprite"
  empty_sprite.type = "sprite"
  data:extend({
  
  {
      type = "item",
      name = "circuit-screen",
      icon = "__CircuitConditionScreen__/graphics/icons/circ_screen_64.png",
      icon_size = 64,
      flags = {},
      subgroup = "energy-pipe-distribution",
      order = "f[circuit-screen]",
      place_result = "circuit-screen",
      stack_size = 50
  },
  
  circuit_screen,
  empty_sprite
  })
  
  
  