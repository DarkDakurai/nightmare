//Loads and sets an offset for article sprites.
sprite_change_offset(("cover"), 0, 0);


////nightmare pieces

//body
sprite_change_offset("night_bod", 75, 85);
sprite_change_offset("night_cannon", 75, 85);
sprite_change_offset("night_larm", 75, 85);
sprite_change_offset("night_rarm", 75, 85);
sprite_change_offset("night_face", 72, 52);
sprite_change_offset("night_face_overlay", 72, 52);
sprite_change_offset("night_gelface", 57, 37);
sprite_change_offset("nightmare_transform", 69, 50); //6, 35

//core x
sprite_change_offset("night_core", 17, 17);
sprite_change_offset("core_aura", 16, 16);
sprite_change_offset("night_shell", 23, 24);
sprite_change_offset("night_shell_piece", 12, 12);
sprite_change_offset("spark_anim", 23, 24);
sprite_change_offset("blue_spark0", 46, 48);
sprite_change_offset("blue_spark1", 46, 48);
sprite_change_offset("blue_spark2", 46, 48);

//misc
sprite_change_offset("rarm0", 96, -88);
sprite_change_offset("rarm1", 104, -66);
sprite_change_offset("rarm2", 110, -34);

sprite_change_offset("larm0", -2, -110);
sprite_change_offset("larm1", -28, -66);
sprite_change_offset("larm2", -34, -30);
sprite_change_offset("larm3", -28, -2);
sprite_change_offset("larm4", -4, 34);

sprite_change_offset("nightmare_fire", 48, 16);
sprite_change_offset("night_proj", 32, 7);

sprite_change_offset("night_drop", 3, 7);
sprite_change_offset("night_drop_fx", 12, 12);

sprite_change_offset("ground", 250, 160);
sprite_change_offset("groundoutline", 176, 21);

sprite_change_offset("para0", 8, 8);
sprite_change_offset("para1", 8, 8);
sprite_change_offset("x_mask", 6, 6);

var a = 1;
while a < 22{
	sprite_change_offset("ground" + string(a), 176, 21);
	sprite_change_offset("lines" + string(a), 300, 200);
	a++;
}

sprite_change_offset("x_caught", 32, 32);
sprite_change_offset("x_caught0", 32, 32);
sprite_change_offset("x_caught1", 32, 32);

sprite_change_offset("text", 120, 16);

//vfx
sprite_change_offset("vfx_boom1", 16, 16);
sprite_change_offset("vfx_boom2", 32, 32);
sprite_change_offset("vfx_smoke", 16, 16);
sprite_change_offset("vfx_ding", 16, 16);

//hud
sprite_change_offset("game_over", 85, 12);
sprite_change_offset("sector_5", 103, 9);

//collisions
sprite_change_offset("night_col_body_1", 75, 85);
sprite_change_offset("night_col_body_2", 75, 85);
sprite_change_offset("night_col_hit_body_1", 150, 170);
sprite_change_offset("night_col_hit_body_2", 150, 170);
sprite_change_offset("night_col_hurt_body_1", 75, 85);
sprite_change_offset("night_col_hurt_body_2", 75, 85);
sprite_change_offset("night_col_hurt_body_3", 23, 24);
sprite_change_collision_mask("night_col_body_1", 0, 0, 0, 0, 0, 0, 0)
sprite_change_collision_mask("night_col_body_2", 0, 0, 0, 0, 0, 0, 0)
sprite_change_collision_mask("night_col_hit_body_1", 0, 0, 0, 0, 0, 0, 0)
sprite_change_collision_mask("night_col_hit_body_2", 0, 0, 0, 0, 0, 0, 0)
sprite_change_collision_mask("night_col_hurt_body_1", 0, 0, 0, 0, 0, 0, 0)
sprite_change_collision_mask("night_col_hurt_body_2", 0, 0, 0, 0, 0, 0, 0)
sprite_change_collision_mask("night_col_hurt_body_3", 0, 0, 0, 0, 0, 0, 0)