return {
	image = "entities/door_blast.png",
	width = 32,
	height = 32,
	frametime = 0.15,
	animations = {
		idleclosed = { 1 },
		idleopen = { 8 },
		opening = { 2, 2, { from = 2, to = 8 } },
		closing = { { from = 8, to = 2 } }
	}
}