if !absorbed{
	image_index =  t*.2;
	if !(t % 50) || point_distance(x, y, room_width/2, room_height/2) > max(room_width, room_height)*2/3 randdir = random_func_2(abs(floor((x + y)%200)), 360, 1);
    hsp += dcos(floor(randdir))*.5;
    vsp += dsin(floor(randdir))*.5;
    var dir = point_direction(0, 0, hsp, vsp);
    var am = clamp(point_distance(0, 0, hsp, vsp), 0, 7)
    hsp = lengthdir_x(am, dir);
    vsp = lengthdir_y(am, dir);
	t++;
	
	if t >= 30 pl_touch = instance_place(x, y, oPlayer);
	
	if point_distance(x, y, room_width/2, room_height/2) >= max(room_width, room_height)*2/3 p++;
	else p = 0;
	
	if p >= 80{
		instance_destroy(self);
		exit;
	}
	
	if obj_stage_main.finish_game{
		image_alpha = 1 - obj_stage_main.finish_game/20;
		if image_alpha <= 0{
			instance_destroy(self);
			exit;
		}
	}else if pl_touch != noone{
		obj_stage_main.absorbed_parasites++;
		sound_play(sound_get("sfx_xgrab"));
		absorbed = 1;
		t = 0;
		sprite_index = sprite_get("x_caught" + string(type));
		if !type{
			if obj_stage_main.spc obj_stage_main.energy[@pl_touch.player-1] = min(obj_stage_main.energy[@pl_touch.player-1] + 10, 1299);
			else set_player_damage(pl_touch.player, max(0, get_player_damage(pl_touch.player) - 4));
		}
	}
}else{
	t++;
	x = pl_touch.x + pl_touch.hsp;
	y = pl_touch.y + pl_touch.vsp - pl_touch.char_height/2;
	image_index = t/2;
	image_alpha = t%2;
	depth = pl_touch.depth-2;
	if t >= 36{
		instance_destroy(self);
		exit;
	}
}