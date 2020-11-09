return {
	image = "entities/airlock_fill.png",
	width = 32,
	height = 32,
	frametime = 0.1,
	animations = {
		["atmos.idleclosed"]       = 1,
		["atmos.idleopen"]         = 6,
		["atmos.opening"]          = { from = 1, to = 6 },
		["atmos.closing"]          = { from = 6, to = 1 },

		["command.idleclosed"]     = 7,
		["command.idleopen"]       = 12,
		["command.opening"]        = { from = 7, to = 12 },
		["command.closing"]        = { from = 12, to = 7 },

		["engineering.idleclosed"] = 13,
		["engineering.idleopen"]   = 18,
		["engineering.opening"]    = { from = 13, to = 18 },
		["engineering.closing"]    = { from = 18, to = 13 },

		["external.idleclosed"]    = 19,
		["external.idleopen"]      = 24,
		["external.opening"]       = { from = 19, to = 24 },
		["external.closing"]       = { from = 24, to = 19 },

		["maintenance.idleclosed"] = 25,
		["maintenance.idleopen"]   = 30,
		["maintenance.opening"]    = { from = 25, to = 30 },
		["maintenance.closing"]    = { from = 30, to = 25 },

		["medical.idleclosed"]     = 31,
		["medical.idleopen"]       = 36,
		["medical.opening"]        = { from = 31, to = 36 },
		["medical.closing"]        = { from = 36, to = 31 },

		["mining.idleclosed"]      = 37,
		["mining.idleopen"]        = 42,
		["mining.opening"]         = { from = 37, to = 42 },
		["mining.closing"]         = { from = 42, to = 31 },

		["public.idleclosed"]      = 43,
		["public.idleopen"]        = 48,
		["public.opening"]         = { from = 43, to = 48 },
		["public.closing"]         = { from = 48, to = 43 },

		["public2.idleclosed"]     = 49,
		["public2.idleopen"]       = 54,
		["public2.opening"]        = { from = 49, to = 54 },
		["public2.closing"]        = { from = 54, to = 49 },

		["research.idleclosed"]    = 55,
		["research.idleopen"]      = 60,
		["research.opening"]       = { from = 55, to = 60 },
		["research.closing"]       = { from = 60, to = 55 },

		["science.idleclosed"]     = 61,
		["science.idleopen"]       = 66,
		["science.opening"]        = { from = 61, to = 66 },
		["science.closing"]        = { from = 66, to = 61 },

		["security.idleclosed"]    = 67,
		["security.idleopen"]      = 72,
		["security.opening"]       = { from = 67, to = 72 },
		["security.closing"]       = { from = 72, to = 67 },

		["virology.idleclosed"]    = 73,
		["virology.idleopen"]      = 78,
		["virology.opening"]       = { from = 73, to = 78 },
		["virology.closing"]       = { from = 78, to = 73 },

		["glass.idleclosed"]       = 79,
		["glass.idleopen"]         = 84,
		["glass.opening"]          = { from = 79, to = 84 },
		["glass.closing"]          = { from = 84, to = 79 },

		["glass2.idleclosed"]      = 85,
		["glass2.idleopen"]        = 90,
		["glass2.opening"]         = { from = 85, to = 90 },
		["glass2.closing"]         = { from = 90, to = 85 }
	}
}