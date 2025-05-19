
function Slot(_slotId, _slotParent, _itemId, _itemCount = 1, _itemData = undefined) constructor {
  
  // Private
  __ = {}
  with (__) {
    slotId    = _slotId
    slotParent= _slotParent
    itemId    = _itemId;
    itemCount = _itemCount;
    itemData  = _itemData;  
    
    xScale    = 1.0;
    yScale    = 1.0;
    angle     = 0;   
  }
  
  // Public
  static GetId = function() {
    return __.itemId;
  }
  static SetId = function(_itemId) {
    __.itemId = _itemId;
    return self;
  }
  static GetCount = function() {
    return __.itemCount;
  }
  static SetCount = function(_itemCount) {
    __.itemCount = _itemCount;
    if (__.itemCount <= 0) {
      Destroy()
    }
    return self;
  }
  static GetData = function() {
    return __.itemData;
  }
  static SetData = function(_itemData) {
    __.itemData = _itemData;
    return self;
  }
  
  static Destroy = function() {
    __.slotParent.__.slotArray[__.slotId] = -1
  }
  
  static GetScale = function() {
    return {x:__.xScale, y:__.yScale};
  }
  static SetScale = function(_x, _y = _x) {
    __.xScale = _x;
    __.yScale = _y;
    return self;
  }
  static GetAngle = function() {
    return __.angle;
  }
  static SetAngle = function(_angle) {
    __.angle = _angle;
    return self;
  } 
}

