local categoriesaj, categoriespj, categoriesd, categoriesmj, categoriesa, categoriesb, categoriesc, categoriest, categoriesv, categoriesvb = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
local vehiclesaj, vehiclespj, vehiclesd, vehiclesmj, vehiclesa, vehiclesb, vehiclesc, vehiclest, vehiclesv, vehiclesvb = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}

Citizen.CreateThread(function()
	local char = Config.Main.PlateLetters
	char = char + Config.Main.PlateNumbers
	if Config.Main.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('[esx_advancedvehicleshop] [^3WARNING^7] Plate character count reached, %s/8 characters!'):format(char))
	end
end)

function RemoveOwnedVehicle(plate)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
end

AddEventHandler('onResourceStart', function(resource)
	Wait(10000)
	if resource == GetCurrentResourceName() then
		if Config.Ambulance.Shop then
			mysqlAmbulance()
		end

		if Config.Police.Shop then
			mysqlPolice()
		end

		if Config.Division.Shop then
			mysqlDivision()
		end

		if Config.Mechanic.Shop then
			mysqlMechanic()
		end

		if Config.Aircraft.Shop then
			mysqlAircraft()
		end

		if Config.Boat.Shop then
			mysqlBoat()
		end

		if Config.Car.Shop then
			mysqlCar()
		end

		if Config.Truck.Shop then
			mysqlTruck()
		end

		if Config.VIP.Shop then
			mysqlVIP()
		end

		if Config.VIPBoat.Shop then
			mysqlVIPBoat()
		end
	end
end)

-- Ambulance Shop
function mysqlAmbulance()
	MySQL.Async.fetchAll('SELECT * FROM `vs_ambulance_categories`', {}, function(_categories)
		categoriesaj = _categories

		MySQL.Async.fetchAll('SELECT * FROM `vs_ambulance`', {}, function(_vehicles)
			vehiclesaj = _vehicles
			GetAmbulance(categoriesaj, vehiclesaj)
		end)
	end)
end

function GetAmbulance(categoriesaj, vehiclesaj)
	for k,v in ipairs(vehiclesaj) do
		for k2,v2 in ipairs(categoriesaj) do
			if v2.name == v.category then
				vehiclesaj[k].categoryLabel = v2.label
				break
			end
		end
	end

	-- send information after db has loaded
	TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesAJ', -1, categoriesaj)
	TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesAJ', -1, vehiclesaj)
end

ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesAJ', function(source, cb)
	cb(categoriesaj)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesAJ', function(source, cb)
	cb(vehiclesaj)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleAJ', function(source, cb, model, plate, name, image)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesaj) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @job, @category, @name, @image)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'car',
			['@job'] = 'ambulance',
			['@category'] = 'cars',
			['@name'] = name,
			['@image'] = image
		}, function(rowsChanged)
			xPlayer.showNotification(_U('ambulance_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleAJ', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesaj, 1 do
		if GetHashKey(vehiclesaj[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesaj[i].price / 100 * Config.Ambulance.ResellPerc)
			vehicleName = vehiclesaj[i].model
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
			else
				cb(false)
			end
		end)
	end
end)

-- Police Shop
function mysqlPolice()
	MySQL.Async.fetchAll('SELECT * FROM `vs_police_categories`', {}, function(_categories)
		categoriespj = _categories

		MySQL.Async.fetchAll('SELECT * FROM `vs_police`', {}, function(_vehicles)
			vehiclespj = _vehicles
			GetPolice(categoriespj, vehiclespj)
		end)
	end)
end

function GetPolice(categoriespj, vehiclespj)
	for k,v in ipairs(vehiclespj) do
		for k2,v2 in ipairs(categoriespj) do
			if v2.name == v.category then
				vehiclespj[k].categoryLabel = v2.label
				break
			end
		end
	end

	-- send information after db has loaded
	TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesPJ', -1, categoriespj)
	TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesPJ', -1, vehiclespj)
end

ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesPJ', function(source, cb)
	cb(categoriespj)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesPJ', function(source, cb)
	cb(vehiclespj)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehiclePJ', function(source, cb, model, plate, name, image)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclespj) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @job, @category, @name, @image)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'car',
			['@job'] = 'police',
			['@category'] = 'cars',
			['@name'] = name,
			['@image'] = image
		}, function(rowsChanged)
			xPlayer.showNotification(_U('police_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehiclePJ', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclespj, 1 do
		if GetHashKey(vehiclespj[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclespj[i].price / 100 * Config.Police.ResellPerc)
			vehicleName = vehiclespj[i].model
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
			else
				cb(false)
			end
		end)
	end
end)

-- Division Shop
function mysqlDivision()
	MySQL.Async.fetchAll('SELECT * FROM `vs_division_categories`', {}, function(_categories)
		categoriesd = _categories

		MySQL.Async.fetchAll('SELECT * FROM `vs_divisions`', {}, function(_vehicles)
			vehiclesd = _vehicles
			GetDivision(categoriesd, vehiclesd)
		end)
	end)
end

function GetDivision(categoriesd, vehiclesd)
	for k,v in ipairs(vehiclesd) do
		for k2,v2 in ipairs(categoriesd) do
			if v2.name == v.category then
				vehiclesd[k].categoryLabel = v2.label
				break
			end
		end
	end

	-- send information after db has loaded
	TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesD', -1, categoriesd)
	TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesD', -1, vehiclesd)
end

ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesD', function(source, cb)
	cb(categoriesd)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesD', function(source, cb)
	cb(vehiclesd)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleD', function(source, cb, model, plate, name, image)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesd) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		if xPlayer.job.name == 'ambulance' then
			if model == Config.Division.Heli1 then
				MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @job, @category, @name, @image)', {
					['@owner'] = xPlayer.identifier,
					['@plate'] = plate,
					['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
					['@type'] = 'aircraft',
					['@job'] = 'ambulance',
					['@category'] = 'helis',
					['@name'] = name,
					['@image'] = image
				}, function(rowsChanged)
					xPlayer.showNotification(_U('division_belongs', plate))
					cb(true)
				end)
			else
				MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @job, @category, @name, @image)', {
					['@owner'] = xPlayer.identifier,
					['@plate'] = plate,
					['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
					['@type'] = 'car',
					['@job'] = 'ambulance',
					['@category'] = 'cars',
					['@name'] = name,
					['@image'] = image
				}, function(rowsChanged)
					xPlayer.showNotification(_U('division_belongs', plate))
					cb(true)
				end)
			end
		elseif xPlayer.job.name == 'police' then
			if model == Config.Division.Heli1 then
				MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @job, @category, @name, @image)', {
					['@owner'] = xPlayer.identifier,
					['@plate'] = plate,
					['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
					['@type'] = 'aircraft',
					['@job'] = 'police',
					['@category'] = 'helis',
					['@name'] = name,
					['@image'] = image
				}, function(rowsChanged)
					xPlayer.showNotification(_U('division_belongs', plate))
					cb(true)
				end)
			else
				MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @job, @category, @name, @image)', {
					['@owner'] = xPlayer.identifier,
					['@plate'] = plate,
					['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
					['@type'] = 'car',
					['@job'] = 'police',
					['@category'] = 'cars',
					['@name'] = name,
					['@image'] = image
				}, function(rowsChanged)
					xPlayer.showNotification(_U('division_belongs', plate))
					cb(true)
				end)
			end
		end
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleD', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesd, 1 do
		if GetHashKey(vehiclesd[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesd[i].price / 100 * Config.Division.ResellPerc)
			vehicleName = vehiclesd[i].model
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
			else
				cb(false)
			end
		end)
	end
end)

-- Mechanic Shop
function mysqlMechanic()
	MySQL.Async.fetchAll('SELECT * FROM `vs_mecano_categories`', {}, function(_categories)
		categoriesmj = _categories

		MySQL.Async.fetchAll('SELECT * FROM `vs_mecano`', {}, function(_vehicles)
			vehiclesmj = _vehicles
			GetMechanic(categoriesmj, vehiclesmj)
		end)
	end)
end

function GetMechanic(categoriesmj, vehiclesmj)
	for k,v in ipairs(vehiclesmj) do
		for k2,v2 in ipairs(categoriesmj) do
			if v2.name == v.category then
				vehiclesmj[k].categoryLabel = v2.label
				break
			end
		end
	end

	-- send information after db has loaded
	TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesMJ', -1, categoriesmj)
	TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesMJ', -1, vehiclesmj)
end

ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesMJ', function(source, cb)
	cb(categoriesmj)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesMJ', function(source, cb)
	cb(vehiclesmj)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleMJ', function(source, cb, model, plate, name, image)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesmj) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @job, @category, @name, @image)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'car',
			['@job'] = 'mechanic',
			['@category'] = 'cars',
			['@name'] = name,
			['@image'] = image
		}, function(rowsChanged)
			xPlayer.showNotification(_U('mechanic_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleMJ', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesmj, 1 do
		if GetHashKey(vehiclesmj[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesmj[i].price / 100 * Config.Mechanic.ResellPerc)
			vehicleName = vehiclesmj[i].model
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
			else
				cb(false)
			end
		end)
	end
end)

-- Aircraft Shop
function mysqlAircraft()
	MySQL.Async.fetchAll('SELECT * FROM `vs_aircraft_categories`', {}, function(_categories)
		categoriesa = _categories

		MySQL.Async.fetchAll('SELECT * FROM `vs_aircrafts`', {}, function(_vehicles)
			vehiclesa = _vehicles
			GetAircraft(categoriesa, vehiclesa)
		end)
	end)
end

function GetAircraft(categoriesa, vehiclesa)
	for k,v in ipairs(vehiclesa) do
		for k2,v2 in ipairs(categoriesa) do
			if v2.name == v.category then
				vehiclesa[k].categoryLabel = v2.label
				break
			end
		end
	end

	-- send information after db has loaded
	TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesA', -1, categoriesa)
	TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesA', -1, vehiclesa)
end

ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesA', function(source, cb)
	cb(categoriesa)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesA', function(source, cb)
	cb(vehiclesa)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleA', function(source, cb, model, plate, category, name, image)
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

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @category, @name, @image)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'aircraft',
			['@category'] = category,
			['@name'] = name,
			['@image'] = image
		}, function(rowsChanged)
			xPlayer.showNotification(_U('aircraft_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleA', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesa, 1 do
		if GetHashKey(vehiclesa[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesa[i].price / 100 * Config.Aircraft.ResellPerc)
			vehicleName = vehiclesa[i].model
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
			else
				cb(false)
			end
		end)
	end
end)

-- Boat Shop
function mysqlBoat()
	MySQL.Async.fetchAll('SELECT * FROM `vs_boat_categories`', {}, function(_categories)
		categoriesb = _categories

		MySQL.Async.fetchAll('SELECT * FROM `vs_boats`', {}, function(_vehicles)
			vehiclesb = _vehicles
			GetBoat(categoriesb, vehiclesb)
		end)
	end)
end

function GetBoat(categoriesb, vehiclesb)
	for k,v in ipairs(vehiclesb) do
		for k2,v2 in ipairs(categoriesb) do
			if v2.name == v.category then
				vehiclesb[k].categoryLabel = v2.label
				break
			end
		end
	end

	-- send information after db has loaded
	TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesB', -1, categoriesb)
	TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesB', -1, vehiclesb)
end

ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesB', function(source, cb)
	cb(categoriesb)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesB', function(source, cb)
	cb(vehiclesb)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleB', function(source, cb, model, plate, category, name, image)
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

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @category, @name, @image)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'boat',
			['@category'] = category,
			['@name'] = name,
			['@image'] = image
		}, function(rowsChanged)
			xPlayer.showNotification(_U('boat_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleB', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesb, 1 do
		if GetHashKey(vehiclesb[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesb[i].price / 100 * Config.Boat.ResellPerc)
			vehicleName = vehiclesb[i].model
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
			else
				cb(false)
			end
		end)
	end
end)

-- Car Shop
function mysqlCar()
	MySQL.Async.fetchAll('SELECT * FROM `vs_car_categories`', {}, function(_categories)
		categoriesc = _categories

		MySQL.Async.fetchAll('SELECT * FROM `vs_cars`', {}, function(_vehicles)
			vehiclesc = _vehicles
			GetCar(categoriesc, vehiclesc)
		end)
	end)
end

function GetCar(categoriesc, vehiclesc)
	for k,v in ipairs(vehiclesc) do
		for k2,v2 in ipairs(categoriesc) do
			if v2.name == v.category then
				vehiclesc[k].categoryLabel = v2.label
				break
			end
		end
	end

	-- send information after db has loaded
	TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesC', -1, categoriesc)
	TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesC', -1, vehiclesc)
end

ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesC', function(source, cb)
	cb(categoriesc)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesC', function(source, cb)
	cb(vehiclesc)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleC', function(source, cb, model, plate, category, name, image)
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

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @category, @name, @image)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'car',
			['@category'] = category,
			['@name'] = name,
			['@image'] = image
		}, function(rowsChanged)
			xPlayer.showNotification(_U('car_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleC', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesc, 1 do
		if GetHashKey(vehiclesc[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesc[i].price / 100 * Config.Car.ResellPerc)
			vehicleName = vehiclesc[i].model
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
			else
				cb(false)
			end
		end)
	end
end)

-- Truck Shop
function mysqlTruck()
	MySQL.Async.fetchAll('SELECT * FROM `vs_truck_categories`', {}, function(_categories)
		categoriest = _categories

		MySQL.Async.fetchAll('SELECT * FROM `vs_trucks`', {}, function(_vehicles)
			vehiclest = _vehicles
			GetTruck(categoriest, vehiclest)
		end)
	end)
end

function GetTruck(categoriest, vehiclest)
	for k,v in ipairs(vehiclest) do
		for k2,v2 in ipairs(categoriest) do
			if v2.name == v.category then
				vehiclest[k].categoryLabel = v2.label
				break
			end
		end
	end

	-- send information after db has loaded
	TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesT', -1, categoriest)
	TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesT', -1, vehiclest)
end

ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesT', function(source, cb)
	cb(categoriest)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesT', function(source, cb)
	cb(vehiclest)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleT', function(source, cb, model, plate, category, name, image)
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

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @category, @name, @image)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'car',
			['@category'] = category,
			['@name'] = name,
			['@image'] = image
		}, function(rowsChanged)
			xPlayer.showNotification(_U('truck_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleT', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclest, 1 do
		if GetHashKey(vehiclest[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclest[i].price / 100 * Config.Truck.ResellPerc)
			vehicleName = vehiclest[i].model
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
			else
				cb(false)
			end
		end)
	end
end)

-- VIP Shop
function mysqlVIP()
	MySQL.Async.fetchAll('SELECT * FROM `vs_vip_categories`', {}, function(_categories)
		categoriesv = _categories

		MySQL.Async.fetchAll('SELECT * FROM `vs_vips`', {}, function(_vehicles)
			vehiclesv = _vehicles
			GetVIP(categoriesv, vehiclesv)
		end)
	end)
end

function GetVIP(categoriesv, vehiclesv)
	for k,v in ipairs(vehiclesv) do
		for k2,v2 in ipairs(categoriesv) do
			if v2.name == v.category then
				vehiclesv[k].categoryLabel = v2.label
				break
			end
		end
	end

	-- send information after db has loaded
	TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesV', -1, categoriesv)
	TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesV', -1, vehiclesv)
end

ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesV', function(source, cb)
	cb(categoriesv)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesV', function(source, cb)
	cb(vehiclesv)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleV', function(source, cb, model, plate, category, name, image)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesv) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @category, @name, @image)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'car',
			['@category'] = category,
			['@name'] = name,
			['@image'] = image
		}, function(rowsChanged)
			xPlayer.showNotification(_U('vip_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleV', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesv, 1 do
		if GetHashKey(vehiclesv[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesv[i].price / 100 * Config.VIP.ResellPerc)
			vehicleName = vehiclesv[i].model
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
			else
				cb(false)
			end
		end)
	end
end)

-- VIP Boat Shop
function mysqlVIPBoat()
	MySQL.Async.fetchAll('SELECT * FROM `vs_vipboat_categories`', {}, function(_categories)
		categoriesvb = _categories

		MySQL.Async.fetchAll('SELECT * FROM `vs_vipboats`', {}, function(_vehicles)
			vehiclesvb = _vehicles
			GetVIPBoat(categoriesvb, vehiclesvb)
		end)
	end)
end

function GetVIPBoat(categoriesvb, vehiclesvb)
	for k,v in ipairs(vehiclesvb) do
		for k2,v2 in ipairs(categoriesvb) do
			if v2.name == v.category then
				vehiclesvb[k].categoryLabel = v2.label
				break
			end
		end
	end

	-- send information after db has loaded
	TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesVB', -1, categoriesvb)
	TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesVB', -1, vehiclesvb)
end

ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesVB', function(source, cb)
	cb(categoriesvb)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesVB', function(source, cb)
	cb(vehiclesvb)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleVB', function(source, cb, model, plate, category, name, image)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesvb) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, category, name, image) VALUES (@owner, @plate, @vehicle, @type, @category, @name, @image)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'boat',
			['@category'] = category,
			['@name'] = name,
			['@image'] = image
		}, function(rowsChanged)
			xPlayer.showNotification(_U('vip_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleVB', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesvb, 1 do
		if GetHashKey(vehiclesvb[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesvb[i].price / 100 * Config.VIPBoat.ResellPerc)
			vehicleName = vehiclesvb[i].model
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
			else
				cb(false)
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

function getPlayerData(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local result = MySQL.Sync.fetchAll('SELECT `group` FROM `users` WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

	local group = result[1].group
	local data = {
		group = group
	}

	cb(data)
end

ESX.RegisterServerCallback('esx_advancedvehicleshop:getPlayerData', function(source, cb)
	getPlayerData(source, function(data)
		if data ~= nil then
			cb(data)
		end
	end)
end)
