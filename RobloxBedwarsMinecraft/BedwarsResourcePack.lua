repeat wait() until game:IsLoaded() == true
repeat wait() until game.ReplicatedStorage ~= nil
repeat wait() until game.ReplicatedStorage.Items ~= nil
repeat wait() until game.Workspace ~= nil 
repeat wait() until game.Workspace:FindFirstChild("Map") ~= nil
local getasset = getsynasset or getcustomasset
local sounds = require(game.ReplicatedStorage.TS.sound["sound-manager"]).SoundManager.soundConfigs
for i,v in pairs(listfiles("bedwars/sounds")) do
    local str = tostring(tostring(v):gsub('bedwars/sounds\\', ""):gsub(".mp3", ""))
    local item = sounds[tonumber(str)]
    if item then
        item.assetId = getasset(v)
    end
end 
for i,v in pairs(listfiles("bedwars")) do
    local str = tostring(tostring(v):gsub('bedwars\\', ""):gsub(".png", ""))
    local item = game.ReplicatedStorage.Items:FindFirstChild(str)
    if item then
        if isfile("bedwars/models/"..str..".mesh") then
            item.Handle.MeshId = getasset("bedwars/models/"..str..".mesh")
            item.Handle.TextureID = getasset("bedwars/models/"..str..".png")
            for i2,v2 in pairs(item.Handle:GetDescendants()) do
                if v2:IsA("MeshPart") then
                    v2.Transparency = 1
                end
            end
        else
            for i2,v2 in pairs(item:GetDescendants()) do
                if v2:IsA("Texture") then
                    v2.Texture = getasset(v)
                end
            end
        end
    end
end
for i,v in pairs(getgc(true)) do
    if type(v) == "table" and rawget(v, "wool_blue") and type(v["wool_blue"]) == "table" then
        for i2,v2 in pairs(v) do
            if isfile("bedwars/"..i2..".png") then
                if rawget(v2, "block") and rawget(v2["block"], "greedyMesh") then
                    if #v2["block"]["greedyMesh"]["textures"] > 1 and isfile("bedwars/"..i2.."_side_1.png") then
                        for i3,v3 in pairs(v2["block"]["greedyMesh"]["textures"]) do
                            v2["block"]["greedyMesh"]["textures"][i3] = getasset("bedwars/"..i2.."_side_"..i3..".png")
                        end
                    else
                     v2["block"]["greedyMesh"]["textures"] = {
                            [1] = getasset("bedwars/"..i2..".png")
                     }
                    end
                    if isfile("bedwars/"..i2.."_image.png") then
                        v2["image"] = getasset("bedwars/"..i2.."_image.png")
                    end
                else
                    v2["image"] = getasset("bedwars/"..i2..".png")
                end
            end
        end
    end
end
for i,v in pairs(game.Workspace.Map.Blocks:GetChildren()) do
    if isfile("bedwars/"..v.Name..".png") then
        for i2,v2 in pairs(v:GetDescendants()) do
            if v2:IsA("Texture") then
                v2.Texture = getasset("bedwars/"..v.Name..".png")
            end
        end
    end
end
game.Workspace.DescendantAdded:connect(function(v)
    if v.Parent == game.Workspace.Map.Blocks and isfile("bedwars/"..v.Name..".png") then
        for i2,v2 in pairs(v:GetDescendants()) do
            if v2:IsA("Texture") then
                v2.Texture = getasset("bedwars/"..v.Name..".png")
            end
        end
        v.DescendantAdded:connect(function(v3)
            if v3:IsA("Texture") then
                v3.Texture = getasset("bedwars/"..v.Name..".png")
            end
        end)
    end
    if v:IsA("Accessory") and isfile("bedwars/models/"..v.Name..".mesh") then
        spawn(function()
            local handle = v:WaitForChild("Handle")
            handle.MeshId = getasset("bedwars/models/"..v.Name..".mesh")
            handle.TextureID = getasset("bedwars/models/"..v.Name..".png")
            for i2,v2 in pairs(handle:GetDescendants()) do
                if v2:IsA("MeshPart") then
                    v2.Transparency = 1
                end
            end
        end)
    end
end)