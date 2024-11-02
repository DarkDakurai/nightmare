if array_find_index(hit_hitbx, enemy_hitboxID)+1 exit;
var ding = 0;
if nightmare.phase = 3{
	if nightmare.hit_anim exit;
	var kb = get_kb_formula(40, 1, 1, enemy_hitboxID.damage, enemy_hitboxID.kb_value, enemy_hitboxID.kb_scale);
	var an = get_hitbox_angle(enemy_hitboxID);
	if kb > 8 && enemy_hitboxID.kb_value > 4{
		nightmare.hit_anim = 110;
		nightmare.vsp = -dsin(an)*kb*1.1
		nightmare.hsp = dcos(an)*kb*1.1
		nightmare.health -= enemy_hitboxID.damage;
		obj_stage_main.damage_dealt += enemy_hitboxID.damage;
		sound_play(sound_get("sfx_xhit"));
		if nightmare.health+1 sound_play(sound_get("sfx_xouch"));
	}else{
		with enemy_hitboxID{
			has_hit = 1;
			sound_play(sound_get("sfx_ding"));
			if type = 2 && walls = 0 destroyed = 1;
			ding = 1;
		}
		if !nightmare.spawn_x{
			nightmare.spawn_x = 40;
			sound_play(sound_get("sfx_xspawn"));
			var xp = instance_create(x, y, "obj_stage_article", 7);
			xp.vsp = -dsin(an)*kb*1.2
			xp.hsp = dcos(an)*kb*1.2
			if !random_func_2(34, 3, 1){
				an -= 20
				var xp = instance_create(x, y, "obj_stage_article", 7);
				xp.vsp = -dsin(an)*kb*1.2
				xp.hsp = dcos(an)*kb*1.2
			}
		}
	}
}else{
	if nightmare.hit_anim == 0 sound_play(sound_get("sfx_dmg" + string(get_gameplay_time()%2)))
	nightmare.hit_anim = 16;
	if nightmare.phase = 1 && nightmare.goop_flag = -1 nightmare.goop_flag = 0;
	nightmare.health -= enemy_hitboxID.damage;
	obj_stage_main.damage_dealt += enemy_hitboxID.damage;
}
array_push(hit_hitbx, enemy_hitboxID);
with enemy_hitboxID{
	has_hit = 1;
	if ding with obj_stage_main var g = spawn_hit_fx(other.x, other.y, ding_fx);
	else{
		sound_play(sound_effect);
		var g = spawn_hit_fx(x, y, hit_effect);
	}
	g.depth = -111;
	if type = 2 && walls = 0 destroyed = 1;
}