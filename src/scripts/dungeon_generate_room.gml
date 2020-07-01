/// @function dungeon_generate_room(index, x, y, width, height)
/// @description This function creates rectangle room in dungeon grid
/// @argument index The index of the dungeon grid
/// @argument x The x position in the dungeon grid where to place room
/// @argument y The y position in the dungeon grid where to place room
/// @argument width The width of a room
/// @argument height The height of a room
var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var ww = argument3;
var hh = argument4;

for (var i = 0; i < ww; i++) {
	for (var j = 0; j < hh; j++) {
		dungeon[# xx + i, yy + j] = dungeon_cell(2, 2, 2, 2, ROOM, -1);
	}
}

for (var i = 0; i < ww; i++) {
	dungeon_cell_change_direction(dungeon, xx + i, yy, 1, 0);
}

for (var i = 0; i < ww; i++) {
	dungeon_cell_change_direction(dungeon, xx + i, yy + hh - 1, 3, 0);
}

for (var j = 0; j < hh; j++) {
	dungeon_cell_change_direction(dungeon, xx, yy + j, 2, 0);
}

for (var j = 0; j < hh; j++) {
	dungeon_cell_change_direction(dungeon, xx + ww - 1, yy + j, 0, 0);
}