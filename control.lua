require("script/screen.lua")

script.on_event(defines.events.on_built_entity, function(event) placedcs(event.entity) end)
script.on_event(defines.events.on_robot_built_entity, function(event) placedcs(event.entity) end)
script.on_event(defines.events.script_raised_built, function(event) placedcs(event.entity) end)
script.on_event(defines.events.script_raised_revive, function(event) placedcs(event.entity) end)
script.on_event(defines.events.on_entity_cloned, function(event) placedcs(event.destination) end)

script.on_event(defines.events.on_pre_player_mined_item, function(event) removedcs(event.entity) end)
script.on_event(defines.events.on_robot_pre_mined, function(event) removedcs(event.entity) end)
script.on_event(defines.events.on_entity_died, function(event) removedcs(event.entity) end)
script.on_event(defines.events.script_raised_destroy, function(event) removedcs(event.entity) end)


script.on_event(defines.events.on_pre_chunk_deleted, function(event)
    for _,chunk in pairs(event.positions) do
      local x = chunk.x
      local y = chunk.y
      local area = {{x*32,y*32},{31+x*32,31+y*32}}
      for _,ent in pairs(game.get_surface(event.surface_index).find_entities_filtered{name = {"circuit-screen", "circuit-lamp"}, area = area}) do
        removedcs(ent)
      end
    end
  end)
  script.on_event(defines.events.on_pre_surface_cleared,function (event)
    for _,ent in pairs(game.get_surface(event.surface_index).find_entities_filtered{name = {"circuit-screen", "circuit-lamp"}}) do
        removedcs(ent)
    end
  end)
  script.on_event(defines.events.on_pre_surface_deleted,function (event)
    for _,ent in pairs(game.get_surface(event.surface_index).find_entities_filtered{name = {"circuit-screen", "circuit-lamp"}}) do
        removedcs(ent)
    end
  end)


script.on_configuration_changed(function()
    storage.css = {}
    storage.cstop = {}
    storage.csbottom = {}
    storage.csindex = 1
    register_css()
  end)

script.on_init(function() 
    storage.css = {}
    storage.cstop = {}
    storage.csbottom = {}
    storage.csindex = 1
  end)

script.on_event(defines.events.on_tick, on_tick)
