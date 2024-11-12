local QBCore = exports['qb-core']:GetCoreObject()

-- Araç kullanım sınırlaması
CreateThread(function()
    while true do
        local player = PlayerPedId()
        local veh = GetVehiclePedIsIn(player, false)

        if veh ~= 0 and GetPedInVehicleSeat(veh, -1) == player then
            local vehModel = GetEntityModel(veh)
            local vehName = GetDisplayNameFromVehicleModel(vehModel):lower()
            local PlayerData = QBCore.Functions.GetPlayerData()
            local jobName = PlayerData.job and PlayerData.job.name

            -- Eğer oyuncunun bir işi yoksa veya tanımlanmamışsa, sınırlı araçları sürmesine izin vermeyin
            if jobName and Config.RestrictedVehicles[jobName] then
                if not has_value(Config.RestrictedVehicles[jobName], vehName) then
                    QBCore.Functions.Notify("Bu aracı sürme yetkiniz yok.", "error")
                    TaskLeaveVehicle(player, veh, 16) -- Oyuncuyu araçtan çıkar
                end
            elseif Config.RestrictedVehicles["police"] and has_value(Config.RestrictedVehicles["police"], vehName) then
                -- Eğer meslek "police" değilse, polisi sınırlı araçları kullanamasın
                QBCore.Functions.Notify("Bu aracı sürme yetkiniz yok.", "error")
                TaskLeaveVehicle(player, veh, 16)
            end
        end
        Wait(1000) -- 1 saniye bekletme
    end
end)

-- Silah kullanım sınırlaması
CreateThread(function()
    while true do
        local player = PlayerPedId()
        local weapon = GetSelectedPedWeapon(player)
        local PlayerData = QBCore.Functions.GetPlayerData()
        local jobName = PlayerData.job and PlayerData.job.name

        -- Sınırlı bir silah mı kontrol edin
        for restrictedWeapon, allowedJobs in pairs(Config.RestrictedItems.weapons) do
            if GetHashKey(restrictedWeapon) == weapon then
                -- Oyuncunun mesleği, bu silahı çekmeye yetkili mi kontrol et
                if jobName and not has_job(allowedJobs, jobName) then
                    -- Yetkisi yoksa, silahı kaldır ve uyarı ver
                    RemoveWeaponFromPed(player, weapon)
                    QBCore.Functions.Notify("Bu silahı çekme yetkiniz yok.", "error")
                end
            end
        end
        Wait(500) -- Her 0.5 saniyede bir kontrol et
    end
end)

-- Meslek doğrulama fonksiyonu
function has_job(jobList, job)
    for _, v in ipairs(jobList) do
        if v == job then
            return true
        end
    end
    return false
end

-- Bir değerin tabloda olup olmadığını kontrol eden yardımcı fonksiyon
function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end
