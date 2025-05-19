
x = lerp(x, obj_player.x - game_wid/2, 0.1)
y = lerp(y, obj_player.y - game_hei/2, 0.1)

x = clamp(x, 0, room_width - game_wid)
y = clamp(y, 0, room_height - game_hei)

camera_set_view_pos(cam, x, y)
camera_set_view_size(cam, game_wid, game_hei)