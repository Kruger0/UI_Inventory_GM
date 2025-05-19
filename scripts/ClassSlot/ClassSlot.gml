
function Slot(_slotId, _slotParent, _itemId, _itemCount = 1, _itemData = undefined) constructor {
  
  #region Private
  __slotId    = _slotId
  __slotParent= _slotParent
  __itemId    = _itemId;
  __itemCount = _itemCount;
  __itemData  = _itemData;  

  __xScale    = 1.0;
  __yScale    = 1.0;
  __angle     = 0;   
  #endregion
  
  // Public
  static GetId = function() {
    return __itemId;
  }
  static SetId = function(_itemId) {
    __itemId = _itemId;
    return self;
  }
  static GetCount = function() {
    return __itemCount;
  }
  static SetCount = function(_itemCount) {
    __itemCount = _itemCount;
    if (__itemCount <= 0) {
      Destroy()
    }
    return self;
  }
  static GetData = function() {
    return __itemData;
  }
  static SetData = function(_itemData) {
    __itemData = _itemData;
    return self;
  }
  
  static Destroy = function() {
    __slotParent.__slotArray[__slotId] = -1
  }
  
  static GetScale = function() {
    return {x:__xScale, y:__yScale};
  }
  static SetScale = function(_x, _y = _x) {
    __xScale = _x;
    __yScale = _y;
    return self;
  }
  static GetAngle = function() {
    return __angle;
  }
  static SetAngle = function(_angle) {
    __angle = _angle;
    return self;
  } 
}

