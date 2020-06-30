/// @function dungeon_cell_change_direction(index, x, y, direction, state)
/// @description This function changes border state of the cell in chosen direction
/// @argument {ds_grid} index The index of the dungeon grid
/// @argument {real} x The x position of the cell you want to change direction
/// @argument {real} y The y position of the cell you want to change direction
/// @argument {real} direction Real value representing side of the cell
/// @argument {real} state Real value representing border state
/// @returns {bool} Whether changing succeded
var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var dir = argument3;
var state = argument4;

var node = dungeon[# xx, yy];

if (is_cell(node)) {
    node[dir] = state; dungeon[# xx, yy] = node;
    return true;
} else {
    return false;
}