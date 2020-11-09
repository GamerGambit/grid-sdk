return {
	image = "entities/door_shutter.png",
	width = 32,
	height = 32,
	frametime = 0.1,
	animations = {
		idleclosed = 1,
		idleopen = 8,
		opening = {
			{ from = 1, to = 7 },
			{
				frameTime = 0.4,
				frames = 8
			}
		},
		closing = {
			{ from = 8, to = 2 },
			{
				frameTime = 0.4,
				frames = 1
			}
		}
	}
}
