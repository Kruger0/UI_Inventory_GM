

function InventoryManager(_slots, _columns) constructor {
  
  // Private
  __ = {};
  with (__) {
   slots    = _slots
	 cols     = _columns;
   
   
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
    
    for (var _i = 0; _i < __.slots; _i++) {
      array_push(__.slotArray, new Slot())
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
       
    // Visual matrix
    var _mat_old = matrix_get(matrix_world)
    var _scale = 2;
    matrix_set(matrix_world, matrix_build(_x, _y, 0, 0, 0, 0, _scale, _scale, 1))

    // Background
    var _slotWidth  = 32
    var _slotHeight = 32
    var _wid = __.cols * _slotWidth
    var _hei = __.slots div __.cols * _slotHeight
    var _bgPad = 4
    draw_sprite_stretched(spr_dt_box, 0, -_wid/2 - _bgPad, -_hei/2 - _bgPad, _wid + _bgPad*2, _hei + _bgPad*2)
    
    // Input
    var _mouseX = (device_mouse_x_to_gui(0) - _x) / _scale
    var _mouseY = (device_mouse_y_to_gui(0) - _y) / _scale            

    // Slots
    var _overId = -1
    for (var _i = 0; _i < __.slots; _i++) {
      var _sx = _i mod __.cols * _slotWidth - _wid/2;
      var _sy = _i div __.cols * _slotHeight - _hei/2;      
      var _slot = __.slotArray[_i]
        
      // Slot box
      var _slotPad = -2
      var _x1 = _sx - _slotPad
      var _y1 = _sy - _slotPad
      var _x2 = _x1 + _slotWidth + _slotPad*2
      var _y2 = _y1 + _slotHeight + _slotPad*2
      
      // Mouse Over Slot
      var _mouseOver = point_in_rectangle(_mouseX, _mouseY, _x1, _y1, _x2, _y2)
      var _slotBox = spr_lt_box;
      if (_mouseOver) {
        _overId = _i
        _slotBox = spr_w_box
      }
      
      draw_sprite_stretched(_slotBox, 0, _x1, _y1, _x2 - _x1, _y2 - _y1)
      
      // Item Sprite
      // global.itemDatabase[$ _slot.itemId].sprite
      // _slot.GetItem().sprite
      scribble("[sword]").align(1, 1).draw(_sx + _slotWidth/2, _sy + _slotHeight/2)
      
      // Item Count
      // _slot.itemCount
      scribble(_i*64).align(2, 2).draw(_sx + _slotWidth - 1, _sy + _slotHeight + 2)
    }
    
    // Item Description
    if (_overId != -1) {
      var _descString = "Sword" + "\n" + "It's very sharp and shiny"
      var _descHPad  = 6
      var _descVPad  = 3
      var _descWidth = string_width_scribble(_descString) + _descHPad*2
      var _descHeight = string_height_scribble(_descString) + _descVPad*2
      var _descDist = 32 / _scale
      var _descX = _mouseX + _descDist - _descHPad
      var _descY = _mouseY + _descDist - _descVPad
      draw_sprite_stretched(spr_w_box, 0, _descX, _descY, _descWidth, _descHeight)
      scribble(_descString).draw(_mouseX + _descDist, _mouseY + _descDist)
    }
    
    matrix_set(matrix_world, _mat_old)
  }  
}

