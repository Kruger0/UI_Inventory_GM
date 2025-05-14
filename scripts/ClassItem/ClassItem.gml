
function Item(_config) constructor {
	// Private
  __ = {};
  with (__) {
    consumable  = _config[$ "consumable"] ?? false;
    stackSize   = _config[$ "stackSize"]  ?? 8;
    categoty    = _config[$ "category"]   ?? "";
    sprite      = _config[$ "sprite"]     ?? undefined;
    rarity      = _config[$ "rarity"]     ?? RARITY.COMMON;
  }
  
  static Draw = function() {
    
  }
  static Use = function() {
    
  }
  static ShowInfo = function() {
    
  }
}
