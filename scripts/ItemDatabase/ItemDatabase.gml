
enum RARITY {
  COMMON,
  RARE,
  EPIC,
  LEGENDARY,
}

global.itemDatabase = {}

with (global.itemDatabase) {
  itemSword       = new Item("Sword", "Very sharp", sword, {stackSize: 1,durability: 200})
  itemPickaxe     = new Item("Pickaxe", "Very sharp", pickaxe, {stackSize: 1,durability: 200})
  itemAxe         = new Item("Axe", "Very sharp", axe, {stackSize: 1,durability: 200})
  itemHammer      = new Item("Hammer", "Very sharp", hammer, {stackSize: 1,durability: 200})
  
  itemPumpkin     = new Item("Pumpkin", "Halloween", pumpkin_05)
  itemPotato      = new Item("Potato", "Great for fries!", potato_05)
  itemCarrot      = new Item("Carrot", "Tasty", carrot_05)
  itemSunflower   = new Item("Sunflower", "Oh sunshine", sunflower_05)
  
  itemEgg         = new Item("Egg", "Ommelet", egg)
  itemFish        = new Item("Fish", "Smelly", fish)
  itemMilk        = new Item("Milk", "Yummy!", milk, {rarity: RARITY.LEGENDARY})
  itemWood        = new Item("Wood", "Useful", wood, {stackSize: 64})
}


function ItemGetData(_itemId) {
  return global.itemDatabase[$ _itemId]
}

