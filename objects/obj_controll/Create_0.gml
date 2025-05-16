
var _font_main = font_get_name(fnt_main)
scribble_font_bake_shadow(_font_main, "fnt_temp1", 0, 1, c_black, 1, -1, false)
scribble_font_bake_outline_8dir("fnt_temp1", "fnt_main", c_black, false)
scribble_font_set_default("fnt_main")
scribble_font_delete("fnt_temp1")

window_set_cursor(cr_none)

