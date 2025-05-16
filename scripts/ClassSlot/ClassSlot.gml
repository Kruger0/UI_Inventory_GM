
function Slot(_itemId, _itemData) constructor {
  __ = {}
  with (__) {
    itemId    = _itemId
    itemData  = _itemData  
    
    xScale    = 1.25;
    yScale    = 1.25;
    angle     = 15;   
  }
  
  static GetId = function() {
    return __.itemId;
  }
  static GetData = function() {
    return __.itemData
  }
  static SetScale = function(_x = 1.25, _y = _x) {
    __.xScale = _x
    __.yScale = _y
    return self;
  }
  static SetAngle = function(_angle = 15) {
    __.angle = _angle;
    return self;
  }
  static GetScale = function() {
    return {x:__.xScale, y:__.yScale};
  }
  static GetAngle = function() {
    return __.angle;
  }
}