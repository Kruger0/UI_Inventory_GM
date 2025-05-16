
function Item(_name, _desc, _sprite, _stackSize, _rarity, _config = {}) constructor {
	// Private
  var _self = self;
  __ = {};
  with (__) {
    name        = _name;
    description = _desc;
    sprite      = _sprite;
    stackSize   = _stackSize;
    rarity      = _rarity;
    
    //consumable  = _config[$ "consumable"] ?? false;
    //durability  = _config[$ "durability"] ?? infinity;
    var _names = struct_get_names(_config)
    for (var _i = 0; _i < array_length(_names); _i++) {
      var _key = _names[_i]
      var _value = _config[$ _key]
      if (is_method(_value)) {
        _self[$ _key] = method(_self, _value)
      } else {
        self[$ _key] = _value 
      }     
    }
  }
  
  static GetName = function() {
    return __.name;
  }
}

bread = new Item("Bread", "food", spr_attack, 10, RARITY.COMMON, {
  consume : true,
  rarity : "Common",
  saturation : 5,
  OnUse : function() {
    show_message(GetName())
  }
})

bread.OnUse()
game_end()