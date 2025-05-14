

function InventoryItem(_config) constructor {
	// Private
  __ = {};
  with (__) {
    consumable  = _config[$ "consumable"] ?? false;
    stackSize   = _config[$ "stackSize"]  ?? 8;
    categoty    = _config[$ "category"]   ?? "";
  }
  
  static Draw = function() {
    
  }
  static Use = function() {
    
  }
  static ShowInfo = function() {
    
  }
}

global.itemList = {}