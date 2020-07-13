/// @function dungeon_setup(width, height)
/// @description Setup dungeon generation
/// @argument {real} width The width of the dungeon grid
/// @argument {real} height The height of the dungeon grid
/// @returns {ds_grid} Setuped dungeon
randomize();
// or something like random_set_seed(1234567890);

// Dungeon size
var width  = argument0;
var height = argument1;

// Create empty dungeon
var dungeon = ds_grid_create(width + 2, height + 2);
// with one cell border of BEDROCK but with VOID inside
ds_grid_clear(dungeon, BEDROCK);
ds_grid_set_region(dungeon, 1, 1, width, height, VOID);

return dungeon;