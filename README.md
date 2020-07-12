# gmdungeon
Dungeon template creating asset for GameMaker: Studio 1.4 and GameMaker Studio 2 

![Dungeon example animated](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example3.gif)

## Usage
### Basic dungeon
Create event:
```gml
var setup = dungeon_create(); // Basic dungeon settings
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

### Cut deadends
Create event:
```gml
var setup = dungeon_create();

var list = dungeon_create_rooms_list();
dungeon_add_room(list, dungeon_room(3, 3, BOSS_ROOM), 1);
dungeon_add_room(list, dungeon_room(3, 2, SHOP_ROOM), 1);

// This function will tell generator to cut 3 cells from every deadend
// empty cells will be filled with from 1 up to 3 treasure rooms by default.
// To change this range use dungeon_set_tresure_rooms function.
dungeon_set_deadend_cut_length(setup, 3);

// Everything else is the same
dungeon_set_rooms_list(setup, list);

dungeon = dungeon_generate(setup);
```

Draw event:
```gml
dungeon_draw(dungeon, 0, 0);
```

![Dungeon with wide corridors advanced example](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example5.png)

## Requirements
- GameMaker: Studio 1.4 or GameMaker Studio 2

## Installation
### For GameMaker: Studio 1.4
Drag all scripts from `src/scripts` folder into your open game maker project, add `sDungeonCells_strip19.png` and `sDungeonRooms_strip13.png` files as a sprite strips, name them `sDungeonCells` and `sDungeonRooms`.
Delete `dungeon_macros.gml` script and then import `constants.txt` as macros.

### For GameMaker Studio 2
Drag all scripts from `src/scripts` folder into your open game maker project, add `sDungeonCells_strip19.png` and `sDungeonRooms_strip13.png` files as a sprite strips, name them `sDungeonCells` and `sDungeonRooms`.

Generated dungeon-template can be used to build full-sized dungeon (see docs in every script).

## License
gmdungeon is available under the MIT License. You may freely adapt and use this asset in commercial and non-commercial projects.

## TODO and ideas:
- Insert constant pregenerated areas in dungeon