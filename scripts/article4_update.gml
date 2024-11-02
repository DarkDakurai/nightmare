if t%8 == 0{
	if t >= 24{
		spawn_area_effect(floor(x), floor(y) - 20, 100, 50, 1);
		spawn_area_effect(floor(x), floor(y) - 40, 100, 50, 2, 1, 4);
	}else spawn_area_effect(floor(x), floor(y), 100, 50, 0);
}
if t >= 76{
	instance_destroy(self);
	exit;
}
t++;


#define spawn_area_effect
/// spawn_area_effect(dx, dy, area_width, area_height, effect_id, angle = 1, seed = 0, follow_player = 0;)
var dx = argument[0], dy = argument[1], area_width = argument[2], area_height = argument[3], effect_id = argument[4];
var angle = argument_count > 5 ? argument[5] : 1;
var seed = argument_count > 6 ? argument[6] : 0;
var follow_player = argument_count > 7 ? argument[7] : 0;;

var fx_list = [obj_stage_main.boom1, obj_stage_main.boom2, obj_stage_main.smoke]
dx += random_func(1 + seed, area_width, true) - area_width/2;
dy += random_func(2 + seed, area_height, true) - area_height/2;

var da = angle;

var h = spawn_hit_fx(dx, dy, fx_list[effect_id]);

h.draw_angle = da;
h.depth = nightmare.depth-6;
if follow_player with h if "fx_follow_player" not in self fx_follow_player = other;