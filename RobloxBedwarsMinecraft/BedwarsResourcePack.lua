repeat wait() until game:IsLoaded() == true
repeat wait() until game.ReplicatedStorage ~= nil
repeat wait() until game.ReplicatedStorage.Items ~= nil
repeat wait() until game.Workspace ~= nil 
repeat wait() until game.Workspace:FindFirstChild("Map") ~= nil
local getasset = getsynasset or getcustomasset
for i,v in pairs(listfiles("bedwars")) do
    local str = tostring(tostring(v):gsub('bedwars\\', ""):gsub(".png", ""))
    local item = game.ReplicatedStorage.Items:FindFirstChild(str)
    if item then
        for i2,v2 in pairs(item:GetDescendants()) do
            if v2:IsA("Texture") then
                v2.Texture = getasset(v)
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
game.Workspace.Map.Blocks.ChildAdded:connect(function(v)
    if isfile("bedwars/"..v.Name..".png") then
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
end)