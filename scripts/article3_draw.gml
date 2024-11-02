if nightmare.phase == 1{
	shader_end()
	var al = (nightmare.state < 5? nightmare.phase_t/60: 1 - nightmare.timer/60);
	gpu_set_blendmode(bm_add)
	draw_primitive_begin(pr_trianglestrip);
	draw_vertex_color(0, 0, c_red, 1*al)
	draw_vertex_color(room_width, 0, c_red, 1*al)
	draw_vertex_color(0, room_height*2/3, c_red, 0)
	draw_vertex_color(room_width, room_height*2/3, c_red, 0)
	draw_primitive_end();
	gpu_set_blendmode(bm_normal)
}

with nightmare if state = 9{
	if timer < 8 draw_sprite_ext(sprite_get("larm0"), 0, x, y, -1*image_dir, 1, 0, c_white, bod_alpha);
	if timer < 16 draw_sprite_ext(sprite_get("larm1"), 0, x, y, -1*image_dir, 1, 0, c_white, bod_alpha);
	if timer < 24 draw_sprite_ext(sprite_get("larm2"), 0, x, y, -1*image_dir, 1, 0, c_white, bod_alpha);
	if timer < 32 draw_sprite_ext(sprite_get("larm3"), 0, x, y, -1*image_dir, 1, 0, c_white, bod_alpha);
	if timer < 40 draw_sprite_ext(sprite_get("larm4"), 0, x, y, -1*image_dir, 1, 0, c_white, bod_alpha);
}