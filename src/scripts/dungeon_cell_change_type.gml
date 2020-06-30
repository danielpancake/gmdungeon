/// @function dungeon_cell_change_type(index, x, y, type)
/// @description This function change type value of the cell
/// @argument {ds_grid} index The index of the dungeon grid
/// @argument {real} x The x position of the cell you want to change type
/// @argument {real} y The y position of the cell you want to change type
/// @argument {real} type Real value representing type of the cell
/// @returns {bool} Whether changing succeded
var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var type = argument3;

var node = dungeon[# xx, yy];

if (is_cell(node)) {
    node[4] = type; dungeon[# xx, yy] = node;
    return true;
} else {
    return false;
}