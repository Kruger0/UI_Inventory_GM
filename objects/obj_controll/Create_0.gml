
// Scribble Setup
var _font_main = font_get_name(fnt_inventory)
scribble_font_bake_shadow(_font_main, "fnt_temp1", 0, 1, c_black, 1, -1, false)
scribble_font_bake_outline_8dir("fnt_temp1", "fnt_main", c_black, false)
scribble_font_set_default("fnt_main")
scribble_font_delete("fnt_temp1")

scribble_anim_wave(0.7, 0.5, 0.3)
scribble_anim_rainbow(0.8, 0.01)

window_set_cursor(cr_none)

show_debug_overlay(true, true)
