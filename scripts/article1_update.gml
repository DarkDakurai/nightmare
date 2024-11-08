//Removes a harmless error from appearing in the debug log due to article inits running before init.
if "cur_song" not in obj_stage_main exit;

//Allows the article to follow the camera view.
y = view_get_yview()+79;

//Sets the article's animation frame to match the selected song.
image_index = obj_stage_main.cur_song
var tm = clamp((150 - abs(t - 150))/20, 0, 1);
image_alpha = tm;
x = view_get_xview()+16 - 200 + 200*tm;
t++

//This triggers after a short amount of time (about two seconds after the countdown) and destroys the article.
if (t >= 300) instance_destroy();