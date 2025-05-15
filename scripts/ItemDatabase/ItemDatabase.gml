
enum ITEM {
  TOOL,
  CROP,
  MATERIAL
}

enum RARITY {
  COMMON,
  RARE,
  EPIC,
  LEGENDARY,
}

global.itemList = {}

function CreateItem(_name, _id, _type, _config = {}) {
  global.itemList[$ _name] = new Item(_config) 
}

#region Tools

  CreateItem("Sword",     "itemSword",     ITEM.TOOL, {})
  CreateItem("Pickaxe",   "itemPickaxe",   ITEM.TOOL, {})
  CreateItem("Axe",       "itemAxe",       ITEM.TOOL, {})
  CreateItem("Hammer",    "itemHammer",    ITEM.TOOL, {})
  CreateItem("Rod",       "itemHammer",    ITEM.TOOL, {})

#endregion

#region Crops

  CreateItem("Pumpkin",   "itemPumpkin",   ITEM.CROP, {})
  CreateItem("Potato",    "itemPotato",    ITEM.CROP, {})
  CreateItem("Carrot",    "itemCarrot",    ITEM.CROP, {})
  CreateItem("Sunflower", "itemSunflower", ITEM.CROP, {})
  CreateItem("Wheat",     "itemWheat",     ITEM.CROP, {})

#endregion

#region Materials

  CreateItem("Egg",        "itemEgg",      ITEM.MATERIAL, {})
  CreateItem("Fish",       "itemFish",     ITEM.MATERIAL, {})
  CreateItem("Milk",       "itemMilk",     ITEM.MATERIAL, {})
  CreateItem("Wood",       "itemWood",     ITEM.MATERIAL, {})
  CreateItem("Rock",       "itemRock",     ITEM.MATERIAL, {})

#endregion
