for _, force in pairs(game.forces) do
  if force.recipes["circuit-screen-rec"] and force.recipes["circuit-lamp-rec"] then
    force.recipes["circuit-screen-rec"].enabled = false
    force.recipes["circuit-lamp-rec"].enabled = false
  end
  if force.recipes["circuit-screen"] and force.recipes["circuit-lamp"] then
    force.recipes["circuit-screen"].enabled = true
    force.recipes["circuit-lamp"].enabled = true
  end
end