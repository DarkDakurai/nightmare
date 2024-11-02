var cx = view_get_xview();
var cy = view_get_yview();
var wx = view_get_wview();
var wy = view_get_hview();
var ccx = ccx + wx/2;
var ccy = ccy + wy/2;
if nightmare.state >= 14 && finish_game = clamp(finish_game, 40, 280){
	var col = make_color_rgb(64, 0, 120);
	var sz = clamp((120 - abs(finish_game-40 - 120))/40, 0, .5);
	draw_rectangle_color(ccx - wx*sz, ccy - 80*sz - 100, ccx + wx*sz, ccy+80*sz - 100, col, col, col, col, 0);
	if abs(finish_game-40 - 120) < 100 draw_sprite_ext(sprite_get("text"), 0, ccx, ccy - 100, 2, 2, 0, c_white, 1);
}

if get_gameplay_time() < 120 draw_sprite_ext(sprite_get("sector_5"), 0, ccx, clamp(dsin(get_gameplay_time()*2 + 60)*200, -200, 80), 1, 1, 0, c_white, 1);

if finish_game < 500{
    var hud_y = 462;
    var offscreen_spr = hud_offscreen
    var hud_spr = hud_main
    with (oPlayer)
    {
        //overhead info + offscreen indicator
        if (visible && draw_indicator)
        {
            var player_x = x - cx;
            var player_y = y - cy;
            var player_name = get_player_name(player)
            var name_length = (string_length(player_name)*10)
            var check_dead = (state == PS_DEAD || state == PS_RESPAWN)
            var check_hud_col = check_dead ? other.hud_darker_color[player-1] : other.player_hud_colors[player-1];
            var height = player_y-char_height-hud_offset
            draw_sprite_ext(
                hud_spr,
                8 + (url == CH_ELLIANA),
                player_x-28,
                height-30+(url == CH_ELLIANA)*2,
                2, 2, 0, check_hud_col, 1
            );
            text_draw(player_x, height-42, player_name, check_hud_col, "fName", fa_center, 1, true, 1, $4F2727);
            if !other.spc text_draw(player_x, height-58, string(get_player_damage(player)) + "%", c_white, "fName", fa_center, 1, true);
                if (!check_dead) //offscreen indicator
            {
                //var off_limits = [32, view_w-32, 54, view_h-80]; //left, right, up, down
                var off_limits_x1 = 32
                var off_limits_x2 = wx-32
                var off_limits_y1 = 54
                var off_limits_y2 = wy-80
                //var off_x = clamp(player_x, off_limits_x1, off_limits_x2);
                //var off_y = clamp(player_y, off_limits_y1, off_limits_y2);
                
                if (player_x <= off_limits_x1 || player_x >= off_limits_x2 || player_y <= off_limits_y1 || player_y >= off_limits_y2)
                {
                    draw_sprite_ext(
                        offscreen_spr, 0, 
                        clamp(player_x, off_limits_x1, off_limits_x2), 
                        clamp(player_y, off_limits_y1, off_limits_y2) - 20, 2, 2,
                        point_direction(player_x, player_y, clamp(player_x, off_limits_x1, off_limits_x2), clamp(player_y, off_limits_y1+32, off_limits_y2-32))-90,
                        check_hud_col, 1
                    );
                }
            }
        }
    
    }
	
	
	var a = 0;
	with oPlayer with other{
		temp_player_hud_draw(132 + 240*a, other, a+1)
		a++;
	}
}else{
	var t = finish_game-500;
	draw_sprite_tiled_ext(sprite_get("cosmic_bg"), t/3, dcos(t)*10, -t, 2, 2, c_white, clamp(t/120, 0, .5));
	t = finish_game-620;
	draw_sprite_ext(sprite_get("game_over"), 0, ccx, ccy - 150, 2, 2, 0, c_white, t/30);
	if t > 30{
		draw_metroid_text(ccx - 400, ccy - 80, "time:", "fnt_metroid_intro2");
		draw_metroid_text(ccx + 400, ccy - 80,  m+":"+s+":"+ms, "fnt_metroid_intro2", fa_right);
	}
	if t > 60{
		draw_metroid_text(ccx - 400, ccy - 50, "damage dealt:", "fnt_metroid_intro2");
		draw_metroid_text(ccx + 400, ccy - 50,  string(damage_dealt), "fnt_metroid_intro2", fa_right);
	}
	if t > 90{
		draw_metroid_text(ccx - 400, ccy - 20, "damage taken:", "fnt_metroid_intro2");
		draw_metroid_text(ccx + 400, ccy - 20,  string(damage_taken), "fnt_metroid_intro2", fa_right);
	}
	if t > 120{
		draw_metroid_text(ccx - 400, ccy + 10, "absorbed parasites:", "fnt_metroid_intro2");
		draw_metroid_text(ccx + 400, ccy + 10,  string(absorbed_parasites), "fnt_metroid_intro2", fa_right);
	}
	if t > 150{
		draw_metroid_text(ccx - 400, ccy + 40, "score:", "fnt_metroid_intro2");
		draw_metroid_text(ccx + 400, ccy + 40,  string(score), "fnt_metroid_intro2", fa_right);
	}
	if t > 250 draw_metroid_text(ccx, ccy + 70, "rank:", "fnt_metroid_intro2", fa_center);
	if t > 300 draw_metroid_text(ccx, ccy + 100,  rank, "fnt_metroid_intro2", fa_center);
}





#define temp_player_hud_draw(hud_x, p_id, port)
if !instance_exists(p_id) return;
var hud_y = 462
var hud_spr = hud_main
var energy = sprite_get("energy")
var tanks = sprite_get("tanks")
var stocks = sprite_get("stocks")
var damage_font = font_get("font_damage");
var metrd = font_get("fnt_metroid_energy");
with p_id {
    var check_dead = (state == PS_RESPAWN || state == PS_DEAD);
    var check_hud_col = check_dead ? other.hud_darker_color[player-1] : other.player_hud_colors[player-1];
    var check_white_col = check_dead ? c_gray : c_white;
    
    draw_sprite_ext(hud_spr, 0, hud_x - 10, hud_y, 2, 2, 0, check_dead ? c_gray : c_white, 1);
    draw_sprite_ext(hud_spr, 1, hud_x, hud_y, 2, 2, 0, check_dead ? other.hud_darker_color[player-1] : other.player_hud_colors[player-1], 1);
    
    if other.spc{
    	draw_sprite(energy, 2, hud_x+68, hud_y+12); //damage % normally
    	var a = 1;
    	repeat 12{
    		draw_sprite(tanks, other.energy[player-1] < a*100, hud_x+108 + a*8, hud_y+28);
    		a++;
    	}
    	var en = other.energy[player-1];
    	text_draw_test(hud_x+114, hud_y+30,
	        (en%100 < 10? "0": "") + string(en%100),
	        check_white_col,
	        metrd, fa_right, 1
	    );
    }else{
    	draw_sprite(hud_spr, 2, hud_x+140, hud_y+22); //damage % normally
	    text_draw_test(hud_x+142, hud_y + 16,
	        string(get_player_damage(player)),
	        check_white_col,
	        damage_font, fa_right, 1
	    );
	    draw_sprite_ext(stocks, other.stocks[player-1]-1, hud_x + 206, hud_y + 14, 2, 2, 0, check_dead ? c_gray : c_white, 1);
    }
    
    var hud_spr = check_dead ? get_char_info(player, INFO_HUDHURT) : get_char_info(player, INFO_HUD);
    
    if (("draw_hud_event" in self ? draw_hud_event : -1) != -1 && ("demonhorde_hud_overwrite" in self && demonhorde_hud_overwrite) == 1)
    {
        temp_x = hud_x + 8;
        temp_y = hud_y - 12;
        draw_hud_type = "gw_demonhorde";
        
        user_event(draw_hud_event);
        //shader_end();
    } else {
        var idx = select-1
        gpu_set_fog(true, check_hud_col, 1, 0);
        draw_sprite(hud_spr, idx, hud_x + 14, hud_y + 8);
        gpu_set_fog(false, c_white, 1, 0);
        if ("nightmare_colorOcache" in self) {
            var tmp_colorO = static_colorO;
            static_colorO = nightmare_colorOcache;
            shader_start();
            draw_sprite_ext(hud_spr, idx, hud_x + 8, hud_y + 8, 1, 1, 0, check_dead ? c_gray : c_white, 1);
            static_colorO = tmp_colorO;
            shader_end();
        } else {
            shader_start();
            draw_sprite_ext(hud_spr, idx, hud_x + 8, hud_y + 8, 1, 1, 0, check_dead ? c_gray : c_white, 1);
            shader_end();
        }
        //CUSTOM HUD SUPPORT
        var gus_shopicon_spr = asset_get("gus_shopicon_spr")
        switch (url) //built in basecast compatibility
        {
            case CH_WRASTOR: //slipstream
                draw_sprite_ext(gus_shopicon_spr, 7, hud_x + 186, hud_y - 12, 2, 2, 0, c_white, 1);
                draw_sprite_ext(gus_shopicon_spr, 7, hud_x + 186, hud_y - 12, 2, 2, 0, c_black, (move_cooldown[AT_FSPECIAL] > 0)*0.5);
                break;
            case CH_FORSBURN: //clone hud
                draw_sprite_ext(gus_shopicon_spr, 8, hud_x + 186, hud_y - 12, 2, 2, 0, c_white, 1);
                draw_sprite_ext(gus_shopicon_spr, 8, hud_x + 186, hud_y - 12, 2, 2, 0, c_black,
                    (move_cooldown[AT_FSPECIAL] > 0 && can_create_clone && state != PS_ATTACK_GROUND && state != PS_ATTACK_AIR)*0.5);
                break;
            case CH_CLAIREN: //plasma field
                draw_sprite_ext(gus_shopicon_spr, 9, hud_x + 186, hud_y - 12, 2, 2, 0, c_white, 1);
                draw_sprite_ext(gus_shopicon_spr, 9, hud_x + 186, hud_y - 12, 2, 2, 0, c_black,
                    (move_cooldown[AT_DSPECIAL] > 0 || attack == AT_DSPECIAL && (state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR))*0.5);
                break;
            case CH_ELLIANA: //overheat meter
                var outline_x1 = hud_x + 26
                var outline_y1 = hud_y - 8
                var fill_x1 = outline_x1 + 2
                var outline_x2 = outline_x1 + 104
                var outline_y2 = hud_y + 2
                var outline_color = c_black
                    
                    
                draw_rectangle_color(outline_x1, outline_y1, outline_x2 - 1, outline_y2 - 1, outline_color, outline_color, outline_color, outline_color, false)
                draw_rectangle_color(fill_x1, outline_y1 + 2, outline_x2 - 3, outline_y2 -3, $4c4c4c, $4c4c4c, $4c4c4c, $4c4c4c, false)
                if (heat > 0) //fill outline
                {
                    var bar_length = floor(heat/12) & ~1
                    var heat_color = overheated ? c_red : c_white
                    draw_rectangle_color(fill_x1 + bar_length, outline_y1, fill_x1 + 1 + bar_length, outline_y2 - 1, outline_color, outline_color, outline_color, outline_color, false)
                    draw_rectangle_color(fill_x1 , outline_y1 + 2, fill_x1 + bar_length - 1, outline_y2 - 3, heat_color, heat_color, heat_color, heat_color, false)
                }
                
                break;
            case CH_SHOVEL_KNIGHT: //shop stuff
                draw_sprite_ext(gus_shopicon_spr, 0, hud_x, hud_y - 12, 2, 2, 0, c_white, 1);
    
                //side icons - if there's only one it forces to the first position, if there's 2 the armors are in the first position
                if (armor_set > 0) draw_sprite_ext(gus_shopicon_spr, armor_set+3, hud_x + 202, hud_y - 12, 2, 2, 0, c_white, 1);
                if (nspecial_relic > 0) draw_sprite_ext(gus_shopicon_spr, nspecial_relic, hud_x + 202 - (armor_set > 0) * 28, hud_y - 12, 2, 2, 0, c_white, 1);
                
                //shoutout to frtoud for helping me code this
                var displayed_gems = string(abs(gems));
                var length = string_length(displayed_gems);
                for (var g = 0; g < length; g++)
                {
                    //draw each digit
                    var digit = string_ord_at(displayed_gems, length-g);
                    draw_sprite( asset_get("gus_shopnum_spr"),
                        (digit - 40),
                        hud_x + 8 + (length - g) * 16,
                        hud_y - 14
                    );
                }
                break;
            case CH_MOLLO: //active when mollo holds a bomb, image is bomb type
                if (holding_bomb) draw_sprite_ext(asset_get("moth_bomb_hud_spr"), bombtype, hud_x + 186, hud_y - 4, 2, 2, 0, c_white, 1);
                break;
            default: // Do workshop check
                if (("draw_hud_event" in self ? draw_hud_event : -1) != -1) //workshop compatibility
                {
                    temp_x = hud_x + 8;
                    temp_y = hud_y - 12;
                    draw_hud_type = "gw_demonhorde";
            
                    //shader_start();
                    user_event(draw_hud_event);
                    //shader_end();
                }
                break;
        }
    }
    
}

//text_draw_test(x, y, string, color, font, align, ?alpha)
#define text_draw_test
{
    var x = argument[0];
    var y = argument[1];
    var string = argument[2];
    var color = argument[3];
    var font = argument[4];
    var align = argument[5];
    var alpha = argument_count > 6 ? argument[6] : 1;

    draw_set_font(font);
    draw_set_halign(align);

    draw_text_color(x, y, string, color, color, color, color, alpha);
}

//text_draw(x, y, string, color, font, align, ?alpha, ?outline, ?line_alpha, ?line_col)
#define text_draw
{
    var x = argument[0];
    var y = argument[1];
    var string = argument[2];
    var color = argument[3];
    var font = asset_get(argument[4]);
    var align = argument[5];
    var alpha = argument_count > 6 ? argument[6] : 1;
    var outline = argument_count > 7 ? argument[7] : false;
    var line_alpha = (argument_count > 8 ? argument[8] : 1) * alpha;
    var line_col = argument_count > 9 ? argument[9] : c_black;
    
    if draw_get_font() != font
        draw_set_font(font);
    if draw_get_halign() != align
        draw_set_halign(align);

    y-=2
    draw_text_color(x-2, y, string, line_col, line_col, line_col, line_col, line_alpha);
    draw_text_color(x, y, string, line_col, line_col, line_col, line_col, line_alpha);
    draw_text_color(x+2, y, string, line_col, line_col, line_col, line_col, line_alpha);
    y+=2
    draw_text_color(x-2, y, string, line_col, line_col, line_col, line_col, line_alpha);
    draw_text_color(x+2, y, string, line_col, line_col, line_col, line_col, line_alpha);
    y+=2
    draw_text_color(x-2, y, string, line_col, line_col, line_col, line_col, line_alpha);
    draw_text_color(x, y, string, line_col, line_col, line_col, line_col, line_alpha);
    draw_text_color(x+2, y, string, line_col, line_col, line_col, line_col, line_alpha);
    
    draw_text_color(x, y-2, string, color, color, color, color, alpha);
}

#define draw_metroid_text
/// draw_metroid_text(x1, y1, text, font, halign = fa_left, c1 = c_white, col = noone, alpha = 1, xsc = 2, ysc = 2, sep = 0;)
var x1 = argument[0], y1 = argument[1], text = argument[2], font = argument[3];
var halign = argument_count > 4 ? argument[4] : fa_left;
var c1 = argument_count > 5 ? argument[5] : c_white;
var col = argument_count > 6 ? argument[6] : noone;
var alpha = argument_count > 7 ? argument[7] : 1;
var xsc = argument_count > 8 ? argument[8] : 2;
var ysc = argument_count > 9 ? argument[9] : 2;
var sep = argument_count > 10 ? argument[10] : 0;;
if col = noone col = make_color_rgb(41, 57, 140);
draw_set_font(font_get(font));
draw_set_halign(halign);
draw_text_ext_transformed_color(x1, y1, text, sep, 99999, xsc, ysc, 0, c1, c1, c1, c1, alpha);
