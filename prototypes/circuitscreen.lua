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
  circuit_screen.icon = "__CircuitConditionScreen__/graphics/icons/circ_screen_64_2sp.png"
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
        filename = "__CircuitConditionScreen__/graphics/entities/alarmoff32.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        shift = util.by_pixel(0, 0),
        hr_version =
        {
          filename = "__CircuitConditionScreen__/graphics/entities/alarmoff64.png",
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

  circuit_lamp = util.table.deepcopy(data.raw["lamp"]["small-lamp"])
  circuit_lamp.name = "circuit-lamp"
  circuit_lamp.icon = "__CircuitConditionScreen__/graphics/icons/bhr3.png"
  circuit_lamp.icon_size = 64
  circuit_lamp.flags = {"placeable-player", "player-creation", "placeable-neutral", "placeable-enemy"}
  circuit_lamp.minable = {mining_time = 0.1, result = "circuit-lamp"}
  circuit_lamp.collision_box = {{-0.9, -0.40}, {0.9, 0.40}}
  circuit_lamp.selection_box = {{-0.9, -0.40}, {0.9, 0.40}}
  circuit_lamp.apply_runtime_tint = false
  circuit_lamp.corpse = "small-remnants"
  circuit_lamp.dying_explosion = "pump-explosion" -- test explosion
  circuit_lamp.circuit_wire_connection_point = circuit_connector_definitions["circuit-screen"].points
  circuit_lamp.circuit_connector_sprites = circuit_connector_definitions["circuit-screen"].sprites
  circuit_lamp.circuit_wire_max_distance = default_circuit_wire_max_distance
  circuit_lamp.se_allow_in_space = true
  circuit_lamp.water_reflection = 
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

  circuit_lamp.energy_usage_per_tick = "2KW"
  circuit_lamp.energy_source =
  {
    type = "electric",
    usage_priority = "secondary-input",
  }
  circuit_lamp.picture_off = 
  {
    layers =
    {
      {
        filename = "__CircuitConditionScreen__/graphics/entities/lampoff32.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        shift = util.by_pixel(0, 0),
        hr_version =
        {
          filename = "__CircuitConditionScreen__/graphics/entities/lampoff64.png",
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
  circuit_lamp.light = nil
  circuit_lamp.light_when_colored = nil
  circuit_lamp.picture_on = empty_sprite



  empty_sprite.name = "emptysprite"
  empty_sprite.type = "sprite"
  data:extend({
  
  {
      type = "item",
      name = "circuit-screen",
      icon = "__CircuitConditionScreen__/graphics/icons/circ_screen_64_2sp.png",
      icon_size = 64,
      flags = {},
      subgroup = "circuit-network",
      order = "c[circuit-screen]",
      place_result = "circuit-screen",
      stack_size = 50
  },
  {
    type = "item",
    name = "circuit-lamp",
    icon = "__CircuitConditionScreen__/graphics/icons/bhr3b.png",
    icon_size = 64,
    flags = {},
    subgroup = "circuit-network",
    order = "c[circuit-lamp]",
    place_result = "circuit-lamp",
    stack_size = 50
},
  circuit_screen,
  circuit_lamp,
  empty_sprite
  })
  
  
  