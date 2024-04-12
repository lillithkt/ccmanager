lvn.sorter = {
  filters = {
    -- Stone
    right = function(item)
      if not item.tags then
        return false
      end
      return item.tags["forge:stone"] ~= nil
      or item.tags["forge:cobblestone"] ~= nil
      or item.tags["forge:gravel"] ~= nil
      or item.tags["minecraft:base_stone_overworld"] ~= nil
      or item.tags["minecraft:stone_tool_materials"] ~= nil
      or item.tags["minecraft:stone_crafting_materials"] ~= nil
      or item.name == "minecraft:flint"
    end,
    -- Food
    left = function(item)
      if not item.itemGroups then
        return false
      end
      for _, group in ipairs(item.itemGroups) do
        if group.id == "minecraft:food_and_drinks" then
          return true
        end
      end
      return false
    end,
    -- Input
    top = function(item)
      return false
    end,
    -- Ores
    bottom = function(item)
      if not item.tags then
        return false
      end
      return item.tags["forge:raw_materials"] ~= nil
      or item.tags["forge:gems"] ~= nil
      or item.tags["forge:ingots"] ~= nil
      or item.tags["forge:nuggets"] ~= nil
      or item.tags["minecraft:beacon_payment_items"] ~= nil
    end,
    -- Mob Drops
    front = function(item)
      return item.name == "minecraft:rotten_flesh"
      or item.name == "minecraft:bone"
      or item.name == "minecraft:gunpowder"
      or item.name == "minecraft:spider_eye"
      or item.name == "minecraft:ender_pearl"
      or item.name == "minecraft:blaze_rod"
      or item.name == "minecraft:ghast_tear"
      or item.name == "minecraft:slime_ball"
      or item.name == "minecraft:magma_cream"
      or item.name == "minecraft:string"
    end,
    -- Default
    back = function(item)
      return false
    end,
  },

  default = "back"
}