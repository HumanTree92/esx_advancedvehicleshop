-- To have this work with esx_lscustom you must edit
ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		MySQL.Async.fetchAll('SELECT * FROM vs_cars', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)

-- New Fix
ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		MySQL.Async.fetchAll('SELECT model, price FROM vs_ambulance UNION SELECT model, price FROM vs_police UNION SELECT model, price FROM vs_aircrafts UNION SELECT model, price FROM vs_boats UNION SELECT model, price FROM vs_cars UNION SELECT model, price FROM vs_trucks UNION SELECT model, price FROM vs_vips;', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)

-- Old Fix
ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if not Vehicles then
	    local vehicles = {}

		-- Get Ambulance Vehicles
		MySQL.Async.fetchAll('SELECT * FROM vs_ambulance', {}, function(result)
			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end
		end)

		-- Get Police Vehicles
		MySQL.Async.fetchAll('SELECT * FROM vs_police', {}, function(result)
			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end
		end)

		-- Get Aircrafts
		MySQL.Async.fetchAll('SELECT * FROM vs_aircrafts', {}, function(result)
			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end
		end)

		-- Get Boats
		MySQL.Async.fetchAll('SELECT * FROM vs_boats', {}, function(result)
			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end
		end)

		-- Get Cars
		MySQL.Async.fetchAll('SELECT * FROM vs_cars', {}, function(result)
			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end
		end)

		-- Get Trucks
		MySQL.Async.fetchAll('SELECT * FROM vs_trucks', {}, function(result)
			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end
		end)

		-- Get VIPS
		MySQL.Async.fetchAll('SELECT * FROM vs_vips', {}, function(result)
			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles 
			cb(Vehicles)             
		end)
	else
		cb(Vehicles)
	end
end)