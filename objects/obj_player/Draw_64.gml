
var _guiWidth = display_get_gui_width()
var _guiHeight = display_get_gui_height()

inventory.Draw(_guiWidth * 0.5, _guiHeight * 0.5)

scribble($"Inventory System Demo\nCreated by Krug\n\n[[I] - Open/close inventory\n[[Enter] - Add items\n[[Left Click] - Use item").draw(8, 8)