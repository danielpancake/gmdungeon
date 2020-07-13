/// @function dungeon_set_mask(index, mask sprite, image index)
/// @argument {array} index The dungeon created with dungeon_create()
/// @argument {real} mask_sprite Sprite index
/// @argument {real} image_index The frame of the sprite 
var index = argument0;
index[@ 7] = array(argument1, argument2);