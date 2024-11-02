type = random_func_2(abs(floor(56 + x + y))%200, 2, 1);
sprite_index = sprite_get("para" + string(type));
absorbed = 0;
pl_touch = noone;

randdir = 0;
image_xscale = 2;
image_yscale = 2;
mask_index = sprite_get("x_mask");
t = -type;