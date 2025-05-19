
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
  return _tiers[irandom(array_length(_tiers)-1)]+"[#C0C0C0]"
}