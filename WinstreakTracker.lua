wait(2)
if shared.VapeExecuted then
    spawn(function()
        local players = game:GetService("Players")
        local lplr = players.LocalPlayer
        local winstreaks = Instance.new("TextLabel")
        winstreaks.TextSize = 17
        winstreaks.Name = "WinStreakTracker"
        winstreaks.TextXAlignment = Enum.TextXAlignment.Left
        winstreaks.TextYAlignment = Enum.TextYAlignment.Bottom
        winstreaks.TextColor3 = Color3.new(1, 1, 1)
        winstreaks.BackgroundTransparency = 1
        winstreaks.Text = " "
        winstreaks.Size = UDim2.new(1, 0, 1, 0)
        winstreaks.Active = false
        winstreaks.Font = Enum.Font.SourceSansBold
        winstreaks.TextStrokeTransparency = 0
        winstreaks.Parent = game.CoreGui.RobloxGui

        local function update()
            local str = "-- WINSTREAK TRACKER --"
            for i,v in pairs(players:GetChildren()) do
                if v:GetAttribute("WinStreak") and v:GetAttribute("WinStreak") > 0 and v ~= lplr then
                    str = str.."\n"..(v.DisplayName or v.Name).." : "..v:GetAttribute("WinStreak")
                end
            end
            winstreaks.Text = str
        end

        update()
        repeat
            wait(3)
            update()
        until true == false
    end)
end