/// @function get_cell_type(val)
/// @argument {array} val
/// @returns {real} The real value representing type of the cell
///					or undefined if val is not a cell
var cell = argument0;

if (is_cell(cell)) {
	return cell[4];
} else {
	return undefined;
}