
function Slot(_itemId, _itemCount = 1, _itemData = undefined) constructor {
  
  // Private
  __ = {}
  with (__) {
    itemId    = _itemId;
    itemCount = _itemCount;
    itemData  = _itemData;  
    
    xScale    = 1.25;
    yScale    = 1.25;
    angle     = 15;   
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
    return self;
  }
  static GetData = function() {
    return __.itemData;
  }
  static SetData = function(_itemData) {
    __.itemData = _itemData;
    return self;
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