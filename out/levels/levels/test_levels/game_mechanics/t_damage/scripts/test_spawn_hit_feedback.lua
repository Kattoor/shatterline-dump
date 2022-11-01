----------------------------------------------------------------------------------------------------
-- Copyright 2021 Fraglab Ltd. All rights reserved.
----------------------------------------------------------------------------------------------------

require('scripts.bus_helpers')

local test_spawn_hit_feedback =
{
    Properties =
    {
    }
}

function test_spawn_hit_feedback:OnActivate()
    self.bc = BusConnector:Create(self)
    self.bc:Connect(EntityHitFeedbackNotificationBus, self, self.entityId)

    Debug.Assert(self.bc:IsConnected(EntityHitFeedbackNotificationBus), "EntityHitFeedbackNotificationBus is not connected")
end

function test_spawn_hit_feedback:OnDeactivate()
    if self.bc then
        self.bc:Destroy()
        self.bc = nil
    end
end

-- EntityHitFeedbackNotificationBus
function test_spawn_hit_feedback:OnSurfaceHitFeedback(feedbackEvent)
    Debug.Log("Feedback event:"..
              "\n   Position = "..tostring(feedbackEvent.Position)..
              "\n   Direction = "..tostring(feedbackEvent.Direction)..
              "\n   Normal = "..tostring(feedbackEvent.Normal)..
              "\n   Target = "..tostring(feedbackEvent.TargetId).." ("..Entity(feedbackEvent.TargetId):GetName()..")"..
              "\n   Is pierced out = "..(feedbackEvent.IsPiercedOut and "yes" or "no")..
              "\n   Is foe = "..(feedbackEvent.IsFoe and "yes" or "no")..
              "\n   HitType = "..tostring(feedbackEvent.HitType)..
              "\n   Bullet type = "..tostring(feedbackEvent.BulletType)..
              "\n   Melee type = "..tostring(feedbackEvent.MeleeType)..
              "\n   Validation type = "..tostring(feedbackEvent.ValidationType).."("..self:GetValidationTypeName(feedbackEvent.ValidationType)..")\n")

    SpawnerComponentRequestBus.Event.DestroyAllSpawnedSlices(self.entityId)

    local position = feedbackEvent.Position
    local rotation = Quaternion.CreateShortestArc(Vector3.CreateAxisZ(), feedbackEvent.Normal)
    SpawnerComponentRequestBus.Event.SpawnAbsolute(self.entityId, Transform.CreateFromQuaternionAndTranslation(rotation, position))
end

-- Private functions
function test_spawn_hit_feedback:GetValidationTypeName(validationType)
	if validationType == 0 then
        return "local"
    end

    if validationType == 1 then
        return "server unconfirmed"
    end
    
    if validationType == 2 then
        return "server confirmed"
    end

    return "unknown"
end


return test_spawn_hit_feedback