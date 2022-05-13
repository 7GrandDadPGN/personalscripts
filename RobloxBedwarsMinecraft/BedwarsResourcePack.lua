repeat wait() until game:IsLoaded() == true
--repeat wait() until game.ReplicatedStorage ~= nil
--repeat wait() until game.ReplicatedStorage.Items ~= nil
--repeat wait() until game.Workspace ~= nil 
--repeat wait() until game.Workspace:FindFirstChild("Map") ~= nil

local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
local setthreadidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity
local getthreadidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity
local getasset = getsynasset or getcustomasset
local cachedthings = {}
local cachedthings2 = {}
local cachedsizes = {}

local function betterisfile(path)
    if cachedthings2[path] == nil then
        cachedthings2[path] = isfile(path)
    end
    return cachedthings2[path]
end

local function removeTags(str)
    str = str:gsub("<br%s*/>", "\n")
    return (str:gsub("<[^<>]->", ""))
end


local function getcustomassetfunc(path)
	if not isfile(path) then
		spawn(function()
            setthreadidentity(7)
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
            setthreadidentity(2)
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/7GrandDadPGN/personalscripts/main/RobloxBedwarsMinecraft/"..path,
			Method = "GET"
		})
		writefile(path, req.Body)
	end
    if cachedthings[path] == nil then
        cachedthings[path] = getasset(path)
    end
	return cachedthings[path]
end

local function cachesize(image)
    local thing = Instance.new("ImageLabel")
    thing.Image = getcustomassetfunc(image)
    thing.Size = UDim2.new(1, 0, 1, 0)
    thing.ImageTransparency = 0.999
    thing.BackgroundTransparency = 1
    thing.Parent = game.CoreGui.RobloxGui
    spawn(function()
        cachedsizes[image] = 1
        repeat wait() until thing.IsLoaded and thing.ContentImageSize ~= Vector2.new(0, 0)
        local oldidentity = getthreadidentity()
        setthreadidentity(7)
        cachedsizes[image] = thing.ContentImageSize.X / 256
        setthreadidentity(oldidentity)
        thing:Remove()
    end)
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

for i = 1, 5  do
    cachesize("bedwars/ui/death/"..tostring(i)..".png")
end
cachesize("bedwars/ui/widgets.png")
cachesize("bedwars/ui/icons.png")
cachesize("bedwars/ui/container/generic_54.png")

local Flamework = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
local newupdate = game.Players.LocalPlayer.PlayerScripts.TS:FindFirstChild("ui") and true or false
repeat wait() until Flamework.isInitialized
local KnitClient = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"].knit.src).KnitClient
local soundslist = require(game:GetService("ReplicatedStorage").TS.sound["game-sound"]).GameSound
local sounds = (newupdate and require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager or require(game:GetService("ReplicatedStorage").TS.sound["sound-manager"]).SoundManager)
local footstepsounds = require(game.ReplicatedStorage.TS.sound["footstep-sounds"])
local items = require(game.ReplicatedStorage.TS.item["item-meta"])
local itemtab = debug.getupvalue(items.getItemMeta, 1)
local maps = debug.getupvalue(require(game.ReplicatedStorage.TS.game.map["map-meta"]).getMapMeta, 1)
local defaultremotes = require(game.ReplicatedStorage.TS.remotes).default
local battlepassutils = require(game.ReplicatedStorage.TS["battle-pass"]["battle-pass-utils"]).BattlePassUtils
local inventoryutil = require(game.ReplicatedStorage.TS.inventory["inventory-util"]).InventoryUtil
local inventoryentity = require(game.ReplicatedStorage.TS.entity.entities["inventory-entity"]).InventoryEntity
local notification = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.ui.notifications.components["notification-card"]).NotificationCard
local hotbartile = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-tile"]).HotbarTile
local hotbaropeninventory = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-open-inventory"]).HotbarOpenInventory
local hotbarpartysection = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.party["hotbar-party-section"]).HotbarPartySection
local hotbarspectatesection = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.spectate["hotbar-spectator-section"]).HotbarSpectatorSection
local hotbarcustommatchsection = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["custom-match"]["hotbar-custom-match-section"]).HotbarCustomMatchSection
local respawntimer = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.games.bedwars.respawn.ui["respawn-timer"])
local hotbarhealthbar = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui.healthbar["hotbar-healthbar"]).HotbarHealthbar
local appcontroller = {closeApp = function() end}
if newupdate then
    appcontroller = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController
end
local getQueueMeta = function() end
if newupdate then
    local queuemeta = require(game.ReplicatedStorage.TS["game"]["queue-meta"]).QueueMeta
    getQueueMeta = function(type)
        return queuemeta[type]
    end
else
    getQueueMeta = require(game.ReplicatedStorage.TS["game"]["queue-meta"]).getQueueMeta
end
local hud2
local hotbarapp = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-app"]).HotbarApp
local hotbarapp2 = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-app"])
local itemshopapp = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.games.bedwars.shop.ui["item-shop"]["bedwars-item-shop-app"])[(newupdate and "BedwarsItemShopAppBase" or "BedwarsItemShopApp")]
local teamshopapp = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.games.bedwars["generator-upgrade"].ui["bedwars-team-upgrade-app"]).BedwarsTeamUpgradeApp
local victorysection = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers["game"].match.ui["victory-section"]).VictorySection
local battlepasssection = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.games.bedwars["battle-pass-progression"].ui["battle-pass-progession-app"]).BattlePassProgressionApp
local bedwarsshopitems = require(game.ReplicatedStorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop
local bedwarsbows = require(game.ReplicatedStorage.TS.games.bedwars["bedwars-bows"]).BedwarsBows
local roact = debug.getupvalue(hotbartile.render, 1)
local clientstore = (newupdate and require(game.Players.LocalPlayer.PlayerScripts.TS.ui.store).ClientStore or require(game.Players.LocalPlayer.PlayerScripts.TS.rodux.rodux).ClientStore)
local client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
local colorutil = debug.getupvalue(hotbartile.render, 2)
local soundmanager = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager
local itemviewport = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.inventory.ui["item-viewport"]).ItemViewport
local empty = debug.getupvalue(hotbartile.render, 6)
local tween = debug.getupvalue(hotbartile.tweenPosition, 1)
--local hotbarimage = getcustomassetfunc("bedwars/ui/widgets.png")
--local healthimage = getcustomassetfunc("bedwars/ui/icons.png")
--local shopimage = getcustomassetfunc("bedwars/ui/container/generic_54.png")
local flashing = false
local realcode = ""
local oldrendercustommatch = hotbarcustommatchsection.render
local crosshairref = roact.createRef()
local beddestroyref = roact.createRef()
local trapref = roact.createRef()
local timerref = roact.createRef()
local startimer = false
local timernum = 0

for i,v in pairs(footstepsounds["FootstepSounds"]) do
    if betterisfile("bedwars/sounds/footstep/"..tostring(i).."-1.mp3") then
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
for i2,v2 in pairs(soundslist) do 
    --print(i2,v2)
end
for i,v in pairs(listfiles("bedwars/sounds")) do
    local str = tostring(tostring(v):gsub('bedwars/sounds\\', ""):gsub(".mp3", ""))
    if identifyexecutor():find("ScriptWare") then
        str = tostring(tostring(v):gsub('bedwars\\sounds\\', ""):gsub(".mp3", ""))
    end 
    local item = soundslist[str]
    if item then
        soundslist[str] = getcustomassetfunc(v)
    end
end 