/// @function is_room(val)
/// @argument val
/// @returns {bool} Whether argument has room type
var cell = argument0;

if (is_cell(cell)) {
	return cell[4] >= EMPTY_ROOM;
} else {
	return false;
}