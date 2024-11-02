switch state{
	case 10:
	draw_sprite_ext(sprite_get("nightmare_transform"), timer, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
	break;
	
	case 11:
	draw_sprite_ext(sprite_get("night_core"), phase_t/6 + 2, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
	draw_sprite_ext(sprite_get("night_shell"), clamp((60-health)/20, 0, 2), x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
	draw_sprite_ext(sprite_get("spark_anim"), face_anim, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
	if hit_anim && (8 - hit_anim%8)>4 draw_sprite_ext(sprite_get("night_shell"), 3, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
	break;
	
	case 12:
	case 13:
	draw_sprite_ext(sprite_get("night_core"), phase_t/6 + 2, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
	draw_sprite_ext(sprite_get("core_aura"), phase_t/4, x, y, -2*image_dir, 2, 0, c_white, get_gameplay_time()%2);
	with hit_fx_obj if player = other.player && hit_fx == other.parts with other draw_sprite_ext(sprite_get("night_shell_piece"), other.indx, other.x, other.y, 2, 2, -other.step_timer*2*((other.indx%2)*2 - 1), c_white, get_gameplay_time()%2);
	break;
	
	case 14:
	with touch_opl{
		shader_end();
		gpu_set_fog(1, c_lime, 1, 0)
		draw_sprite_ext(sprite_index, image_index, x, y, (1 + small_sprites)*spr_dir, 1 + small_sprites, spr_angle, c_white, 1 - other.timer/40)
		gpu_set_fog(0, c_lime, 1, 0)
	}
	draw_sprite_ext(sprite_get("night_core"), phase_t/6 + 2, touch_opl.x, touch_opl.y - touch_opl.char_height/2 + round((timer/4)%2)*2, 2 - timer/20, 2 - timer/20, 0, c_white, timer < 40);
	if !(timer%2) && timer < 40 draw_sprite_ext(sprite_get("x_caught"), timer/2, touch_opl.x, touch_opl.y - touch_opl.char_height/2, 2, 2, 0, c_white, 1);
	break;
	
	default:
	if arm_anim+1 draw_sprite_ext(sprite_get("night_rarm"), arm_anim >> 3, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
	if state = 9{
		if timer < 16 draw_sprite_ext(sprite_get("rarm0"), 0, x, y, -1*image_dir, 1, 0, c_white, bod_alpha);
		if timer < 24 draw_sprite_ext(sprite_get("rarm1"), 0, x, y, -1*image_dir, 1, 0, c_white, bod_alpha);
		if timer < 32 draw_sprite_ext(sprite_get("rarm2"), 0, x, y, -1*image_dir, 1, 0, c_white, bod_alpha);
	}
	draw_sprite_ext(sprite_get("night_bod"), 0, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
	if goop_flag+1 draw_sprite_ext(sprite_get("night_gelface"), (goop_flag/8 < 14? goop_flag/8: 14 + (goop_flag/8)%13), x, y, -2*image_dir, 2, 0, c_white, cann_alpha);
	if gravity_anim+1 draw_sprite_ext(sprite_get("night_cannon"), gravity_anim, x, y, -2*image_dir, 2, 0, c_white, cann_alpha);
	if phase = 2 draw_sprite_ext(sprite_get("night_face"), face_anim, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
	if hit_anim && (8 - hit_anim%8)>4{
		shader_end();
		gpu_set_fog(1, c_white, 1, 0);
		if phase = 2{
			draw_sprite_ext(sprite_get("night_face_overlay"), face_anim, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
			if state == 8{
				draw_sprite_ext(sprite_get("night_rarm"), arm_anim >> 3, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
				draw_sprite_ext(sprite_get("night_larm"), arm_anim >> 3, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
			}
			if state >= 8 draw_sprite_ext(sprite_get("night_bod"), 0, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
		}
		else draw_sprite_ext(sprite_get("night_cannon"), gravity_anim, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
		gpu_set_fog(0, c_white, 1, 0);
	}
	if arm_anim+1 && !(hit_anim && (8 - hit_anim%8)>4 && state == 8) draw_sprite_ext(sprite_get("night_larm"), arm_anim >> 3, x, y, -2*image_dir, 2, 0, c_white, bod_alpha);
	break;
}