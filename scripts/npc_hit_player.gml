damage_taken += my_hitboxID.damage;
if spc{
	energy[hit_player_obj.player - 1] = max(energy[hit_player_obj.player - 1] - my_hitboxID.damage, 0);
	if energy[hit_player_obj.player - 1] <= 0 sound_play(asset_get("sfx_death" + string(random_func(5, 2, true) + 1)));
}