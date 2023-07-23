require("circuit-connector-sprites")
require ("util")

empty_sprite = { 
    filename = "__core__/graphics/empty.png", 
    size = 1, 
    frame_count = 1 
  }

  circuit_connector_definitions["circuit-screen"] = circuit_connector_definitions.create
  (
    universal_connector_template,
    {
      { variation = 31,
      main_offset = util.by_pixel(25.5, 1.5),
      shadow_offset = util.by_pixel(26.0, 2.5),
      show_shadow = true },
    }
  )

  circuit_screen = util.table.deepcopy(data.raw["programmable-speaker"]["programmable-speaker"])
  circuit_screen.name = "circuit-screen"
  circuit_screen.icon = "__CircuitConditionScreen__/graphics/icons/circ_screen_64_2.png"
  circuit_screen.icon_size = 64
  circuit_screen.flags = {"placeable-player", "player-creation", "placeable-neutral", "placeable-enemy"}
  circuit_screen.minable = {mining_time = 0.1, result = "circuit-screen"}
  circuit_screen.collision_box = {{-0.9, -0.40}, {0.9, 0.40}}
  circuit_screen.selection_box = {{-0.9, -0.40}, {0.9, 0.40}}
  circuit_screen.apply_runtime_tint = false
  circuit_screen.corpse = "small-remnants"
  circuit_screen.dying_explosion = "pump-explosion" -- test explosion
  circuit_screen.circuit_wire_connection_point = circuit_connector_definitions["circuit-screen"].points
  circuit_screen.circuit_connector_sprites = circuit_connector_definitions["circuit-screen"].sprites
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
      shift = util.by_pixel(0, 40), --test this
      variation_count = 1,
      scale = 2
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
        filename = "__CircuitConditionScreen__/graphics/entities/screen2_kozep.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        shift = util.by_pixel(0, 0),
        hr_version =
        {
          filename = "__CircuitConditionScreen__/graphics/entities/screen2_hr_kozep.png",
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
        shift = util.by_pixel(50.5, 0),
        draw_as_shadow = true,
        hr_version =
        {
          filename = "__CircuitConditionScreen__/graphics/entities/shadow_hr.png",
          priority = "extra-high",
          width = 64,
          height = 64,
          shift = util.by_pixel(50.75, 1),
          draw_as_shadow = true,
          scale = 0.7
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
      icon = "__CircuitConditionScreen__/graphics/icons/circ_screen_64_2.png",
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
  
  
  