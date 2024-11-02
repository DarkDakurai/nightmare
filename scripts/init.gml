//The variable used to randomize the stage's music, set to -1 for the randomizer in update.gml to work.
cur_song = -1

realdir = 1;
image_xscale = 2;
image_yscale = 2;

stocks = [3, 3, 3, 3];
energy = [1299, 1299, 1299, 1299];
spc = is_aether_stage();

nightmare = instance_create(-1000, -1000, "obj_stage_article", 2);
instance_create(0, 0, "obj_stage_article", 5);
instance_create(0, 0, "obj_stage_article", 6);

music_play_file("pre_boss_ambience");

boom1 = hit_fx_create(sprite_get("vfx_boom1"), 48)
boom2 = hit_fx_create(sprite_get("vfx_boom2"), 24)
smoke = hit_fx_create(sprite_get("vfx_smoke"), 32)
ding_fx = hit_fx_create(sprite_get("vfx_ding"), 8)

finish_game = 0;

//hud stuff
hud_main = sprite_get("hud_main");
hud_offscreen = sprite_get("hud_offscreen");

hud_darker_color = [0, 0, 0, 0];
player_hud_colors = [$1e26f3, $f3673f, $3ee432, $3fe0f3];

music_play_file("music_track0");

win = 0;

damage_dealt = 0;
damage_score = 430;

damage_taken = 0;

time = 0;

absorbed_parasites = 0;

score = 12500;

m = ""
s = ""

rank = ["f", "e", "d", "c", "b", "a", "s", "ss"];

/*
F 0-2499

E 2500-4999

D 5000-7499

C 7500-9999

B 10000-12499

A 12500-14999

S 15000-17499

SS 17500-19999

*/