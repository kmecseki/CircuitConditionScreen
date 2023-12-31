local function players_present()

    local players_present = false
    for _, player in pairs(game.players) do
        if player.connected then
            players_present = true
            break
        end
    end
    return players_present
end

local function signal_is_blank(sigid)

    if sigid == nil or (sigid.type == "item" and sigid.name == nil) then
        return true
    else
        return false
    end
end

local function csupdate()

    if next(global.css)~=nil then
        for i=0, settings.global["number_of_cs_to_check_per_update"].value do
            global.csindex, cs = next(global.css, global.csindex)
            if cs~=nil then
                if cs.valid then
                    local surface = cs.surface
                    local behavior = cs.get_control_behavior()
                    local networkred = cs.get_circuit_network(defines.wire_type.red)
                    local networkgreen = cs.get_circuit_network(defines.wire_type.green)
                    if behavior and behavior['circuit_condition'] then
                        local rev = behavior.circuit_condition.fulfilled
                        if cs.name == "circuit-lamp" then
                            rev = not rev
                        end
                        if rev then
                            rendering.set_sprite(global.cstop[global.csindex], "emptysprite")
                            rendering.set_sprite(global.csbottom[global.csindex], "circuit-cond-Fault")
                            if cs.name == "circuit-lamp" then
                                rendering.set_color(global.csbottom[global.csindex],settings.global["lamp-off-color"].value)
                            --elseif cs.name == "circuit-screen" then
                            --    rendering.set_color(global.csbottom[global.csindex],settings.global["alarm-on-color"].value)
                            end                        
                        else
                            rendering.set_sprite(global.cstop[global.csindex], "circuit-cond-OK")
                            rendering.set_sprite(global.csbottom[global.csindex], "emptysprite")
                            if cs.name == "circuit-lamp" then
                                rendering.set_color(global.cstop[global.csindex],settings.global["lamp-on-color"].value)
                            --elseif cs.name == "circuit-screen" then
                            --    rendering.set_color(global.cstop[global.csindex],settings.global["alarm-off-color"].value)
                            end        
                        end
                        if networkred == nil and networkgreen == nil then
                            rendering.set_sprite(global.csbottom[global.csindex], "emptysprite")
                            rendering.set_sprite(global.cstop[global.csindex], "emptysprite")
                        end
                        if signal_is_blank(behavior.circuit_condition.condition.first_signal) then
                            rendering.set_sprite(global.csbottom[global.csindex], "emptysprite")
                            rendering.set_sprite(global.cstop[global.csindex], "emptysprite")
                        end
                    end
                else
                    rendering.destroy(global.cstop[global.csindex])
                    rendering.destroy(global.csbottom[global.csindex])
                    global.css[global.csindex] = nil
                    global.cstop[global.csindex] = nil
                    global.csbottom[global.csindex] = nil
                end
            end
        end
    end
end

local function on_tick(event)
    
    -- Check if players present and if yes, update units.
    if players_present then
        if game.tick % settings.global["update_every_x_tickcs"].value == 0 then
                csupdate()
        end
    end
end

local function create_textbox(cs, surface)

    global.cstop[cs.unit_number] = rendering.draw_sprite({ -- GREEN
            sprite = "emptysprite",
            target = {cs.position.x-0.38,cs.position.y-0.05},
            surface = surface,
            tint = {r=0.1,  g=0.8,  b=0.1, a=0.99},
            x_scale = 1,
            y_scale = 1,
            })
    global.csbottom[cs.unit_number] = rendering.draw_sprite({ -- RED
            sprite = "emptysprite",
            target = {cs.position.x+0.38,cs.position.y-0.08},
            surface = surface,
            tint = {r=0.9,  g=0.1,  b=0.1, a=0.85},
            x_scale = 1,
            y_scale = 1,
            })
end

local function placedcs(placed_entity)

    local surface = placed_entity.surface
    if placed_entity.name=="circuit-screen" or placed_entity.name=="circuit-lamp" then
        global.css[placed_entity.unit_number] = placed_entity
        create_textbox(placed_entity, surface)
        global.csindex = placed_entity.unit_number
    end
end

local function register_css()
    rendering.clear("CircuitConditionScreen") 
    for _,surface in pairs(game.surfaces) do
        for _,cs in pairs(surface.find_entities_filtered({name = {"circuit-screen", "circuit-lamp"}})) do
            global.css[cs.unit_number] = cs
            create_textbox(cs, surface)
            global.csindex = cs.unit_number
        end
    end
    if next(global.css)~= nil then
        global.csindex, cs = next(global.css, nil)
    end
end

local function removedcs(removed_entity)
    if removed_entity.name=="circuit-screen" or removed_entity.name=="circuit-lamp" then
        global.css[removed_entity.unit_number] = nil
        rendering.destroy(global.cstop[removed_entity.unit_number])
        rendering.destroy(global.csbottom[removed_entity.unit_number])
        global.cstop[removed_entity.unit_number] = nil
        global.csbottom[removed_entity.unit_number] = nil
    end
end

script.on_event(defines.events.on_built_entity, function(event) placedcs(event.created_entity) end)
script.on_event(defines.events.on_robot_built_entity, function(event) placedcs(event.created_entity) end)
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
      for _,ent in pairs(game.get_surface(event.surface_index).find_entities_filtered{name = {"circuit-screen", "circuit-lamp"},area = area}) do
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
    global.css = {}
    global.cstop = {}
    global.csbottom = {}
    global.csindex = 1
    register_css()
  end)

script.on_init(function() 
    global.css = {}
    global.cstop = {}
    global.csbottom = {}
    global.csindex = 1
  end)

script.on_event(defines.events.on_tick, on_tick)
