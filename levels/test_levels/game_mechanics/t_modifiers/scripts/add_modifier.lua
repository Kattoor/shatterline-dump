----------------------------------------------------------------------------------------------------
-- Copyright 2020 Fraglab Ltd. All rights reserved.
----------------------------------------------------------------------------------------------------

require('scripts.bus_helpers')

local add_modifier =
{
    Properties =
    {
        ModifierName = { default = "", description = "Which modifier to add when entering trigger" };
    }
}

function add_modifier:OnActivate()
    if EnvironmentHelpers.IsServer() then
        self.bc = BusConnector:Create(self)
        self.bc:Connect(TriggerNotificationBus)
    end
end

function add_modifier:OnDeactivate()
    if self.bc then
        self.bc:Destroy()
        self.bc = nil
    end
end

-- TriggerNotificationBus
function add_modifier:OnTriggerEnter(enteredEntityId)
    PlayerModifiersRequests.Event.AddModifier(enteredEntityId, self.entityId, self.Properties.ModifierName)
end

return add_modifier