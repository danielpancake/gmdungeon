/// @function dungeon_add_room(list, room, count)
/// @description Adds new room (or rooms) to the list
/// @argument {ds_list} list The id of the list to add to
/// @argument {array} room The room created with dungeon_room()
/// @argument {real} count The count of rooms to be added
repeat (argument2) {
	ds_list_add(argument0, argument1);
}