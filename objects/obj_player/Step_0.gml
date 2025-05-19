
if (InputPressed(INPUT_VERB.INV)) {
  inventory.SetOpen(!inventory.GetOpen())
}

if (keyboard_check_pressed(vk_space)) {
  var _itemId = choose("itemPumpkin", "itemPotato", "itemCarrot", "itemSunflower", "itemEgg", "itemFish", "itemMilk", "itemWood");
  var _itemCount = irandom_range(4, 24);
  var _itemData = undefined;
  inventory.AddItem(_itemId, _itemCount, _itemData);
}

if (keyboard_check_pressed(ord("P"))) {
  var _itemId = choose("itemSword", "itemAxe", "itemPickaxe", "itemHammer")
  var _itemData = {
    rarity : ItemChooseRarity(),
    damage: (ItemGetData(_itemId).durability)-4
  }
  inventory.AddItem(_itemId, 1, _itemData);
}

if (keyboard_check_pressed(ord("W"))) {
  inventory.AddItem("itemWatch")
}