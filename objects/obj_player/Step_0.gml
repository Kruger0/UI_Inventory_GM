
if (!inventory.GetOpen()) {
  var _hmov = InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT)
  var _vmov = InputCheck(INPUT_VERB.DOWN)  - InputCheck(INPUT_VERB.UP)
  if (_hmov != 0) {
    image_xscale = sign(_hmov)
  }

  if (_hmov != 0 || _vmov != 0) {
    sprite_index = spr_run462
  } else {
    sprite_index = spr_idle473
  }

  var _collider = move_and_collide(_hmov, _vmov, obj_wall)
}


if (InputPressed(INPUT_VERB.INV)) {
  inventory.SetOpen(!inventory.GetOpen())
}


if (InputPressed(INPUT_VERB.ADD)) {
  var _itemId = ""
  var _itemCount = 1
  var _itemData = undefined
  if (choose(1, 1, 1, 0)) {
    _itemId = choose("itemPumpkin", "itemPotato", "itemCarrot", "itemSunflower", "itemEgg", "itemFish", "itemMilk", "itemWood");
    _itemCount = irandom_range(4, 24);
  } else {
    _itemId = choose("itemSword", "itemAxe", "itemPickaxe", "itemHammer", "itemWatch");
    _itemData = {
      rarity : ItemChooseRarity(),
      damage: irandom(ItemGetData(_itemId)[$ "durability"] ?? 0)
    };
  }
  inventory.AddItem(_itemId, _itemCount, _itemData);  
}
