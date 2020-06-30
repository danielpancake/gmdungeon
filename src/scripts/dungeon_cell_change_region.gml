/// @function dungeon_cell_change_region(index, x, y, region)
/// @description This function changes cell's region value
/// @argument {ds_grid} index The index of the dungeon grid
/// @argument {real} x The x position of the cell you want to change region
/// @argument {real} y The y position of the cell you want to change region
/// @argument {real} region Real value representing region
/// @returns {bool} Whether changing succeded
var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var region = argument3;

var node = dungeon[# xx, yy];

if (is_cell(node)) {
    node[5] = region; dungeon[# xx, yy] = node;
    return true;
} else {
    return false;
}