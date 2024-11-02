arm_anim = 0;
gravity_anim = 0;
image_dir = -1;
bod_alpha = 1;
cann_alpha = 1

state = -1;
timer = 0;
phase_t = 0;
phase = -1;
health = 40;
hit_anim = 0;

coeff = .1
goop_flag = -1;

sideswitcht_timer = 0;
side = 1;
face_frames = [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1] //2f
lenfrms = array_length(face_frames);
face_anim = 0;

touch_opl = noone;

spark_anim = [1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 4, 5, 6, 0, 0, 0, 0, 0, 0];
lenspk = array_length(spark_anim);
blue_spark_anim = 0;
sparks = [hit_fx_create(sprite_get("blue_spark0"), 6), hit_fx_create(sprite_get("blue_spark1"), 6), hit_fx_create(sprite_get("blue_spark2"), 6)];
parts = hit_fx_create(asset_get("empty_sprite"), 60);

is_hittable = 1;
hittable_hitpause_mult = 0;

ignores_walls = 1;
can_be_grounded = 0;

hurtbox_obj = instance_create(x, y, "obj_stage_article", 3);
hurtbox_obj.nightmare = self;
body_collision_hutbox = noone;

target = noone;

firing_timer = 0;
firing_type = 0;
fire_cd = 80;
fires = [noone, noone, noone, noone, noone, noone];
fire_fx = hit_fx_create(sprite_get("nightmare_fire"), 52);
fire_pos = [
	[[-42, 118], [-48, 86], [-44, 52], [88, 130], [96, 112], [102, 82]],
	[[-46, 122], [-52, 88], [-46, 54], [86, 134], [96, 116], [102, 84]],
	[[-52, 126], [-56, 92], [-48, 56], [86, 140], [96, 118], [102, 86]],
	[[-60, 130], [-60, 92], [-50, 56], [86, 148], [96, 122], [102, 86]],
	[[-64, 138], [-62, 96], [-52, 60], [88, 150], [96, 124], [102, 86]],
	[[-64, 138], [-62, 96], [-52, 60], [88, 150], [96, 124], [102, 86]],
	[[-60, 130], [-60, 92], [-50, 56], [86, 148], [96, 122], [102, 86]],
	[[-52, 126], [-56, 92], [-48, 56], [86, 140], [96, 118], [102, 86]],
	[[-46, 122], [-52, 88], [-46, 54], [86, 134], [96, 116], [102, 84]],
	[[-42, 118], [-48, 86], [-44, 52], [88, 130], [96, 112], [102, 82]],
];

spawn_x = 0;

image_xscale = 2;
image_yscale = 2;
mask_index = asset_get("empty_sprite");
sprite_index = asset_get("empty_sprite");
hurt_mask = asset_get("empty_sprite");
part0 = hit_fx_create(sprite_get("larm0"), 120);
part1 = hit_fx_create(sprite_get("larm1"), 120);
part2 = hit_fx_create(sprite_get("rarm0"), 120);
part3 = hit_fx_create(sprite_get("larm2"), 120);
part4 = hit_fx_create(sprite_get("rarm1"), 120);
part5 = hit_fx_create(sprite_get("larm3"), 120);
part6 = hit_fx_create(sprite_get("rarm2"), 120);
part7 = hit_fx_create(sprite_get("larm4"), 120);
fxs = [part0, part1, part2, part3, part4, part5, part6, part7]

/*

pre grav
40 health

	gravity thing

solid mask
10 health

goopy mask
150 health

	no more gravity

goopy face 1
70 health

goopy face 2
70 health

goopy face 3
70 health

core x
60 health