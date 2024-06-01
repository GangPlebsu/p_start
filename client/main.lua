local ESX = exports["es_extended"]:getSharedObject()

-- Client
Citizen.CreateThread(function()
exports["qtarget"]:AddBoxZone("p_start:qtarget", vector3(-1072.2681, -2835.7451, 14.8863), 0.5, 1, {
	name="p_start:qtarget",
	debugPoly=false,
	minZ=14.50,
	maxZ=14.55,
		}, {
		options = {
			{
				event = "p_start:client",
				icon = "fas fa-tshirt",
				label = _U("baga")
				-- label = "Odbiesz bagaż",
			},
		},
		distance = 2.0,
	})

	Citizen.Wait(5000)
end)

AddEventHandler('p_start:client', function(source, args)
    TriggerServerEvent('p_start:dodaj')
end)

local locped = vector3(-1032.9550, -2734.8232, 20.1693-1.00)
local heading = 109.0175
local ped = GetHashKey("a_m_y_smartcaspat_01")


Citizen.CreateThread(function()
    RequestModel(ped)
    while not HasModelLoaded(ped) do Citizen.Wait(1) end
    info = CreatePed(4, ped, locped, heading, false, false)

    SetEntityAsMissionEntity(info)
    SetPedDiesWhenInjured(info, false)
    SetEntityInvincible(info, true)
    SetPedFleeAttributes(info, 0, 0)
    SetBlockingOfNonTemporaryEvents(info, true)
    FreezeEntityPosition(info, true)
end)

exports['qtarget']:AddBoxZone("p_start:rower", vector3(-1032.9550, -2734.8232, 20.1693), 0.5, 1, {
	name="p_start:rower",
	debugPoly=false,
	minZ=20.10,
	maxZ=20.90,
		}, {
	options = {
		{
			event = "p_start:RentBMX",
			icon = "fas fa-hands",
			label = "Wypożycz BMX",
			num = 1,
		},
		{
			event = "p_start:RentSCORCHER",
			icon = "fas fa-hands",
			label = "Wypożycz SCORCHER",
			num = 2,
		},
		{
			event = "p_start:RentTRIBIKE",
			icon = "fas fa-hands",
			label = "Wypożycz TRIBIKE",

			num = 3,
		},
		{
            event = "teleport:toCoords",
            icon = "fas fa-rocket",
			label = "Przejć do Urzędu",

			num = 4,
		},
	},
	distance = 2
})

local bikes = {
	["p_start:RentBMX"] = 'bmx',
	["p_start:RentSCORCHER"] = 'scorcher',
	["p_start:RentTRIBIKE"] = 'tribike',
}

for event, bike in pairs(bikes) do
	RegisterNetEvent(event)
	AddEventHandler(event, function()
		TriggerServerEvent("p_start:pay", Config.Price)
		local coords = vector3(-1036.2969, -2735.3916, 20.1693)

		ESX.Game.SpawnVehicle(bike, coords, 0.0, function(vehicle)
			TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
			-- Config.notifyBike
			TriggerEvent("notify", "success", "Wypożyczalnia", 'Twój rower ' .. bike .. ' jest gotowy!')
		end)
	end)
end

RegisterNetEvent('teleport:toCoords')
AddEventHandler('teleport:toCoords', function()
	TriggerServerEvent("p_start:pay", Config.PriceTriBike)
	TriggerEvent("notify", "success", "Przenoszenie", "Jesteś w Urzędzie Pracy!!")
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, -1285.8789, -560.3805, 31.7122)
    SetEntityHeading(playerPed, 218.8998)
end)

