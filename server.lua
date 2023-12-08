local framework 
local Player 

if config.framework.qb then 
    framework = exports['qb-core']:GetCoreObject()
    Player = function(src)
        return framework.Functions.GetPlayer(src)
    end
elseif config.framework.esx then
    framework = exports['es_extended']:getSharedObject()
    Player = function(src)
        return framework.GetPlayerFromId(src)
    end
elseif config.framework.custom then 
    framework = exports['custom-framework']:GetCoreObject() -- edit if using custom framework
    Player = function(src)
        return framework.GetPlayerFromId(src)
    end
end

function ItemCheck(source, item)
    if config.debug then 
        print('checking item', item) --debug
    end

    local src = source
    local count = 0
    if config.framework.qb then 
        local playerdata = Player(src).PlayerData
        local items = playerdata.items

        for k, v in pairs(items) do 
            if config.debug then 
                print('item', v.name, v.count) --debug
            end
            if v.name == item then 
                local amount = v.count or v.amount
                count += amount
            end
        end
    elseif config.framework.esx then
        local items = Player(src).getInventory(false)

        for k, v in pairs(items) do 
            if config.debug then 
                print('item', v.name, v.count) --debug
            end

            if v.name == item then 
                local amount = v.count or v.amount
                count += amount
            end
        end
    elseif config.framework.custom then
        local playerdata = Player(src).PlayerData
        local items = playerdata.items

        for k, v in pairs(items) do 
            if config.debug then 
                print('item', v.name, v.count) --debug
            end

            if v.name == item then 
                local amount = v.count or v.amount
                count += amount
            end
        end
    end

    return count
end

lib.callback.register('solos-weed2:server:GetItemCount', function(source, item)
    local src = source
    local count = ItemCheck(src, item)
    return count
end)

RegisterNetEvent('solos-joints:server:itemremove', function(item, amount, bool)
    local src = source
    if config.framework.qb then 
        Player(src).Functions.RemoveItem(item, amount, bool)
        local QBCore = exports['qb-core']:GetCoreObject()
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")

    elseif config.framework.esx then
        Player(src).removeInventoryItem(item, amount)
    elseif config.framework.custom then
        Player(src).Functions.RemoveItem(item, amount, bool) -- edit if using custom framework
    end
end)

RegisterNetEvent('solos-joints:server:itemadd', function(item, amount, bool)
    local src = source
    if config.framework.qb then 
        Player(src).Functions.AddItem(item, amount, bool)
        local QBCore = exports['qb-core']:GetCoreObject()
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
    elseif config.framework.esx then
        Player(src).addInventoryItem(item, amount)
    elseif config.framework.custom then
        Player(src).Functions.AddItem(item, amount, bool) -- edit if using custom framework
    end
end)


-- Making Joint Roller Item usable:

if config.framework.qb then 
    CreateThread(function()
        framework.Functions.CreateUseableItem('joint_roller', function(source, item)
            if config.debug then 
                print('joint roller used')
            end
            TriggerClientEvent('solos-joints:client:UseJointRoller', source)
        end)
    end)
elseif config.framework.esx then
    CreateThread(function()
        framework.RegisterUsableItem('joint_roller', function(source)
            if config.debug then 
                print('joint roller used')
            end
            TriggerClientEvent('solos-joints:client:UseJointRoller', source)
        end)
    end)
elseif config.framework.custom then
    CreateThread(function()
        framework.RegisterUsableItem('joint_roller', function(source)
            if config.debug then 
                print('joint roller used')
            end
            TriggerClientEvent('solos-joints:client:UseJointRoller', source)
        end)
    end)
end

-- make joints useable:

if config.framework.qb then 
    CreateThread(function()
        for k, v in pairs(config.strains) do 
            framework.Functions.CreateUseableItem(v.joint, function(source, item)
                if config.debug then 
                    print('joint used')
                end

                local strain = k
                TriggerClientEvent('solos-joints:client:UseJointItem', source, strain)
            end)
        end
    end)
elseif config.framework.esx then
    CreateThread(function()
        for k, v in pairs(config.strains) do 
            framework.RegisterUsableItem(v.joint, function(source)
                if config.debug then 
                    print('joint used')
                end

                local strain = k
                TriggerClientEvent('solos-joints:client:UseJointItem', source, strain)
            end)
        end
    end)
elseif config.framework.custom then
    CreateThread(function()
        for k, v in pairs(config.strains) do 
            framework.RegisterUsableItem(v.joint, function(source)
                if config.debug then 
                    print('joint used')
                end

                local strain = k
                TriggerClientEvent('solos-joints:client:UseJointItem', source, strain)
            end)
        end
    end)
end