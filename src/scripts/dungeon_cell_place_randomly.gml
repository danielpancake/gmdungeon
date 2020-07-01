/// @function dungeon_cell_place_randomly(index, width, height, type, check)
/// @description This function changes type of a random cell (if its type is REGULAR).
///				If check argument is an 1D array of cell's coordinates, function will try to change
///				type of the furthest cell.
/// @argument {ds_grid} index The index of the dungeon grid
/// @argument {real} width The width of the dungeon grid
/// @argument {real} height The height of the dungeon grid
/// @argument {real} type Real value representing type
/// @argument {array} check -1 or 1D array of cell's coordinates
/// @returns {array} Coordinates of the changed cell
var dungeon = argument0;
var width = argument1;
var height = argument2;
var type = argument3;
var check = argument4;

var radius = sqrt(power(width, 2) + power(height, 2));

while (true) {
	var xx = irandom(width - 1) + 1;
	var yy = irandom(height - 1) + 1;
	
	var cell = dungeon[# xx, yy];
	
	if (is_cell(cell)) {
		if (cell[4] == HALL || cell[4] == REGULAR) {
			if (is_array(check)) {
				var dx = xx - check[0];
				var dy = yy - check[1];
				
				if (ceil(sqrt(power(dx, 2) + power(dy, 2))) >= ceil(radius)) {
					dungeon_cell_change_type(dungeon, xx, yy, type);
					break;
				} else {
					radius -= width / height;
				}
			} else {
				dungeon_cell_change_type(dungeon, xx, yy, type);
				break;
			}
		}
	}
}

return array(xx, yy);