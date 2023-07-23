data:extend({
    {
        type = "technology",
        name = "circuit-screen",
        icon_size = 512,
        icon = "__CircuitConditionScreen__/graphics/icons/techiconsmall.png",
        effects =
        {
          {
            type = "unlock-recipe",
            recipe = "circuit-screen-rec"
          }
        },
        prerequisites = {"electronics"},
        unit =
        {
          count = 30,
          ingredients =
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack",1}
          },
          time = 15
        },
        order = "e-d-e"
      }
    })
