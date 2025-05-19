
global.itemDatabase = {}

with (global.itemDatabase) {
  itemSword       = new Item("Sword", "{rarity}\nVery sharp\nDurability: {damage}/{0}", sword, 1, {
    durability: 500,
    GetDesc : function(_itemData) {
      return string(StringReplaceKeys(__.description, _itemData), __.durability)
    }
  })
  itemPickaxe     = new Item("Pickaxe", "{rarity}\nPointy!\nDurability: {damage}/300", pickaxe, 1, {durability: 300})
  itemAxe         = new Item("Axe", "{rarity}\nChop chop\nDurability: {damage}/350", axe, 1, {durability: 350})
  itemHammer      = new Item("Hammer", "{rarity}\nBuild and repair!\nDurability: {damage}/250", hammer, 1, {durability: 250})
  
  itemPumpkin     = new Item("Pumpkin", "Halloween", pumpkin_05)
  itemPotato      = new Item("Potato", "Great for fries!", potato_05)
  itemCarrot      = new Item("Carrot", "Tasty", carrot_05)
  itemSunflower   = new Item("Sunflower", "Oh sunshine", sunflower_05)
  
  itemEgg         = new Item("Egg", "Good for ommelet", egg, 12)
  itemFish        = new Item("Fish", "Smelly", fish)
  itemMilk        = new Item("Milk", "Yummy!", milk, 8)
  itemWood        = new Item("Wood", "Basic material", wood, 64)
  
  itemWatch       = new Item("Watch", "Tells the time", stopwatch, 1, {
    GetDesc : function() {
      var _h = string_replace_all(string_format(current_hour, 2, 0), " ", "0")
      var _m = string_replace_all(string_format(current_minute, 2, 0), " ", "0")
      var _s = string_replace_all(string_format(current_second, 2, 0), " ", "0")
      return __.description + $"\n{_h}:{_m}:{_s}";
    }
  })
}

function ItemGetData(_itemId) {
  return global.itemDatabase[$ _itemId];
}

function ItemChooseRarity() {
  var _tiers = [
    "[#C0C0C0]Common",
    "[#60FF60]Rare",
    "[#FF60FF]Epic",
    "[#FFA020][wave]Legendary[/wave]",
  ]
  return _tiers[irandom(array_length(_tiers)-1)]+"[/c]"
}

