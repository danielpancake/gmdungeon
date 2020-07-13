/// @function dungeon_draw(index, x, y)
/// @argument {ds_grid} index Index of dungeon generated with dungeon_generate()
/// @argument {real} x The x coordinate to draw the dungeon
/// @argument {real} y The y coordinate to draw the dungeon
var dungeon = argument0[0];
var rooms = argument0[1];
var xx = argument1;
var yy = argument2;

var width = ds_grid_width(dungeon);
var height = ds_grid_height(dungeon);

for (var i = 0; i < width; i++) {
	for (var j = 0; j < height; j++) {
		var cell = dungeon[# i, j];
		
		if (is_cell(cell)) {
			var celltype = sDungeonCells;
			
			if (cell[4] >= EMPTY_ROOM) {
				celltype = sDungeonRooms;
			}
			
			draw_sprite(celltype, 0, xx + i * 8, yy + j * 8);
			
			for (var k = 0; k < 4; k++) {
				draw_sprite(celltype, 1 + 3 * k + cell[k], xx + i * 8, yy + j * 8);
			}
			
			switch (cell[4]) {
				case ENTRANCE:
					draw_sprite(sDungeonCells, 14, xx + i * 8, yy + j * 8);
				break;
				
				case EXIT:
					draw_sprite(sDungeonCells, 15, xx + i * 8, yy + j * 8);
				break;
				
				case TREASURE:
					draw_sprite(sDungeonCells, 16, xx + i * 8, yy + j * 8);
				break;
			}
		} else {
			draw_sprite(sDungeonCells, 13, xx + i * 8, yy + j * 8);
		}
	}
}

if (rooms != undefined) {
	for (var i = 0; i < ds_list_size(rooms); i++) {
		var rm = rooms[| i];
		
		if (rm[4] > EMPTY_ROOM) {
			draw_sprite(sDungeonCells, rm[4] + 10, xx + (rm[0] + rm[2] / 2 - 1) * 8 - 4,
										yy + (rm[1] + rm[3] / 2 - 1) * 8 - 4);
		}
	}
}