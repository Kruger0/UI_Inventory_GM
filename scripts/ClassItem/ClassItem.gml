
function Item(_name, _desc, _sprite, _stackSize = 32, _config = {}) constructor {
	
  // Private
  var _self = self;
  __ = {};
  with (__) {
    name        = _name;
    description = _desc;
    sprite      = _sprite;
    stackSize   = _stackSize;
    
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
  static GetName = function() {
    return __.name;
  }
  static GetDesc = function(_itemData) {
    // procura na description pelas keys
    
    var _result = __.description
    var _keys = variable_struct_get_names(_itemData ?? {});
    var _key_count = array_length(_keys)
    
    for (var i = 0; i < _key_count; i++) {
        var _key = _keys[i];
        var _tag = "{" + _key + "}";
        var _value = string(_itemData[$ _key] ?? "key_not_found");
        _result = string_replace_all(_result, _tag, _value);
    }
    
    return _result;
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
}

//bread = new Item("Bread", "food", spr_attack, 10, RARITY.COMMON, {
//  consume : true,
//  rarity : "Common",
//  saturation : 5,
//  OnUse : function() {
//    show_message(GetName())
//  }
//})

//bread.OnUse()
//game_end()