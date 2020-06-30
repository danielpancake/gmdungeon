/// @function dungeon_floodfill(index, x, y, region)
/// @description This function fills all connected cells in dungeon grid with region value
/// @argument {ds_grid} index The index of the dungeon grid
/// @argument {real} x The x position of the cell where you want the filling algorithm to start
/// @argument {real} y The y position of the cell where you want the filling algorithm to start
/// @argument {real} region Real value representing region
/// @returns {real} Number of cells filled
var count = 0;

var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var region = argument3;

var ww = ds_grid_width(dungeon);
var hh = ds_grid_height(dungeon);

var cell = dungeon[# xx, yy];
dungeon_cell_change_region(dungeon, xx, yy, region);

for (var dir = 0; dir < 4; dir++) {
    var xdir = lengthdir_x(1, dir * 90);
    var ydir = lengthdir_y(1, dir * 90);
        
    if (xx + xdir >= 0 && xx + xdir < ww && yy + ydir >= 0 && yy + ydir < hh) {
        var nextcell = dungeon[# xx + xdir, yy + ydir];
        
		if (is_cell(nextcell)) {
	        if (cell[dir] != 0 && nextcell[inverse_direction(dir)] != 0 && nextcell[5] == -1) {
	            count++;
	            count += dungeon_floodfill(dungeon, xx + xdir, yy + ydir, region);
	        }
		}
    }    
}

return count;