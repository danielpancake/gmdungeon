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

![Dungeon example](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example.png)

### Dungeon with rooms
Create event:
```gml
var setup = dungeon_create(); // Basic dungeon settings
// Basically it's an array with parameters for dungeon generator
// Parameters can be changed with dungeon_set_* functions

var list = dungeon_create_rooms_list();
dungeon_add_room(list, dungeon_room(2, 3, REGULAR), 1);

// And now apply rooms list
dungeon_set_rooms_list(setup, list);

dungeon = dungeon_generate(setup);
```

Draw event:
```gml
dungeon_draw(dungeon, 0, 0);
```

![Dungeon advanced example](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example2.png)

## Requirements
- GameMaker: Studio 1.4 or GameMaker Studio 2

## Installation
### For GameMaker: Studio 1.4
Drag all scripts from `src/scripts` folder into your open game maker project, add `sDungeonCells_strip17.png` and `sDungeonRooms_strip13.png` files as a sprite strip, name them `sDungeonCells` and `sDungeonRooms`.
Delete `dungeon_macros.gml` script and then import `constants.txt` as macros.

### For GameMaker Studio 2
Drag all scripts from `src/scripts` folder into your open game maker project, add `sDungeonCells_strip17.png` and `sDungeonRooms_strip13.png` files as a sprite strip, name them `sDungeonCells` and `sDungeonRooms`.

Generated dungeon's template can be used to build full-sized dungeon (see docs in every script).

## License
gmdungeon is available under the MIT License. You may freely adapt and use this asset in commercial and non-commercial projects.
