local QBCore = exports['qb-core']:GetCoreObject()

for itemName, jobs in pairs(Config.RestrictedItems.weapons) do
    QBCore.Functions.CreateUseableItem(itemName, function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player and Player.PlayerData.job and has_job(jobs, Player.PlayerData.job.name) then
            TriggerClientEvent('inventory:client:UseWeapon', source, itemName)
        else
            TriggerClientEvent('QBCore:Notify', source, "Bu eşyayı kullanma yetkiniz yok.", "error")
        end
    end)
end

for ammoName, jobs in pairs(Config.RestrictedItems.ammo) do
    QBCore.Functions.CreateUseableItem(ammoName, function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player and Player.PlayerData.job and has_job(jobs, Player.PlayerData.job.name) then
            TriggerClientEvent('weapons:client:AddAmmo', source, ammoName, 12)
        else
            TriggerClientEvent('QBCore:Notify', source, "Bu mermiyi kullanma yetkiniz yok.", "error")
        end
    end)
end

function has_job(jobList, job)
    for _, v in ipairs(jobList) do
        if v == job then
            return true
        end
    end
    return false
end
