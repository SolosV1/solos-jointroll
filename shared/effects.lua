-- Customize Effects:

effects = {

    ['stress'] = {
        action = function()
            local amount = 10
            StressEffect(amount)
        end
    },

    ['stamina'] = {
        action = function()
            local duration = 60
            local amount = 1

            StaminaEffect(duration, amount)
        end
    },

    ['speed'] = {

        action = function()
            local duration = 30
            local amount = 1.49     -- 1.49 is the max speed multiplier cant be above this or nothing will happen

            SpeedEffect(duration, amount)
        end
    },

    ['armor'] = {
        action = function()
            local duration = 10
            local amount = 5

            ArmorEffect(duration, amount)
        end
    },

    ['health'] = {
        action = function()
            local duration = 25
            local amount = 1
    
            HealthEffect(duration, amount)
        end
    },

    ['custom'] = {          -- name whatever tf you want
        action = function()
            local duration = 60
            local amount = 1

            -- Do something custom here
        end
    }
}



--- Functions:

StressEffect = function(duration, amount)
    TriggerServerEvent('hud:server:RelieveStress', amount)
end

StaminaEffect = function(duration, amount)
    local ped = PlayerPedId()
    local startStamina = duration
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do
        Wait(1000)
        startStamina -= 1
        RestorePlayerStamina(PlayerId(), 1.0)
    end
end

SpeedEffect = function(duration, amount)
    local ped = PlayerId()
    SetRunSprintMultiplierForPlayer(ped, amount)
    Wait(duration*1000)
    SetRunSprintMultiplierForPlayer(ped, 1.0)
end

ArmorEffect = function(duration, amount)
    local ped = PlayerPedId()

    for i = 1, duration do 
        local current = GetPedArmour(ped)
        SetPedArmour(ped, current+amount)
        Wait(1000)
    end
end

HealthEffect = function(duration, amount)
    local ped = PlayerPedId()
    for i = 1, duration do 
        local current = GetEntityHealth(ped)
        SetEntityHealth(ped, current+amount)
        Wait(1000)
    end
end

