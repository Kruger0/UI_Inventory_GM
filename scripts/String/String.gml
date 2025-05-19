

function StringReplaceKeys(_string, _struct) {
  var _result = _string;
  var _keys = variable_struct_get_names(_struct ?? {});
  var _keyCount = array_length(_keys);
    
  for (var i = 0; i < _keyCount; i++) {
      var _key = _keys[i];
      var _tag = "{" + _key + "}";
      var _value = string(_struct[$ _key] ?? "key_not_found");
      _result = string_replace_all(_result, _tag, _value);
  }
  return _result;
}