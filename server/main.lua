ESX = exports["es_extended"]:getSharedObject()
-- Server
RegisterServerEvent('p_start:dodaj')
AddEventHandler('p_start:dodaj', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result[1] ~= nil then
            if result[1].kid == 0 then
                -- Dodaj przedmioty do ekwipunku gracza
                xPlayer.addInventoryItem('phone', 1)
                xPlayer.addInventoryItem('burger', 3)
                xPlayer.addInventoryItem('water', 3)
                xPlayer.addMoney(2500)

                -- Ustaw kid na 1
                MySQL.Async.execute('UPDATE users SET kid = 1 WHERE identifier = @identifier', {
                    ['@identifier'] = xPlayer.identifier
                })

                TriggerClientEvent('p_Notify:Notify', _source, "success", "Udane", "Odebrałeś bagarz")
            else
                TriggerClientEvent('p_Notify:Notify', _source, "error", "Odrzucono", "Już odebrałeś bagarz")
            end
        end
    end)
end)

RegisterServerEvent("p_start:pay")
AddEventHandler("p_start:pay", function(money)
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	--xPlayer.removeMoney(money)
end)
