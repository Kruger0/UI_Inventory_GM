
var _guiWidth = display_get_gui_width()
var _guiHeight = display_get_gui_height()

inventory.Draw(_guiWidth * 0.5, _guiHeight * 0.5)

draw_line(0, _guiHeight * 0.5, _guiWidth, _guiHeight * 0.5)
draw_line(_guiWidth * 0.5, 0, _guiWidth * 0.5, _guiHeight)