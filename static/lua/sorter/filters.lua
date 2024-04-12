


lvn.sorter = {
  defaultOrder = {
    "left",
    "back",
    "right",
    "front",
    "top",
    "bottom"
  },

  util = {
    always = function(item)
      return true
    end,

    never = function(item)
      return false
    end,

    tags = function(tags, item)
      if not item or not item.tags then
        return false
      end
      for _, tag in ipairs(tags) do
        if item.tags[tag] then
          return true
        end
      end
      return false
    end,

    tagsMatches = function(matchers, item)
      if not item or not item.tags then
        return false
      end
      for _, matcher in ipairs(matchers) do
        for tag, _ in pairs(item.tags) do
          if tag:match(matcher) then
            return true
          end
        end
      end
      return false
    end,

    groups = function(groups, item)
      if not item or not item.itemGroups then
        return false
      end
      for _, group in ipairs(groups) do
        for _, itemGroup in ipairs(item.itemGroups) do
          if itemGroup.id == group then
            return true
          end
        end
      end
      return false
    end,

    names = function(names, item)
      if not item or not item.name then
        return false
      end
      for _, name in ipairs(names) do
        if item.name == name then
          return true
        end
      end
      return false
    end,

    nameMatches = function(matchers, item)
      if not item or not item.name then
        return false
      end
      for _, matcher in ipairs(matchers) do
        print(matcher, item.name)
        if item.name:match(matcher) then
          return true
        end
      end
      return false
    end,

    mods = function(mods, item)
      if not item or not item.name then
        return false
      end
      for _, mod in ipairs(mods) do
        if item.name:match("^" .. mod .. ":") then
          return true
        end
      end
      return false
    end
  },


  generic = {
    stone = function(item)
      return lvn.sorter.util.tags({
        "forge:stone",
        "forge:cobblestone",
        "forge:gravel",
        "minecraft:base_stone_overworld",
        "minecraft:stone_tool_materials",
        "minecraft:stone_crafting_materials",
      }, item) or lvn.sorter.util.names({"minecraft:flint"}, item)
    end,
    
    food = function(item)
      return (
          lvn.sorter.util.groups({"minecraft:food_and_drinks"}, item)
          and not lvn.sorter.generic.mobdrops(item)
        ) or lvn.sorter.util.tags({
          "forge:seeds",
          "forge:egg",
          "forge:crops",
        })
    end,
    
    ores = function(item)
      return lvn.sorter.util.tags({
        "minecraft:coals",
        "forge:raw_materials",
        "forge:gems",
        "forge:ingots",
        "forge:nuggets",
        "minecraft:beacon_payment_items"
      }, item)
    end,

    mobdrops = function(item)
      return lvn.sorter.util.names({
        "minecraft:rotten_flesh",
        "minecraft:bone",
        "minecraft:gunpowder",
        "minecraft:spider_eye",
        "minecraft:ender_pearl",
        "minecraft:blaze_rod",
        "minecraft:ghast_tear",
        "minecraft:slime_ball",
        "minecraft:magma_cream",
        "minecraft:string"
      }, item)
    end,

    tools = function(item)
      return lvn.sorter.util.tags({
        "forge:tools"
      }, item) or lvn.sorter.util.groups({
        "minecraft:tools_and_utilities"
      }, item)
    end,

    redstone = function(item)
      return lvn.sorter.util.groups({
        "minecraft:redstone_blocks"
      }, item)
    end,

    wood = function(item)
      local woodtypes = {
        "oak",
        "spruce",
        "birch",
        "jungle",
        "acacia",
        "dark_oak",
        "crimson",
        "warped",
        "cherry"
      }

      local woodMatches = {}

      for _, woodtype in ipairs(woodtypes) do
        table.insert(woodMatches, "^minecraft:" .. woodtype .. "_.+")
      end

      return lvn.sorter.util.nameMatches(woodMatches, item) or lvn.sorter.util.tags({
        "minecraft:logs"
      }, item)
      or lvn.sorter.util.tagsMatches({
        "^forge:.+/wooden"
      }, item)
    end,

    armour = function(item)
      return lvn.sorter.util.tags({
        "forge:armors"
      }, item) or lvn.sorter.util.names({
        "minecraft:saddle"
      }, item) or lvn.sorter.util.nameMatches({
        "minecraft:.+_horse_armor"
      }, item)
    end,
  }
}