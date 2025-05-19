
game_wid = 320
game_hei = 180

cam = view_camera[0]

scl = {
  win : 4,
  gui : 2,
  cam : 1
}

surface_resize(application_surface, game_wid * scl.win, game_hei * scl.win)
display_set_gui_size(game_wid * scl.gui, game_hei * scl.gui)
window_set_size(game_wid * scl.win, game_hei * scl.win)
window_center()