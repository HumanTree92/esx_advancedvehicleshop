Config = {}
Config.Locale = 'en'

Config.DrawDistance = 100
Config.MarkerColor  = {r = 120, g = 120, b = 240}

Config.ResellPercentage = 50 -- The Resell % of Vehicles Sold | Example: $10,000 / 50% = $5,000 Back
Config.LicenseEnable    = true -- Requires licenses to buy Aircrafts, Boats, Cars, & Trucks.
Config.AircraftLicense  = 25000 -- Aircraft License Price
Config.BoatLicense      = 1000 -- Boat License Price

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Blips = {
	AircraftShop = {
		Coords  = vector3(-940.0, -2963.1, 18.8),
		Sprite  = 326, -- 90
		Display = 4,
		Scale   = 1.0
	},
	BoatShop = {
		Coords  = vector3(-714.3, -1297.3, 4.1),
		Sprite  = 326, -- 410
		Display = 4,
		Scale   = 1.0
	},
	CarShop = {
		Coords  = vector3(-33.7, -1102.0, 25.4),
		Sprite  = 326,
		Display = 4,
		Scale   = 1.0
	},
	TruckShop = {
		Coords  = vector3(900.4, -1155.0, 24.1),
		Sprite  = 326, -- 67
		Display = 4,
		Scale   = 1.0
	}
}

-- ShopEntering = Marker for Accessing Shop | ShopInside = Marker for Viewing Vehicles
-- ShopOutside = Marker for Purchasing Vehicles | ResellVehicle = Marker for Selling Vehicles

Config.Zones = {
	-- Aircraft Shop
	ShopEnteringAircraft = {
		Pos   = vector3(-940.0, -2963.1, 18.8),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = 1
	},
	ShopInsideAircraft = {
		Pos     = vector3(-1874.7, -3137.5, 14.9), -- vector3(-1075.0, -2933.2, 14.5),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 333.95, -- 59.9
		Type    = -1
	},
	ShopOutsideAircraft = {
		Pos     = vector3(-965.2, -2983.5, 14.5),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 59.9,
		Type    = -1
	},
	ResellVehicleAircraft = {
		Pos   = vector3(-1003.2, -2920.7, 12.9),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = 1
	},
	-- Boat Shop
	ShopEnteringBoat = {
		Pos   = vector3(-714.3, -1297.3, 4.1),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = 1
	},
	ShopInsideBoat = {
		Pos     = vector3(-716.1, -1350.7, -0.4),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 138.4,
		Type    = -1
	},
	ShopOutsideBoat = {
		Pos     = vector3(-717.7, -1339.2, -0.4),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 90.0,
		Type    = -1
	},
	ResellVehicleBoat = {
		Pos   = vector3(-725.3, -1327.8, -0.4),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = 1
	},
	-- Car Shop
	ShopEnteringCar = {
		Pos   = vector3(-33.7, -1102.0, 25.4),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = 1
	},
	ShopInsideCar = {
		Pos     = vector3(-47.5, -1097.2, 25.4),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = -20.0,
		Type    = -1
	},
	ShopOutsideCar = {
		Pos     = vector3(-26.8, -1083.5, 26.6),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 70.68,
		Type    = -1
	},
	ResellVehicleCar = {
		Pos   = vector3(-44.6, -1080.7, 25.6),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = 1
	},
	-- Truck Shop
	ShopEnteringTruck = {
		Pos   = vector3(900.4, -1155.0, 24.1),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = 1
	},
	ShopInsideTruck = {
		Pos     = vector3(927.5, -1226.8, 24.6),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 102.93,
		Type    = -1
	},
	ShopOutsideTruck = {
		Pos     = vector3(994.7, -1186.4, 24.5),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 93.19,
		Type    = -1
	},
	ResellVehicleTruck = {
		Pos   = vector3(879.2, -1168.5, 24.0),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = 1
	}
}
