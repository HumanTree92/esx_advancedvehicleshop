local CurrentActionData, JobBlips = {}, {}
local CategoriesAJ, CategoriesPJ, CategoriesD, CategoriesMJ, CategoriesA, CategoriesB, CategoriesC, CategoriesT, CategoriesV, CategoriesVB = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
local VehiclesAJ, VehiclesPJ, VehiclesD, VehiclesMJ, VehiclesA, VehiclesB, VehiclesC, VehiclesT, VehiclesV, VehiclesVB = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, IsInMainMenu, YesAlready = false, false, false
local LastZone, CurrentAction, CurrentActionMsg, currentDisplayVehicle, CurrentVehicleData
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	if Config.Ambulance.Blips or Config.Police.Blips or Config.Mechanic.Blips then
		RefreshJobBlips()
	end

	Citizen.Wait(10000)

	if Config.Ambulance.Shop then
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getCategoriesAJ', function(categoriesaj)
			CategoriesAJ = categoriesaj
		end)

		ESX.TriggerServerCallback('esx_advancedvehicleshop:getVehiclesAJ', function(vehiclesaj)
			VehiclesAJ = vehiclesaj
		end)
	end

	if Config.Police.Shop then
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getCategoriesPJ', function(categoriespj)
			CategoriesPJ = categoriespj
		end)

		ESX.TriggerServerCallback('esx_advancedvehicleshop:getVehiclesPJ', function(vehiclespj)
			VehiclesPJ = vehiclespj
		end)
	end

	if Config.Division.Shop then
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getCategoriesD', function(categoriesd)
			CategoriesD = categoriesd
		end)

		ESX.TriggerServerCallback('esx_advancedvehicleshop:getVehiclesD', function(vehiclesd)
			VehiclesD = vehiclesd
		end)
	end

	if Config.Mechanic.Shop then
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getCategoriesMJ', function(categoriesmj)
			CategoriesMJ = categoriesmj
		end)

		ESX.TriggerServerCallback('esx_advancedvehicleshop:getVehiclesMJ', function(vehiclesmj)
			VehiclesMJ = vehiclesmj
		end)
	end

	if Config.Aircraft.Shop then
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getCategoriesA', function(categoriesa)
			CategoriesA = categoriesa
		end)

		ESX.TriggerServerCallback('esx_advancedvehicleshop:getVehiclesA', function(vehiclesa)
			VehiclesA = vehiclesa
		end)
	end

	if Config.Boat.Shop then
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getCategoriesB', function(categoriesb)
			CategoriesB = categoriesb
		end)

		ESX.TriggerServerCallback('esx_advancedvehicleshop:getVehiclesB', function(vehiclesb)
			VehiclesB = vehiclesb
		end)
	end

	if Config.Car.Shop then
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getCategoriesC', function(categoriesc)
			CategoriesC = categoriesc
		end)

		ESX.TriggerServerCallback('esx_advancedvehicleshop:getVehiclesC', function(vehiclesc)
			VehiclesC = vehiclesc
		end)
	end

	if Config.Truck.Shop then
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getCategoriesT', function(categoriest)
			CategoriesT = categoriest
		end)

		ESX.TriggerServerCallback('esx_advancedvehicleshop:getVehiclesT', function(vehiclest)
			VehiclesT = vehiclest
		end)
	end

	if Config.VIP.Shop then
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getCategoriesV', function(categoriesv)
			CategoriesV = categoriesv
		end)
		
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getVehiclesV', function(vehiclesv)
			VehiclesV = vehiclesv
		end)
	end

	if Config.VIPBoat.Shop then
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getCategoriesVB', function(categoriesvb)
			CategoriesVB = categoriesvb
		end)
		
		ESX.TriggerServerCallback('esx_advancedvehicleshop:getVehiclesVB', function(vehiclesvb)
			VehiclesVB = vehiclesvb
		end)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer

	if Config.Ambulance.Blips or Config.Police.Blips or Config.Division.Blips or Config.Mechanic.Blips then
		RefreshJobBlips()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job

	if Config.Ambulance.Blips or Config.Police.Blips or Config.Division.Blips or Config.Mechanic.Blips then
		DeleteJobBlips()
		RefreshJobBlips()
	end
end)

-- Ambulance Shop
RegisterNetEvent('esx_advancedvehicleshop:sendCategoriesAJ')
AddEventHandler('esx_advancedvehicleshop:sendCategoriesAJ', function(categoriesaj)
	CategoriesAJ = categoriesaj
end)

RegisterNetEvent('esx_advancedvehicleshop:sendVehiclesAJ')
AddEventHandler('esx_advancedvehicleshop:sendVehiclesAJ', function(vehiclesaj)
	VehiclesAJ = vehiclesaj
end)

-- Police Shop
RegisterNetEvent('esx_advancedvehicleshop:sendCategoriesPJ')
AddEventHandler('esx_advancedvehicleshop:sendCategoriesPJ', function(categoriespj)
	CategoriesPJ = categoriespj
end)

RegisterNetEvent('esx_advancedvehicleshop:sendVehiclesPJ')
AddEventHandler('esx_advancedvehicleshop:sendVehiclesPJ', function(vehiclespj)
	VehiclesPJ = vehiclespj
end)

-- Division Shop
RegisterNetEvent('esx_advancedvehicleshop:sendCategoriesD')
AddEventHandler('esx_advancedvehicleshop:sendCategoriesD', function(categoriesd)
	CategoriesD = categoriesd
end)

RegisterNetEvent('esx_advancedvehicleshop:sendVehiclesD')
AddEventHandler('esx_advancedvehicleshop:sendVehiclesD', function(vehiclesd)
	VehiclesD = vehiclesd
end)

-- Mechanic Shop
RegisterNetEvent('esx_advancedvehicleshop:sendCategoriesMJ')
AddEventHandler('esx_advancedvehicleshop:sendCategoriesMJ', function(categoriesmj)
	CategoriesMJ = categoriesmj
end)

RegisterNetEvent('esx_advancedvehicleshop:sendVehiclesMJ')
AddEventHandler('esx_advancedvehicleshop:sendVehiclesMJ', function(vehiclesmj)
	VehiclesMJ = vehiclesmj
end)

-- Aircraft Shop
RegisterNetEvent('esx_advancedvehicleshop:sendCategoriesA')
AddEventHandler('esx_advancedvehicleshop:sendCategoriesA', function(categoriesa)
	CategoriesA = categoriesa
end)

RegisterNetEvent('esx_advancedvehicleshop:sendVehiclesA')
AddEventHandler('esx_advancedvehicleshop:sendVehiclesA', function(vehiclesa)
	VehiclesA = vehiclesa
end)

-- Boat Shop
RegisterNetEvent('esx_advancedvehicleshop:sendCategoriesB')
AddEventHandler('esx_advancedvehicleshop:sendCategoriesB', function(categoriesb)
	CategoriesB = categoriesb
end)

RegisterNetEvent('esx_advancedvehicleshop:sendVehiclesB')
AddEventHandler('esx_advancedvehicleshop:sendVehiclesB', function(vehiclesb)
	VehiclesB = vehiclesb
end)

-- Car Shop
RegisterNetEvent('esx_advancedvehicleshop:sendCategoriesC')
AddEventHandler('esx_advancedvehicleshop:sendCategoriesC', function(categoriesc)
	CategoriesC = categoriesc
end)

RegisterNetEvent('esx_advancedvehicleshop:sendVehiclesC')
AddEventHandler('esx_advancedvehicleshop:sendVehiclesC', function(vehiclesc)
	VehiclesC = vehiclesc
end)

-- Truck Shop
RegisterNetEvent('esx_advancedvehicleshop:sendCategoriesT')
AddEventHandler('esx_advancedvehicleshop:sendCategoriesT', function(categoriest)
	CategoriesT = categoriest
end)

RegisterNetEvent('esx_advancedvehicleshop:sendVehiclesT')
AddEventHandler('esx_advancedvehicleshop:sendVehiclesT', function(vehiclest)
	VehiclesT = vehiclest
end)

-- VIP Shop
RegisterNetEvent('esx_advancedvehicleshop:sendCategoriesV')
AddEventHandler('esx_advancedvehicleshop:sendCategoriesV', function(categoriesv)
	CategoriesV = categoriesv
end)

RegisterNetEvent('esx_advancedvehicleshop:sendVehiclesV')
AddEventHandler('esx_advancedvehicleshop:sendVehiclesV', function(vehiclesv)
	VehiclesV = vehiclesv
end)

-- VIP Boat Shop
RegisterNetEvent('esx_advancedvehicleshop:sendCategoriesVB')
AddEventHandler('esx_advancedvehicleshop:sendCategoriesVB', function(categoriesvb)
	CategoriesVB = categoriesvb
end)

RegisterNetEvent('esx_advancedvehicleshop:sendVehiclesVB')
AddEventHandler('esx_advancedvehicleshop:sendVehiclesVB', function(vehiclesvb)
	VehiclesVB = vehiclesvb
end)

function DeleteDisplayVehicleInsideShop()
	local attempt = 0

	if currentDisplayVehicle and DoesEntityExist(currentDisplayVehicle) then
		while DoesEntityExist(currentDisplayVehicle) and not NetworkHasControlOfEntity(currentDisplayVehicle) and attempt < 100 do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(currentDisplayVehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(currentDisplayVehicle) and NetworkHasControlOfEntity(currentDisplayVehicle) then
			ESX.Game.DeleteVehicle(currentDisplayVehicle)
		end
	end
end

function StartShopRestriction()
	Citizen.CreateThread(function()
		while IsInMainMenu do
			Citizen.Wait(0)

			DisableControlAction(0, 75, true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end

-- Buy Ambulance Menu
function BuyAmbulanceMenu()
	if #VehiclesAJ == 0 then
		print('[esx_advancedvehicleshop] [^3ERROR^7] No Ambulance Vehicles Found!!!')
		return
	end

	IsInMainMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInsideAmbulance.Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #CategoriesAJ, 1 do
		vehiclesByCategory[CategoriesAJ[i].name] = {}
	end

	for i=1, #VehiclesAJ, 1 do
		if IsModelInCdimage(GetHashKey(VehiclesAJ[i].model)) then
			table.insert(vehiclesByCategory[VehiclesAJ[i].category], VehiclesAJ[i])
		else
			print(('[esx_advancedvehicleshop] [^3ERROR^7] Ambulance Vehicle "%s" does not exist'):format(VehiclesAJ[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

	for i=1, #CategoriesAJ, 1 do
		local category = CategoriesAJ[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.sort(options)

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #CategoriesAJ[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_buy', {
		title = _U('ambulance_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_confirm', {
			title = _U('buy_vehicle', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = GetConvar('esx_MenuAlign', 'top-left'),
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' and not YesAlready then
				YesAlready = true
				local generatedPlate = GeneratePlate()

				if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and ESX.PlayerData.job.grade_name == vehicleData.category then
					ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehicleAJ', function(success)
						if success then
							IsInMainMenu, YesAlready = false, false
							menu2.close()
							menu.close()
							DeleteDisplayVehicleInsideShop()

							ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutsideAmbulance.Pos, Config.Zones.ShopOutsideAmbulance.Heading, function(vehicle)
								TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
								SetVehicleNumberPlateText(vehicle, generatedPlate)

								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)
							end)
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end, vehicleData.model, generatedPlate, vehicleData.name)
				else
					ESX.ShowNotification(_U('your_rank'))
				end
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction = 'ambulance_menu'
		CurrentActionMsg = _U('ambulance_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEnteringAmbulance.Pos)

		IsInMainMenu, YesAlready = false, false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInsideAmbulance.Pos, Config.Zones.ShopInsideAmbulance.Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInsideAmbulance.Pos, Config.Zones.ShopInsideAmbulance.Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

-- Buy Police Menu
function BuyPoliceMenu()
	if #VehiclesPJ == 0 then
		print('[esx_advancedvehicleshop] [^3ERROR^7] No Police Vehicles Found!!!')
		return
	end

	IsInMainMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInsidePolice.Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #CategoriesPJ, 1 do
		vehiclesByCategory[CategoriesPJ[i].name] = {}
	end

	for i=1, #VehiclesPJ, 1 do
		if IsModelInCdimage(GetHashKey(VehiclesPJ[i].model)) then
			table.insert(vehiclesByCategory[VehiclesPJ[i].category], VehiclesPJ[i])
		else
			print(('[esx_advancedvehicleshop] [^3ERROR^7] Police Vehicle "%s" does not exist'):format(VehiclesPJ[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

	for i=1, #CategoriesPJ, 1 do
		local category = CategoriesPJ[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.sort(options)

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #CategoriesPJ[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_buy', {
		title = _U('police_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_confirm', {
			title = _U('buy_vehicle', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = GetConvar('esx_MenuAlign', 'top-left'),
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' and not YesAlready then
				YesAlready = true
				local generatedPlate = GeneratePlate()

				if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.grade_name == vehicleData.category then
					ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehiclePJ', function(success)
						if success then
							IsInMainMenu, YesAlready = false, false
							menu2.close()
							menu.close()
							DeleteDisplayVehicleInsideShop()

							ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutsidePolice.Pos, Config.Zones.ShopOutsidePolice.Heading, function(vehicle)
								TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
								SetVehicleNumberPlateText(vehicle, generatedPlate)

								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)
							end)
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end, vehicleData.model, generatedPlate, vehicleData.name)
				else
					ESX.ShowNotification(_U('your_rank'))
				end
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction = 'police_menu'
		CurrentActionMsg = _U('police_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEnteringPolice.Pos)

		IsInMainMenu, YesAlready = false, false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInsidePolice.Pos, Config.Zones.ShopInsidePolice.Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInsidePolice.Pos, Config.Zones.ShopInsidePolice.Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

-- Buy Division Menu
function BuyDivisionMenu()
	if #VehiclesD == 0 then
		print('[esx_advancedvehicleshop] [^3ERROR^7] No Division Vehicles Found!!!')
		return
	end

	IsInMainMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInsideDivision.Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #CategoriesD, 1 do
		vehiclesByCategory[CategoriesD[i].name] = {}
	end

	for i=1, #VehiclesD, 1 do
		if IsModelInCdimage(GetHashKey(VehiclesD[i].model)) then
			table.insert(vehiclesByCategory[VehiclesD[i].category], VehiclesD[i])
		else
			print(('[esx_advancedvehicleshop] [^3ERROR^7] Division Vehicle "%s" does not exist'):format(VehiclesD[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

	for i=1, #CategoriesD, 1 do
		local category = CategoriesD[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.sort(options)

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #CategoriesD[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'division_buy', {
		title = _U('division_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'division_confirm', {
			title = _U('buy_vehicle', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = GetConvar('esx_MenuAlign', 'top-left'),
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' and not YesAlready then
				YesAlready = true
				local generatedPlate = GeneratePlate()

				if vehicleData.model == Config.Division.Heli1 then
					ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehicleD', function(success)
						if success then
							IsInMainMenu, YesAlready = false, false
							menu2.close()
							menu.close()
							DeleteDisplayVehicleInsideShop()

							ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutsideDivisionHeli.Pos, Config.Zones.ShopOutsideDivisionHeli.Heading, function(vehicle)
								TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
								SetVehicleNumberPlateText(vehicle, generatedPlate)

								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)
							end)
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end, vehicleData.model, generatedPlate, vehicleData.name)
				else
					ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehicleD', function(success)
						if success then
							IsInMainMenu, YesAlready = false, false
							menu2.close()
							menu.close()
							DeleteDisplayVehicleInsideShop()

							ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutsideDivision.Pos, Config.Zones.ShopOutsideDivision.Heading, function(vehicle)
								TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
								SetVehicleNumberPlateText(vehicle, generatedPlate)

								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)
							end)
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end, vehicleData.model, generatedPlate, vehicleData.name)
				end
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction = 'division_menu'
		CurrentActionMsg = _U('division_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEnteringDivision.Pos)

		IsInMainMenu, YesAlready = false, false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInsideDivision.Pos, Config.Zones.ShopInsideDivision.Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInsideDivision.Pos, Config.Zones.ShopInsideDivision.Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

-- Buy Mechanic Menu
function BuyMechanicMenu()
	if #VehiclesMJ == 0 then
		print('[esx_advancedvehicleshop] [^3ERROR^7] No Mechanic Vehicles Found!!!')
		return
	end

	IsInMainMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInsideMechanic.Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #CategoriesMJ, 1 do
		vehiclesByCategory[CategoriesMJ[i].name] = {}
	end

	for i=1, #VehiclesMJ, 1 do
		if IsModelInCdimage(GetHashKey(VehiclesMJ[i].model)) then
			table.insert(vehiclesByCategory[VehiclesMJ[i].category], VehiclesMJ[i])
		else
			print(('[esx_advancedvehicleshop] [^3ERROR^7] Mechanic Vehicle "%s" does not exist'):format(VehiclesMJ[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

	for i=1, #CategoriesMJ, 1 do
		local category = CategoriesMJ[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.sort(options)

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #CategoriesMJ[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_buy', {
		title = _U('mechanic_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_confirm', {
			title = _U('buy_vehicle', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = GetConvar('esx_MenuAlign', 'top-left'),
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' and not YesAlready then
				YesAlready = true
				local generatedPlate = GeneratePlate()

				if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' and ESX.PlayerData.job.grade_name == vehicleData.category then
					ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehicleMJ', function(success)
						if success then
							IsInMainMenu, YesAlready = false, false
							menu2.close()
							menu.close()
							DeleteDisplayVehicleInsideShop()

							ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutsideMechanic.Pos, Config.Zones.ShopOutsideMechanic.Heading, function(vehicle)
								TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
								SetVehicleNumberPlateText(vehicle, generatedPlate)

								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)
							end)
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end
					end, vehicleData.model, generatedPlate, vehicleData.name)
				else
					ESX.ShowNotification(_U('your_rank'))
				end
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction = 'mechanic_menu'
		CurrentActionMsg = _U('mechanic_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEnteringMechanic.Pos)

		IsInMainMenu, YesAlready = false, false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInsideMechanic.Pos, Config.Zones.ShopInsideMechanic.Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInsideMechanic.Pos, Config.Zones.ShopInsideMechanic.Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

-- Buy Aircraft Menu
function BuyAircraftMenu()
	if #VehiclesA == 0 then
		print('[esx_advancedvehicleshop] [^3ERROR^7] No Aircrafts Found!!!')
		return
	end

	IsInMainMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInsideAircraft.Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #CategoriesA, 1 do
		vehiclesByCategory[CategoriesA[i].name] = {}
	end

	for i=1, #VehiclesA, 1 do
		if IsModelInCdimage(GetHashKey(VehiclesA[i].model)) then
			table.insert(vehiclesByCategory[VehiclesA[i].category], VehiclesA[i])
		else
			print(('[esx_advancedvehicleshop] [^3ERROR^7] Aircraft "%s" does not exist'):format(VehiclesA[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

	for i=1, #CategoriesA, 1 do
		local category = CategoriesA[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.sort(options)

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #CategoriesA[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'aircraft_buy', {
		title = _U('aircraft_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'aircraft_confirm', {
			title = _U('buy_vehicle', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = GetConvar('esx_MenuAlign', 'top-left'),
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' and not YesAlready then
				YesAlready = true
				local generatedPlate = GeneratePlate()

				ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehicleA', function(success)
					if success then
						IsInMainMenu, YesAlready = false, false
						menu2.close()
						menu.close()
						DeleteDisplayVehicleInsideShop()

						ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutsideAircraft.Pos, Config.Zones.ShopOutsideAircraft.Heading, function(vehicle)
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							SetVehicleNumberPlateText(vehicle, generatedPlate)

							FreezeEntityPosition(playerPed, false)
							SetEntityVisible(playerPed, true)
						end)
					else
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end, vehicleData.model, generatedPlate, vehicleData.category, vehicleData.name)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction = 'aircraft_menu'
		CurrentActionMsg = _U('aircraft_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEnteringAircraft.Pos)

		IsInMainMenu, YesAlready = false, false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInsideAircraft.Pos, Config.Zones.ShopInsideAircraft.Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInsideAircraft.Pos, Config.Zones.ShopInsideAircraft.Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

-- Buy Boat Menu
function BuyBoatMenu()
	if #VehiclesB == 0 then
		print('[esx_advancedvehicleshop] [^3ERROR^7] No Boats Found!!!')
		return
	end

	IsInMainMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInsideBoat.Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #CategoriesB, 1 do
		vehiclesByCategory[CategoriesB[i].name] = {}
	end

	for i=1, #VehiclesB, 1 do
		if IsModelInCdimage(GetHashKey(VehiclesB[i].model)) then
			table.insert(vehiclesByCategory[VehiclesB[i].category], VehiclesB[i])
		else
			print(('[esx_advancedvehicleshop] [^3ERROR^7] Boat "%s" does not exist'):format(VehiclesB[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

	for i=1, #CategoriesB, 1 do
		local category = CategoriesB[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.sort(options)

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #CategoriesB[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_buy', {
		title = _U('boat_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_confirm', {
			title = _U('buy_vehicle', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = GetConvar('esx_MenuAlign', 'top-left'),
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' and not YesAlready then
				YesAlready = true
				local generatedPlate = GeneratePlate()

				ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehicleB', function(success)
					if success then
						IsInMainMenu, YesAlready = false, false
						menu2.close()
						menu.close()
						DeleteDisplayVehicleInsideShop()

						ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutsideBoat.Pos, Config.Zones.ShopOutsideBoat.Heading, function(vehicle)
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							SetVehicleNumberPlateText(vehicle, generatedPlate)

							FreezeEntityPosition(playerPed, false)
							SetEntityVisible(playerPed, true)
						end)
					else
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end, vehicleData.model, generatedPlate, vehicleData.category, vehicleData.name)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction = 'boat_menu'
		CurrentActionMsg = _U('boat_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEnteringBoat.Pos)

		IsInMainMenu, YesAlready = false, false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInsideBoat.Pos, Config.Zones.ShopInsideBoat.Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInsideBoat.Pos, Config.Zones.ShopInsideBoat.Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

-- Buy Car Menu
function BuyCarMenu()
	if #VehiclesC == 0 then
		print('[esx_advancedvehicleshop] [^3ERROR^7] No Cars Found!!!')
		return
	end

	IsInMainMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInsideCar.Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #CategoriesC, 1 do
		vehiclesByCategory[CategoriesC[i].name] = {}
	end

	for i=1, #VehiclesC, 1 do
		if IsModelInCdimage(GetHashKey(VehiclesC[i].model)) then
			table.insert(vehiclesByCategory[VehiclesC[i].category], VehiclesC[i])
		else
			print(('[esx_advancedvehicleshop] [^3ERROR^7] Boat "%s" does not exist'):format(VehiclesC[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

	for i=1, #CategoriesC, 1 do
		local category = CategoriesC[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.sort(options)

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #CategoriesC[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_buy', {
		title = _U('car_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_confirm', {
			title = _U('buy_vehicle', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = GetConvar('esx_MenuAlign', 'top-left'),
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' and not YesAlready then
				YesAlready = true
				local generatedPlate = GeneratePlate()

				ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehicleC', function(success)
					if success then
						IsInMainMenu, YesAlready = false, false
						menu2.close()
						menu.close()
						DeleteDisplayVehicleInsideShop()

						ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutsideCar.Pos, Config.Zones.ShopOutsideCar.Heading, function(vehicle)
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							SetVehicleNumberPlateText(vehicle, generatedPlate)

							FreezeEntityPosition(playerPed, false)
							SetEntityVisible(playerPed, true)
						end)
					else
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end, vehicleData.model, generatedPlate, vehicleData.category, vehicleData.name)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction = 'car_menu'
		CurrentActionMsg = _U('car_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEnteringCar.Pos)

		IsInMainMenu, YesAlready = false, false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInsideCar.Pos, Config.Zones.ShopInsideCar.Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInsideCar.Pos, Config.Zones.ShopInsideCar.Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

-- Buy Truck Menu
function BuyTruckMenu()
	if #VehiclesT == 0 then
		print('[esx_advancedvehicleshop] [^3ERROR^7] No Trucks Found!!!')
		return
	end

	IsInMainMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInsideTruck.Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #CategoriesT, 1 do
		vehiclesByCategory[CategoriesT[i].name] = {}
	end

	for i=1, #VehiclesT, 1 do
		if IsModelInCdimage(GetHashKey(VehiclesT[i].model)) then
			table.insert(vehiclesByCategory[VehiclesT[i].category], VehiclesT[i])
		else
			print(('[esx_advancedvehicleshop] [^3ERROR^7] Truck "%s" does not exist'):format(VehiclesT[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

	for i=1, #CategoriesT, 1 do
		local category = CategoriesT[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.sort(options)

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #CategoriesT[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'truck_buy', {
		title = _U('truck_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'truck_confirm', {
			title = _U('buy_vehicle', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = GetConvar('esx_MenuAlign', 'top-left'),
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' and not YesAlready then
				YesAlready = true
				local generatedPlate = GeneratePlate()

				ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehicleT', function(success)
					if success then
						IsInMainMenu, YesAlready = false, false
						menu2.close()
						menu.close()
						DeleteDisplayVehicleInsideShop()

						ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutsideTruck.Pos, Config.Zones.ShopOutsideTruck.Heading, function(vehicle)
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							SetVehicleNumberPlateText(vehicle, generatedPlate)

							FreezeEntityPosition(playerPed, false)
							SetEntityVisible(playerPed, true)
						end)
					else
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end, vehicleData.model, generatedPlate, vehicleData.category, vehicleData.name)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction = 'truck_menu'
		CurrentActionMsg = _U('truck_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEnteringTruck.Pos)

		IsInMainMenu, YesAlready = false, false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInsideTruck.Pos, Config.Zones.ShopInsideTruck.Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInsideTruck.Pos, Config.Zones.ShopInsideTruck.Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

-- Buy VIP Menu
function BuyVIPMenu()
	if #VehiclesV == 0 then
		print('[esx_advancedvehicleshop] [^3ERROR^7] No VIP Vehicles Found!!!')
		return
	end

	IsInMainMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInsideVIP.Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #CategoriesV, 1 do
		vehiclesByCategory[CategoriesV[i].name] = {}
	end

	for i=1, #VehiclesV, 1 do
		if IsModelInCdimage(GetHashKey(VehiclesV[i].model)) then
			table.insert(vehiclesByCategory[VehiclesV[i].category], VehiclesV[i])
		else
			print(('[esx_advancedvehicleshop] [^3ERROR^7] VIP Vehicle "%s" does not exist'):format(VehiclesV[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

	for i=1, #CategoriesV, 1 do
		local category = CategoriesV[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.sort(options)

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #CategoriesV[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vip_buy', {
		title = _U('vip_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vip_confirm', {
			title = _U('buy_vehicle', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = GetConvar('esx_MenuAlign', 'top-left'),
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' and not YesAlready then
				YesAlready = true
				local generatedPlate = GeneratePlate()

				ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehicleV', function(success)
					if success then
						IsInMainMenu, YesAlready = false, false
						menu2.close()
						menu.close()
						DeleteDisplayVehicleInsideShop()

						ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutsideVIP.Pos, Config.Zones.ShopOutsideVIP.Heading, function(vehicle)
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							SetVehicleNumberPlateText(vehicle, generatedPlate)

							FreezeEntityPosition(playerPed, false)
							SetEntityVisible(playerPed, true)
						end)
					else
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end, vehicleData.model, generatedPlate, vehicleData.category, vehicleData.name)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction = 'vip_menu'
		CurrentActionMsg = _U('vip_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEnteringVIP.Pos)

		IsInMainMenu, YesAlready = false, false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInsideVIP.Pos, Config.Zones.ShopInsideVIP.Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInsideVIP.Pos, Config.Zones.ShopInsideVIP.Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

-- Buy VIP Boat Menu
function BuyVIPBoatMenu()
	if #VehiclesVB == 0 then
		print('[esx_advancedvehicleshop] [^3ERROR^7] No VIP Boats Found!!!')
		return
	end

	IsInMainMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInsideVIPBoat.Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #CategoriesVB, 1 do
		vehiclesByCategory[CategoriesVB[i].name] = {}
	end

	for i=1, #VehiclesVB, 1 do
		if IsModelInCdimage(GetHashKey(VehiclesVB[i].model)) then
			table.insert(vehiclesByCategory[VehiclesVB[i].category], VehiclesVB[i])
		else
			print(('[esx_advancedvehicleshop] [^3ERROR^7] VIP Boat "%s" does not exist'):format(VehiclesVB[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.name < b.name
		end)
	end

	for i=1, #CategoriesVB, 1 do
		local category = CategoriesVB[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.sort(options)

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #CategoriesVB[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vip_buy', {
		title = _U('vip_dealer'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vip_confirm', {
			title = _U('buy_vehicle', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = GetConvar('esx_MenuAlign', 'top-left'),
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' and not YesAlready then
				YesAlready = true
				local generatedPlate = GeneratePlate()

				ESX.TriggerServerCallback('esx_advancedvehicleshop:buyVehicleVB', function(success)
					if success then
						IsInMainMenu, YesAlready = false, false
						menu2.close()
						menu.close()
						DeleteDisplayVehicleInsideShop()

						ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutsideVIPBoat.Pos, Config.Zones.ShopOutsideVIPBoat.Heading, function(vehicle)
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							SetVehicleNumberPlateText(vehicle, generatedPlate)

							FreezeEntityPosition(playerPed, false)
							SetEntityVisible(playerPed, true)
						end)
					else
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end, vehicleData.model, generatedPlate, vehicleData.category, vehicleData.name)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction = 'vipb_menu'
		CurrentActionMsg = _U('vipb_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEnteringVIPBoat.Pos)

		IsInMainMenu, YesAlready = false, false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInsideVIPBoat.Pos, Config.Zones.ShopInsideVIPBoat.Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInsideVIPBoat.Pos, Config.Zones.ShopInsideVIPBoat.Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName(_U('shop_awaiting_model'))
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		BusyspinnerOff()
	end
end

-- Entered Marker
AddEventHandler('esx_advancedvehicleshop:hasEnteredMarker', function(zone)
	if zone == 'ShopEnteringAmbulance' then
		if Config.Ambulance.Shop then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
				CurrentAction = 'ambulance_menu'
				CurrentActionMsg = _U('ambulance_menu')
				CurrentActionData = {}
			end
		end
	elseif zone == 'ResellVehicleAmbulance' then
		if Config.Ambulance.Shop then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
				local playerPed = PlayerPedId()

				if IsPedSittingInAnyVehicle(playerPed) then
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					local vehicleData, model, resellPrice, plate

					if GetPedInVehicleSeat(vehicle, -1) == playerPed then
						for i=1, #VehiclesAJ, 1 do
							if GetHashKey(VehiclesAJ[i].model) == GetEntityModel(vehicle) then
								vehicleData = VehiclesAJ[i]
								break
							end
						end

						if vehicleData == nil then
							ESX.ShowNotification(_U('cant_sell'))
							Citizen.Wait(10000)
						else
							resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.Ambulance.ResellPerc)
							model = GetEntityModel(vehicle)
							plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

							CurrentAction = 'ambulance_resell'
							CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
							CurrentActionData = {vehicle = vehicle, label = vehicleData.name, price = resellPrice, model = model, plate = plate}
						end
					end
				end
			end
		end
	elseif zone == 'ShopEnteringPolice' then
		if Config.Police.Shop then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				CurrentAction = 'police_menu'
				CurrentActionMsg = _U('police_menu')
				CurrentActionData = {}
			end
		end
	elseif zone == 'ResellVehiclePolice' then
		if Config.Police.Shop then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				local playerPed = PlayerPedId()

				if IsPedSittingInAnyVehicle(playerPed) then
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					local vehicleData, model, resellPrice, plate

					if GetPedInVehicleSeat(vehicle, -1) == playerPed then
						for i=1, #VehiclesPJ, 1 do
							if GetHashKey(VehiclesPJ[i].model) == GetEntityModel(vehicle) then
								vehicleData = VehiclesPJ[i]
								break
							end
						end

						if vehicleData == nil then
							ESX.ShowNotification(_U('cant_sell'))
							Citizen.Wait(10000)
						else
							resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.Police.ResellPerc)
							model = GetEntityModel(vehicle)
							plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

							CurrentAction = 'police_resell'
							CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
							CurrentActionData = {vehicle = vehicle, label = vehicleData.name, price = resellPrice, model = model, plate = plate}
						end
					end
				end
			end
		end
	elseif zone == 'ShopEnteringDivision' then
		if Config.Division.Shop then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				CurrentAction = 'division_menu'
				CurrentActionMsg = _U('division_menu')
				CurrentActionData = {}
			end
		end
	elseif zone == 'ResellVehicleDivision' then
		if Config.Division.Shop then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				local playerPed = PlayerPedId()

				if IsPedSittingInAnyVehicle(playerPed) then
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					local vehicleData, model, resellPrice, plate

					if GetPedInVehicleSeat(vehicle, -1) == playerPed then
						for i=1, #VehiclesD, 1 do
							if GetHashKey(VehiclesD[i].model) == GetEntityModel(vehicle) then
								vehicleData = VehiclesD[i]
								break
							end
						end

						if vehicleData == nil then
							ESX.ShowNotification(_U('cant_sell'))
							Citizen.Wait(10000)
						else
							resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.Division.ResellPerc)
							model = GetEntityModel(vehicle)
							plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

							CurrentAction = 'division_resell'
							CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
							CurrentActionData = {vehicle = vehicle, label = vehicleData.name, price = resellPrice, model = model, plate = plate}
						end
					end
				end
			end
		end
	elseif zone == 'ResellVehicleDivisionHeli' then
		if Config.Division.Shop then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				local playerPed = PlayerPedId()

				if IsPedSittingInAnyVehicle(playerPed) then
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					local vehicleData, model, resellPrice, plate

					if GetPedInVehicleSeat(vehicle, -1) == playerPed then
						for i=1, #VehiclesD, 1 do
							if GetHashKey(VehiclesD[i].model) == GetEntityModel(vehicle) then
								vehicleData = VehiclesD[i]
								break
							end
						end

						if vehicleData == nil then
							ESX.ShowNotification(_U('cant_sell'))
							Citizen.Wait(10000)
						else
							resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.Division.ResellPerc)
							model = GetEntityModel(vehicle)
							plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

							CurrentAction = 'division_resell'
							CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
							CurrentActionData = {vehicle = vehicle, label = vehicleData.name, price = resellPrice, model = model, plate = plate}
						end
					end
				end
			end
		end
	elseif zone == 'ShopEnteringMechanic' then
		if Config.Mechanic.Shop then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
				CurrentAction = 'mechanic_menu'
				CurrentActionMsg = _U('mechanic_menu')
				CurrentActionData = {}
			end
		end
	elseif zone == 'ResellVehicleMechanic' then
		if Config.Mechanic.Shop then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
				local playerPed = PlayerPedId()

				if IsPedSittingInAnyVehicle(playerPed) then
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					local vehicleData, model, resellPrice, plate

					if GetPedInVehicleSeat(vehicle, -1) == playerPed then
						for i=1, #VehiclesMJ, 1 do
							if GetHashKey(VehiclesMJ[i].model) == GetEntityModel(vehicle) then
								vehicleData = VehiclesMJ[i]
								break
							end
						end

						if vehicleData == nil then
							ESX.ShowNotification(_U('cant_sell'))
							Citizen.Wait(10000)
						else
							resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.Mechanic.ResellPerc)
							model = GetEntityModel(vehicle)
							plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

							CurrentAction = 'mechanic_resell'
							CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
							CurrentActionData = {vehicle = vehicle, label = vehicleData.name, price = resellPrice, model = model, plate = plate}
						end
					end
				end
			end
		end
	elseif zone == 'ShopEnteringAircraft' then
		if Config.Aircraft.Shop then
			CurrentAction = 'aircraft_menu'
			CurrentActionMsg = _U('aircraft_menu')
			CurrentActionData = {}
		end
	elseif zone == 'ResellVehicleAircraft' then
		if Config.Aircraft.Shop then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local vehicleData, model, resellPrice, plate

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					for i=1, #VehiclesA, 1 do
						if GetHashKey(VehiclesA[i].model) == GetEntityModel(vehicle) then
							vehicleData = VehiclesA[i]
							break
						end
					end

					if vehicleData == nil then
						ESX.ShowNotification(_U('cant_sell'))
						Citizen.Wait(10000)
					else
						resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.Aircraft.ResellPerc)
						model = GetEntityModel(vehicle)
						plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

						CurrentAction = 'aircraft_resell'
						CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
						CurrentActionData = {vehicle = vehicle, label = vehicleData.name, price = resellPrice, model = model, plate = plate}
					end
				end
			end
		end
	elseif zone == 'ShopEnteringBoat' then
		if Config.Boat.Shop then
			CurrentAction = 'boat_menu'
			CurrentActionMsg = _U('boat_menu')
			CurrentActionData = {}
		end
	elseif zone == 'ResellVehicleBoat' then
		if Config.Boat.Shop then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local vehicleData, model, resellPrice, plate

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					for i=1, #VehiclesB, 1 do
						if GetHashKey(VehiclesB[i].model) == GetEntityModel(vehicle) then
							vehicleData = VehiclesB[i]
							break
						end
					end

					if vehicleData == nil then
						ESX.ShowNotification(_U('cant_sell'))
						Citizen.Wait(10000)
					else
						resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.Boat.ResellPerc)
						model = GetEntityModel(vehicle)
						plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

						CurrentAction = 'boat_resell'
						CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
						CurrentActionData = {vehicle = vehicle, label = vehicleData.name, price = resellPrice, model = model, plate = plate}
					end
				end
			end
		end
	elseif zone == 'ShopEnteringCar' then
		if Config.Car.Shop then
			CurrentAction = 'car_menu'
			CurrentActionMsg = _U('car_menu')
			CurrentActionData = {}
		end
	elseif zone == 'ResellVehicleCar' then
		if Config.Car.Shop then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local vehicleData, model, resellPrice, plate

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					for i=1, #VehiclesC, 1 do
						if GetHashKey(VehiclesC[i].model) == GetEntityModel(vehicle) then
							vehicleData = VehiclesC[i]
							break
						end
					end

					if vehicleData == nil then
						ESX.ShowNotification(_U('cant_sell'))
						Citizen.Wait(10000)
					else
						resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.Car.ResellPerc)
						model = GetEntityModel(vehicle)
						plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

						CurrentAction = 'car_resell'
						CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
						CurrentActionData = {vehicle = vehicle, label = vehicleData.name, price = resellPrice, model = model, plate = plate}
					end
				end
			end
		end
	elseif zone == 'ShopEnteringTruck' then
		if Config.Truck.Shop then
			CurrentAction = 'truck_menu'
			CurrentActionMsg = _U('truck_menu')
			CurrentActionData = {}
		end
	elseif zone == 'ResellVehicleTruck' then
		if Config.Truck.Shop then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local vehicleData, model, resellPrice, plate

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					for i=1, #VehiclesT, 1 do
						if GetHashKey(VehiclesT[i].model) == GetEntityModel(vehicle) then
							vehicleData = VehiclesT[i]
							break
						end
					end

					if vehicleData == nil then
						ESX.ShowNotification(_U('cant_sell'))
						Citizen.Wait(10000)
					else
						resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.Truck.ResellPerc)
						model = GetEntityModel(vehicle)
						plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

						CurrentAction = 'truck_resell'
						CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
						CurrentActionData = {vehicle = vehicle, label = vehicleData.name, price = resellPrice, model = model, plate = plate}
					end
				end
			end
		end
	elseif zone == 'ShopEnteringVIP' then
		if Config.VIP.Shop then
			CurrentAction = 'vip_menu'
			CurrentActionMsg = _U('vip_menu')
			CurrentActionData = {}
		end
	elseif zone == 'ResellVehicleVIP' then
		if Config.VIP.Shop then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local vehicleData, model, resellPrice, plate

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					for i=1, #VehiclesV, 1 do
						if GetHashKey(VehiclesV[i].model) == GetEntityModel(vehicle) then
							vehicleData = VehiclesV[i]
							break
						end
					end

					if vehicleData == nil then
						ESX.ShowNotification(_U('cant_sell'))
						Citizen.Wait(10000)
					else
						resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.VIP.ResellPerc)
						model = GetEntityModel(vehicle)
						plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

						CurrentAction = 'vip_resell'
						CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
						CurrentActionData = {vehicle = vehicle, label = vehicleData.name, price = resellPrice, model = model, plate = plate}
					end
				end
			end
		end
	elseif zone == 'ShopEnteringVIPBoat' then
		if Config.VIPBoat.Shop then
			CurrentAction = 'vipb_menu'
			CurrentActionMsg = _U('vipb_menu')
			CurrentActionData = {}
		end
	elseif zone == 'ResellVehicleVIPBoat' then
		if Config.VIPBoat.Shop then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local vehicleData, model, resellPrice, plate

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					for i=1, #VehiclesVB, 1 do
						if GetHashKey(VehiclesVB[i].model) == GetEntityModel(vehicle) then
							vehicleData = VehiclesVB[i]
							break
						end
					end

					if vehicleData == nil then
						ESX.ShowNotification(_U('cant_sell'))
						Citizen.Wait(10000)
					else
						resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.VIPBoat.ResellPerc)
						model = GetEntityModel(vehicle)
						plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

						CurrentAction = 'vipb_resell'
						CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
						CurrentActionData = {vehicle = vehicle, label = vehicleData.name, price = resellPrice, model = model, plate = plate}
					end
				end
			end
		end
	end
end)

-- Exited Marker
AddEventHandler('esx_advancedvehicleshop:hasExitedMarker', function(zone)
	if not IsInMainMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Resource Stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInMainMenu then
			ESX.UI.Menu.CloseAll()

			local playerPed = PlayerPedId()
			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
		end

		DeleteDisplayVehicleInsideShop()
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	if Config.Aircraft.Shop and Config.Aircraft.Blips then
		local blip = AddBlipForCoord(Config.Aircraft.Blip.Coords)

		SetBlipSprite (blip, Config.Aircraft.Blip.Sprite)
		SetBlipColour (blip, Config.Aircraft.Blip.Color)
		SetBlipDisplay(blip, Config.Aircraft.Blip.Display)
		SetBlipScale  (blip, Config.Aircraft.Blip.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('aircraft_dealer'))
		EndTextCommandSetBlipName(blip)
	end

	if Config.Boat.Shop and Config.Boat.Blips then
		local blip = AddBlipForCoord(Config.Boat.Blip.Coords)

		SetBlipSprite (blip, Config.Boat.Blip.Sprite)
		SetBlipColour (blip, Config.Boat.Blip.Color)
		SetBlipDisplay(blip, Config.Boat.Blip.Display)
		SetBlipScale  (blip, Config.Boat.Blip.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('boat_dealer'))
		EndTextCommandSetBlipName(blip)
	end

	if Config.Car.Shop and Config.Car.Blips then
		local blip = AddBlipForCoord(Config.Car.Blip.Coords)

		SetBlipSprite (blip, Config.Car.Blip.Sprite)
		SetBlipColour (blip, Config.Car.Blip.Color)
		SetBlipDisplay(blip, Config.Car.Blip.Display)
		SetBlipScale  (blip, Config.Car.Blip.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('car_dealer'))
		EndTextCommandSetBlipName(blip)
	end

	if Config.Truck.Shop and Config.Truck.Blips then
		local blip = AddBlipForCoord(Config.Truck.Blip.Coords)

		SetBlipSprite (blip, Config.Truck.Blip.Sprite)
		SetBlipColour (blip, Config.Truck.Blip.Color)
		SetBlipDisplay(blip, Config.Truck.Blip.Display)
		SetBlipScale  (blip, Config.Truck.Blip.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('truck_dealer'))
		EndTextCommandSetBlipName(blip)
	end

	if Config.VIP.Shop and Config.VIP.Blips then
		local blip = AddBlipForCoord(Config.VIP.Blip.Coords)

		SetBlipSprite (blip, Config.VIP.Blip.Sprite)
		SetBlipColour (blip, Config.VIP.Blip.Color)
		SetBlipDisplay(blip, Config.VIP.Blip.Display)
		SetBlipScale  (blip, Config.VIP.Blip.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('vip_dealer'))
		EndTextCommandSetBlipName(blip)
	end

	if Config.VIPBoat.Shop and Config.VIPBoat.Blips then
		local blip = AddBlipForCoord(Config.VIPBoat.Blip.Coords)

		SetBlipSprite (blip, Config.VIPBoat.Blip.Sprite)
		SetBlipColour (blip, Config.VIPBoat.Blip.Color)
		SetBlipDisplay(blip, Config.VIPBoat.Blip.Display)
		SetBlipScale  (blip, Config.VIPBoat.Blip.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('vip_dealer'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Handles Job Blips
function DeleteJobBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function RefreshJobBlips()
	if Config.Ambulance.Shop and Config.Ambulance.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			local blip = AddBlipForCoord(Config.Ambulance.Blip.Coords)

			SetBlipSprite (blip, Config.Ambulance.Blip.Sprite)
			SetBlipColour (blip, Config.Ambulance.Blip.Color)
			SetBlipDisplay(blip, Config.Ambulance.Blip.Display)
			SetBlipScale  (blip, Config.Ambulance.Blip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(_U('ambulance_dealer'))
			EndTextCommandSetBlipName(blip)
			table.insert(JobBlips, blip)
		end
	end

	if Config.Police.Shop and Config.Police.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			local blip = AddBlipForCoord(Config.Police.Blip.Coords)

			SetBlipSprite (blip, Config.Police.Blip.Sprite)
			SetBlipColour (blip, Config.Police.Blip.Color)
			SetBlipDisplay(blip, Config.Police.Blip.Display)
			SetBlipScale  (blip, Config.Police.Blip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(_U('police_dealer'))
			EndTextCommandSetBlipName(blip)
			table.insert(JobBlips, blip)
		end
	end

	if Config.Division.Shop and Config.Division.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			local blip = AddBlipForCoord(Config.Division.Blip.Coords)

			SetBlipSprite (blip, Config.Division.Blip.Sprite)
			SetBlipColour (blip, Config.Division.Blip.Color)
			SetBlipDisplay(blip, Config.Division.Blip.Display)
			SetBlipScale  (blip, Config.Division.Blip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(_U('division_dealer'))
			EndTextCommandSetBlipName(blip)
			table.insert(JobBlips, blip)
		end
	end

	if Config.Mechanic.Shop and Config.Mechanic.Blips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			local blip = AddBlipForCoord(Config.Mechanic.Blip.Coords)

			SetBlipSprite (blip, Config.Mechanic.Blip.Sprite)
			SetBlipColour (blip, Config.Mechanic.Blip.Color)
			SetBlipDisplay(blip, Config.Mechanic.Blip.Display)
			SetBlipScale  (blip, Config.Mechanic.Blip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(_U('police_dealer'))
			EndTextCommandSetBlipName(blip)
			table.insert(JobBlips, blip)
		end
	end
end

-- Enter / Exit marker events & Draw Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, true

		for k,v in pairs(Config.Zones) do
			local distance = #(playerCoords - v.Pos)

			if distance < Config.Main.DrawDistance then
				letSleep = false

				if v.Type ~= -1 then
					if v.ShopId == 1 then
						if Config.Ambulance.Shop then
							if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
								DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
							end
						end
					end

					if v.ShopId == 2 then
						if Config.Police.Shop then
							if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
								DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
							end
						end
					end

					if v.ShopId == 3 then
						if Config.Division.Shop then
							if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
								DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
							end
						end
					end

					if v.ShopId == 4 then
						if Config.Mechanic.Shop then
							if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
								DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
							end
						end
					end

					if v.ShopId == 5 then
						if Config.Aircraft.Shop then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
						end
					end

					if v.ShopId == 6 then
						if Config.Boat.Shop then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
						end
					end

					if v.ShopId == 7 then
						if Config.Car.Shop then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
						end
					end

					if v.ShopId == 8 then
						if Config.Truck.Shop then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
						end
					end

					if v.ShopId == 9 then
						if Config.VIP.Shop then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
						end
					end

					if v.ShopId == 10 then
						if Config.VIPBoat.Shop then
							DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, nil, nil, false)
						end
					end
				end

				if distance < v.Size.x then
					isInMarker, currentZone = true, k
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			LastZone = currentZone
			TriggerEvent('esx_advancedvehicleshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_advancedvehicleshop:hasExitedMarker', LastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'ambulance_menu' then
					if Config.Ambulance.Shop then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
							if Config.Ambulance.License then
								ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
									if hasdriverLicense then
										BuyAmbulanceMenu()
									else
										ESX.ShowNotification(_U('car_missing'))
									end
								end, GetPlayerServerId(PlayerId()), 'drive')
							else
								BuyAmbulanceMenu()
							end
						end
					end
				elseif CurrentAction == 'ambulance_resell' then
					if Config.Ambulance.Shop then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
							ESX.TriggerServerCallback('esx_advancedvehicleshop:resellVehicleAJ', function(vehicleSold)
								if vehicleSold then
									ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
									ESX.ShowNotification(_U('sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
								else
									ESX.ShowNotification(_U('not_yours'))
								end
							end, CurrentActionData.plate, CurrentActionData.model)
						end
					end
				elseif CurrentAction == 'police_menu' then
					if Config.Police.Shop then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
							if Config.Police.License then
								ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
									if hasdriverLicense then
										BuyPoliceMenu()
									else
										ESX.ShowNotification(_U('car_missing'))
									end
								end, GetPlayerServerId(PlayerId()), 'drive')
							else
								BuyPoliceMenu()
							end
						end
					end
				elseif CurrentAction == 'police_resell' then
					if Config.Police.Shop then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
							ESX.TriggerServerCallback('esx_advancedvehicleshop:resellVehiclePJ', function(vehicleSold)
								if vehicleSold then
									ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
									ESX.ShowNotification(_U('sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
								else
									ESX.ShowNotification(_U('not_yours'))
								end
							end, CurrentActionData.plate, CurrentActionData.model)
						end
					end
				elseif CurrentAction == 'division_menu' then
					if Config.Division.Shop then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
							if Config.Division.License then
								ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
									if hasdriverLicense then
										BuyDivisionMenu()
									else
										ESX.ShowNotification(_U('car_missing'))
									end
								end, GetPlayerServerId(PlayerId()), 'drive')
							else
								BuyDivisionMenu()
							end
						end
					end
				elseif CurrentAction == 'division_resell' then
					if Config.Division.Shop then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
							ESX.TriggerServerCallback('esx_advancedvehicleshop:resellVehicleD', function(vehicleSold)
								if vehicleSold then
									ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
									ESX.ShowNotification(_U('sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
								else
									ESX.ShowNotification(_U('not_yours'))
								end
							end, CurrentActionData.plate, CurrentActionData.model)
						end
					end
				elseif CurrentAction == 'mechanic_menu' then
					if Config.Mechanic.Shop then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
							if Config.Mechanic.License then
								ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
									if hasdriverLicense then
										BuyMechanicMenu()
									else
										ESX.ShowNotification(_U('truck_missing'))
									end
								end, GetPlayerServerId(PlayerId()), 'drive_truck')
							else
								BuyMechanicMenu()
							end
						end
					end
				elseif CurrentAction == 'mechanic_resell' then
					if Config.Mechanic.Shop then
						if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
							ESX.TriggerServerCallback('esx_advancedvehicleshop:resellVehicleMJ', function(vehicleSold)
								if vehicleSold then
									ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
									ESX.ShowNotification(_U('sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
								else
									ESX.ShowNotification(_U('not_yours'))
								end
							end, CurrentActionData.plate, CurrentActionData.model)
						end
					end
				elseif CurrentAction == 'aircraft_menu' then
					if Config.Aircraft.Shop then
						if Config.Aircraft.License then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasAircraftLicense)
								if hasAircraftLicense then
									BuyAircraftMenu()
								else
									ESX.ShowNotification(_U('aircraft_missing'))
									ESX.ShowNotification(_U('go_to'))
								end
							end, GetPlayerServerId(PlayerId()), 'aircraft')
						else
							BuyAircraftMenu()
						end
					end
				elseif CurrentAction == 'aircraft_resell' then
					if Config.Aircraft.Shop then
						ESX.TriggerServerCallback('esx_advancedvehicleshop:resellVehicleA', function(vehicleSold)
							if vehicleSold then
								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
								ESX.ShowNotification(_U('sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
							else
								ESX.ShowNotification(_U('not_yours'))
							end
						end, CurrentActionData.plate, CurrentActionData.model)
					end
				elseif CurrentAction == 'boat_menu' then
					if Config.Boat.Shop then
						if Config.Boat.License then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasBoatingLicense)
								if hasBoatingLicense then
									BuyBoatMenu()
								else
									ESX.ShowNotification(_U('boat_missing'))
									ESX.ShowNotification(_U('go_to'))
								end
							end, GetPlayerServerId(PlayerId()), 'boating')
						else
							BuyBoatMenu()
						end
					end
				elseif CurrentAction == 'boat_resell' then
					if Config.Boat.Shop then
						ESX.TriggerServerCallback('esx_advancedvehicleshop:resellVehicleB', function(vehicleSold)
							if vehicleSold then
								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
								ESX.ShowNotification(_U('sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
							else
								ESX.ShowNotification(_U('not_yours'))
							end
						end, CurrentActionData.plate, CurrentActionData.model)
					end
				elseif CurrentAction == 'car_menu' then
					if Config.Car.Shop then
						if Config.Car.License then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
								if hasdriverLicense then
									BuyCarMenu()
								else
									ESX.ShowNotification(_U('car_missing'))
								end
							end, GetPlayerServerId(PlayerId()), 'drive')
						else
							BuyCarMenu()
						end
					end
				elseif CurrentAction == 'car_resell' then
					if Config.Car.Shop then
						ESX.TriggerServerCallback('esx_advancedvehicleshop:resellVehicleC', function(vehicleSold)
							if vehicleSold then
								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
								ESX.ShowNotification(_U('sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
							else
								ESX.ShowNotification(_U('not_yours'))
							end
						end, CurrentActionData.plate, CurrentActionData.model)
					end
				elseif CurrentAction == 'truck_menu' then
					if Config.Truck.Shop then
						if Config.Truck.License then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasCommercialLicense)
								if hasCommercialLicense then
									BuyTruckMenu()
								else
									ESX.ShowNotification(_U('truck_missing'))
								end
							end, GetPlayerServerId(PlayerId()), 'drive_truck')
						else
							BuyTruckMenu()
						end
					end
				elseif CurrentAction == 'truck_resell' then
					if Config.Truck.Shop then
						ESX.TriggerServerCallback('esx_advancedvehicleshop:resellVehicleT', function(vehicleSold)
							if vehicleSold then
								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
								ESX.ShowNotification(_U('sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
							else
								ESX.ShowNotification(_U('not_yours'))
							end
						end, CurrentActionData.plate, CurrentActionData.model)
					end
				elseif CurrentAction == 'vip_menu' then
					if Config.VIP.Shop then
						if Config.VIP.License then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasdriverLicense)
								if hasdriverLicense then
									BuyVIPMenu()
								else
									ESX.ShowNotification(_U('car_missing'))
								end
							end, GetPlayerServerId(PlayerId()), 'drive')
						else
							BuyVIPMenu()
						end
					end
				elseif CurrentAction == 'vip_resell' then
					if Config.VIP.Shop then
						ESX.TriggerServerCallback('esx_advancedvehicleshop:resellVehicleV', function(vehicleSold)
							if vehicleSold then
								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
								ESX.ShowNotification(_U('sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
							else
								ESX.ShowNotification(_U('not_yours'))
							end
						end, CurrentActionData.plate, CurrentActionData.model)
					end
				elseif CurrentAction == 'vipb_menu' then
					if Config.VIPBoat.Shop then
						if Config.VIPBoat.License then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasBoatingLicense)
								if hasBoatingLicense then
									BuyVIPBoatMenu()
								else
									ESX.ShowNotification(_U('boat_missing'))
								end
							end, GetPlayerServerId(PlayerId()), 'boating')
						else
							BuyVIPBoatMenu()
						end
					end
				elseif CurrentAction == 'vipb_resell' then
					if Config.VIPBoat.Shop then
						ESX.TriggerServerCallback('esx_advancedvehicleshop:resellVehicleVB', function(vehicleSold)
							if vehicleSold then
								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
								ESX.ShowNotification(_U('sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
							else
								ESX.ShowNotification(_U('not_yours'))
							end
						end, CurrentActionData.plate, CurrentActionData.model)
					end
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	RequestIpl('shr_int') -- Load walls and floor

	local interiorID = 7170
	LoadInterior(interiorID)
	EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window
	RefreshInterior(interiorID)
end)
