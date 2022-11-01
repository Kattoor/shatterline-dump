----------------------------------------------------------------------------------------------------
-- Copyright 2020 Fraglab Ltd. All rights reserved.
----------------------------------------------------------------------------------------------------

require('scripts.bus_helpers')

local modifier_added_notification = {}

function modifier_added_notification:OnActivate()
    self.bc = BusConnector:Create(self)
    self.bc:Connect(LocalPlayerNotificationBus)
end

function modifier_added_notification:OnDeactivate()
    if self.bc then
        self.bc:Destroy()
        self.bc = nil
    end
end

-- LocalPlayerNotificationBus
function modifier_added_notification:OnLocalCharacterSpawned(characterId)
    self.characterId = characterId

    self.bc:Disconnect(PlayerModifiersNotifications)
    self.bc:Connect(PlayerModifiersNotifications, self, characterId)
end

-- PlayerModifiersNotifications
function modifier_added_notification:OnPlayerModifierAdded(modifierName, modifierId)
    if self.lastAddedModifierId then
        if PlayerModifiersRequests.Event.HasModifier(self.characterId, self.lastAddedModifierId) then
            Debug.Log("Local player character still has previously added modifier #"..self.lastAddedModifierId)
        else
            Debug.Log("Local player doesn't have previously added modifier #"..self.lastAddedModifierId.." anymore")
        end
    end

    self.lastAddedModifierId = modifierId

    Debug.Log("Modifier '"..modifierName.."' with id #"..modifierId.." was added to local player character")
end

return modifier_added_notification