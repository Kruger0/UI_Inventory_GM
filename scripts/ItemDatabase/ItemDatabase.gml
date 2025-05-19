
enum RARITY {
  COMMON,
  RARE,
  EPIC,
  LEGENDARY,
}

global.itemDatabase = {}

with (global.itemDatabase) {
  itemSword       = new Item("Sword", "Rarity: {rarity}", sword, 1, {durability: 200})
  itemPickaxe     = new Item("Pickaxe", "Very sharp", pickaxe, 1, {durability: 300})
  itemAxe         = new Item("Axe", "Very sharp", axe, 1, {durability: 350})
  itemHammer      = new Item("Hammer", "Very sharp", hammer, 1, {durability: 250})
  
  itemPumpkin     = new Item("Pumpkin", "Halloween", pumpkin_05)
  itemPotato      = new Item("Potato", "Great for fries!", potato_05)
  itemCarrot      = new Item("Carrot", "Tasty", carrot_05)
  itemSunflower   = new Item("Sunflower", "Oh sunshine", sunflower_05)
  
  itemEgg         = new Item("Egg", "Good for ommelet", egg)
  itemFish        = new Item("Fish", "Smelly", fish)
  itemMilk        = new Item("Milk", "Yummy!", milk, 16)
  itemWood        = new Item("Wood", "Useful", wood, 64)
}

function ItemGetData(_itemId) {
  return global.itemDatabase[$ _itemId]
}

