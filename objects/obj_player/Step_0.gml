
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
  inventory.AddItem(choose("itemSword", "itemAxe", "itemPickaxe", "itemHammer"), 1, {rarity : ItemSetRarity(), damage: irandom(300)});
}