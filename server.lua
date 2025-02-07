local peacetime = false
local permissionsEnabled = true -- Change to false to disable permission checks
local peacetimeTimer = nil

RegisterCommand('pt', function(source, args)
    local player = source
    if not permissionsEnabled or IsPlayerAceAllowed(player, "peacetime.toggle") then
        peacetime = not peacetime
        TriggerClientEvent('togglePeacetime', -1, peacetime)

        local message = peacetime and "PeaceTime is now enabled. All combat is disabled." or "PeaceTime is now disabled. PvP is allowed again."
        TriggerClientEvent('ox_lib:notify', -1, {
            title = "PeaceTime",
            description = message,
            type = peacetime and "success" or "error"
        })

        if peacetime and args[1] then
            local duration = tonumber(args[1])
            if duration and duration > 0 then
                if peacetimeTimer then
                    ClearTimeout(peacetimeTimer)
                end
                peacetimeTimer = SetTimeout(duration * 60000, function()
                    peacetime = false
                    TriggerClientEvent('togglePeacetime', -1, false)
                    TriggerClientEvent('ox_lib:notify', -1, {
                        title = "PeaceTime",
                        description = "PeaceTime has automatically ended.",
                        type = "error"
                    })
                    peacetimeTimer = nil
                end)
            end
        elseif not peacetime and peacetimeTimer then
            ClearTimeout(peacetimeTimer)
            peacetimeTimer = nil
        end
    else
        TriggerClientEvent('ox_lib:notify', player, {
            title = "Permission Denied",
            description = "You do not have permission to use this command.",
            type = "error"
        })
    end
end, false)

RegisterCommand('checkpt', function(source)
    local player = source
    local status = peacetime and "enabled" or "disabled"
    TriggerClientEvent('ox_lib:notify', player, {
        title = "PeaceTime Status",
        description = "PeaceTime is currently " .. status,
        type = peacetime and "info" or "warning"
    })
end, false)
