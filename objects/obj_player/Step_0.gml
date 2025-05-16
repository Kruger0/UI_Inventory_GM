
if (InputPressed(INPUT_VERB.INV)) {
  inventory.SetOpen(!inventory.GetOpen())
}

if (keyboard_check_pressed(vk_space)) {
  inventory.AddItem(choose("itemMilk", "itemPotato", "itemPumpkin", "itemWood", "itemEgg", "itemFish"), irandom(8))
}