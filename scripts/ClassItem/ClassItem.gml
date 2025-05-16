
function Item(_name, _desc, _sprite, _stackSize, _config = {}) constructor {
	// Private
  __ = {};
  with (__) {
    name        = _name;
    description = _desc;
    sprite      = _sprite;
    stackSize   = _stackSize
    
    consumable  = _config[$ "consumable"] ?? false;
    rarity      = _config[$ "rarity"]     ?? RARITY.COMMON;
    on_use      = _config[$ "on_use"]     ?? undefined;
  }
  
  static Draw = function() {
    
  }
  static Use = function() {
    
  }
  static ShowInfo = function() {
    
  }
}
