var spd = 4;

var nx = x + clamp(mouse_x - x, -spd, spd);
var ny = y + clamp(mouse_y - y, -spd, spd);

if (!place_meeting(nx, y, oSolid)) x = nx;
if (!place_meeting(x, ny, oSolid)) y = ny;

