return {
	image = "entities/door_blast.png",
	width = 32,
	height = 32,
	frametime = 0.1,
	animations = {
		idleclosed = 1,
		idleopen = 8,
		opening = {
			{ from = 2, to = 7 },
			{
				frameTime = 0.4,
				frames = 8
			}
		},
		closing = {
			{ from = 8, to = 3 },
			{
				frameTime = 0.4,
				frames = 2
			}
		}
	}
}