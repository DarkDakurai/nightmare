if nightmare.phase == 1{
	draw_sprite_ext(sprite_get("groundoutline"), 0, room_width/2, room_height/2 + 32 , 2, 2, 0, c_white, 1);
	var al = clamp(nightmare.state < 5? nightmare.phase_t/60: 1 - nightmare.timer/60, 0, 1);
	var a = 1;
	while a < 22{
		draw_sprite_ext(sprite_get("ground" + string(a)), 0, room_width/2 + al*6*dsin(get_gameplay_time() + a*18), room_height/2 + 32 , 2, 2, 0, c_white, 1);
		a++;
	}
}else draw_sprite_ext(sprite_get("ground"), 0, room_width/2, room_height/2 + 32 , 2, 2, 0, c_white, 1);