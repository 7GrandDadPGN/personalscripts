repeat wait() until game:IsLoaded() == true
repeat wait() until game.ReplicatedStorage ~= nil
repeat wait() until game.ReplicatedStorage.Items ~= nil
repeat wait() until game.Workspace ~= nil 
repeat wait() until game.Workspace:FindFirstChild("Map") ~= nil
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
local getasset = getsynasset or getcustomasset

local function getcustomassetfunc(path)
	if not isfile(path) then
		spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = game.CoreGui.RobloxGui
			repeat wait() until isfile(path)
			textlabel:Remove()
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/7GrandDadPGN/personalscripts/main/RobloxBedwarsMinecraft/"..path,
			Method = "GET"
		})
		writefile(path, req.Body)
	end
	return getasset(path) 
end

local function downloadassets(path2)
    local json = requestfunc({
        Url = "https://api.github.com/repos/7GrandDadPGN/personalscripts/contents/RobloxBedwarsMinecraft/"..path2,
        Method = "GET"
    })
    local decodedjson = game:GetService("HttpService"):JSONDecode(json.Body)
    for i2,v2 in pairs(decodedjson) do
        if v2["type"] == "file" then
			getcustomassetfunc(path2.."/"..v2["name"])
		end
    end
end

if isfolder("bedwars") == false then
	makefolder("bedwars")
end
downloadassets("bedwars")
if isfolder("bedwars/models") == false then
	makefolder("bedwars/models")
end
downloadassets("bedwars/models")
if isfolder("bedwars/sounds") == false then
	makefolder("bedwars/sounds")
end
downloadassets("bedwars/sounds")
if isfolder("bedwars/sounds/footstep") == false then
	makefolder("bedwars/sounds/footstep")
end
downloadassets("bedwars/sounds/footstep")

local sounds = require(game.ReplicatedStorage.TS.sound["sound-manager"]).SoundManager.soundConfigs
local footstepsounds = require(game.ReplicatedStorage.TS.sound["footstep-sounds"])
local items = require(game.ReplicatedStorage.TS.item["item-meta"])
local itemtab = debug.getupvalue(items.getItemMeta, 1)
local hotbartile = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-tile"])
local hotbaropeninventory = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-open-inventory"])
local roact = debug.getupvalue(hotbartile["HotbarTile"].render, 1)
local colorutil = debug.getupvalue(hotbartile["HotbarTile"].render, 2)
local soundmanager = debug.getupvalue(hotbartile["HotbarTile"].render, 3)
local itemviewport = debug.getupvalue(hotbartile["HotbarTile"].render, 5)
local empty = debug.getupvalue(hotbartile["HotbarTile"].render, 6)
local tween = debug.getupvalue(hotbartile["HotbarTile"].tweenPosition, 1)

hotbaropeninventory["HotbarOpenInventory"].render = function() end
hotbartile["HotbarTile"].tweenPosition = function(slottile)
	slottile.positionMaid:DoCleaning()
	local tempTween
	if slottile.props.Selected then
		tempTween = tween:Create(slottile.frameRef:getValue(), TweenInfo.new(0.12), {
			Position = UDim2.fromScale(0, 0)
		})
	else
		tempTween = tween:Create(slottile.frameRef:getValue(), TweenInfo.new(0.12), {
			Position = UDim2.fromScale(0, 0)
		})
	end
	tempTween:Play()
	slottile.positionMaid:GiveTask(function()
		tempTween:Cancel()
	end)
end
hotbartile["HotbarTile"].render = function(slottile)
	local v5 = {
		Size = UDim2.fromScale(1, 1), 
		SizeConstraint = "RelativeYY"
	}
	local v6 = {}
	local v7 = {
		[roact.Ref] = slottile.frameRef, 
		Size = UDim2.fromScale(1, 1), 
		SizeConstraint = "RelativeYY", 
		BackgroundColor3 = Color3.new(0, 0, 0)
	}
	v7.BackgroundTransparency = 0.4
	v7.BorderMode = "Inset"
	local PixelSize = 1
	if slottile.props.Selected then
		PixelSize = 5
	end
	v7.BorderSizePixel = PixelSize
	v7.BorderColor3 = slottile.props.Selected and Color3.fromRGB(255, 255, 255) or Color3.new(0, 0, 0)
	v7.LayoutOrder = slottile.props.LayoutOrder
	v7.Image = nil
	v7.Selectable = slottile.props.store.Inventory.opened
	v7[roact.Event.MouseButton1Click] = function()
		slottile.props.OnClick()
	end
	v7[roact.Event.MouseEnter] = function(p7)

	end
	local v10 = { roact.createElement("TextLabel", {
			Text = "", 
			Size = UDim2.fromScale(0.23, 0.23), 
			Position = UDim2.fromScale(0, 0), 
			BackgroundTransparency = 1,
			BackgroundColor3 = slottile.props.Selected and Color3.fromRGB(255, 255, 255) or Color3.new(0, 0, 0), 
			BorderSizePixel = 0, 
			TextColor3 = slottile.props.Selected and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255), 
			Font = "Roboto", 
			TextScaled = true, 
			RichText = true
		}, { roact.createElement("UICorner", {
				CornerRadius = UDim.new(0.1, 0)
			}), roact.createElement("UIPadding", {
				PaddingTop = UDim.new(0.15, 0), 
				PaddingBottom = UDim.new(0.15, 0)
			}) }) }
	local v11 = #v10
	local v12 = false
	if slottile.props.HotbarSlot.item ~= nil then
		v12 = roact.createElement(itemviewport, {
			ItemType = slottile.props.HotbarSlot.item.itemType, 
			Amount = slottile.props.HotbarSlot.item.amount, 
			Size = UDim2.fromScale(0.8, 0.8), 
			Position = UDim2.fromScale(0.5, 0.15), 
			AnchorPoint = Vector2.new(0.5, 0)
		})
	end
	if v12 then
		if v12.elements ~= nil or v12.props ~= nil and v12.component ~= nil then
			v10[v11 + 1] = v12
		else
			for v13, v14 in ipairs(v12) do
				v10[v11 + v13] = v14
			end
		end
	end
	v6[#v6 + 1] = roact.createElement("ImageButton", v7, v10)
	return roact.createElement(empty, v5, v6)
end

for i,v in pairs(footstepsounds["FootstepSounds"]) do
    if isfile("bedwars/sounds/footstep/"..tostring(i).."-1.mp3") then
        v["walk"][1] = getcustomassetfunc("bedwars/sounds/footstep/"..tostring(i).."-1.mp3")
        v["walk"][2] = getcustomassetfunc("bedwars/sounds/footstep/"..tostring(i).."-2.mp3")
        v["run"][1] = getcustomassetfunc("bedwars/sounds/footstep/"..tostring(i).."-3.mp3")
        v["run"][2] = getcustomassetfunc("bedwars/sounds/footstep/"..tostring(i).."-4.mp3")
    end
end
footstepsounds["BlockFootstepSound"][4] = "WOOL"
footstepsounds["BlockFootstepSound"]["WOOL"] = 4
footstepsounds["FootstepSounds"][4] = {
    ["walk"] = {getcustomassetfunc("bedwars/sounds/footstep/4-1.mp3"), getcustomassetfunc("bedwars/sounds/footstep/4-2.mp3")},
    ["run"] = {getcustomassetfunc("bedwars/sounds/footstep/4-3.mp3"), getcustomassetfunc("bedwars/sounds/footstep/4-4.mp3")}
}
for i,v in pairs(itemtab) do
    if tostring(i):match("wool") then
        v.footstepSound = footstepsounds["BlockFootstepSound"]["WOOL"]
    end
end
for i,v in pairs(listfiles("bedwars/sounds")) do
    local str = tostring(tostring(v):gsub('bedwars/sounds\\', ""):gsub(".mp3", ""))
    if identifyexecutor():find("ScriptWare") then
        str = tostring(tostring(v):gsub('bedwars\\sounds\\', ""):gsub(".mp3", ""))
    end
    local item = sounds[tonumber(str)]
    if item then
        item.assetId = getcustomassetfunc(v)
    end
end 
for i,v in pairs(listfiles("bedwars")) do
    local str = tostring(tostring(v):gsub('bedwars\\', ""):gsub(".png", ""))
    local item = game.ReplicatedStorage.Items:FindFirstChild(str)
    if item then
        if isfile("bedwars/models/"..str..".mesh") then
            item.Handle.MeshId = getcustomassetfunc("bedwars/models/"..str..".mesh")
            item.Handle.TextureID = getcustomassetfunc("bedwars/models/"..str..".png")
            for i2,v2 in pairs(item.Handle:GetDescendants()) do
                if v2:IsA("MeshPart") then
                    v2.Transparency = 1
                end
            end
        else
            for i2,v2 in pairs(item:GetDescendants()) do
                if v2:IsA("Texture") then
                    v2.Texture = getcustomassetfunc(v)
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
                            v2["block"]["greedyMesh"]["textures"][i3] = getcustomassetfunc("bedwars/"..i2.."_side_"..i3..".png")
                        end
                    else
                     v2["block"]["greedyMesh"]["textures"] = {
                            [1] = getcustomassetfunc("bedwars/"..i2..".png")
                     }
                    end
                    if isfile("bedwars/"..i2.."_image.png") then
                        v2["image"] = getcustomassetfunc("bedwars/"..i2.."_image.png")
                    end
                else
                    v2["image"] = getcustomassetfunc("bedwars/"..i2..".png")
                end
            end
        end
    end
end
for i,v in pairs(game.Workspace.Map.Blocks:GetChildren()) do
    if isfile("bedwars/"..v.Name..".png") then
        for i2,v2 in pairs(v:GetDescendants()) do
            if v2:IsA("Texture") then
                v2.Texture = getcustomassetfunc("bedwars/"..v.Name..".png")
            end
        end
    end
end
game.Workspace.DescendantAdded:connect(function(v)
    if v.Parent == game.Workspace.Map.Blocks and isfile("bedwars/"..v.Name..".png") then
        for i2,v2 in pairs(v:GetDescendants()) do
            if v2:IsA("Texture") then
                v2.Texture = getcustomassetfunc("bedwars/"..v.Name..".png")
            end
        end
        v.DescendantAdded:connect(function(v3)
            if v3:IsA("Texture") then
                v3.Texture = getcustomassetfunc("bedwars/"..v.Name..".png")
            end
        end)
    end
    if v:IsA("Accessory") and isfile("bedwars/models/"..v.Name..".mesh") then
        spawn(function()
            local handle = v:WaitForChild("Handle")
            handle.MeshId = getcustomassetfunc("bedwars/models/"..v.Name..".mesh")
            handle.TextureID = getcustomassetfunc("bedwars/models/"..v.Name..".png")
            for i2,v2 in pairs(handle:GetDescendants()) do
                if v2:IsA("MeshPart") then
                    v2.Transparency = 1
                end
            end
        end)
    end
end)