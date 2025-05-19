
global.itemDatabase = {}

with (global.itemDatabase) {
  itemSword       = new Item("Sword", "", sword, 1, {
    durability: 500,
    atack: 8,
    GetDesc : function(_itemData) {
      var _desc = $"{_itemData.rarity}\nVery sharp\nAtack: {__.atack}\nDurability: {__.durability-_itemData.damage}/{__.durability}"
      return _desc;
    },
    OnUse : function(_slot) {
      var _data = _slot.GetData()
      _data.damage++
      if (_data.damage > __.durability) {
        _slot.Destroy()
      }
      _slot.SetData(_data)
      show_debug_message($"{__.name} used!")
    }
  })
  itemPickaxe     = new Item("Pickaxe", "", pickaxe, 1, {
    durability: 300,
    GetDesc : function(_itemData) {
      var _desc = $"{_itemData.rarity}\nPointy\nDurability: {__.durability-_itemData.damage}/{__.durability}"
      return _desc;
    },
    OnUse : function(_slot) {
      var _data = _slot.GetData()
      _data.damage++
      if (_data.damage > __.durability) {
        _slot.Destroy()
      }
      _slot.SetData(_data)
      show_debug_message($"{__.name} used!")
    }
  })
  itemAxe         = new Item("Axe", "", axe, 1, {
    durability: 350,
    GetDesc : function(_itemData) {
      var _desc = $"{_itemData.rarity}\nChop chop\nDurability: {__.durability-_itemData.damage}/{__.durability}"
      return _desc;
    },
    OnUse : function(_slot) {
      var _data = _slot.GetData()
      _data.damage++
      if (_data.damage > __.durability) {
        _slot.Destroy()
      }
      _slot.SetData(_data)
      show_debug_message($"{__.name} used!")
    }
  })
  itemHammer      = new Item("Hammer", "", hammer, 1, {
    durability: 250,
    GetDesc : function(_itemData) {
      var _desc = $"{_itemData.rarity}\nBuild and repair!\nDurability: {__.durability-_itemData.damage}/{__.durability}"
      return _desc;
    },
    OnUse : function(_slot) {
      var _data = _slot.GetData()
      _data.damage++
      if (_data.damage > __.durability) {
        _slot.Destroy()
      }
      _slot.SetData(_data)
      show_debug_message($"{__.name} used!")
    }
  })
  
  itemPumpkin     = new Item("Pumpkin", "Halloween", pumpkin_05)
  itemPotato      = new Item("Potato", "Great for fries!", potato_05)
  itemCarrot      = new Item("Carrot", "Tasty", carrot_05)
  itemSunflower   = new Item("Sunflower", "Oh sunshine", sunflower_05)
  
  itemEgg         = new Item("Egg", "Good for ommelet", egg, 12, {
    OnUse : function(_slot) {
      show_debug_message($"Trowed an egg!")
      _slot.SetCount(_slot.GetCount()-1)
    }
  })
  itemFish        = new Item("Fish", "Smelly", fish)
  itemMilk        = new Item("Milk", "Yummy!", milk, 8)
  itemWood        = new Item("Wood", "Basic material", wood, 64)
  
  itemWatch       = new Item("Watch", "Tells the time", stopwatch, 1, {
    GetDesc : function() {
      var _h = string_replace_all(string_format(current_hour, 2, 0), " ", "0")
      var _m = string_replace_all(string_format(current_minute, 2, 0), " ", "0")
      var _s = string_replace_all(string_format(current_second, 2, 0), " ", "0")
      return __.description + $"\n{_h}:{_m}:{_s}";
    },
  })
}



