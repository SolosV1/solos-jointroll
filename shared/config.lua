config = {}

config.debug = false                                    -- Enable or disable debug mode (prints to console)

config.framework = {
    qb = true,                                          -- Set to true if using qbcore
    esx = false,                                        -- Set to true if using esx
    custom = false,                                     -- Set to true if using custom framework (requires modifications)
}

config.notify = function(msg, status) -- DON'T TOUCH THIS

    ---------   edit (or replace) below   -------------  
    
        lib.notify({
            description = msg,
            position = 'top',
            type = status, -- 'success', 'error', 'inform'
            style = {
                backgroundColor = 'rgba(0, 0, 0, 0.65)',
                color = 'white',
            },
        })
    
    ---------------------------------------------------
    
end

config.RollingPaper = {

    required = true,                                    -- Enable or disable requiring rolling paper to roll a joint

    item = 'rolling_paper',                             -- Item name of the rolling paper (you can change this if you have a different rolling paper item than the one included)
    amount = 1,                                         -- Amount of rolling paper required each time joint roller is used
}       


config.strains = {      
    ['Northern Lights'] = {     
        joint = 'northern_lights_joint',                -- Item name of the joint that player will receive
        effect = 'armor',                               -- Effect that will be applied to player when smoking this joint 
        receive = 1,                                    -- Amount of joints that player will receive after using joint roller
        required = {        
            item = 'northern_lights_bag',               -- Item name of the weed that is required to roll this joint (can be dry bud, bag of weed, whatever you want)
            amount = 1,                                 -- Amount of that item that is required to roll this joint
        },
    },
    ['Blue Dream'] = { 
        joint = 'blue_dream_joint', 
        effect = 'armor',
        receive = 1, 
        required = { 
            item = 'blue_dream_bag', 
            amount = 1, 
        },
    },
    ['Pineapple Express'] = {
        joint = 'pineapple_express_joint', 
        effect = 'speed',
        receive = 1, 
        required = { 
            item = 'pineapple_express_bag', 
            amount = 1, 
        },
    },
    ['Sour Diesel'] = {
        joint = 'sour_diesel_joint', 
        effect = 'stamina',
        receive = 1, 
        required = { 
            item = 'sour_diesel_bag', 
            amount = 1, 
        },
    },
    ['Strawberry Kush'] = {
        joint = 'strawberry_kush_joint',
        effect = 'health',
        receive = 1,
        required = {
            item = 'strawberry_kush_bag',
            amount = 1,
        },
    },
    ['Golden Goat'] = {
        joint = 'golden_goat_joint',
        effect = 'stress',
        receive = 1,
        required = {
            item = 'golden_goat_bag',
            amount = 1,
        },
    },
}