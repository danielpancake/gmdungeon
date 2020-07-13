/// @function dungeon_generate_mask(index, mask sprite, image index)
/// @description Generates mask from sprite image
/// @argument {ds_grid} index The index of the dungeon grid
/// @argument {real} mask_sprite Sprite index
/// @argument {real} image_index The frame of the sprite 
var dungeon = argument0;
var mask = argument1;
var index = argument2;

var ww = ds_grid_width(dungeon) - 2;
var hh = ds_grid_height(dungeon) - 2;

var buffer = buffer_create(ww * hh * 4, buffer_fast, 4);
var surface = surface_create(ww, hh);

surface_set_target(surface);
	draw_sprite_ext(mask, index, 0, 0,
					ww / sprite_get_width(mask), hh / sprite_get_height(mask), 0, c_white, 1);
surface_reset_target();

buffer_get_surface(buffer, surface, buffer_surface_copy, 0, 0);
surface_free(surface);

for (var j = 0; j < hh; j++) {
	for (var i = 0; i < ww; i++) {
		var offset = i + j * ww;
		
		var val = buffer_peek(buffer, offset * 4, buffer_u8);
		if (val == 0) {
			dungeon[# i + 1, j + 1] = BORDER;
		}
	}
}

buffer_delete(buffer);