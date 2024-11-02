with enemy_hitboxID{
	has_hit = 1;
	with obj_stage_main{
		var g = spawn_hit_fx(other.x, other.y, ding_fx);
		sound_play(sound_get("sfx_ding"));
	}
	g.depth = -111;
	if type = 2 && walls = 0 destroyed = 1;
}