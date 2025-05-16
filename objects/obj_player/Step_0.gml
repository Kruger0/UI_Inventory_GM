
if (InputPressed(INPUT_VERB.INV)) {
  inventory.SetOpen(!inventory.GetOpen())
}

if (keyboard_check_pressed(vk_space)) {
  var _itemId = choose("itemMilk", "itemPotato", "itemPumpkin", "itemWood", "itemEgg", "itemFish");
  var _itemCount = irandom_range(1, 8);
  var _itemData = undefined;
  inventory.AddItem(_itemId, _itemCount, _itemData);
}