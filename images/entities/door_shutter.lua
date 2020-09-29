return {
	image = "entities/door_shutter.png",
	width = 32,
	height = 32,
	frametime = 0.15,
	animations = {
		idleclosed = { 1 },
		idleopen = { 8 },
		opening = { { from = 1, to = 8 } },
		closing = { { from = 8, to = 1 } }
	}
}