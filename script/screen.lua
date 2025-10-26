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

local function move_light(cs)
    if storage.cstop[storage.csindex] then
          storage.cstop[storage.csindex].target = { cs.position.x - 0.38,cs.position.y - 0.05 }
    end
    if storage.csbottom[storage.csindex] then
          storage.csbottom[storage.csindex].target = { cs.position.x + 0.38,cs.position.y - 0.08 }
    end

end

local function csupdate()

    if next(storage.css)~=nil then
        for i=0, settings.global["number_of_cs_to_check_per_update"].value do
            storage.csindex, cs = next(storage.css, storage.csindex)
            if cs~=nil then
                if cs.valid then
                    local surface = cs.surface
                    local behavior = cs.get_control_behavior()
                    local networkred = cs.get_circuit_network(defines.wire_connector_id.circuit_red)
                    local networkgreen = cs.get_circuit_network(defines.wire_connector_id.circuit_green)
                    if behavior and behavior['circuit_condition'] then
                        if storage.cstop[storage.csindex] ~= nil then
                            if storage.cstop[storage.csindex].target ~= { cs.position.x - 0.38,cs.position.y - 0.05 } then
                                move_light(cs)
                            end
                        end
                        local rev = behavior.circuit_condition.fulfilled
                        if cs.name == "circuit-lamp" then
                            rev = not rev
                        end
                        if rev then
                            -- prios-zold fulfilled
                            storage.cstop[storage.csindex].sprite = "emptysprite"
                            storage.csbottom[storage.csindex].sprite = "circuit-cond-Fault"
                            if cs.name == "circuit-lamp" then
                                storage.csbottom[storage.csindex].color = settings.global["lamp-off-color"].value
                            end
                        else
                            storage.cstop[storage.csindex].sprite = "circuit-cond-OK"
                            storage.csbottom[storage.csindex].sprite = "emptysprite"
                            if cs.name == "circuit-lamp" then
                                storage.cstop[storage.csindex].color = settings.global["lamp-on-color"].value
                            end
                        end
                        if networkred == nil and networkgreen == nil then
                            storage.csbottom[storage.csindex].sprite = "emptysprite"
                            storage.cstop[storage.csindex].sprite = "emptysprite"
                        end
                        local cond = behavior.circuit_condition.condition
                        if cond ~= nil then
                            if signal_is_blank(cond.first_signal) then
                                storage.csbottom[storage.csindex].sprite = "emptysprite"
                                storage.cstop[storage.csindex].sprite = "emptysprite"
                            end
                        end
                    end
                else
                    storage.cstop[storage.csindex].destroy()
                    storage.csbottom[storage.csindex].destroy()
                    storage.css[storage.csindex] = nil
                    storage.cstop[storage.csindex] = nil
                    storage.csbottom[storage.csindex] = nil
                end
            end
        end
    end
end

function on_tick(event)
    
    -- Check if players present and if yes, update units.
    if players_present then
        if game.tick % settings.global["update_every_x_tickcs"].value == 0 then
                csupdate()
        end
    end
end

local function drawsprites(cs, surface)

    storage.cstop[cs.unit_number] = rendering.draw_sprite({ -- GREEN
        sprite = "emptysprite",
        target = {cs.position.x-0.38,cs.position.y-0.05},
        surface = surface,
        tint = {r=0.1,  g=0.8,  b=0.1, a=0.99},
        x_scale = 1,
        y_scale = 1,
    })
    storage.csbottom[cs.unit_number] = rendering.draw_sprite({ -- RED
        sprite = "emptysprite",
        target = {cs.position.x+0.38,cs.position.y-0.08},
        surface = surface,
        tint = {r=0.9,  g=0.1,  b=0.1, a=0.85},
        x_scale = 1,
        y_scale = 1,
    })
end

function placedcs(placed_entity)

    local surface = placed_entity.surface
    if placed_entity.name=="circuit-screen" or placed_entity.name=="circuit-lamp" then
        storage.css[placed_entity.unit_number] = placed_entity
        drawsprites(placed_entity, surface)
        storage.csindex = placed_entity.unit_number
    end
end

function register_css()
    rendering.clear("CircuitConditionScreen") 
    for _,surface in pairs(game.surfaces) do
        for _,cs in pairs(surface.find_entities_filtered({name = {"circuit-screen", "circuit-lamp"}})) do
            storage.css[cs.unit_number] = cs
            drawsprites(cs, surface)
            storage.csindex = cs.unit_number
        end
    end
    if next(storage.css)~= nil then
        storage.csindex, cs = next(storage.css, nil)
    end
end

function removedcs(removed_entity)
    if removed_entity.name=="circuit-screen" or removed_entity.name=="circuit-lamp" then
        storage.css[removed_entity.unit_number] = nil
        storage.cstop[removed_entity.unit_number].destroy()
        storage.csbottom[removed_entity.unit_number].destroy()
        storage.cstop[removed_entity.unit_number] = nil
        storage.csbottom[removed_entity.unit_number] = nil
    end
end