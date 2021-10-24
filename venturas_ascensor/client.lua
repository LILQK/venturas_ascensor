ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


Citizen.CreateThread(function()

    local cansleep = true

    while true do

        local ped = GetPlayerPed(-1)

        Citizen.Wait(1)
            
            --DrawMarker(0, 930.17395019531,41.545589447021,81.097236633301, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 10, 255, 50, 200, true, false, false, false, nil, nil, false)
			if IsPlanta1() or IsPlanta3() or IsPlantaM1() or IsPlantaM2() or IsPlantaM3() then
				cansleep = false
                ESX.ShowHelpNotification("Presiona ~INPUT_CELLPHONE_UP~ para subir o ~INPUT_CELLPHONE_DOWN~ para bajar")
				if(IsControlJustReleased(0,172)) then
					
					if IsPlantaM1() then
						local coords = {
							x = -1066.0407714844,
							y = -833.74798583984,
							z = 11.037249565125}
						ESX.Game.Teleport(ped, coords)
					elseif IsPlantaM2() then

						local coords = {x=-1066.1768798828,y=-833.34173583984,z=14.882767677307}
						ESX.Game.Teleport(ped, coords)
					elseif IsPlantaM3() then
						local coords = {x=-1066.0905761719,y=-833.86712646484,z=19.035650253296}
						ESX.Game.Teleport(ped, coords)
					elseif IsPlanta1() then
						if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "sheriff" then
							local coords = {
								x = -1066.02,
								y = -833.62,
								z = 27.03
							}
							ESX.Game.Teleport(ped, coords)
							--SetEntityCoords(ped, -1066.0257568359,-833.62139892578,27.036458969116, 1, 1, 1,0)
							--SetEntityCoords(GetPlayerPed(-1) , -1066.025, -833.621, 27.036)
						else
							ESX.ShowNotification("Planta solo para policias")
						end
					end

				end

				if(IsControlJustReleased(0,173)) then
					if IsPlantaM1() then
						ESX.ShowNotification("No puedes bajar mas")
					elseif IsPlantaM2() then

						local coords = {x=-1066.0509033203, y = -833.84515380859, z = 5.4798135757446}
						ESX.Game.Teleport(ped, coords)
					elseif IsPlantaM3() then
						local coords = {x=-1066.0407714844,y=-833.74798583984,z=11.037249565125}
						ESX.Game.Teleport(ped, coords)
					elseif IsPlanta3() then
							local coords = {
								x = -1066.0905761719, y = -833.86712646484, z = 19.035650253296
							}
							ESX.Game.Teleport(ped, coords)
							--SetEntityCoords(ped, -1066.0257568359,-833.62139892578,27.036458969116, 1, 1, 1,0)
							--SetEntityCoords(GetPlayerPed(-1) , -1066.025, -833.621, 27.036)
					elseif IsPlanta1() then
						local coords = {
							x = -1066.1768798828, y = -833.34173583984, z = 14.882767677307
						}
						ESX.Game.Teleport(ped, coords)
					end
				end
			else
				Citizen.Wait(500)
			end

        if cansleep then
            Citizen.Wait(1000)
        end
    end
end)

function IsPlanta1()

	local pped = GetPlayerPed(-1)
	local distance = GetDistanceBetweenCoords(GetEntityCoords(pped), -1066.0905761719,-833.86712646484,19.035650253296,true)

	if distance > 2 then
		return false
	else
		return true
	end

end

function IsPlanta3()

	local pped = GetPlayerPed(-1)
	local distance = GetDistanceBetweenCoords(GetEntityCoords(pped), -1066.0257568359,-833.62139892578,27.036458969116,true)

	if distance > 2 then
		return false
	else
		return true
	end

end


function IsPlantaM3()

	local pped = GetPlayerPed(-1)
	local distance = GetDistanceBetweenCoords(GetEntityCoords(pped), -1066.1768798828,-833.34173583984,14.882767677307,true)

	if distance > 2 then
		return false
	else
		return true
	end

end

function IsPlantaM2()

	local pped = GetPlayerPed(-1)
	local distance = GetDistanceBetweenCoords(GetEntityCoords(pped), -1066.0407714844,-833.74798583984,11.037249565125,true)

	if distance > 2 then
		return false
	else
		return true
	end

end

function IsPlantaM1()

	local pped = GetPlayerPed(-1)
	local distance = GetDistanceBetweenCoords(GetEntityCoords(pped), -1066.0509033203,-833.84515380859,5.4798135757446,true)

	if distance > 2 then
		return false
	else
		return true
	end

end

function OpenShop()
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'purchase_confirm', {
		title    = "Seguro que quieres comprarlo?",
		align    = 'top-left',
		elements = {
			--{label = _U('revive'), value = 'revive'},
			{label = "Cambiar dinero", value = 'yes'},
			{label = "Salir",  value = 'no'}
		}
	}, function(data, menu)
		menu.close()
		
		if data.current.value == 'yes' then
            TriggerServerEvent('venturas:cambiodinero')
		elseif data.current.value == 'no' then
			menu.close()
		end
	end, function (data, menu)
		menu.close()
	end)
end