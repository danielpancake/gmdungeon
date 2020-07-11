/// @function dungeon_init_rooms(index, list)
/// @description This function tries to place rooms from list argument into dungeon grid
/// @argument {ds_grid} index The index of the dungeon grid
/// @argument {ds_list} list List of rooms created with dungeon_create_rooms_list()
/// @returns {ds_list} List of rooms attributes (position, width and height)
var dungeon = argument0;
var rooms = argument1;

var list = ds_list_create();

for (var i = 0; i < ds_list_size(rooms); i++) {
	var rm = rooms[| i];
	
	var width = rm[0];
	var height = rm[1];
	var type = rm[2];
	
	repeat(1000) {
		var can_be_placed = true;
		
		var xx = irandom(ds_grid_width(dungeon) - width - 2) + 1;
		var yy = irandom(ds_grid_height(dungeon) - height - 2) + 1;
		
		for (var _x = xx; _x < xx + width; _x++) {
			for (var _y = yy; _y < yy + height; _y++) {
				if (dungeon[# _x, _y] != BEDROCK && dungeon[# _x, _y] != VOID) {
					can_be_placed = false; break;
				}
			}
			
			if (!can_be_placed) break;
		}
		
		if (can_be_placed) {
			dungeon_generate_room(dungeon, xx, yy, width, height, type);
			ds_list_add(list, array(xx, yy, width, height, type));
			
			break;
		}
	}
}

return list;