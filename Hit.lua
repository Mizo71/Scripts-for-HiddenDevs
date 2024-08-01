local bat = script.Parent
local active = false
local localPlayer = bat.Parent.Parent
local charge = localPlayer.charge.amount
local cooldown = false
local sound = script.Parent.hit_punch_l
local spring = script.Parent["Short spring sound.wav"]
local faceDecal = script.Parent.FaceDecal
local died = true

bat.Activated:Connect(function()
	if cooldown == false then
		local value = Instance.new("StringValue")
		value.Name = "toolanim"
		value.Value = "Slash" 
		value.Parent = bat
		active = true
		cooldown = true
		wait(0.8)
		cooldown = false
	end
end)

bat.HitBox.Touched:Connect(function(hit)
	local player = hit.Parent:FindFirstChild("Humanoid")
	local char = hit.Parent
	local charRoot = char:FindFirstChild("HumanoidRootPart")
	local charhead = char:FindFirstChild("Head")

	if active == true and player then
		sound:Play()
		if charge.Value >= 100 then
			if charhead:FindFirstChild("face") then
				charhead:FindFirstChild("face"):Destroy()
				faceDecal.Parent = charhead
			else
				faceDecal.Parent = charhead
			end

			spring:Play()
			player:TakeDamage(6)
			active = false
			charge.Value = 0

			if charRoot:FindFirstChildOfClass("BodyVelocity") then
				local velocity1 = charRoot:FindFirstChildOfClass("BodyVelocity") 
				velocity1.Velocity = charRoot.CFrame.LookVector * 20
				hit.Parent.Humanoid.Sit = true
				wait(1)
				velocity1.Velocity = charRoot.CFrame.LookVector * 0
				wait(0.5)
				hit.Parent.Humanoid.Sit = false
			else
				local velocity = Instance.new("BodyVelocity")
				velocity.Velocity = charRoot.CFrame.LookVector * 20
				velocity.MaxForce = Vector3.new(1,0,1) * 30000
				velocity.Parent = charRoot
				hit.Parent.Humanoid.Sit = true
				wait(1)
				velocity.Velocity = charRoot.CFrame.LookVector * 0
				wait(0.5)
				hit.Parent.Humanoid.Sit = false
			end
		else
			player:TakeDamage(4)
			active = false
			charge.Value = charge.Value + 10
		end 

		player.Died:Connect(function()
			if died == true then
				localPlayer.leaderstats.Kills.Value = localPlayer.leaderstats.Kills.Value + 1
				died = false
				wait(0.1)
				died = true
			else print("idk")
				
			end
		end)
	end
end)
