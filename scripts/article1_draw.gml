//Song Name
draw_set_alpha(image_alpha);
draw_debug_text(floor(x+60), floor(y), "Track " + string(obj_stage_main.cur_song) + " - " + string(song_name_array[obj_stage_main.cur_song]));

//Artist
draw_debug_text(floor(x+60), floor(y+20), string(song_artist_array[obj_stage_main.cur_song]));

//Album
draw_debug_text(floor(x+60), floor(y+40), string(song_album_array[obj_stage_main.cur_song]));
draw_set_alpha(1);