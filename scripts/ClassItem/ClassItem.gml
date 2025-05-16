
function Item(_name, _desc, _sprite, _config = {}) constructor {
	// Private
  __ = {};
  with (__) {
    name        = _name;
    description = _desc;
    sprite      = _sprite;
    
    stackSize   = _config[$ "stackSize"]  ?? 16;
    consumable  = _config[$ "consumable"] ?? false;
    rarity      = _config[$ "rarity"]     ?? RARITY.COMMON;
    durability  = _config[$ "durability"] ?? infinity;
    
    onUse       = method(self, _config[$ "on_use"] ?? function(){show_debug_message($"Item {__.name} used.")});
  }
}

