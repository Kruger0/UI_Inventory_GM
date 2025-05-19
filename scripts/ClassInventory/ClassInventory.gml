

function InventoryManager(_name, _slots, _columns) constructor {
  
  #region Private
  __name          = _name;
  __slots         = _slots
	__cols          = _columns;
                            
  __isOpen        = false;
    
  __animDuration  = 20;
  __animTime      = 0
  __animCurve     = ac_inventory
  __animHeight    = 550
    
  __slotArray     = array_create(_slots, -1);
  __slotSelected  = -1;
  __slotWidth     = 28;
  __slotHeight    = 28;
  __slotSprite    = undefined;
  __slotHPad      = 1;
  __slotVPad      = 1;
    
  __bgSprite      = spr_dt_box
  __bgHPad        = 6
  __bgVPad        = 6
    
  __descSprite    = spr_w_box
  __descHPad      = 6
  __descVPad      = 3
  __descDist      = 32
                  
  __cursorSlot    = -1;
     
  __color         = c_white;
  __alpha         = 1;
  __scale         = 2;
  __hPad          = 2;
  __vPad          = 2;
  #endregion
  
  // Public
  static SetStyle = function() {
    
    //for (var _i = 0; _i < __slots; _i++) {
    //  array_push(__slotArray, new Slot())
    //}
    
    return self;
  }

  static SetOpen = function(_open) {
    __isOpen = _open;
    return self;
  }
  static GetOpen = function() {
    return __isOpen;
  }
  
  ///@func AddItem(itemId, [itemCount], [itemData])
  static AddItem = function(_itemId, _itemCount = 1, _itemData = undefined) {
    if (_itemCount < 1) return false;
    
    // Se não tem NBT, procura o inventário por um stack dele
    if (is_undefined(_itemData)) {
      var _tempCount = _itemCount
      var _itemStack = ItemGetData(_itemId).GetStackSize()
      
      // Preenche todos os slots que encontrar
      for (var _i = 0; _i < __slots; _i++) {
        var _slot = __slotArray[_i]  
        if (_slot != -1 && _slot.GetId() == _itemId) {
          while (_tempCount > 0 && _slot.GetCount() < _itemStack) {
            _slot.SetCount(_slot.GetCount()+1);
            _slot.SetScale(1.5)
            _tempCount--;
          }
        }      
      }
      
      // Se não tinha slot suficiente
      while (_tempCount > 0) {
        for (var _i = 0; _i < __slots; _i++) {
          var _slot = __slotArray[_i]
          if (_slot == -1) {
            if (_tempCount <= _itemStack) {
              __slotArray[_i] = new Slot(_i, self, _itemId, _tempCount).SetScale(1.5)
              _tempCount = 0;
              break;              
            } else {
              __slotArray[_i] = new Slot(_i, self, _itemId, _itemStack).SetScale(1.5)
              _tempCount -= _itemStack;
            }
          }
        }
        
        if (_tempCount <= 0) break;
        
        // Se não coube item no inventário
        if (_tempCount) {
          show_debug_message($"Not enough space for {_itemId} - {_tempCount}")
          break;
        }
      }
      show_debug_message($"Added {_itemId} - {_tempCount} / {_itemCount}")
    } else {
      // Se tem NBT
      for (var _i = 0; _i < __slots; _i++) {
        var _slot = __slotArray[_i]
        if (_slot == -1) {
          __slotArray[_i] = new Slot(_i, self, _itemId, _itemCount, _itemData).SetScale(1.5)
          show_debug_message($"Added {_itemId} - {_itemData}")
          break;
        }
      }      
    }
  }
  static RemoveItem = function(_slotId) {
    // search for item stack in inventory and push into slot list
  }
  
  static Sort = function() {
    
  }
  
  
  static Draw = function(_x, _y) {
    
    // Open/Close Animation
    var _animName = ""
    if (__isOpen) {
      __animTime = min(++__animTime, __animDuration)
      _animName = "open"
    } else {
      __animTime = max(--__animTime, 0)
      _animName = "close"
    }
    var _pos = __animTime / __animDuration
    var _animValue = __animHeight - animcurve_channel_evaluate(animcurve_get_channel(ac_inventory, "open"), _pos) * __animHeight
     
    // Rendering matrix
    var _mat_old = matrix_get(matrix_world)
    matrix_set(matrix_world, matrix_build(_x, _y + _animValue, 0, 0, 0, 0, __scale, __scale, 1))
    
    // Background & name
    var _wid = __cols * __slotWidth
    var _hei = ceil(__slots / __cols) * __slotHeight
    var _nameHei = string_height_scribble(__name)
    draw_sprite_stretched(__bgSprite, 0, -_wid/2 - __bgHPad, -_hei/2 - __bgVPad - _nameHei, _wid + __bgHPad*2, _hei + __bgVPad*2 + _nameHei)
    scribble(__name).align(0, 0).draw(-_wid/2 + __slotHPad*2, -_hei/2 - _nameHei)
    
    // Input
    var _mouseX = (InputMouseGuiX() - _x) / __scale
    var _mouseY = (InputMouseGuiY() - _y - _animValue) / __scale
    var _select = InputPressed(INPUT_VERB.SELECT)    

    // Slots
    __slotSelected = -1;
    for (var _i = 0; _i < __slots; _i++) {
      var _sx = _i mod __cols * __slotWidth - _wid/2;
      var _sy = _i div __cols * __slotHeight - _hei/2;      
      var _slot = __slotArray[_i]      
      
      // Slot box      
      var _x1 = _sx + __slotHPad
      var _y1 = _sy + __slotVPad
      var _x2 = _x1 + __slotWidth - __slotHPad*2
      var _y2 = _y1 + __slotHeight - __slotVPad*2
      draw_sprite_stretched(spr_lt_box, 0, _x1, _y1, _x2 - _x1, _y2 - _y1)
      
      if (_slot == -1) {
        if (__cursorSlot == -1) continue;        
      }
      var _item = ItemGetData(_slot.GetId())
      
      // Mouse Over Slot      
      var _mouseOver = point_in_rectangle(_mouseX, _mouseY, _x1, _y1, _x2, _y2)
      if (_mouseOver && __isOpen && __animTime == __animDuration) {
        __slotSelected = _slot;
        
        _slot.__xScale = lerp(_slot.__xScale, 1.5, 0.1)
        _slot.__yScale = lerp(_slot.__yScale, 1.5, 0.1)
        draw_sprite_stretched(spr_w_box, 0, _x1, _y1, _x2 - _x1, _y2 - _y1)
        
        // Item Use
        if (_select) {
          _slot.SetScale(1)
          _item.OnUse(_slot)
        }
        
      } else {
        _slot.__xScale = lerp(_slot.__xScale, 1, 0.1)
        _slot.__yScale = lerp(_slot.__yScale, 1, 0.1)
      }
      
      // Item Sprite
      var _itemScale = _slot.GetScale()
      var _itemAngle = _slot.GetAngle()
      draw_sprite_ext(_item.GetSprite(), 0, _sx + __slotWidth/2, _sy + __slotHeight/2, _itemScale.x, _itemScale.y, _itemAngle, -1, 1)
      
      // Item Count
      if (_item.GetStackSize() > 1) {
        scribble(_slot.GetCount()).align(2, 2).transform(1.0).draw(_sx + __slotWidth - 1, _sy + __slotHeight + 2 - (1-_itemScale.y)*4) 
      }
      if (_slot == -1) continue;     
    }
    
    // Item Description
    if (__slotSelected != -1) {
      var _descData = ItemGetData(__slotSelected.GetId())
      var _descString = _descData.GetName() + "\n[#C0C0C0]" + _descData.GetDesc(__slotSelected.GetData())

      var _descWidth = string_width_scribble(_descString) + __descHPad*2
      var _descHeight = string_height_scribble(_descString) + __descVPad*2
      var _descX = _mouseX + __descDist/__scale - __descHPad
      var _descY = _mouseY + __descDist/__scale - __descVPad
      draw_sprite_stretched(__descSprite, 0, _descX, _descY, _descWidth, _descHeight)
      scribble(_descString).draw(_mouseX + __descDist/__scale, _mouseY + __descDist/__scale)
    }
    
    matrix_set(matrix_world, _mat_old)
  }  
}

