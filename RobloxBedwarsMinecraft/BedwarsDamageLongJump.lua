repeat task.wait() until game:IsLoaded()
if game.GameId ~= 2619619496 then return end
local cam
repeat
	task.wait(0.1)
	for i,v in pairs(getconnections(workspace.CurrentCamera:GetPropertyChangedSignal("CameraType"))) do 
		if v.Function then
			cam = debug.getupvalue(v.Function, 1)
		end
	end
until cam
local caminput = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule.CameraModule.CameraInput)
local num = Instance.new("IntValue")
local numanim

shared.damageanim = function()
	if numanim then numanim:Cancel() end
    num.Value = 100
    numanim = game:GetService("TweenService"):Create(num, TweenInfo.new(0.5), {Value = 0})
    numanim:Play()
end

cam.Update = function(dt) 
	if cam.activeCameraController then
		cam.activeCameraController:UpdateMouseBehavior()

		local newCameraCFrame, newCameraFocus = cam.activeCameraController:Update(dt)

		game.Workspace.CurrentCamera.CFrame = newCameraCFrame * CFrame.Angles(0, 0, math.rad(num.Value / 10))
		game.Workspace.CurrentCamera.Focus = newCameraFocus

	
		if cam.activeTransparencyController then
			cam.activeTransparencyController:Update()
		end

		if caminput.getInputEnabled() then
			caminput.resetInputForFrameEnd()
		end
	end
end