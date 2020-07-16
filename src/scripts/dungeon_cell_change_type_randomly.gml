/// @function dungeon_cell_change_type_randomly(index, type, cell, farthest, offset)
/// @description This function changes type of a random cell (if its type is initially REGULAR or HALL).
///				If third argument (cell) is an 1D array of cell's coordinates, function will try to change
///				type of the furthest or closest cell. 
/// @argument {ds_grid} index The index of the dungeon grid
/// @argument {real} type Real value representing type
/// @argument {array} cell -1 or 1D array of cell's coordinates
/// @argumnet {boolean} farthest If this argument is true, cell will be placed far from the position of the passed cell.
///								Otherwise it will be placed close to the position of the passed cell.
/// @argumnet {real} offset Number of cells from the dungeon's border or the position of the passed cell (it depends on previous argument).
/// @returns {array} Coordinates of the changed cell
var dungeon = argument0;
var type = argument1;
var cell_to_check = argument2;
var farthest = argument3;
var offset = argument4;

var offset_outer = 0;
var offset_inner = offset;

if (!is_array(cell_to_check)) {
	cell_to_check = -1;
} else if (farthest) {
	offset_outer = offset;
}

var width = ds_grid_width(dungeon) - 1;
var height = ds_grid_height(dungeon) - 1;

var distance_max = 0;
var distance_min = infinity;

var cell_list = ds_list_create();

for (var i = 1 + offset_outer; i < width - offset_outer; i++) {
	for (var j = 1 + offset_outer; j < height - offset_outer; j++) {
		var cell = dungeon[# i, j];
		
		if (is_cell(cell)) {
			if (cell[4] == REGULAR || cell[4] == HALL) {
				if (cell_to_check == -1) {
					ds_list_add(cell_list, array(i, j));
				} else {
					var distance = ceil(point_distance(cell_to_check[0], cell_to_check[1], i, j));
					
					if (farthest) {
						if (distance > distance_max) {
							distance_max = distance;
							ds_list_clear(cell_list);
						}
					
						if (distance == distance_max) {
							ds_list_add(cell_list, array(i, j, distance));
						}
					} else if (distance > offset_inner) {
						if (distance < distance_min) {
							distance_min = distance;
							ds_list_clear(cell_list);
						}
						
						if (distance == distance_min) {
							ds_list_add(cell_list, array(i, j, distance));
						}
					}
				}
			}
		}
	}
}

ds_list_shuffle(cell_list);	

var cell_coord = cell_list[| 0];
var xx = cell_coord[0];
var yy = cell_coord[1];

dungeon_cell_change_type(dungeon, xx, yy, type);

ds_list_clear(cell_list);
ds_list_destroy(cell_list);

return array(xx, yy);