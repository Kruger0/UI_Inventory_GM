
function Item(_name, _desc, _sprite, _stackSize = 32, _config = {}) constructor {
	
  // Private
  __name          = _name;
  __description   = _desc;
  __sprite        = _sprite;
  __stackSize     = _stackSize;
    
  __CustomGetName = method(self, _config[$ "GetName"]  ?? function(){return __name})
  __CustomGetDesc = method(self, _config[$ "GetDesc"]  ?? function(){return __description})
  __CustomOnUse   = method(self, _config[$ "OnUse"]    ?? function(){show_debug_message($"Used item {__name}!")})
    
  // Copy config values & custom methods
  var _names = struct_get_names(_config);
  for (var _i = 0; _i < array_length(_names); _i++) {
    var _key = _names[_i];
    var _value = _config[$ _key];
    if (is_method(_value)) {
      self[$ _key] = method(self, _value);
    } else {
      self[$ _key] = _value;
    }     
  }
  
  // Public
  static GetName = function(_itemData = {}) {
    return StringReplaceKeys(__CustomGetName(), _itemData)
  }
  static GetDesc = function(_itemData = {}) {
    return StringReplaceKeys(__CustomGetDesc(), _itemData)
  }
  static GetSprite = function() {
    return __sprite;
  }
  static GetStackSize = function() {
    return __stackSize;
  }
  static GetData = function() {
    return __;
  }
    
  static OnUse = function(_slot) {
    __CustomOnUse(_slot);
  }
}

