local peacetime = false

RegisterNetEvent('togglePeacetime')
AddEventHandler('togglePeacetime', function(state)
    peacetime = state
    SetCanAttackFriendly(PlayerPedId(), not peacetime, false)
    NetworkSetFriendlyFireOption(not peacetime)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if peacetime then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 68, true)
            DisableControlAction(0, 69, true)
            DisableControlAction(0, 70, true)
            DisableControlAction(0, 92, true)
            DisableControlAction(0, 114, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 143, true)
            DisablePlayerFiring(PlayerPedId(), true)
        end
    end
end)
