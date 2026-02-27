

draw_sprite_ext(sprite_index, image_index, x + myshake.x - camera_get_view_x(VIEW), y + myshake.y - camera_get_view_y(VIEW), image_xscale, image_yscale, image_angle, image_blend, image_alpha)

myshake.step();