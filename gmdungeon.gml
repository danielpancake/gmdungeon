#define array
/// array(val1, val2...)

var a, c;

for (c = 0; c < argument_count; c++) {
    a[c] = argument[c];
}

return a;

#define with_a_chance
/// with_a_chance(%)

return random(100) < argument0;

#define dungeon_cell_add_direction
/// dungeon_cell_add_direction(index, x, y, direction, type)

var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var dir = argument3;
var type = argument4;

var node = ds_grid_get(dungeon, xx, yy); node[dir] = type;
dungeon[# xx, yy] = node;

#define dungeon_cell_change_region
/// dungeon_cell_change_region(index, x, y, region)

var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var region = argument3;

var node = ds_grid_get(dungeon, xx, yy); node[5] = region;
dungeon[# xx, yy] = node;

#define dungeon_cell_change_type
/// dungeon_cell_change_type(index, x, y, type)

var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var type = argument3;

var node = ds_grid_get(dungeon, xx, yy); node[4] = type;
dungeon[# xx, yy] = node;

#define dungeon_cell_random_place
/// dungeon_cell_random_place(index, width, height, type, check)
// Returns coordinates

var dungeon = argument0;
var width = argument1;
var height = argument2;
var type = argument3;
var check = argument4;

var radius = sqrt(power(width, 2) + power(height, 2));

while (true) {
    var xx = irandom(width - 1) + 1;
    var yy = irandom(height - 1) + 1;
    
    var cell = dungeon[# xx, yy];
    
    if (cell[4] == REGULAR) {
        if (is_array(check)) {
            var dx = xx - check[0];
            var dy = yy - check[1];
            
            if (ceil(sqrt(power(dx, 2) + power(dy, 2))) >= ceil(radius)) {       
                dungeon_cell_change_type(dungeon, xx, yy, type);
                break;
            } else {
                radius -= width / height;
            }
        } else {         
            dungeon_cell_change_type(dungeon, xx, yy, type);
            break;
        }
    }
}

return array(xx, yy);

#define dungeon_create
/// dungeon_create(width, height, rooms list)

var width = argument0;
var height = argument1;
var rooms = argument2;

var dungeon = dungeon_setup(width, height);

if (rooms != -1) {
    var list = dungeon_rooms_init(dungeon, rooms);

    for (var i = 0; i < ds_list_size(list); i++) {

        var doors = ds_list_create();
        
        var rm = list[| i];
        var xx = rm[0];
        var yy = rm[1];
        var ww = rm[2];
        var hh = rm[3];
        
        for (var _x = 0; _x < ww; _x++) {
        
            var c1 = dungeon[# xx + _x, yy + hh];
            if (is_array(c1)) {
                ds_list_add(doors, array(xx + _x, yy + hh, 1));
            }
            
            var c2 = dungeon[# xx + _x, yy - 1];
            if (is_array(c2)) {
                ds_list_add(doors, array(xx + _x, yy - 1, 3));
            }
            
        }
            
        for (var _y = 0; _y < hh; _y++) {
        
            var c1 = dungeon[# xx - 1, yy + _y];
            if (is_array(c1)) {
                ds_list_add(doors, array(xx - 1, yy + _y, 0));
            }
            
            var c2 = dungeon[# xx + ww, yy + _y];
            if (is_array(c2)) {
                ds_list_add(doors, array(xx + ww, yy + _y, 2));
            }
            
        }
        
        dungeon_doors_create(dungeon, doors);
    }
}

for (var i = 1; i < width + 1; i++) {
    for (var j = 1; j < height + 1; j++) {
        if (dungeon[# i, j] == VOID) {
            dungeon_generate_maze(dungeon, i, j);
        }
    }
}

var region = 0;

for (var i = 1; i < width + 1; i++) {
    for (var j = 1; j < height + 1; j++) {
        var cell = dungeon[# i, j];
        
        if (cell[5] == -1) {
            dungeon_floodfill(dungeon, i, j, region++);
        }
    }
}

for (var n = 0; n < region; n++) {
    var doors = ds_list_create();
    
    for (var i = 1; i < width + 1; i++) {
        for (var j = 1; j < height + 1; j++) {

            var cell = dungeon[# i, j];
            
            if (cell[5] == n) {
                for (var dir = 0; dir < 4; dir++) {
                    var xdir = lengthdir_x(1, dir * 90);
                    var ydir = lengthdir_y(1, dir * 90);
                    
                    var nextcell = dungeon[# i + xdir, j + ydir];
                    
                    if (is_array(nextcell)) {
                        if (nextcell[5] != n) {
                            ds_list_add(doors, array(i, j, dir));
                        }
                    }
                }
            }
        }
    }
    
    dungeon_doors_create(dungeon, doors);
}

var entrance = dungeon_cell_random_place(dungeon, width, height, ENTRANCE, 0);
dungeon_cell_random_place(dungeon, width, height, EXIT, entrance);

ds_grid_set_grid_region(dungeon, dungeon, 1, 1, width, height, 0, 0);
ds_grid_resize(dungeon, width, height);

return dungeon;

#define dungeon_doors_create
/// dungeon_doors_create(index, doors)

var dungeon = argument0;
var doors = argument1;

ds_list_shuffle(doors);
    
for (var j = 0; j < clamp(irandom(3) + 1, 1, ds_list_size(doors) - 1); j++) {
    var door = doors[| j];
        
    var _x = door[0];
    var _y = door[1];
    var dir = door[2];
        
    var xdir = lengthdir_x(1, dir * 90);
    var ydir = lengthdir_y(1, dir * 90);
        
    dungeon_cell_add_direction(dungeon, _x, _y, dir, 1);        
    dungeon_cell_add_direction(dungeon, _x + xdir, _y + ydir, inverse_direction(dir), 1);
}

#define dungeon_draw
/// dungeon_draw(index, x, y, width of the dungeon, height of the dungeon)

var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var width = argument3;
var height = argument4;

for (var i = 0; i < width; i++) {
    for (var j = 0; j < height; j++) {
    
        var cell = dungeon[# i, j];
        
        if (is_array(cell)) {
            draw_sprite(sDungeonCells, cell[0] * 27 + cell[1] * 9 + cell[2] * 3 + cell[3], xx + i * 8, yy + j * 8);
            
            switch (cell[4]) {
                case ENTRANCE:
                    draw_sprite(sDungeonCells, 81, xx + i * 8, yy + j * 8);
                break;
                
                case EXIT:
                    draw_sprite(sDungeonCells, 82, xx + i * 8, yy + j * 8);
                break;
            }
        } else {
            draw_sprite(sDungeonCells, 0, xx + i * 8, yy + j * 8);
        }
    }
}

#define dungeon_floodfill
/// dungeon_floodfill(index, x, y, region) 

var count = 0;

var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var region = argument3;

var cell = dungeon[# xx, yy];
dungeon_cell_change_region(dungeon, xx, yy, region);

for (var dir = 0; dir < 4; dir++) {

    var xdir = lengthdir_x(1, dir * 90);
    var ydir = lengthdir_y(1, dir * 90);
        
    if (xx + xdir >= 0 && xx + xdir < ds_grid_width(dungeon) && yy + ydir >= 0 && yy + ydir < ds_grid_height(dungeon)) {
    
        var nextcell = dungeon[#xx + xdir, yy + ydir];
        
        if (cell[dir] != 0 && nextcell[inverse_direction(dir)] != 0 && nextcell[5] == -1) {
            count++;
            count += dungeon_floodfill(dungeon, xx + xdir, yy + ydir, region);
        }
    }    
}

return count;

#define dungeon_floodfill_restore
/// dungeon_floodfill_restore(index)

var dungeon = argument0;

for (var i = 0; i < ds_grid_width(dungeon) - 1; i++) {
    for (var j = 0; j < ds_grid_height(dungeon) - 1; j++) {
        var cell = dungeon[# i, j];    
    
        if (is_array(cell)) {
            if (cell[5] != -1) {
                dungeon_cell_change_region(dungeon, i, j, -1);
            }
        }
    }
}

#define dungeon_generate_maze
/// dungeon_generate_maze(index, x, y)

var nodes = ds_list_create();

var dungeon = argument0;
var xx = argument1;
var yy = argument2;

var dir, odir = -1;

dungeon[# xx, yy] = dungeon_cell(0, 0, 0, 0, REGULAR, -1);

while (true) {
    dir = irandom(3);
    
    var xdir = lengthdir_x(1, dir * 90);
    var ydir = lengthdir_y(1, dir * 90);
    
    if (dungeon[# xx + xdir, yy + ydir] == VOID) {
        
        ds_list_add(nodes, array(xx, yy));
        dungeon[# xx + xdir, yy + ydir] = dungeon_cell(0, 0, 0, 0, REGULAR, -1);
        
        if (dir == odir && with_a_chance(60)) {
            dungeon_cell_add_direction(dungeon, xx, yy, dir, 2);
            dungeon_cell_change_type(dungeon, xx, yy, HALL);
            dungeon_cell_add_direction(dungeon, xx + xdir, yy + ydir, inverse_direction(dir), 2);
            dungeon_cell_change_type(dungeon, xx + xdir, yy + ydir, HALL);
        } else {
            dungeon_cell_add_direction(dungeon, xx, yy, dir, 1);
            dungeon_cell_add_direction(dungeon, xx + xdir, yy + ydir, inverse_direction(dir), 1);
        }
        
        xx += xdir; yy += ydir;        
        odir = dir;
        
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
                
                odir = -1;
                
                break;
                
            } else {
                ds_list_delete(nodes, i);
            }
        }
        
        if (ds_list_empty(nodes)) { break; }
    }
}

#define dungeon_room_create
/// dungeon_room_create(index, x, y, width, height)

var dungeon = argument0;
var xx = argument1;
var yy = argument2;
var ww = argument3;
var hh = argument4;

for (var i = 1; i < ww - 1; i++) {
    for (var j = 1; j < hh - 1; j++) {
        dungeon[# xx + i, yy + j] = dungeon_cell(2, 2, 2, 2, ROOM, -1);
    }
}

for (var i = 1; i < ww - 1; i++) {
    dungeon[# xx + i, yy] = dungeon_cell(2, 0, 2, 2, ROOM, -1);
}

for (var i = 1; i < ww - 1; i++) {
    dungeon[# xx + i, yy + hh - 1] = dungeon_cell(2, 2, 2, 0, ROOM, -1);
}

for (var j = 1; j < hh - 1; j++) {
    dungeon[# xx, yy + j] = dungeon_cell(2, 2, 0, 2, ROOM, -1);
}

for (var j = 1; j < hh - 1; j++) {
    dungeon[# xx + ww - 1, yy + j] = dungeon_cell(0, 2, 2, 2, ROOM, -1);
}

dungeon[# xx, yy] = dungeon_cell(2, 0, 0, 2, ROOM, -1);
dungeon[# xx + ww - 1, yy] = dungeon_cell(0, 0, 2, 2, ROOM, -1);
dungeon[# xx, yy + hh - 1] = dungeon_cell(2, 2, 0, 0, ROOM, -1);
dungeon[# xx + ww - 1, yy + hh - 1] = dungeon_cell(0, 2, 2, 0, ROOM, -1);

#define dungeon_rooms_init
/// dungeon_rooms_init(index, list)
// Returns list of rooms coordinates

var list = ds_list_create();

var dungeon = argument0;
var rooms = argument1;

for (var i = 0; i < ds_list_size(rooms); i++) {
    var rm = rooms[| i];
    var width = rm[0];
    var height = rm[1];
    
    repeat(1000) {
    
        var empty = true;
    
        var xx = irandom(ds_grid_width(dungeon) - width - 2) + 1;
        var yy = irandom(ds_grid_height(dungeon) - height - 2) + 1;
        
        for (var _x = xx; _x < xx + width; _x++) {
            for (var _y = yy; _y < yy + height; _y++) {
            
                if (dungeon[# _x, _y] != BEDROCK && dungeon[# _x, _y] != VOID) {
                    empty = false; break;
                }
            }
            
            if (!empty) { break; }
        }
        
        if (empty) {
            dungeon_room_create(dungeon, xx, yy, width, height);
            ds_list_add(list, array(xx, yy, width, height));
            
            break;
        }
        
    }
}

return list;

#define dungeon_setup
/// dungeon_setup(width, height)

randomize();
// or somthing like random_set_seed(1234567890);

/// Dungeon properties
var width = argument0 + 2;
var height = argument1 + 2;

/// Create empty dungeon
var dungeon = ds_grid_create(width, height);

ds_grid_clear(dungeon, BEDROCK);
ds_grid_set_region(dungeon, 1, 1, width - 2, height - 2, VOID);

return dungeon;

#define inverse_direction
/// inverse_direction(direction)

var dir = argument0;

if (dir % 2 == 0) {
    return 2 - dir;
} else {
    return 4 - dir;
}

#define dungeon_cell
/// dungeon_cell(right, up, left, down, type, region)
/// This is script for initiating dungeon cell

return array(argument0, argument1, argument2, argument3, argument4, argument5);

#define dungeon_room
/// dungeon_room(width, height, type)
/// This is script for initiating dungeon room

return array(argument0, argument1, argument2);

#define dungeon_rooms_list
/// dungeon_rooms_list(room 1, room 2...)
/// This is script for initiating dungeon rooms list

var list = ds_list_create();

for (var i = 0; i < argument_count; i++) {
    var rooms = argument[i];    
    
    repeat(rooms[1]) {
        ds_list_add(list, rooms[0]);
    }
}

return list;