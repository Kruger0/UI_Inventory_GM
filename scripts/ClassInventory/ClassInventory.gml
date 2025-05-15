

function InventoryManager(_cols, _rows) constructor {
  
  // Private
  __ = {};
  with (__) {
   cols   = _config[$ "cols"]  ?? 2;
	 rows   = _config[$ "rows"] ?? 2;
   isOpen = false;
	   
   panelSpr = undefined;
   panelScl = 1;
   panelRound = 5;
   panelColor = c_white;
   panelAlpha = 1;
   
   slotArray    = [];
   slotSelected = 0;
   slotWidth    = 4;
   slotHeight   = 4;
   slotSprite   = undefined;
   slotHPad     = 2;
   slotVPad     = 2;
    
   color = c_white;
   alpha = 1;
   hPad   = 2;
   vPad   = 2;
  }
  
  // Public
  static Create = function() {
    
    for (var _i = 0; _i < __.rows; _i++) {
      for (var _j = 0; _j < __.cols; _j++) {
        // Create slots
        array_push(__.slotArray, new Slot())
      }
    }
    
    return self;
  }
  static GetCols = function() {
    return __.cols;
  }
  static SetCols = function(_cols) {
    __.cols = _cols;
    return self;
  }
  static GetRows = function() {
    return __.rows;
  }
  static SetRows = function(_rows) {
    __.rows = _rows;
    return self;
  }
  static SetOpen = function(_open) {
    __.isOpen = _open;
    return self;
  }
  static GetOpen = function() {
    return __.isOpen;
  }
  
  static AddItem = function(_item) {
    // search for item stack in inventory and push into slot list
  }
  static RemoveItem = function(_item) {
    // search for item stack in inventory and push into slot list
  }
  
  static Sort = function() {
    
  }
  
  static Update = function() {
    
  }
  
  static Draw = function(_x, _y) {
    var _mat_old = matrix_get(matrix_world)
    matrix_set(matrix_world, matrix_build(_x, _y, 0, 0, 0, 0, 1, 1, 1))
    for (var _i = 0; _i < __.rows; _i++) {
      for (var _j = 0; _j < __.cols; _j++) {
        var _xx = (_j * 32) + _x;
        var _yy = (_i * 32) + _y;
        scribble("[sword]").draw(_xx, _yy)
      }
    }
    
    matrix_set(matrix_world, _mat_old)
  }
  
}

