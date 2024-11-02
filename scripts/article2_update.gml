arm_anim++;
body_collision_hutbox = noone;
if hit_anim hit_anim--;
if fire_cd fire_cd--;
if spawn_x spawn_x--;



timer++
phase_t++;
firing_timer++;
var enable_firing = 0
target = instance_nearest(x, y, oPlayer);
switch phase{
	case -1: //spawn phase
	mask_index = asset_get("empty_sprite");
	hurt_mask = asset_get("empty_sprite");
	break;
	
	case 0: //initial 40hp
	mask_index = sprite_get("night_col_body_1");
	hurt_mask = sprite_get("night_col_hurt_body_1");
	body_collision_hutbox = create_hitbox(3, 1, floor(x), floor(y));
	gravity_anim = abs(floor(phase_t/8)%8 - 4)*3;
	if !(phase_t%60) sound_play(sound_get("sfx_nfloat"))
	break;
	
	case 1: //gravity engine 160hp
	if phase_t = 18 sound_play(sound_get("sfx_grav"), 1);
	mask_index = sprite_get("night_col_body_1");
	hurt_mask = sprite_get("night_col_hurt_body_1");
	body_collision_hutbox = create_hitbox(3, 1, floor(x), floor(y));
	gravity_anim = abs(floor(phase_t/8)%8 - 4)*3 + ((phase_t*clamp(phase_t/30, 0, 1))%3);
	if health+1{
		with oPlayer vsp += .5;
		with pHitBox if player != 5 vsp += 1.5;
	}
	if !(phase_t%60) sound_play(sound_get("sfx_nfloat"))
	break;
	
	case 2: //goop face 210hp
	mask_index = sprite_get("night_col_body_2");
	hurt_mask = sprite_get("night_col_hurt_body_2");
	if state < 9 body_collision_hutbox = create_hitbox(3, 2, floor(x), floor(y));
	if !(phase_t%60) sound_play(sound_get("sfx_nfloat"))
	break;
	
	case 3: //core x 60hp
	mask_index = asset_get("empty_sprite");
	hurt_mask = sprite_get("night_col_hurt_body_3");
	if state < 12 body_collision_hutbox = create_hitbox(3, 3, floor(x), floor(y));
	break;
}

switch state{
	
	///phase -1
	case -1: //wait
	if timer >= 460{
		state_set(0);
		y = room_height + 100;
	}
	bod_alpha = 0;
	cann_alpha = 0;
	break;
	
	case 0: //spawn
	x = room_width/2;
	vsp = -.25 - (timer%90)/90;
	bod_alpha = timer%2;
	cann_alpha = timer%2;
	shake_camera(4, 4)
	if !(timer%80) sound_play(sound_get("sfx_intro"));
	if y < 330{
		bod_alpha = 1;
		cann_alpha = 1;
		vsp = -3;
		state_set(1);
		phase = 0;
		phase_t = 0;
		sideswitcht_timer = 600 + random_func_2(floor(y%200), 300, 1);
		music_play_file("music_track" + string(obj_stage_main.cur_song));
		instance_create(0, 0, "obj_stage_article", 1)
	}
	break;
	
	///phase 0
	case 1:
	enable_firing = 1;
	if sign(ceil(room_width/2 - x)*2 - 1) != image_dir image_dir = -image_dir;
	if sideswitcht_timer sideswitcht_timer--;
	else{
		side = -side;
		sideswitcht_timer = 600 + random_func_2(abs(floor(y%200)), 300, 1);
	}
	var sidepos = room_width/2 + 400*side;
	hsp = lerp(hsp, clamp(sidepos - x, -10, 10), .01);
	if abs(target.y - y - 180) > 100 vsp = lerp(vsp, clamp(target.y - y - 180, -10, 10), .01);
	
	if health < 0{
		hsp = 0;
		vsp = -3;
		health = 120;
		state_set(2)
		phase = 1;
		phase_t = 0;
		sound_play(sound_get("sfx_grav_start"));
	}
	break;
	
	///phase 1
	
	case 2:
	enable_firing = 2
	if sign(ceil(room_width/2 - x)*2 - 1) != image_dir image_dir = -image_dir;
	if goop_flag+1 goop_flag += (goop_flag < 112 || health < 120);
	var sidepos = room_width/2 - 400*image_dir;
	if abs(x - sidepos) > 20 hsp = lerp(hsp, clamp(sidepos - x, -10, 10), .01);
	if abs(room_height/2 - 40 - y) > 10 vsp = lerp(vsp, clamp(room_height/2 - 40 - y, -10, 10), .01);
	if point_distance(x, y, sidepos, room_height/2 - 40) < 20{
		vsp = -2;
		hsp = lerp(hsp, image_dir, .2);
		sideswitcht_timer = image_dir;
		state_set(3)
	}
	if health < 0 state_set(4)
	break;
	
	case 3:
	enable_firing = 2
	hsp = lerp(hsp, image_dir, .2);
	if sign(ceil(room_width/2 + 150*image_dir - x)*2 - 1) != image_dir image_dir = -image_dir;
	if goop_flag+1 goop_flag += (goop_flag < 112 || health < 120);
	if abs(room_height/2 - 40 - y) > 30 vsp = lerp(vsp, clamp(room_height/2 - 40 - y, -7, 7), .01);
	if image_dir != sideswitcht_timer{
		hsp = -image_dir;
		vsp = -3;
		state_set(2)
	}
	if health < 0 state_set(4)
	break;
	
	case 4:
	sound_stop(sound_get("sfx_grav"));
	enable_firing = 1
	if hit_anim = 0 hit_anim = 16; 
	hurt_mask = asset_get("empty_sprite");
	var sidepos = room_width/2 - 400*image_dir;
	if goop_flag+1 goop_flag += (goop_flag < 112 || health < 120);
	if abs(sidepos - x) > 10 hsp = lerp(hsp, clamp(sidepos - x, -3, 3), .01);
	if abs(room_height/2 - 40 - y) > 10 vsp = lerp(vsp, clamp(room_height/2 - 40 - y, -3, 3), .01);
	if distance_to_point(sidepos, room_height/2) < 5{
		sound_play(sound_get("sfx_dmg0"))
		state_set(5)
		instance_create(floor(x) - 28*image_dir, floor(y) + 90, "obj_stage_article", 4)
	}
	break;
	
	case 5:
	enable_firing = 1
	hurt_mask = asset_get("empty_sprite");
	hsp = lerp(hsp, 0, .05);
	vsp = lerp(vsp, 0, .05);
	cann_alpha = timer%2;
	if goop_flag+1 goop_flag += (goop_flag < 112 || health < 120);
	if timer > 60 gravity_anim = -1;
	if timer = 110 instance_create(floor(x) + 64*image_dir, floor(y) - 10, "obj_stage_article", 4)
	if timer = 120{
		sound_play(sound_get("sfx_dmg1"))
		vsp = -3
		cann_alpha = 0;
		state_set(6);
		phase = 2;
		phase_t = 0
		health = 210
	}
	break;
	
	//phase 2
	
	case 6:
	enable_firing = 0
	face_anim = (phase_t/14)%4 + face_frames[(phase_t/2)%lenfrms]*4 + 12*floor(2 - health/71)
	if sign(ceil(room_width/2 - x)*2 - 1) != image_dir image_dir = -image_dir;
	if goop_flag+1 goop_flag += (goop_flag < 112 || health < 120);
	var sidepos = room_width/2 - 400*image_dir;
	if abs(target.x - x) > 20 hsp = lerp(hsp, clamp(target.x - x, -15, 15), .01);
	if abs(target.y - y) > 20 vsp = lerp(vsp, clamp(target.y - y, -15, 15), .01);
	if abs(x - sidepos) < 30 && timer > 300{
		vsp = 0;
		hsp = lerp(hsp, image_dir, .2);
		sideswitcht_timer = image_dir;
		state_set(7)
	}
	if health < 0 state_set(8)
	break;
	
	case 7:
	enable_firing = 1
	face_anim = (phase_t/14)%4 + face_frames[(phase_t/2)%lenfrms]*4 + 12*ceil(2 - health/71)
	if sign(ceil(room_width/2 + 150*image_dir - x)*2 - 1) != image_dir image_dir = -image_dir;
	if goop_flag+1 goop_flag += (goop_flag < 112 || health < 120);
	hsp = lerp(hsp, image_dir*2, .2);
	if abs(target.y - y - 80) > 20 vsp = lerp(vsp, clamp(target.y - y - 80, -6, 6), .02);
	if image_dir != sideswitcht_timer{
		hsp = -image_dir;
		vsp = -3;
		state_set(6)
	}
	if health < 0 state_set(8)
	break;
	
	case 8:
	face_anim = (phase_t/14)%4 + face_frames[(phase_t/2)%lenfrms]*4 + 24
	if hit_anim = 0 hit_anim = 16; 
	hurt_mask = asset_get("empty_sprite");
	var sidepos = room_width/2 - 400*image_dir;
	arm_anim %= 80;
	arm_anim -= clamp(arm_anim, 0, 3);
	if abs(sidepos - x) > 10 hsp = lerp(hsp, clamp(sidepos - x, -3, 3), .01);
	if abs(room_height/2 - 40 - y) > 10 vsp = lerp(vsp, clamp(room_height/2 - 40 - y, -3, 3), .01);
	if distance_to_point(sidepos, room_height/2) < 5{
		state_set(9)
		sound_stop(sound_get("sfx_armbreak"));
	}
	break;
	
	case 9:
	face_anim = (phase_t/14)%4 + face_frames[(phase_t/2)%lenfrms]*4 + 24
	if hit_anim = 0 hit_anim = 16;
	hurt_mask = asset_get("empty_sprite"); 
	hsp = lerp(hsp, 0, .05);
	vsp = lerp(vsp, 0, .05);
	arm_anim = -1;
	switch timer{ //75, 85
		case 8:
		var e = spawn_hit_fx(x, y, part0);
		e.depth = depth-1;
		e.hsp = -2*image_dir;
		e.spr_dir = -image_dir;
		e.grav = .3;
		var e = spawn_hit_fx(x - 42*image_dir, y + 138, obj_stage_main.boom1);
		e.depth = depth-6;
		break;
		case 16:
		var e = spawn_hit_fx(x, y, part1);
		e.depth = depth-2;
		e.hsp = -2*image_dir;
		e.spr_dir = -image_dir;
		e.grav = .3;
		var e = spawn_hit_fx(x, y, part2);
		e.depth = depth+3;
		e.spr_dir = -image_dir;
		e.hsp = 2*image_dir;
		e.grav = .3;
		var e = spawn_hit_fx(x - 66*image_dir, y + 104, obj_stage_main.boom1);
		e.depth = depth-6;
		var e = spawn_hit_fx(x + 82*image_dir, y + 112, obj_stage_main.boom1);
		e.depth = depth-1;
		break
		case 24:
		var e = spawn_hit_fx(x, y, part3);
		e.depth = depth-3;
		e.hsp = -2*image_dir;
		e.spr_dir = -image_dir;
		e.grav = .3;
		var e = spawn_hit_fx(x, y, part4);
		e.depth = depth+2;
		e.hsp = 2*image_dir;
		e.spr_dir = -image_dir;
		e.grav = .3;
		var e = spawn_hit_fx(x - 62*image_dir, y + 64, obj_stage_main.boom1);
		e.depth = depth-6;
		var e = spawn_hit_fx(x + 86*image_dir, y + 88, obj_stage_main.boom1);
		e.depth = depth-1;
		break
		
		case 28:
		instance_create(floor(x) + 92*image_dir, floor(y) + 40, "obj_stage_article", 4);
		break;
		
		case 32:
		var e = spawn_hit_fx(x, y, part5);
		e.depth = depth-4;
		e.hsp = -2*image_dir;
		e.spr_dir = -image_dir;
		e.grav = .3;
		var e = spawn_hit_fx(x, y, part6);
		e.depth = depth+1;
		e.hsp = 2*image_dir;
		e.spr_dir = -image_dir;
		e.grav = .3;
		var e = spawn_hit_fx(x - 30*image_dir, y + 34, obj_stage_main.boom1);
		e.depth = depth-6;
		break
		
		case 36:
		instance_create(floor(x) - 32*image_dir, floor(y) - 28, "obj_stage_article", 4);
		break;
		
		case 40:
		var e = spawn_hit_fx(x, y, part7);
		e.depth = depth-5;
		e.hsp = -2*image_dir;
		e.spr_dir = -image_dir;
		e.grav = .3;
		break
	}
	if timer = 160{
		vsp = 0
		hsp = 0
		state_set(10);
	}
	break;
	
	case 10:
	face_anim = (phase_t/14)%4 + face_frames[(phase_t/2)%lenfrms]*4 + 24
	hurt_mask = asset_get("empty_sprite");
	hsp = lerp(hsp, 0, .05);
	vsp = lerp(vsp, 0, .05);
	arm_anim = -1;
	if timer = 38 image_dir = -1;
	if timer = 81{
		vsp = 0
		hsp = 0
		phase = 3;
		phase_t = 0
		health = 60;
		state_set(11);
		instance_create(x-50, y-16, "obj_stage_article", 7);
		instance_create(x+50, y-16, "obj_stage_article", 7);
		instance_create(x-50, y+16, "obj_stage_article", 7);
		instance_create(x+50, y+16, "obj_stage_article", 7);
		instance_create(x, y+50, "obj_stage_article", 7);
		instance_create(x, y-50, "obj_stage_article", 7);
	}
	break;
	
	//phase 3
	
	case 11: //roam around
	if !(timer%50) sound_play(sound_get("sfx_float"));
	if abs(target.x - x) > 10 hsp = lerp(hsp, clamp(target.x - x, -15, 15), .015);
	if abs(target.y - y - target.char_height/2) > 10 vsp = lerp(vsp, clamp(target.y - y - target.char_height/2, -15, 15), .015);
	face_anim = spark_anim[(timer/2)%lenspk]
	blue_spark_anim--
	if !blue_spark_anim{
		var e = spawn_hit_fx(x, y, sparks[random_func_2(14, 3, 1)]);
		e.depth = depth-2;
		e.follow_id = self;
		e.follow_time = 14;
		blue_spark_anim = 2 + random_func_2(20, 18, 1);
	}
	if health < 0{
		state_set(12)
		hsp = 0;
		vsp = 0;
		var e = spawn_hit_fx(x - 24, y - 24, parts);
		if "indx" not in e with e indx = 0
		e.grav = .3;
		e.hsp = -3
		var e = spawn_hit_fx(x + 24, y - 24, parts);
		if "indx" not in e with e indx = 1
		e.grav = .3;
		e.hsp = +3
		var e = spawn_hit_fx(x - 24, y + 24, parts);
		if "indx" not in e with e indx = 2
		e.grav = .3;
		e.hsp = -2
		var e = spawn_hit_fx(x + 24, y + 24, parts);
		if "indx" not in e with e indx = 3
		e.grav = .3;
		e.hsp = +2
		music_play_file("music_track0");
	}
	break;
	
	case 12: //reach center
	if !(phase_t%40) sound_play(sound_get("sfx_grabbable"));
	hurt_mask = asset_get("empty_sprite");
	if abs(room_width/2 - x) > 10 hsp = lerp(hsp, clamp(room_width/2 - x, -3, 3), .01);
	if abs(room_height/2 - y) > 10 vsp = lerp(vsp, clamp(room_height/2 - y, -3, 3), .01);
	bod_alpha = timer%4 > 2;
	if point_distance(x, y, room_width/2, room_height/2) < 20 state_set(13);
	break;
	
	case 13: //grabbable
	if !(phase_t%40) sound_play(sound_get("sfx_grabbable"));
	bod_alpha = 1
	hurt_mask = asset_get("empty_sprite");
	if abs(room_width/2 - x) > 10 hsp = lerp(hsp, clamp(room_width/2 - x, -3, 3), .01);
	if abs(room_height/2 - y) > 10 vsp = lerp(vsp, clamp(room_height/2 - y, -3, 3), .01);
	touch_opl = collision_circle(x, y, 30, oPlayer, 1, 1);
	if touch_opl != noone{
		obj_stage_main.score += 5000;
		obj_stage_main.absorbed_parasites++;
		state_set(14);
		sound_play(sound_get("sfx_xgrab"));
	}
	break;
	
	case 14:
	phase_t--;
	depth = touch_opl.depth -4;
	obj_stage_main.finish_game = 1;
	if timer >= 80{
		state_set(15);
		phase = 4;
		phase_t = 0;
		visible = 0;
	}
	break;
	
	case -2:
	phase = -1;
	visible = 0;
	hsp = 0;
	vsp = 0;
	break;
	
}

if enable_firing && !fire_cd{
	if firing_timer = 1 firing_type = enable_firing;
	if firing_timer >= 74 fire_cd = 80;
	if firing_timer%4 == 1 && firing_timer <= 21{
		var idx = (firing_timer-1)/4;
		if (idx%3 && firing_type != 2) || idx%3 == 0 fires[@idx] = spawn_hit_fx(x, y, fire_fx);
	}
}else firing_timer = 0;

image_xscale = -2*image_dir;
hurtbox_obj.x = x + hsp;
hurtbox_obj.y = y + vsp;
hurtbox_obj.image_xscale = image_xscale;
hurtbox_obj.mask_index = hurt_mask;
hurtbox_obj.can_be_hit[5] = 5;
can_be_hit[5] = 5;
if body_collision_hutbox != noone{
	body_collision_hutbox.sprite_dir = -image_dir;
	body_collision_hutbox.x = x + hsp;
	body_collision_hutbox.y = y + vsp;
}
with hit_fx_obj if player = other.player && hit_fx = other.fire_fx{
	var idx = array_find_index(other.fires, self);
	var arm = (other.arm_anim >> 3)%10
	if arm = -1 arm = 0;
	spr_dir = -other.image_dir;
	x = other.x + other.fire_pos[arm][idx][0]*other.image_dir + other.hsp;
	y = other.y + other.fire_pos[arm][idx][1] + other.vsp;
	depth = other.depth - 4;
	if step_timer == 40 with other{
		var e = create_hitbox(3, 4, floor(other.x) + 10*image_dir, floor(other.y));
		sound_play(sound_get("sfx_fire"));
		e.spr_dir = image_dir;
		e.hsp = image_dir*abs(e.hsp);
	}
}


#define state_set(st)
state = st;
timer = 0;
