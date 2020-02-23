# LUA Table Library Extensions
SFramework expands upon some of the built-in LUA table library functionality.  Here, you can find reference for these additions.

# Contents
- [table](#table)
  - [indexOf](#tableindexof)
  
# table

## table.indexOf
Returns the index of the given value in the given table, or `0` if not found
### Arguments
- `t` - `table` (required) the table to search in
- `val` - `any` (required) the value to check for
### Example
```lua
local myTable = {2, 5, 4, 7, 1}
local index = table.indexOf(myTable, 4) --should return 3
```
