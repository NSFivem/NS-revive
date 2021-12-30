Config = {}
Config.Redzone = {}

Config.Redzone.Location = vector3(908.6929, 1559.859, 437.161)
Config.Redzone.Size = 400.0

--   Config.Redzone = {
--     Location = vector3(908.6929, 1559.859, 437.161),
--     Size = 300.0
--   }


function IsOutsideOfRedZone(ped)
	return #(GetEntityCoords(ped) - Config.Redzone.Location) > Config.Redzone.Size
end


----------------- F U N C T I O N S ----------------------

-- -- NS100#0001



-- local isDead = false

-- parts = {
--     ['RFoot'] = 52301,
--     ['LFoot'] = 14201,
--     ['RHand'] = 57005,
--     ['LHand'] = 18905,
--     ['RKnee'] = 36864,
--     ['LKnee'] = 63931,
--     ['Head'] = 31086,
--     ['Neck'] = 39317,
--     ['RArm'] = 28252,
--     ['LArn'] = 61163,
--     ['Chest'] = 24818,
--     ['Pelvis'] = 11816,
--     ['RShoulder'] = 40269,
--     ['LShoulder'] = 45509,
--     ['RWrist'] = 28422,
--     ['LWrist'] = 60309,
--     ['Tounge'] = 47495,
--     ['UpperLip'] = 20178,
--     ['LowerLip'] = 17188,
--     ['RThigh'] = 51826,
--     ['LThigh'] = 58217,
-- }


-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)

--         local playerPed = PlayerPedId()
--         local coords = GetEntityCoords(PlayerPedId())
--         local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(PlayerPedId())
--         local DamagedBone = GetKeyOfValue(parts, LastDamagedBone)

--             SetEntityOnlyDamagedByPlayer(PlayerPedId(), true)
-- 			if DamagedBone == 'Head' and not IsEntityDead(PlayerPedId()) then

--                 SetEntityHealth(PlayerPedId(), 0)	
		
-- 			end
--         end
-- end)



-- function GetKeyOfValue(Table, SearchedFor)
--     for Key, Value in pairs(Table) do
--         if SearchedFor == Value then
--             return Key
--         end
--     end
--     return nil
-- end







RegisterCommand('rev', function() 
    local ped = PlayerPedId()

    if IsEntityDead(ped) and (IsOutsideOfRedZone(ped)) then
         Revive(ped)

         AddArmourToPed(GetPlayerPed(-1), 200)
         SetEntityHealth(ped, 100)
         
                exports['t-notify']:Alert({
                        style = 'success',
                        duration = 2900,
                        message = '**Revived.**',
                        custom = true
                    })
        else
         
             exports['t-notify']:Alert({
                style = 'info',
                duration = 2900,
                message = '**You Arent Dead.**',
                custom = true
            })

            if not (IsOutsideOfRedZone(ped)) then   
                exports['t-notify']:Alert({
                style = 'info',
                duration = 2900,
                message = '**You Arent Outside Of The Redzone.**',
                custom = true
            })
        end
        end
end)



function Revive(ped)
        if ped ~= nil and ped ~= 0 then
            local coords = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            DoScreenFadeOut(800)
            SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
            NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
            SetPlayerInvincible(ped, false)
            ClearPedBloodDamage(ped)
            DoScreenFadeIn(800)
    end
end
