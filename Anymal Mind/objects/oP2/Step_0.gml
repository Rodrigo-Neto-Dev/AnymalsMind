
var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);
var cam_w = camera_get_view_width(view_camera[0]);
var cam_h = camera_get_view_height(view_camera[0]);






var spd = 4;

var nx = x + clamp(mouse_x - x, -spd, spd);
var ny = y + clamp(mouse_y - y, -spd, spd);

if (!place_meeting(nx, y, oSolid)) x = nx;
if (!place_meeting(x, ny, oSolid)) y = ny;


x = clamp(x, cam_x, cam_x + cam_w);
y = clamp(y, cam_y, cam_y + cam_h);