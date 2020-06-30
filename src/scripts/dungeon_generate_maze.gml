/// @function dungeon_generate_maze(index, x, y, hallway generation chance)
/// @description This function starts to generate maze in passed position
///				 in the dungeon grid until there are empty cells.
/// @argument index The index of the dungeon grid
/// @argument x The x position of the cell where you want the maze algorithm to start
/// @argument y The y position of the cell where you want the filling maze to start
/// @argument hallway_generation_chance The chance of the hallway to be placed
var nodes = ds_list_create();

var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var hall_gen = argument3;
var dir;

dungeon[# xx, yy] = dungeon_cell(0, 0, 0, 0, REGULAR, -1);

while (true) {
    dir = irandom(3);
    
    var xdir = lengthdir_x(1, dir * 90);
    var ydir = lengthdir_y(1, dir * 90);
    
    if (dungeon[# xx + xdir, yy + ydir] == VOID) {
        ds_list_add(nodes, array(xx, yy));
        dungeon[# xx + xdir, yy + ydir] = dungeon_cell(0, 0, 0, 0, REGULAR, -1);
        
        if (with_a_chance(hall_gen)) {
            dungeon_cell_change_direction(dungeon, xx, yy, dir, 2);
            dungeon_cell_change_type(dungeon, xx, yy, HALL);
            dungeon_cell_change_direction(dungeon, xx + xdir, yy + ydir, inverse_direction(dir), 2);
            dungeon_cell_change_type(dungeon, xx + xdir, yy + ydir, HALL);
        } else {
            dungeon_cell_change_direction(dungeon, xx, yy, dir, 1);
            dungeon_cell_change_direction(dungeon, xx + xdir, yy + ydir, inverse_direction(dir), 1);
        }
        xx += xdir; yy += ydir;
        
    } else if (dungeon[# xx, yy - 1] != VOID &&
               dungeon[# xx, yy + 1] != VOID &&
               dungeon[# xx - 1, yy] != VOID &&
               dungeon[# xx + 1, yy] != VOID) {

        for (var i = 0; i < ds_list_size(nodes); i++) {
            var node = nodes[| i];
            xx = node[0]; yy = node[1];
                
            if (dungeon[# xx, yy - 1] == VOID ||
                dungeon[# xx, yy + 1] == VOID ||
                dungeon[# xx - 1, yy] == VOID ||
                dungeon[# xx + 1, yy] == VOID) {
                
                break;
            } else {
                ds_list_delete(nodes, i);
            }
        }
        
        if (ds_list_empty(nodes)) { break; }
    }
}