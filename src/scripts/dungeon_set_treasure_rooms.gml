/// @function dungeon_set_treasure_rooms(index, min number, max number)
/// @argument {array} index The dungeon created with dungeon_create()
/// @argument {real} min_number The minimum number of treasure rooms to spawn
/// @argument {real} max_number The maximum number of treasure rooms to spawn
var index = argument0;
index[@ 4] = argument1;
index[@ 5] = argument2;