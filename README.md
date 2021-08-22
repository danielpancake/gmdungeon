# gmdungeon
Dungeon-template creating asset for GameMaker: Studio 1.4 and GameMaker Studio 2 (pre 2.3)
### ```<!> This version is no longer supported by newest versions of GameMaker Studio due to syntax update <!>```
![Dungeon example animated](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example3.gif)

## Usage
### Basic dungeon
Create event:
```gml
var setup = dungeon_create(); // Basic dungeon's settings
dungeon = dungeon_generate(setup);
```

Draw event:
```gml
dungeon_draw(dungeon, 0, 0);
```

![Dungeon basic example](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example.png)

### Dungeon with rooms
Create event:
```gml
var setup = dungeon_create();
// Basically it's an array with parameters for dungeon generator
// Parameters can be changed with dungeon_set_* functions

var list = dungeon_create_rooms_list();
dungeon_add_room(list, dungeon_room(3, 3, BOSS_ROOM), 1);
dungeon_add_room(list, dungeon_room(3, 2, SHOP_ROOM), 1);

// And now apply list
dungeon_set_rooms_list(setup, list);

dungeon = dungeon_generate(setup);
```

Draw event:
```gml
dungeon_draw(dungeon, 0, 0);
```

![Dungeon with rooms advanced example](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example2.png)

### Wide corridors
We will use code from previous example and add dungeon_set_* functions

Create event:
```gml
var setup = dungeon_create();

var list = dungeon_create_rooms_list();
dungeon_add_room(list, dungeon_room(3, 3, BOSS_ROOM), 1);
dungeon_add_room(list, dungeon_room(3, 2, SHOP_ROOM), 1);

// Set the chance of connecting cells with hallways to 100%
dungeon_set_hallway_chance(setup, 100);

// Everything else is the same
dungeon_set_rooms_list(setup, list);

dungeon = dungeon_generate(setup);
```

Draw event:
```gml
dungeon_draw(dungeon, 0, 0);
```

![Dungeon with wide corridors advanced example](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example4.png)

### Cut dead ends
Create event:
```gml
var setup = dungeon_create();

var list = dungeon_create_rooms_list();
dungeon_add_room(list, dungeon_room(3, 3, BOSS_ROOM), 1);
dungeon_add_room(list, dungeon_room(3, 2, SHOP_ROOM), 1);

// This function will tell generator to cut 3 cells from every dead end.
// Empty cells will be filled with from 1 up to 3 treasure rooms by default.
// To change this range use dungeon_set_tresure_rooms function.
dungeon_set_deadend_cut_length(setup, 3);

dungeon_set_rooms_list(setup, list);

dungeon = dungeon_generate(setup);
```

Draw event:
```gml
dungeon_draw(dungeon, 0, 0);
```

![Dungeon with wide corridors advanced example](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example5.png)

### Using masks
Create new sprite `sMask` to say, 9x9 pixels, and draw a [white heart on black (or transparent) background](https://github.com/DanielPancake/gmdungeon/blob/master/assets/sMask.png).
Every white pixel indicates available cell's position to generate to. Any other pixel's color will indicate inaccessible cell.

Create event:
```gml
var setup = dungeon_create();

var list = dungeon_create_rooms_list();
dungeon_add_room(list, dungeon_room(3, 3, BOSS_ROOM), 1);
dungeon_add_room(list, dungeon_room(4, 2, SHOP_ROOM), 1);

dungeon_set_hallway_chance(setup, 100);
dungeon_set_rooms_list(setup, list);

// Change dungeon size to 9x9 cells
dungeon_set_size(setup, 9, 9);

// And apply mask
dungeon_set_mask(setup, sMask, 0);

dungeon = dungeon_generate(setup);
```

Draw event:
```gml
dungeon_draw(dungeon, 0, 0);
```

![Dungeon with heart advanced example](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example6.png)

Thank you for checking out this asset!

## Requirements
- GameMaker: Studio 1.4 or GameMaker Studio 2 (pre 2.3)

## Installation
### For GameMaker: Studio 1.4
Drag all scripts from `src/scripts` folder into your open game maker project, add `sDungeonCells_strip19.png` and `sDungeonRooms_strip13.png` files as a sprite strips, name them `sDungeonCells` and `sDungeonRooms`.
Delete `dungeon_macros.gml` script and then import `constants.txt` as macros.

### For GameMaker Studio 2 (below 2.3)
Drag all scripts from `src/scripts` folder into your open game maker project, add `sDungeonCells_strip19.png` and `sDungeonRooms_strip13.png` files as a sprite strips, name them `sDungeonCells` and `sDungeonRooms`.

Generated dungeon-template can be used to build full-sized dungeon (see docs in every script).

## License
gmdungeon is available under the MIT License. You may freely adapt and use this asset in commercial and non-commercial projects.
