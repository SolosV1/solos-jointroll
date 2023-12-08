local is_smoking = false


RegisterNetEvent('solos-joints:client:UseJointItem', function(strain)
    local joint_effect = config.strains[strain].effect

    if config.debug then 
        print('Used joint: ', strain, joint_effect)
    end

    if lib.progressCircle({
        duration = 1000,
        position = 'bottom',
        label = 'Smoking '..strain..' Joint',
        useWhileDead = false,
        canCancel = true,
    }) then 
        is_smoking = true
        TriggerServerEvent('solos-joints:server:itemremove', config.strains[strain].joint, 1)
        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_SMOKING_POT', 0, 0)
        effects[joint_effect].action()
    end    
end)

local function JointMenu()
    local joint_options = {}

    for k, v in pairs(config.strains) do
        if config.debug then 
            print('Checking for joint, Strain: ', k, 'Weed Bag Item', v.required.item, 'Required Amount', v.required.amount)
        end
        local has_item = lib.callback.await('solos-weed2:server:GetItemCount', false, v.required.item)
        if config.debug then 
            print('Amount in inventory: '..tostring(has_item))
        end
        if has_item > 0 then
            if config.debug then 
                print('Adding joint to menu: ', k)
            end
            table.insert(joint_options, {
                title = k,
                icon = 'fas fa-joint',
                onSelect = function(cb)
                    if config.RollingPaper.required then 
                        if config.debug then 
                            print('Checking for rolling paper, Item: ', config.RollingPaper.item, 'Amount: ', config.RollingPaper.amount)
                        end
                        local has_papers = lib.callback.await('solos-weed2:server:GetItemCount', false, config.RollingPaper.item)

                        if config.debug then 
                            print('Amount of rolling paper item in inventory: '..tostring(has_papers))
                        end
                        if has_papers < config.RollingPaper.amount then
                            config.notify('You don\'t have enough rolling paper!', 'error')
                            return
                        else 
                            if config.debug then 
                                print('Removing rolling paper: ', config.RollingPaper.item, 'Amount: ', config.RollingPaper.amount)
                            end
                            TriggerServerEvent('solos-joints:server:itemremove', config.RollingPaper.item, config.RollingPaper.amount)
                        end
                    end

                    TriggerServerEvent('solos-joints:server:itemremove', v.required.item, v.required.amount)
                    TriggerEvent('solos-jointroll:client:RollJoint', k)
                end
            })
        end 
    end

    if #joint_options == 0 then
        config.notify('You don\'t have any weed!', 'error')
        return
    end

    lib.registerContext({
        id = 'joint_menu',
        title = 'Roll Joint',
        options = joint_options,
    })
    
    lib.showContext('joint_menu')
    
end

RegisterNetEvent('solos-joints:client:UseJointRoller', function()
    JointMenu()
end)

RegisterNetEvent('solos-jointroll:client:RollJoint', function(strain)

    
    SendNUIMessage({
        action = "Start_Roll",
        strain = strain,
    })

    SetNuiFocus(true, true)
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, 'PROP_HUMAN_PARKING_METER', 0, true)
end)

RegisterNuiCallback('roll-success', function(data)
    local strain = data.strain

    SetNuiFocus(false, false)
    ClearPedTasks(PlayerPedId())

    if config.debug then 
        print('joint rolled', strain)
    end
    
    for k, v in pairs(config.strains) do
        if k == strain then
            local joint = v.joint
            local amount = v.receive
            if config.debug then 
                print('Giving player joint: ', joint, 'Amount: ', amount)
            end
            TriggerServerEvent('solos-joints:server:itemadd', joint, amount)
            config.notify('You rolled a '..strain..' joint!', 'success')
        end
    end
end)

RegisterNuiCallback('roll-fail', function(data)
    local strain = data.strain
    SetNuiFocus(false, false)
    ClearPedTasks(PlayerPedId())
    for k, v in pairs(config.strains) do
        if k == strain then
            local required = v.required
            local amount = required.amount
            
            if config.debug then 
                print('Giving player weed back: ', required.item, 'Amount: ', amount)
            end

            TriggerServerEvent('solos-joints:server:itemadd', required.item, amount)
            config.notify('Cancelled.', 'error')
        end
    end

    if config.RollingPaper.required then 
        
        if config.debug then 
            print('Giving player rolling paper back: ', config.RollingPaper.item, 'Amount: ', config.RollingPaper.amount)
        end
        
        TriggerServerEvent('solos-joints:server:itemadd', config.RollingPaper.item, config.RollingPaper.amount)
        
    end
end)


-- Press X to stop smoking: 

-- You can comment out or delete below if you have a 'handsup' keybiind that cancels emotes

CreateThread(function()
    local sleep = 2000

    while true do 
        if is_smoking then 
            sleep = 1
            --press X
            if IsControlJustPressed(0, 73) then
                is_smoking = false
                ClearPedTasks(PlayerPedId())
            end
        else 
            sleep = 2000
        end
        Wait(sleep)
    end
end)