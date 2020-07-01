/// @function inverse_direction(direction)
/// @description This function returns real value representing direction opposite to one that was passed into it
/// @argument {real} Real value representing side of the cell
/// @returns {real} Inversed direction
var dir = argument0;
return 2 * (1 + (dir % 2)) - dir;