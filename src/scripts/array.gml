/// @function array(val1, val2...)
/// @description Compatibility script for GameMaker: Studio 1
/// @returns Array with passed values
var a, c;

for (c = 0; c < argument_count; c++) {
    a[c] = argument[c];
}

return a;