
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

function CreateItem(_name, _type, _config = {}) {
  global.itemList[$ _name] = new Item(_config) 
}


CreateItem("Sword",     ITEM.TOOL, {})
CreateItem("Pickaxe",   ITEM.TOOL, {})
CreateItem("Axe",       ITEM.TOOL, {})
CreateItem("Hammer",    ITEM.TOOL, {})
CreateItem("Rod",       ITEM.TOOL, {})

CreateItem("Pumpkin",   ITEM.CROP, {})
CreateItem("Potato",    ITEM.CROP, {})
CreateItem("Carrot",    ITEM.CROP, {})
CreateItem("Sunflower", ITEM.CROP, {})
CreateItem("Wheat",     ITEM.CROP, {})

CreateItem("Egg",       ITEM.MATERIAL, {})
CreateItem("Fish",      ITEM.MATERIAL, {})
CreateItem("Milk",      ITEM.MATERIAL, {})
CreateItem("Wood",      ITEM.MATERIAL, {})
CreateItem("Rock",      ITEM.MATERIAL, {})