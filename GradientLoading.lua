local yes = game.CoreGui:WaitForChild("RobloxLoadingGui")
local uigradient = Instance.new("UIGradient")
uigradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 255)),ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 255)),ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 0, 255))})
uigradient.Rotation = 45
yes:GetChildren()[1].BackgroundColor3 = Color3.new(1, 1, 1)
uigradient.Parent = yes:GetChildren()[1]