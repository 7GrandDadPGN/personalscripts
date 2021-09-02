
        local textlab = Instance.new("TextLabel")
        textlab.Size = UDim2.new(0, 200, 0, 28)
        textlab.BackgroundTransparency = 1
        textlab.TextColor3 = Color3.new(1, 1, 1)
        textlab.TextStrokeTransparency = 0
        textlab.TextStrokeColor3 = Color3.new(0.24, 0.24, 0.24)
        textlab.Font = Enum.Font.SourceSans
        textlab.TextSize = 28
        textlab.Text = "1 ms"
        textlab.BackgroundColor3 = Color3.new(0, 0, 0)
        textlab.Position = UDim2.new(1, -254, 0, -33)
        textlab.TextXAlignment = Enum.TextXAlignment.Right
        textlab.BorderSizePixel = 0
        textlab.Parent = game.CoreGui.RobloxGui
        spawn(function()
            repeat
                wait(1)
                local ping = tonumber(game:GetService("Stats"):FindFirstChild("PerformanceStats").Ping:GetValue())
                ping = math.floor(ping)
                textlab.Text = ping.." ms"
            until textlab == nil
        end)