return {
	image = "images/entities/airlocks.png",
	width = 32,
	height = 32,
	frametime = 0.15,
	animations = {
		["atmos.idleclosed"]   = { 1 },
		["atmos.idleopen"] = { 6 },
		["atmos.opening"]    = { { from = 1, to = 6 } },
		["atmos.closing"]    = { { from = 6, to = 1 } },

		["command.idleclosed"]   = { 9 },
		["command.idleopen"] = { 14 },
		["command.opening"]    = { { from = 9, to = 14 } },
		["command.closing"]    = { { from = 14, to = 9 } },

		["engineering.idleclosed"]   = { 17 },
		["engineering.idleopen"] = { 22 },
		["engineering.opening"]    = { { from = 17, to = 22 } },
		["engineering.closing"]    = { { from = 22, to = 17 } },

		["external.idleclosed"]   = { 25 },
		["external.idleopen"] = { 30 },
		["external.opening"]    = { { from = 25, to = 30 } },
		["external.closing"]    = { { from = 30, to = 25 } },

		["maintenance.idleclosed"]   = { 33 },
		["maintenance.idleopen"] = { 38 },
		["maintenance.opening"]    = { { from = 33, to = 38 } },
		["maintenance.closing"]    = { { from = 38, to = 33 } },

		["medical.idleclosed"]   = { 41 },
		["medical.idleopen"] = { 46 },
		["medical.opening"]    = { { from = 41, to = 46 } },
		["medical.closing"]    = { { from = 46, to = 41 } },

		["mining.idleclosed"]   = { 49 },
		["mining.idleopen"] = { 54 },
		["mining.opening"]    = { { from = 49, to = 54 } },
		["mining.closing"]    = { { from = 54, to = 49 } },

		["public.idleclosed"]   = { 57 },
		["public.idleopen"] = { 62 },
		["public.opening"]    = { { from = 57, to = 62 } },
		["public.closing"]    = { { from = 62, to = 57 } },

		["public2.idleclosed"]   = { 65 },
		["public2.idleopen"] = { 70 },
		["public2.opening"]    = { { from = 65, to = 70 } },
		["public2.closing"]    = { { from = 70, to = 65 } },

		["research.idleclosed"]   = { 73 },
		["research.idleopen"] = { 78 },
		["research.opening"]    = { { from = 73, to = 78 } },
		["research.closing"]    = { { from = 78, to = 73 } },

		["science.idleclosed"]   = { 81 },
		["science.idleopen"] = { 86 },
		["science.opening"]    = { { from = 81, to = 86 } },
		["science.closing"]    = { { from = 86, to = 81 } },

		["security.idleclosed"]   = { 89 },
		["security.idleopen"] = { 94 },
		["security.opening"]    = { { from = 89, to = 94 } },
		["security.closing"]    = { { from = 94, to = 89 } },

		["virology.idleclosed"]   = { 97 },
		["virology.idleopen"] = { 102 },
		["virology.opening"]    = { { from = 97, to = 102 } },
		["virology.closing"]    = { { from = 102, to = 97 } },

		["hatch.idleclosed"]   = { 105 },
		["hatch.idleopen"] = { 110 },
		["hatch.opening"]    = { { from = 105, to = 110 } },
		["hatch.closing"]    = { { from = 110, to = 105 } },

		["hatch_maintenance.idleclosed"]   = { 113 },
		["hatch_maintenance.idleopen"] = { 118 },
		["hatch_maintenance.opening"]    = { { from = 113, to = 118 } },
		["hatch_maintenance.closing"]    = { { from = 118, to = 113 } },

		["highsecurity.idleclosed"]   = { 121 },
		["highsecurity.idleopen"] = { 128 },
		["highsecurity.opening"]    = { { from = 121, to = 128 } },
		["highsecurity.closing"]    = { { from = 128, to = 121 } },

		["vault.idleclosed"]   = { 129 },
		["vault.idleopen"] = { 134 },
		["vault.opening"]    = { { from = 129, to = 134 } },
		["vault.closing"]    = { { from = 134, to = 129 } }
	}
}