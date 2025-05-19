
// Create items here

global.itemDatabase = {}

with (global.itemDatabase) {
  itemSword       = new Item("Sword", "", sword, 1, {
    durability: 500,
    atack: 8,
    GetDesc : function(_itemData) {
      var _desc = $"{_itemData.rarity}\nVery sharp\nAtack: {atack}\nDurability: {durability-_itemData.damage}/{durability}";
      return _desc;
    },
    OnUse : function(_slot) {
      var _data = _slot.GetData();
      _data.damage++
      if (_data.damage >= durability) {
        _slot.Destroy();
      }
      _slot.SetData(_data);
      show_debug_message($"Player used the {GetName()}!");
    }
  })
  itemPickaxe     = new Item("Pickaxe", "", pickaxe, 1, {
    durability: 300,
    GetDesc : function(_itemData) {
      var _desc = $"{_itemData.rarity}\nPointy\nDurability: {durability-_itemData.damage}/{durability}";
      return _desc;
    },
    OnUse : function(_slot) {
      var _data = _slot.GetData();
      _data.damage++;
      if (_data.damage >= durability) {
        _slot.Destroy();
      }
      _slot.SetData(_data);
      show_debug_message($"Player used the {GetName()}!");
    }
  })
  itemAxe         = new Item("Axe", "", axe, 1, {
    durability: 350,
    GetDesc : function(_itemData) {
      var _desc = $"{_itemData.rarity}\nChop chop\nDurability: {durability-_itemData.damage}/{durability}";
      return _desc;
    },
    OnUse : function(_slot) {
      var _data = _slot.GetData();
      _data.damage++;
      if (_data.damage >= durability) {
        _slot.Destroy();
      }
      _slot.SetData(_data);
      show_debug_message($"Player used the {GetName()}!");
    }
  })
  itemHammer      = new Item("Hammer", "", hammer, 1, {
    durability: 250,
    GetDesc : function(_itemData) {
      var _desc = $"{_itemData.rarity}\nBuild and repair!\nDurability: {durability-_itemData.damage}/{durability}";
      return _desc;
    },
    OnUse : function(_slot) {
      var _data = _slot.GetData()
      _data.damage++;
      if (_data.damage >= durability) {
        _slot.Destroy();
      }
      _slot.SetData(_data);
      show_debug_message($"Player used the {GetName()}!");
    }
  })
  
  itemPumpkin     = new Item("Pumpkin", "Halloween", pumpkin_05,, {
    OnUse : function(_slot) {
      show_debug_message($"Player carved a pumpkin!");
      _slot.SetCount(_slot.GetCount()-1);
    }
  })
  itemPotato      = new Item("Potato", "Great for fries!", potato_05,, {
    OnUse : function(_slot) {
      show_debug_message($"Player friend a potato!");
      _slot.SetCount(_slot.GetCount()-1);
    }
  })
  itemCarrot      = new Item("Carrot", "Tasty", carrot_05,, {
    OnUse : function(_slot) {
      show_debug_message($"Player eated a carrot!");
      _slot.SetCount(_slot.GetCount()-1);
    }
  })
  itemSunflower   = new Item("Sunflower", "Oh sunshine", sunflower_05,, {
    OnUse : function(_slot) {
      show_debug_message($"Player planted a sunflower!");
      _slot.SetCount(_slot.GetCount()-1);
    }
  })
  
  itemEgg         = new Item("Egg", "Good for ommelet", egg, 16, {
    OnUse : function(_slot) {
      show_debug_message($"Player trowed an egg!");
      _slot.SetCount(_slot.GetCount()-1);
    }
  })
  itemFish        = new Item("Fish", "Smelly", fish,, {
    OnUse : function(_slot) {
      show_debug_message($"Player trowed a fish!");
      _slot.SetCount(_slot.GetCount()-1);
    }
  })
  itemMilk        = new Item("Milk", "Yummy!", milk,, {
    OnUse : function(_slot) {
      show_debug_message($"Player drinked a bottle of milk!");
      _slot.SetCount(_slot.GetCount()-1);
    }
  })
  itemWood        = new Item("Wood", "Basic material", wood, 64, {
    OnUse : function(_slot) {
      show_debug_message($"Player used a piece of wood!");
      _slot.SetCount(_slot.GetCount()-1);
    }
  })
  
  itemWatch       = new Item("Watch", "Tells the time", stopwatch, 1, {
    OnUse : function(_slot) {
      show_debug_message($"Player checked the time!");
    },
    GetDesc : function() {
      var _h = string_replace_all(string_format(current_hour, 2, 0), " ", "0");
      var _m = string_replace_all(string_format(current_minute, 2, 0), " ", "0");
      var _s = string_replace_all(string_format(current_second, 2, 0), " ", "0");
      return __description + $"\n{_h}:{_m}:{_s}";
    },
  })
}



