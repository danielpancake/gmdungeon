/// @function dungeon_generate(dungeon)
/// @description Generates dungeon template
/// @argument {array} dungeon Dungeon settings created with dungeon_create()
/// 						and edited with dungeon_set_* functions.
/// @returns {ds_grid} Generated dungeon template
var properties = argument0;

var width = properties[0];
var height = properties[1];
var deadends_cut_length = properties[2];
var hallway_chance = properties[3];
var treasure_min_rooms = properties[4];
var treasure_max_rooms = properties[5];
var rooms = properties[6];

var dungeon = dungeon_setup(width, height);
var rooms_props = undefined;

// Try to place rooms from passed list
if (rooms != -1) {
	rooms_props = dungeon_init_rooms(dungeon, rooms);
}

// Fill all empty cells
for (var i = 1; i < width + 1; i++) {
	for (var j = 1; j < height + 1; j++) {
		if (dungeon[# i, j] == VOID) {
			dungeon_generate_maze(dungeon, i, j, hallway_chance);
		}
	}
}

// Connect all rooms
var region = 0;

for (var i = 1; i < width + 1; i++) {
	for (var j = 1; j < height + 1; j++) {
		var cell = dungeon[# i, j];
		
		if (cell[5] == -1) {
			dungeon_floodfill(dungeon, i, j, region++);
		}
	}
}

for (var n = 0; n < region; n++) {
	var doors = ds_list_create();
	
	for (var i = 1; i < width + 1; i++) {
		for (var j = 1; j < height + 1; j++) {
			var cell = dungeon[# i, j];
			
			if (cell[5] == n) {
				for (var dir = 0; dir < 4; dir++) {
					var xdir = lengthdir_x(1, dir * 90);
					var ydir = lengthdir_y(1, dir * 90);
					
					var nextcell = dungeon[# i + xdir, j + ydir];
					
					if (is_cell(nextcell)) {
						if (nextcell[5] != n) {
							ds_list_add(doors, array(i, j, dir));
						}
					}
				}
			}
		}
	}
	
	dungeon_create_doors(dungeon, doors);
	
	ds_list_clear(doors);
	ds_list_destroy(doors);
}

// Place entrance and exit
var entrance = dungeon_cell_place_randomly(dungeon, width, height, ENTRANCE, 0);
dungeon_cell_place_randomly(dungeon, width, height, EXIT, entrance);

// Cut deadends
var deadends = ds_list_create();

repeat (deadends_cut_length) {
	for (var i = 1; i < width + 1; i++) {
		for (var j = 1; j < height + 1; j++) {
			var cell = dungeon[# i, j];
			
			if (is_cell(cell)) {
				if (cell[4] != ENTRANCE && cell[4] != EXIT) {
					var a = cell[0] != 0;
					var b = cell[1] != 0;
					var c = cell[2] != 0;
					var d = cell[3] != 0;
					
					if (!a && !b && (c ^^ d)) || (!c && !d && (a ^^ b)) {
						ds_list_add(deadends, array(i, j));
						dungeon_cell_remove(dungeon, i, j);
					}
				}
			}
		}
	}
}

ds_list_shuffle(deadends);

// and then place tresure rooms
var iter = irandom_range(treasure_min_rooms, treasure_max_rooms);

for (var i = 0; i < clamp(iter, 0, ds_list_size(deadends)); i++) {
	var cell = deadends[| i];
	var xx = cell[0];
	var yy = cell[1];
	
	if (get_cell_type(dungeon[# xx + 1, yy]) != TREASURE &&
		get_cell_type(dungeon[# xx, yy - 1]) != TREASURE &&
		get_cell_type(dungeon[# xx - 1, yy]) != TREASURE &&
		get_cell_type(dungeon[# xx, yy + 1]) != TREASURE) {
		
		dungeon[# xx, yy] = dungeon_cell(0, 0, 0, 0, TREASURE, -1);
	} else {
		iter++;	
	}
}
ds_list_clear(deadends);
ds_list_destroy(deadends);

ds_grid_set_grid_region(dungeon, dungeon, 1, 1, width, height, 0, 0);
ds_grid_resize(dungeon, width, height);

return array(dungeon, rooms_props);