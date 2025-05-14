
function UiPanel(_config = {}) constructor {
  
  // Private
  __ = {};
  with(__) {
    content = _config[$ "content"]  ?? "";
    style   = _config[$ "style"]    ?? {};
  }
  
  // Public
  static Render = function(_x, _y) {
  
  }
}