local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    while true do
        local player = PlayerPedId()
        local veh = GetVehiclePedIsIn(player, false)

        if veh ~= 0 and GetPedInVehicleSeat(veh, -1) == player then
            local vehModel = GetEntityModel(veh)
            local vehName = GetDisplayNameFromVehicleModel(vehModel):lower()
            local PlayerData = QBCore.Functions.GetPlayerData()
            local jobName = PlayerData.job and PlayerData.job.name

            if jobName and Config.RestrictedVehicles[jobName] then
                if not has_value(Config.RestrictedVehicles[jobName], vehName) then
                    QBCore.Functions.Notify("Bu aracı sürme yetkiniz yok.", "error")
                    TaskLeaveVehicle(player, veh, 16) -- Oyuncuyu araçtan çıkar
                end
            elseif Config.RestrictedVehicles["police"] and has_value(Config.RestrictedVehicles["police"], vehName) then
                QBCore.Functions.Notify("Bu aracı sürme yetkiniz yok.", "error")
                TaskLeaveVehicle(player, veh, 16)
            end
        end
        Wait(1000) -- 1 saniye bekletme
    end
end)

CreateThread(function()
    while true do
        local player = PlayerPedId()
        local weapon = GetSelectedPedWeapon(player)
        local PlayerData = QBCore.Functions.GetPlayerData()
        local jobName = PlayerData.job and PlayerData.job.name

        for restrictedWeapon, allowedJobs in pairs(Config.RestrictedItems.weapons) do
            if GetHashKey(restrictedWeapon) == weapon then
                if jobName and not has_job(allowedJobs, jobName) then
                    RemoveWeaponFromPed(player, weapon)
                    QBCore.Functions.Notify("Bu silahı çekme yetkiniz yok.", "error")
                end
            end
        end
        Wait(500)
    end
end)

function has_job(jobList, job)
    for _, v in ipairs(jobList) do
        if v == job then
            return true
        end
    end
    return false
end

function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end
