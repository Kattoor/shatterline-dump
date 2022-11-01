----------------------------------------------------------------------------------------------------
-- Copyright 2020 Fraglab Ltd. All rights reserved.
----------------------------------------------------------------------------------------------------

require('scripts.bus_helpers')

local have_modifier =
{
    Properties =
    {
        ModifierName = { default = "", description = "Which modifier to check when entering trigger" };
    }
}

function have_modifier:OnActivate()
    self.bc = BusConnector:Create(self)
    self.bc:Connect(TriggerNotificationBus)
end

function have_modifier:OnDeactivate()
    if self.bc then
        self.bc:Destroy()
        self.bc = nil
    end
end

-- TriggerNotificationBus
function have_modifier:OnTriggerEnter(enteredEntityId)
    if PlayerModifiersRequests.Event.HasModifierWithName(enteredEntityId, self.Properties.ModifierName) then
        local modifierInstances = PlayerModifiersRequests.Event.FindAllModifiersWithName(enteredEntityId, self.Properties.ModifierName)
        local oldestModifier = PlayerModifiersRequests.Event.FindOldestModifierByName(enteredEntityId, self.Properties.ModifierName)
        local newestModifier = PlayerModifiersRequests.Event.FindNewestModifierByName(enteredEntityId, self.Properties.ModifierName)

        local oldestModifierRemainingTime = PlayerModifiersRequests.Event.GetModifierRemainingTime(enteredEntityId, oldestModifier)
        local newestModifierRemainingTime = PlayerModifiersRequests.Event.GetModifierRemainingTime(enteredEntityId, newestModifier)

        Debug.Log(Entity(enteredEntityId):GetName().." has "..#modifierInstances.." modifiers "..self.Properties.ModifierName)

        Debug.Log("Oldest modifier #"..oldestModifier.." remaining time "..oldestModifierRemainingTime)
        Debug.Log("Newest modifier #"..newestModifier.." remaining time "..newestModifierRemainingTime)
    else
        Debug.Log(Entity(enteredEntityId):GetName().." doesn't have modifier "..self.Properties.ModifierName)
    end
end

return have_modifier