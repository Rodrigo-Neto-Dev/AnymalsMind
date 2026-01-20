y -= float_speed;
x += random_range(-1, 1);

image_yscale -= 0.025;
image_xscale = image_yscale;

time_to_live -= 1;
if (time_to_live <= 0 || image_yscale <= 0) {
	instance_destroy();
}