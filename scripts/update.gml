//Music randomizer
if (cur_song == -1) cur_song = random_func(current_second, 1, true)+1;

if get_gameplay_time() == 126 music_play_file("music_track0");

//If preferred, songs can now be selected from a set of four instead of randomized!
//This is done by reading the inputs from both the left and right sticks, along with their keyboard equivalents.
//Directions are listed starting clockwise from the top.
//Edit the value for "cur_song" under each input to change which song is set to that selection.
//Aether Mode music is also supported, if you don't have Aether exclusive songs the parts to remove are labeled.
if (get_gameplay_time() < 120){
  with (oPlayer) {
      //Option 1: Up
    if (shield_down && up_down || up_stick_down) {
      with (other) {
        cur_song = 1
      }
    }
    //Option 2: Right
    if (shield_down && right_down || right_stick_down) {
      with (other) {
        cur_song = 2
      }
    }
    //Option 3: Down
    if (shield_down && down_down || down_stick_down) {
      with (other) {
        cur_song = 3
      }
    }
    //Option 4: Left
    if (shield_down && left_down || left_stick_down) {
      with (other) {
        cur_song = 4
      }
    }
  }
}

var endg = 1;
with oPlayer{
    
    if !hitstop && floor(can_be_hit[5])%2 grabbed_invisible++;
    if player < 5 && !(is_player_on(player) && temp_level == 0){
    	x = - 20;
    	y = -999999;
    	waiting_to_spawn = 1;
    	grabbed_invisible = 1;
    	custom_clone = 1;
    	instance_destroy(self);
    	exit;
    }
    
    if ( "nightmare_colorOcache" not in self || (get_gameplay_time() % 180 == 0) ){ // recache on interval just in case they're doin funky stuff
        nightmare_colorOcache = array_clone(colorO);
        for (var j = 3; j < array_length(nightmare_colorOcache); j += 4)
        {
            nightmare_colorOcache[j] = 1;
        }
    }
    
    if other.spc set_player_damage(player, 30);
    
    if other.stocks[player-1] == 0 || other.energy[player-1] <= 0{
            x = - 20;
        	y = -999999;
        	set_state(PS_SPAWN);
        	grabbed_invisible = 1;
        	ignore_camera = 1;
    }
    
    if x < get_stage_data(SD_LEFT_BLASTZONE_X) || x > get_stage_data(SD_RIGHT_BLASTZONE_X) || y < get_stage_data(SD_TOP_BLASTZONE_Y) && hitstun > 0 || y > get_stage_data(SD_BOTTOM_BLASTZONE_Y){
        if other.spc other.energy[player - 1] = max(other.energy[player - 1] - 300, 0);
        else other.stocks[player-1]--;
        other.damage_taken += 150 + 150*other.spc;
    }
    endg -= other.stocks[player-1]>0;
}
if endg && !finish_game{
    finish_game = 499;
    nightmare.state = -2;
}

if finish_game{
    if time = 0{
        time = get_gameplay_time();
        m = string(floor(time/3600)%60)
        s = string(floor(time/60)%60)
        ms = string(time%100)
        score -= time*1.2;
        score += absorbed_parasites*1000;
        score -= damage_taken*(9 - 6*spc);
        score += 5000*damage_dealt/damage_score
        rank = rank[clamp(score/2500, 0, 7)];
    }
    finish_game++;
    win = 0;
    if nightmare.state >= 14{
        win = 1;
        if finish_game == 40 sound_play(sound_get("music_track6"));
        if finish_game <= 280 suppress_stage_music(0.0, 0.05);
        if finish_game == 280 music_play_file("music_track0");
        with oPlayer waiting_to_spawn = other.finish_game < 280
        if finish_game > 500 with oPlayer{
            x = - 20;
        	y = -999999;
        	set_state(PS_SPAWN);
        	grabbed_invisible = 1;
        	ignore_camera = 1;
        }
    }
    
    if (finish_game > 1600 && oPlayer.attack_pressed) || finish_game > 2000 + 216000*win end_match(1);
    switch finish_game{
        case 500:
        music_play_file(win? "mus_win": "mus_gameover");
        break;
    }
}