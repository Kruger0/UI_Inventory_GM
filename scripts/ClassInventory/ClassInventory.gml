

function InventoryManager(_slots, _columns) constructor {
  
  // Private
  __ = {};
  with (__) {
   slots    = _slots
	 cols     = _columns;
   
   
   isOpen       = false;
   
   animDuration = 20;
   animTime     = 0
   animCurve    = 5
	   
   panelSpr = undefined;
   panelScl = 1;
   panelRound = 5;
   panelColor = c_white;
   panelAlpha = 1;
   
   slotArray    = array_create(_slots, -1);
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
  static SetStyle = function() {
    
    //for (var _i = 0; _i < __.slots; _i++) {
    //  array_push(__.slotArray, new Slot())
    //}
    
    return self;
  }

  static SetOpen = function(_open) {
    __.isOpen = _open;
    return self;
  }
  static GetOpen = function() {
    return __.isOpen;
  }
  
  static AddItem = function(_itemId, _itemData) {
    
    // Se é um ítem estacável, procura o inventário por um stack dele
    if (is_numeric(_itemData)) {
      var _itemCount = _itemData
      var _itemStack = ItemGetData(_itemId).__.stackSize
      for (var _i = 0; _i < __.slots; _i++) {
        var _slot = __.slotArray[_i]  
        if (is_struct(_slot) && _slot.__.itemId == _itemId) {// se é um slot do mesmo item
          while (_itemCount > 0 && _slot.__.itemData < _itemStack) {
            _slot.__.itemData++;
            _slot.SetScale().SetAngle()
            _itemCount--;
          }
        }      
      }
      // Se sobrou item estacável
      while (_itemCount > 0) {
        for (var _i = 0; _i < __.slots; _i++) {
          var _slot = __.slotArray[_i]
          if (_slot == -1) {
            if (_itemCount <= _itemStack) {
              __.slotArray[_i] = new Slot(_itemId, _itemCount)
              _itemCount = 0;
              break;
            } else {
              __.slotArray[_i] = new Slot(_itemId, _itemStack)
              _itemCount -= _itemStack
            }
          }
        }
        if (_i == __.slots) break;
      }
    }

    // Se é um ítem único
    if (is_struct(_itemData)) {
    
    }
  }
  static RemoveItem = function(_item) {
    // search for item stack in inventory and push into slot list
  }
  
  static Sort = function() {
    
  }
  
  
  static Draw = function(_x, _y) {
    
    // Animation
    var _animValue = 0
    var _animName = ""
    if (__.isOpen) {
      __.animTime = min(++__.animTime, __.animDuration)
      _animName = "open"
    } else {
      __.animTime = max(--__.animTime, 0)
      _animName = "close"
    }
    var _pos = __.animTime / __.animDuration
    _animValue = 500 - animcurve_channel_evaluate(animcurve_get_channel(ac_inventory, "open"), _pos) * 500
     
    // Visual matrix
    var _mat_old = matrix_get(matrix_world)
    var _scale = 2;
    matrix_set(matrix_world, matrix_build(_x, _y + _animValue, 0, 0, 0, 0, _scale, _scale, 1))

    // Background
    var _slotWidth  = 32
    var _slotHeight = 32
    var _wid = __.cols * _slotWidth
    var _hei = __.slots div __.cols * _slotHeight
    var _bgPad = 4
    draw_sprite_stretched(spr_dt_box, 0, -_wid/2 - _bgPad, -_hei/2 - _bgPad, _wid + _bgPad*2, _hei + _bgPad*2)
    
    // Input
    var _mouseX = (device_mouse_x_to_gui(0) - _x) / _scale
    var _mouseY = (device_mouse_y_to_gui(0) - _y - _animValue) / _scale            

    // Slots
    var _overId = -1
    for (var _i = 0; _i < __.slots; _i++) {
      var _sx = _i mod __.cols * _slotWidth - _wid/2;
      var _sy = _i div __.cols * _slotHeight - _hei/2;      
      var _slot = __.slotArray[_i]
      
      // Slot box
      var _slotPad = -1
      var _x1 = _sx - _slotPad
      var _y1 = _sy - _slotPad
      var _x2 = _x1 + _slotWidth + _slotPad*2
      var _y2 = _y1 + _slotHeight + _slotPad*2
      draw_sprite_stretched(spr_lt_box, 0, _x1, _y1, _x2 - _x1, _y2 - _y1)
      
      // Mouse Over Slot
      if (_slot == -1) continue;
      var _mouseOver = point_in_rectangle(_mouseX, _mouseY, _x1, _y1, _x2, _y2)
      if (_mouseOver && __.isOpen && __.animTime == __.animDuration) {
        _overId = _slot.GetId()
        
        _slot.__.xScale = lerp(_slot.__.xScale, 1.25, 0.1)
        _slot.__.yScale = lerp(_slot.__.yScale, 1.25, 0.1)
        //_slot.__.angle = lerp(_slot.__.angle, 15, 0.1)
        draw_sprite_stretched(spr_w_box, 0, _x1, _y1, _x2 - _x1, _y2 - _y1)
      } else {
        _slot.__.xScale = lerp(_slot.__.xScale, 1, 0.1)
        _slot.__.yScale = lerp(_slot.__.yScale, 1, 0.1)
        _slot.__.angle = lerp(_slot.__.angle, 0, 0.1)
      }
      
      // Item
      var _itemScale = _slot.GetScale()
      var _itemAngle = _slot.GetAngle()
      draw_sprite_ext(ItemGetData(_slot.GetId()).__.sprite, 0, _sx + _slotWidth/2, _sy + _slotHeight/2, _itemScale.x, _itemScale.y, _itemAngle, -1, 1)
      scribble(_slot.GetData()).align(2, 2).transform(1.0, _itemScale.y).draw(_sx + _slotWidth - 1, _sy + _slotHeight + 2)
      
      // Durability
      
    }
    
    // Item Description
    if (_overId != -1) {
      var _descString = ItemGetData(_overId).__.name + "\n[c_ltgray]" + ItemGetData(_overId).__.description
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

