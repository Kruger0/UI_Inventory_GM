
///@param Width menu width
function InventoryManager(_config = {}) constructor {
  
  // Private
  __ = {};
  with (__) {
	 cols   = _config[$ "cols"]  ?? 2;
	 rows   = _config[$ "rows"] ?? 2;
   slots  = [];
   slotSelected = 0;
   isOpen = false;
  }
  
  // Public
  static Create = function() {
    show_debug_message("hello");
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

