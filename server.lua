-- Register Command for admin to give vehicle by name to player by ID
RegisterCommand('givecar', function(source, args, rawCommand)
    if QBCore.Functions.HasPermission(source, 'god') or IsPlayerAceAllowed(source, 'command') then
        local src = source
        local player = QBCore.Functions.GetPlayer(src)
        local target = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local car = args[2]
        local plate = args[3]

        if not player then
            TriggerClientEvent('QBCore:Notify', src, "Player not found! Usage: /givecar [targetId] [car] [plate]", 'error')
            return
        end

        if not target then
            TriggerClientEvent('QBCore:Notify', src, "Target not found! Usage: /givecar [targetId] [car] [plate]", 'error')
            return
        end

        if not car then
            TriggerClientEvent('QBCore:Notify', src, "Car not found! Usage: /givecar [targetId] [car] [plate]", 'error')
            return
        end

        if not plate then
            TriggerClientEvent('QBCore:Notify', src, "Plate not found! Usage: /givecar [targetId] [car] [plate]", 'error')
            return
        end

        local cid = target.PlayerData.citizenid

        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            player.PlayerData.license,
            cid,
            car,
            GetHashKey(car),
            '{}',
            plate,
            'pillboxgarage',
            1
        })
    else
        TriggerClientEvent('QBCore:Notify', src, "Permission Denied!", 'error')
    end
end)

TriggerEvent("chat:addSuggestion", "/givecar", "Admin Command to give player a car", new[]
{
    new { name="targetId", help="Target player's server ID" },
    new { name="car", help="Car spawn code to give" },
    new { name="plate", help="Car plate" }
});
