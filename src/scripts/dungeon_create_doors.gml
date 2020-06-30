/// @function dungeon_create_doors(index, doors)
/// @description This function makes from 1 to 4 halls (doors) between cells
/// @argument {ds_grid} index The index of the dungeon grid
/// @argument {ds_list} doors List of doors
var dungeon = argument0;
var doors = argument1;

var size = ds_list_size(doors);
ds_list_shuffle(doors);

for (var j = 0; j < clamp(irandom(3) + 1, 1, size - 1); j++) {
    var door = doors[| j];
        
    var _x  = door[0];
    var _y  = door[1];
    var dir = door[2];
        
    var xdir = lengthdir_x(1, dir * 90);
    var ydir = lengthdir_y(1, dir * 90);
	
	dungeon_cell_change_direction(dungeon, _x, _y, dir, 1);
	dungeon_cell_change_direction(dungeon, _x + xdir, _y + ydir, inverse_direction(dir), 1);
}