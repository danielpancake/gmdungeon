/// @function inverse_direction(direction)
/// @description This function returns real value representing direction opposite to one that was passed into it
/// @argument {real} Real value representing side of the cell
/// @returns {real} Inversed direction
var dir = argument0;

if (dir % 2 == 0) {
    return 2 - dir;
} else {
    return 4 - dir;
}