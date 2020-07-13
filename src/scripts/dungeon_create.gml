/// @function dungeon_create()
/// @description This function returns basic settings for dungeon generator.
///				Use this array with dungeon_generate();
/// @returns {array} Array with basic settings for dungeon generator

/// Dungeon properties:
/// [0] width
/// [1] height
/// [2] number of deadends to cut
/// [3] chance of hallway to spawn
/// [4] min number of trasure rooms
/// [5] max number of trasure rooms
/// [6] rooms list
/// [7] mask (array: [0] - sprite, [1] - index)
return array(8, 8, 0, 50, 1, 3, -1, -1);