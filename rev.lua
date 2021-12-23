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
