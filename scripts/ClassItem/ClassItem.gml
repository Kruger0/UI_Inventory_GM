
function Item(_name, _desc, _sprite, _stackSize = 32, _config = {}) constructor {
	
  // Private
  var _self = self;
  __ = {};
  with (__) {
    name          = _name;
    description   = _desc;
    sprite        = _sprite;
    stackSize     = _stackSize;
    
    CustomGetName = method(_self, _config[$ "GetName"]  ?? function(){return __.name})
    CustomGetDesc = method(_self, _config[$ "GetDesc"]  ?? function(){return __.description})
    CustomOnUse   = method(_self, _config[$ "OnUse"]    ?? function(){show_debug_message($"Used item {__.name}!")})
    
    // Copy config values & custom methods
    var _names = struct_get_names(_config);
    for (var _i = 0; _i < array_length(_names); _i++) {
      var _key = _names[_i];
      var _value = _config[$ _key];
      if (is_method(_value)) {
        _self[$ _key] = method(_self, _value);
      } else {
        self[$ _key] = _value;
      }     
    }
  }
  
  // Public
  static GetName = function(_itemData = {}) {
    return StringReplaceKeys(__.CustomGetName(), _itemData)
  }
  static GetDesc = function(_itemData = {}) {
    return StringReplaceKeys(__.CustomGetDesc(), _itemData)
  }
  static GetSprite = function() {
    return __.sprite;
  }
  static GetStackSize = function() {
    return __.stackSize;
  }
  static GetData = function() {
    return __;
  }
    
  static OnUse = function(_slot) {
    __.CustomOnUse(_slot);
  }
}

