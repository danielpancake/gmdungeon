# gmdungeon
Dungeon template creating library for GameMaker Studio 1.x

## Using
Create event:
```gml
dungeon_width = 4;
dungeon_height = 6;

// This is ds_grid that contains generated dungeon
dungeon = dungeon_create(dungeon_width, dungeon_height, 0);
```

Draw event:
```gml
// This code will draw the dungeon at (0, 0)
dungeon_draw(dungeon, 0, 0, dungeon_width, dungeon_height);
```

## Requirements
- GameMaker Studio 1.x

## Installation
Drag `gmdungeon.gml` into you open game maker project, add   file `sDungeonCells_strip83.png` as a sprite strip, name is `sDungeonCells` and import `constants.txt` as macros.

## License
gmdungeon is available under the MIT License. You may freely adapt and use this library in commercial and non-commercial projects.

## TODO: 
* add apidocs
* add examples