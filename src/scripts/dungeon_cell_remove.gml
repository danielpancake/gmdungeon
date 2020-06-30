/// @function dungeon_cell_remove(index, x, y)
/// @description This function removes cell from dungeon grid
/// @argument {ds_grid} index The index of the dungeon grid
/// @argument {real} x The x position of the cell you want to remove
/// @argument {real} y The y position of the cell you want to remove
var dungeon = argument0;
var xx = argument1;
var yy = argument2;

var cell = dungeon[# xx, yy];

if (cell[0] != 0) { dungeon_cell_change_direction(dungeon, xx + 1, yy, 2, 0); }
if (cell[1] != 0) { dungeon_cell_change_direction(dungeon, xx, yy - 1, 3, 0); }
if (cell[2] != 0) { dungeon_cell_change_direction(dungeon, xx - 1, yy, 0, 0); }
if (cell[3] != 0) { dungeon_cell_change_direction(dungeon, xx, yy + 1, 1, 0); }
            
dungeon[# xx, yy] = VOID;