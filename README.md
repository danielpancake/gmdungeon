# gmdungeon
Dungeon template creating library for GameMaker Studio 1.x

## Usage
### Basic dungeon
Create event:
```gml
dungeon_width = 4;
dungeon_height = 6;

// This is ds_grid that contains generated dungeon
dungeon = dungeon_create(dungeon_width, dungeon_height, -1);
```

Draw event:
```gml
// This code will draw the dungeon at (0, 0)
dungeon_draw(dungeon, 0, 0, dungeon_width, dungeon_height);
```

![Dungeon example](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example.png)

### Dungeon with rooms
Create event:
```gml
dungeon_width = 6;
dungeon_height = 6;

// Let's create list of rooms for dungeon
var list = dungeon_room_list_create();
dungeon_room_list_add(list, dungeon_room(2, 3, REGULAR), 1);

dungeon = dungeon_create(dungeon_width, dungeon_height, list);
```

Draw event:
```gml
// This code will draw the dungeon at (0, 0)
dungeon_draw(dungeon, 0, 0, dungeon_width, dungeon_height);
```

![Dungeon advanced example](https://github.com/DanielPancake/gmdungeon/raw/master/assets/example2.png)

## Requirements
- GameMaker Studio 1.x

## Installation
Drag `gmdungeon.gml` into you open game maker project, add   file `sDungeonCells_strip83.png` as a sprite strip, name is `sDungeonCells` and import `constants.txt` as macros.

Generated dungeon template can be used to build full-sized dungeon (see documentation).

## License
gmdungeon is available under the MIT License. You may freely adapt and use this library in commercial and non-commercial projects.

## TODO:
* documentation
* memory cleanup