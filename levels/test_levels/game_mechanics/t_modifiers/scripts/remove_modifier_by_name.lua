----------------------------------------------------------------------------------------------------
-- Copyright 2020 Fraglab Ltd. All rights reserved.
----------------------------------------------------------------------------------------------------

require('scripts.bus_helpers')

local remove_modifier_by_name =
{
    Properties =
    {
        ModifierName = { default = "", description = "Which modifier to remove by name when entering trigger" };
    }
}

function remove_modifier_by_name:OnActivate()
    if EnvironmentHelpers.IsServer() then
        self.bc = BusConnector:Create(self)
        self.bc:Connect(TriggerNotificationBus)
    end
end

function remove_modifier_by_name:OnDeactivate()
    if self.bc then
        self.bc:Destroy()
        self.bc = nil
    end
end

-- TriggerNotificationBus
function remove_modifier_by_name:OnTriggerEnter(enteredEntityId)
    PlayerModifiersRequests.Event.RemoveModifiersWithName(enteredEntityId, self.Properties.ModifierName)

    Debug.Log("Modifier '"..self.Properties.ModifierName.."' was removed from '"..Entity(enteredEntityId):GetName().."'")
end

return remove_modifier_by_name