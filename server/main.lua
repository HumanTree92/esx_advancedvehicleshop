ESX = nil
local categoriesa, vehiclesa = {}, {}
local categoriesb, vehiclesb = {}, {}
local categoriesc, vehiclesc = {}, {}
local categoriest, vehiclest = {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if Config.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('[esx_advancedvehicleshop] [^3WARNING^7] Plate character count reached, %s/8 characters!'):format(char))
	end
end)

function RemoveOwnedVehicle(plate)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
end

MySQL.ready(function()
	if Config.UseAircraftShop then
		MySQL.Async.fetchAll('SELECT * FROM vs_aircraft_categories', {}, function(_categories)
			categoriesa = _categories

			MySQL.Async.fetchAll('SELECT * FROM vs_aircrafts', {}, function(_vehicles)
				vehiclesa = _vehicles

				for k,v in ipairs(vehiclesa) do
					for k2,v2 in ipairs(categoriesa) do
						if v2.name == v.category then
							vehiclesa[k].categoryLabel = v2.label
							break
						end
					end
				end

				-- send information after db has loaded, making sure everyone gets vehicle information
				TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesA', -1, categoriesa)
				TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesA', -1, vehiclesa)
			end)
		end)
	end

	if Config.UseBoatShop then
		MySQL.Async.fetchAll('SELECT * FROM vs_boat_categories', {}, function(_categories)
			categoriesb = _categories

			MySQL.Async.fetchAll('SELECT * FROM vs_boats', {}, function(_vehicles)
				vehiclesb = _vehicles

				for k,v in ipairs(vehiclesb) do
					for k2,v2 in ipairs(categoriesb) do
						if v2.name == v.category then
							vehiclesb[k].categoryLabel = v2.label
							break
						end
					end
				end

				-- send information after db has loaded, making sure everyone gets vehicle information
				TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesB', -1, categoriesb)
				TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesB', -1, vehiclesb)
			end)
		end)
	end

	if Config.UseCarShop then
		MySQL.Async.fetchAll('SELECT * FROM vs_car_categories', {}, function(_categories)
			categoriesc = _categories

			MySQL.Async.fetchAll('SELECT * FROM vs_cars', {}, function(_vehicles)
				vehiclesc = _vehicles

				for k,v in ipairs(vehiclesc) do
					for k2,v2 in ipairs(categoriesc) do
						if v2.name == v.category then
							vehiclesc[k].categoryLabel = v2.label
							break
						end
					end
				end

				-- send information after db has loaded, making sure everyone gets vehicle information
				TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesC', -1, categoriesc)
				TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesC', -1, vehiclesc)
			end)
		end)
	end

	if Config.UseTruckShop then
		MySQL.Async.fetchAll('SELECT * FROM vs_truck_categories', {}, function(_categories)
			categoriest = _categories

			MySQL.Async.fetchAll('SELECT * FROM vs_trucks', {}, function(_vehicles)
				vehiclest = _vehicles

				for k,v in ipairs(vehiclest) do
					for k2,v2 in ipairs(categoriest) do
						if v2.name == v.category then
							vehiclest[k].categoryLabel = v2.label
							break
						end
					end
				end

				-- send information after db has loaded, making sure everyone gets vehicle information
				TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesT', -1, categoriest)
				TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesT', -1, vehiclest)
			end)
		end)
	end
end)

-- Aircraft Shop
ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesA', function(source, cb)
	cb(categoriesa)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesA', function(source, cb)
	cb(vehiclesa)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleA', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesa) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'aircraft'
		}, function(rowsChanged)
			xPlayer.showNotification(_U('aircraft_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleA', function(source, cb, plate, model)
	local xPlayer, resellPrice = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesa, 1 do
		if GetHashKey(vehiclesa[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesa[i].price / 100 * Config.ResellPercentage)
			break
		end
	end

	if not resellPrice then
		print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate
		}, function(result)
			if result[1] then -- does the owner match?
				local vehicle = json.decode(result[1].vehicle)

				if vehicle.model == model then
					if vehicle.plate == plate then
						xPlayer.addMoney(resellPrice)
						RemoveOwnedVehicle(plate)
						cb(true)
					else
						print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
						cb(false)
					end
				else
					print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
					cb(false)
				end
			end
		end)
	end
end)

-- Boat Shop
ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesB', function(source, cb)
	cb(categoriesb)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesB', function(source, cb)
	cb(vehiclesb)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleB', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesb) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'boat'
		}, function(rowsChanged)
			xPlayer.showNotification(_U('boat_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleB', function(source, cb, plate, model)
	local xPlayer, resellPrice = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesb, 1 do
		if GetHashKey(vehiclesb[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesb[i].price / 100 * Config.ResellPercentage)
			break
		end
	end

	if not resellPrice then
		print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate
		}, function(result)
			if result[1] then -- does the owner match?
				local vehicle = json.decode(result[1].vehicle)

				if vehicle.model == model then
					if vehicle.plate == plate then
						xPlayer.addMoney(resellPrice)
						RemoveOwnedVehicle(plate)
						cb(true)
					else
						print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
						cb(false)
					end
				else
					print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
					cb(false)
				end
			end
		end)
	end
end)

-- Car Shop
ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesC', function(source, cb)
	cb(categoriesc)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesC', function(source, cb)
	cb(vehiclesc)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleC', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesc) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'car'
		}, function(rowsChanged)
			xPlayer.showNotification(_U('car_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleC', function(source, cb, plate, model)
	local xPlayer, resellPrice = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesc, 1 do
		if GetHashKey(vehiclesc[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesc[i].price / 100 * Config.ResellPercentage)
			break
		end
	end

	if not resellPrice then
		print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate
		}, function(result)
			if result[1] then -- does the owner match?
				local vehicle = json.decode(result[1].vehicle)

				if vehicle.model == model then
					if vehicle.plate == plate then
						xPlayer.addMoney(resellPrice)
						RemoveOwnedVehicle(plate)
						cb(true)
					else
						print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
						cb(false)
					end
				else
					print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
					cb(false)
				end
			end
		end)
	end
end)

-- Truck Shop
ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesT', function(source, cb)
	cb(categoriest)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesT', function(source, cb)
	cb(vehiclest)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleT', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclest) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'car'
		}, function(rowsChanged)
			xPlayer.showNotification(_U('truck_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleT', function(source, cb, plate, model)
	local xPlayer, resellPrice = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclest, 1 do
		if GetHashKey(vehiclest[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclest[i].price / 100 * Config.ResellPercentage)
			break
		end
	end

	if not resellPrice then
		print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate
		}, function(result)
			if result[1] then -- does the owner match?
				local vehicle = json.decode(result[1].vehicle)

				if vehicle.model == model then
					if vehicle.plate == plate then
						xPlayer.addMoney(resellPrice)
						RemoveOwnedVehicle(plate)
						cb(true)
					else
						print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
						cb(false)
					end
				else
					print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
					cb(false)
				end
			end
		end)
	end
end)

-- Shared
ESX.RegisterServerCallback('esx_advancedvehicleshop:isPlateTaken', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function(result)
		cb(result)
	end)
end)

RegisterNetEvent('esx_advancedvehicleshop:setJobVehicleState')
AddEventHandler('esx_advancedvehicleshop:setJobVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate AND job = @job', {
		['@stored'] = state,
		['@plate'] = plate,
		['@job'] = xPlayer.job.name
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('[esx_advancedvehicleshop] [^3WARNING^7] %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)
