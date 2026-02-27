if !on_spike exit;

draw_sprite_ext(sprite_index, image_index, x + myshake.x - camera_get_view_x(VIEW), y + myshake.y - camera_get_view_y(VIEW), squash_x, squash_y, image_angle, image_blend, image_alpha);