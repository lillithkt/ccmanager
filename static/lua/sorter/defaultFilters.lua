-- This is setup to my(lily) personal setup

lvn.sorter.cols = {
  {
    -- Hoes and shovels (for enchantment) rerolling, dont quesiton me
    left = function(item)
      return lvn.sorter.util.names({
        "minecraft:wooden_hoe",
        "minecraft:wooden_shovel",
      }, item)
    end,

    -- Tools
    back = function(item)
      return lvn.sorter.generic.tools(item) and not lvn.sorter.generic.armour(item)
    end,

    -- Decoration
    right = function(item)
      return lvn.sorter.util.nameMatches({
        ".*diorite.*",
        "^minecraft:glowstone.*"
      }, item) 
        or lvn.sorter.util.tags({
          "forge:glass",
          "forge:dyes"
        }, item)
    end,

    input = "top",
    nextRow = "front"
  },

  {
    -- Armour
    left = lvn.sorter.generic.armour,

    -- Default
    back = "default",

    -- Wood
    right = lvn.sorter.generic.wood,

    nextRow = "bottom",
    input = "top",

    -- Do default last
    order = {
      "left",
      "right",
      "front",
      "top",
      "bottom",
      "back"
    }
  },

  {
    -- Redstone
    left = lvn.sorter.generic.redstone,

    -- Ores
    back = lvn.sorter.generic.ores,

    -- Stone
    right = lvn.sorter.generic.stone,

    nextRow = "bottom",
    input = "front"
  },

  {
    -- Food
    left = lvn.sorter.generic.food,

    -- Mob Drops
    right = lvn.sorter.generic.mobdrops,

    input = "back"
  }
}

local pcLabel = os.getComputerLabel()

if pcLabel == "sorter1" then
  lvn.sorter.curCol = 1
elseif pcLabel == "sorter2" then
  lvn.sorter.curCol = 2
elseif pcLabel == "sorter3" then
  lvn.sorter.curCol = 3
elseif pcLabel == "sorter4" then
  lvn.sorter.curCol = 4
end