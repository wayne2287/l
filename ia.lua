--[[ Islands V3
--if not LPH_OBFUSCATED then
  --  LPH_JIT_MAX = function(...) return(...) end;
  --  LPH_NO_VIRTUALIZE = function(...) return(...) end;
--end

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer and game.Players.LocalPlayer.Character


local Loaded1,Loaded2,PromptLib1, Loaded3, Loaded4 = true,false,loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/Useful/PromptLibrary.lua"))(), true, false
if workspace.PrivateServer.Value == false then
    PromptLib1("Warning!","It's not recommended to use the script on a public server, as other players may notice and report you.\nAre you sure you want to load Project Z?",{
        {Text = "Yes",LayoutOrder = 0,Primary = false,Callback = function() Loaded2 = true end},
        {Text = "No",LayoutOrder = 0,Primary = true,Callback = function() end}
    }) repeat task.wait(1) until Loaded2
end

]]
-------------------------------
-- Needs To Be Changed Stuff --
-------------------------------

LastUpdated = 'Last Updated: March 22nd, 2026'
ScriptVersion = 'V2'
DiscordInvite = 'https://discord.gg/KxBkG2Ajkq'
local Whitelisted = true
local PV, PPV = 1234, 0
local CanDoSaves = nil
if isfolder and isfile and makefolder and writefile then CanDoSaves = 'yes' else CanDoSaves = nil end
local http_request = request or (syn and syn.request) or (http and http.request)


MobFarmHitWait = 0.3
resizeIncrement = 3 -- for block printer
resizeCooldown = .15 -- Set the desired delay in seconds -- for block printer
lastResizeTime = 0 -- for block printer

----------------------
-- Update Detection --
----------------------
--[[
if game.PlaceVersion ~= PV and workspace.PrivateServer.Value == true then
    PromptLib1("Warning!","Script has not been updated for Islands Version: "..tostring(game.PlaceVersion)..".\nAnti-cheat could have been updated.\nAre you sure you want to load Project Z?",{
        {Text = "Yes",LayoutOrder = 0,Primary = false,Callback = function() Loaded4 = true end},
        {Text = "No",LayoutOrder = 0,Primary = true,Callback = function() end}
    }) repeat task.wait(1) until Loaded4
end

if (isLGPremium and isLGPremium()) == true or not LPH_OBFUSCATED then
    Whitelisted = true
end
]]
if Whitelisted then
    MultiOrSingle = "Multi"
else
    MultiOrSingle = "Single"
end


--------------------
-- Remote Grabber --
--------------------

local remotes = game:GetService("ReplicatedStorage").TS.remotes
local GeneralRemotes = getscriptclosure(remotes.remotes)
local CombatRemotes = getscriptclosure(remotes["combat-remotes"])
local NetEntityRemotes = getscriptclosure(remotes["entity-net-remotes"])
local FishRemotes = getscriptclosure(remotes["fishing-remotes"])
local VendingMachineRemotes = getscriptclosure(remotes["vending-remotes"])

local function getConstantName(constantsTable, index)
    return getconstants(constantsTable)[index]
end

local function createRemoteName(path, baseRemote ,constantIndex)
    return baseRemote .. "/" .. getConstantName(path, constantIndex)
end

-- Combat Remotes
local CombatRemoteBase = getConstantName(GeneralRemotes, 79)
local MeleeRemote = createRemoteName(CombatRemotes, CombatRemoteBase, 43)
local ShootBowRemote = createRemoteName(CombatRemotes, CombatRemoteBase, 38)
local ShootSpellRemote = createRemoteName(CombatRemotes, CombatRemoteBase, 40)

-- Net Entity Remotes
local NetRemoteBase = getConstantName(GeneralRemotes, 87)
local NetRemote = createRemoteName(NetEntityRemotes, NetRemoteBase, 22)


-- Fish Remotes
local FishRemoteBase = getConstantName(GeneralRemotes, 85)
local ThrowRemote = createRemoteName(FishRemotes, FishRemoteBase, 26)
local CatchRemote = createRemoteName(FishRemotes, FishRemoteBase, 23)




-- Vending Machine Remotes
local VendingRemoteBase = getConstantName(GeneralRemotes, 79)-- + GeneralRemotesOffset)
local VendingRemotes = {
    buyVendingRemote = createRemoteName(VendingMachineRemotes, VendingRemoteBase, 35),
    withdrawMoneyVendingRemote = createRemoteName(VendingMachineRemotes, VendingRemoteBase, 34),
    depositMoneyVendingRemote = createRemoteName(VendingMachineRemotes, VendingRemoteBase, 36),
    openVendingRemote = createRemoteName(VendingMachineRemotes, VendingRemoteBase, 39),
    editVendingRemote = createRemoteName(VendingMachineRemotes, VendingRemoteBase, 37),
    closeVendingRemote1 = createRemoteName(VendingMachineRemotes, VendingRemoteBase, 38),
    closeVendingRemote2 = createRemoteName(VendingMachineRemotes, VendingRemoteBase, 40),
    stopEditingVendingRemote = createRemoteName(VendingMachineRemotes, VendingRemoteBase, 38),
    depositItemVendingRemote = createRemoteName(VendingMachineRemotes, VendingRemoteBase, 32),
    withdrawItemVendingRemote = createRemoteName(VendingMachineRemotes, VendingRemoteBase, 32)
}



-----------------
-- Key Grabber --
-----------------

-- hit with tool key
local onBlockHit = require(game:GetService("ReplicatedStorage").TS.tool.tools.shared["axe-tool"])['AxeTool']['onBlockHit']
local onBlockHitFunction = getproto(onBlockHit, 2)
local onBlockHitName = getconstant(onBlockHitFunction, 8)
local onBlockHitValue = getconstant(onBlockHitFunction, 10)--..getconstant(onBlockHitFunction, 11)

-- hit with sword key
local function getswordArgName()
    for i, v in next, getgc(true) do
        if type(v) == "table" and rawget(v, "hitUnit") then
            for index, value in next, v do
                if index ~= "hitUnit" then
                    return index
                end
            end
        end
    end
end
local attemptHit = getscriptclosure(game:GetService("ReplicatedStorage").TS.tool.tools.sword)
local attemptHitName = getswordArgName()
local attemptHitKey
--local attemptHitValue = getconstant(attemptHit, 75)..getconstant(attemptHit, 76)

-- pickup tool/fruits key
local pickupTool = require(game:GetService("StarterPlayer").StarterPlayerScripts.TS.ui.inventory["client-inventory-service"])['ClientInventoryService']['pickupTool']
local pickupToolName = getconstant(pickupTool, 23)
local pickupToolValue = getconstant(pickupTool, 25)--..getconstant(pickupTool, 26)

-- place block key
local placeBlock = require(game:GetService("ReplicatedStorage").TS.tool.behaivor["connectable-placement"])['ConnectablePlacementBehavior']['placeBlock']
local placeBlockName = getconstant(placeBlock, 50)
local placeBlockValue = tostring(getconstant(placeBlock, 53))--..tostring(getconstant(placeBlock, 54))

-- harvest crop key
local breakCrop = require(game:GetService("StarterPlayer").StarterPlayerScripts.TS.block.crop["crop-service"])['CropService']['breakCrop']
local breakCropName = getconstant(breakCrop, 22)
local breakCropValue = getconstant(breakCrop, 26)--..getconstant(breakCrop, 27)

-- deposit tool 
local depositTool = require(game.Players.LocalPlayer.PlayerScripts.TS.flame.controllers.workers["worker-controller"])['WorkerController']['depositTool']
local depositToolName = getconstant(depositTool, 4)
local depositToolValue = getconstant(depositTool, 7)--..getconstant(depositTool, 8)

-- shoot bow key
local shootBowProjectile = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.flame.controllers.combat["projectile-controller"])['ProjectileController']['shootBowProjectile']
local shootBowProjectileName = getconstant(shootBowProjectile, 1)
local shootBowProjectileValue = getupvalue(shootBowProjectile, 1)

-- shoot book key
local shootSpellProjectile = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.flame.controllers.combat["projectile-controller"])['ProjectileController']['shootSpellProjectile']
local shootSpellProjectileName = getconstant(shootSpellProjectile, 1)
local shootSpellProjectileValue = getupvalue(shootSpellProjectile, 1)

---------------
-- Variables --
---------------

local Players = game:GetService('Players')
local mouse = game:GetService('Players').LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local PathfindingService = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService('RunService')
local HttpService = game:GetService('HttpService')
local VirtualInputManager = game:GetService('VirtualInputManager')
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local ProximityPromptService = game:GetService("ProximityPromptService")

local Islands = workspace.Islands
local WildernessBlocks = workspace.WildernessBlocks
local lp = Players.LocalPlayer
local Character = lp.Character or lp.CharacterAdded:Wait()
local OnIcon = '11182316736'
local OffIcon = '11182317572'
local WarningIcon = ''
local InfoIcon = ''

local RemotePathMain = ReplicatedStorage:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged")

----------------------
-- Toggle Variables --
----------------------

-- Farming Toggles


-- Crop Farms
getgenv().BerryFarmToggle = false
getgenv().CropFarmToggle = false
getgenv().ForceXPToggle = false
getgenv().SeedPlantAuraToggle = false

-- Tree Farms
getgenv().WoodFarmToggle = false
getgenv().TreeAuraToggle = false
getgenv().CollectFruitsToggle = false
getgenv().CollectHoneyToggle = false
getgenv().AutoClipLeavesToggle = false
getgenv().TreePlantAuraToggle = false

-- Ore Farms
getgenv().OreFarmToggle = false
getgenv().IslandOreFarmToggle = false
getgenv().OreAuraToggle = false
getgenv().IslandOreAuraToggle = false

-- Flower Farms
getgenv().WaterFertileFlowersToggle = false
getgenv().CollectFlowersToggle = false

-- Fish Farm
getgenv().FishFarmToggle = false

-- Wild Farm
getgenv().WildFarmToggle = false
getgenv().CollectVoidParasitesToggle = false
getgenv().VoidGrassFarmToggle = false
getgenv().VoidSandFarmToggle = false
getgenv().AutoFossilToggle = false



-- Combat Toggles

-- Mob Farm
getgenv().MobFarmToggle = false

-- Boss Farm
getgenv().BossFarmToggle = false

-- Combat Utilities
getgenv().KillAuraToggle = false
getgenv().PlayerKillauraToggle = false
getgenv().BowAuraToggle = false



-- Misc Toggles

-- Inventory & Items
getgenv().CollectTreasureChestsToggle = false
getgenv().CollectNearDropsToggle = false
getgenv().AutoEatToggle = false
getgenv().AutoOpenEggsToggle = false

-- Crafting & Building
getgenv().PlowAreaToggle = false
getgenv().UnPlowAreaToggle = false
getgenv().PlowRadius = 10

getgenv().Multiplier = 5
getgenv().RemoveStoneAndTallGrassToggle = false

-- Pets & Creatures
getgenv().NetEntityToggle = false
getgenv().PetPetsToggle = false
getgenv().SpookTurkeysToggle = false


-- Mobility & Interaction
getgenv().IsNoclipping = false
getgenv().SelectedFieldOfViewAmount = 70




-- Machinery Toggles

-- Auto Utility
getgenv().AutoBlastFurnaceToggle = false
getgenv().AutoStonecutterToggle = false
getgenv().AutoSawmillToggle = false
getgenv().AutoSmallFurnaceToggle = false
getgenv().AutoCampfireToggle = false
getgenv().AutoCratePackerToggle = false
getgenv().AutoComposterToggle = false


-- Collection
getgenv().CollectIndustrialChestItemsToggle = false
getgenv().CollectChestItemsToggle = false

-- Totems
getgenv().UpgradeTotemsToggle = false
getgenv().AutoCollectTotemItemsToggle = false

-- Vending Machines
getgenv().VendingMachineSniperToggle = false
getgenv().VendingMachineSniperMaxPrice = 25

getgenv().StockVendingMachinesToggle = false
getgenv().EmptyBuyVendingMachinesToggle = false
getgenv().EmptyAllVendingMachinesToggle = false


-- World Edit Toggles
getgenv().NukerToggle = false
getgenv().ScaffoldToggle = false
getgenv().BreakSpecificBlocksToggle = false
getgenv().Abort = false


getgenv().AutoGetBuilderToolsToggle = false

-- Settings Toggles
getgenv().ShowAuraRadiusToggle = false
getgenv().TeleportWalkToggle = false
getgenv().ShowScriptNotificationsToggle = true

--------------
-- Settings --
--------------

local CropFarmToggleSettings = {SelectedCrops = {''},ReplantSeeds = false,WaterCrops = false}
local WoodFarmToggleSettings = {SelectedTree = '',IgnoreFruitTrees = false,BreakBlockUnder = false}
local OreFarmToggleSettings = {SelectedOres = {''},BreakBlockUnder = false,CurrentIsland = false}
local OreAuraToggleSettings = {Radius = 15}
local SeedPlantAuraToggleSettings = {Radius = 10}
local TreePlantAuraToggleSettings = {Radius = 10}
local TreeAuraToggleSettings = {Radius = 15}
local MobFarmToggleSettings = {SelectedMob = '',AlwaysCritical = false,YOffset=6,NoContact = false,UndergroundFarming = false,AboveFarming = false}
local BossFarmToggleSettings = {SelectedBoss = '',RespawnBoss = false,AlwaysCritical = false,YOffset=16, NoContact = false,UndergroundFarming = false,AboveFarming = false}
local BowAuraToggleSettings = {Delay = 0.5}
local NetEntityToggleSettings = {SelectedEntity = ''}
local GeneralSettings = {UsePathfinding = false,tweenSpeed = 8,TeleportOffset = Vector3.new(0,10,0)}
local AutoEatToggleSettings = {Time = 120,SelectedFood = ''}
local BuyItemSettings = {SelectedItem = '',SelectedAmount = 1}
local FishFarmToggleSettings = {FishFarmCatchWait = 0.1}
local WildFarmToggleSettings = {SelectedWildCrops = {''}}
local SaveAndLoadPositionSettings = {SavedPosition = nil}
local BlockPrinterSettings = {BreakingBlocks = false, FastPrint = 1, SelectedSpecificBlock = ''}
local SchematicaSettings = {ShowPreview = false}
local TotemToggleSettings = {SelectedTotem = 'wheat', UpgradeType = 'utility', UpgradeAmount = 0}
local CustomConveyorSpeedToggleSettings = {Speed = 4}
local KeyBindsFolder = {ToggleUIKeyBind = 'RightShift', FlyKeybind = 'F', NoclipKeybind = 'N'}
local ShapeGeneratorSettings = {SelectedShape = 'Circle', Radius = 10, Hollow = false, ShowPreview = false}

-- Tables --

local CropTypes = {'wheat','tomato','carrot','cactus','candyCane','chiliPepper','dragonfruit','grapeVine','melon','onion','pineapple','potato','pumpkin','radish','rice','seaweed','spinach','starfruit','voidParasite','spiritCrop','crystallineIvy','vineStem','opuntia'}
local MobTypes = {'slime', 'buffalkor', 'wizardLizard', 'skorp', 'voidDog', 'skeletonPirate', 'hostileCrab', 'magmaBlob', 'magmaGolem', 'voidCropEater'}
local BossTypes = {'slimeKing', 'slimeQueen', 'wizardBoss', 'desertBoss', 'golem', 'voidSerpent', 'magmaDragon','skorpSerpent'}
local OreTypes = {'Coal','Iron','Copper','Gold','Diamond','Stone','Granite','Andesite','Diorite','Marble','Slate','Prismarine','Electrite','Basalt','Amethyst','AmethystStone','Obsidian','Opal','Snow','Clay','Sandstone','SandstoneRed','Emerald'}
local IslandOres = {hub = {'Stone','Coal','Iron','Andesite','Granite','Diorite','Prismarine','Snow','Clay'}, slime = {'Stone','Coal','Prismarine','Iron'}, buffalkor = {'Iron','Coal','Copper','Gold','Basalt','Electrite','Slate','Marble'}, desert = {'Sandstone','SandstoneRed'},diamond = {'Diamond','Copper','Iron','Gold'}}
local IslandPositions = {Hub = Vector3.new(), Slime = Vector3.new(), Buffalkor = Vector3.new(), Diamond = Vector3.new(), Desert = Vector3.new()}
local TreeTypes = {'All','Oak','Birch','Pine','Maple','Hickory','Spirit','CherryBlossom'} if not Whitelisted then table.remove(TreeTypes, 1) end
local EntityTypes = {'firefly','frog','rabbit','bee','spirit'}
local PotionTypes = {'Remove All'}
local TeleportTypes = {'Pathfinding','Tween', 'New Method [Testing]'} if not Whitelisted then table.remove(TeleportTypes, 1) end
local BlastFurnaceItems = {'iron'}
local StonecutterItems = {'stone', 'aquamarineBlock', 'sandstone', 'redSandstone', 'slate','marble','smoothAquamarine','smoothSandstone','smoothRedSandstone','compactIce','andesite','diorite','granite','basalt','voidStoneBlock','stoneBrick','aquamarineBrick','slateBrick',
'marbleBrick','andesiteBrick','dioriteBrick','graniteBrick','basaltBrick','stoneTiles','aquamarineTiles','slateTiles','marbleTiles','andesiteTiles','dioriteTiles','graniteTiles','basaltTiles','voidStoneBrick','voidStoneCobble','voidStonePolished','voidStoneCarved',}
local TotemTypes = {'wheat','tomato','radish','potato','pumpkin','melon','carrot','pineapple','onion','grape','spinach','starfruit','dragonfruit','stone','andesite','diorite','granite','coal','clay','iron','aquamarine','marble','slate','sandstone','redSandstone'}
local TotemData = {Crop = {'wheat','tomato','radish','potato','pumpkin','melon','carrot','pineapple','onion','grape','spinach','starfruit','dragonfruit'}, Rock = {'stone','andesite','diorite','granite','coal','clay','iron','aquamarine','marble','slate','sandstone','redSandstone'}}
local PortalTPSpawns = {
    hub = Vector3.new(317, 27, -1057),
    slime = Vector3.new(700, 196, -216),
    spirit = Vector3.new(34, 291, 856),
    buffalkor = Vector3.new(1291, 391, 150),
    wizard = Vector3.new(1493, 338, -877),
    pirate = Vector3.new(-285, 366, -2000),
    maple = Vector3.new(-814, 250, -718),
    desert = Vector3.new(1126, 283, -1738)
}
local PortalLocations = {
    hub = Vector3.new(317, 27, -1057),
    slime = Vector3.new(151,33,-737),
    spirit = Vector3.new(654.445801, 184.972031, -134.859695),
    buffalkor = Vector3.new(885.671,173.853,24.1171),
    wizard = Vector3.new(1709.62317, 448.131409, -204.412949),
    desert = Vector3.new(1475.5, 337.77, -875.76),
    DiamondMines = Vector3.new(1578.18,207.697,106.508)
}


local BookTypes = {'spellbookAquamarine', 'spellbook', 'spellbookSpirit', 'staffDesert', 'candyCaneScepter', 'staffLightning'}

local IslandsList = {'Slime Island', 'Spirit Island', 'Buffalkor Island', 'Wizard Island', 'Desert Island', 'Void Isles', 'Pirate Island', 'Maple Island', 'Underworld', 'Diamond Mines'}
local StaffList = {22641473,4001781,225721992,21406719,20663325,413206749,44150636,459722531,542310559,22808138,59704814,1068738929,442693739,132271536,173472404,131458969,2061858792,23464867,541918948,309677867,131611316,46921956}
local CopiedBlocks = {Blocks = {}}

local DefaultTable =  {scriptName = 'Project Z', DiscordId = nil, DiscordUsername = nil}
lgVarsTbl = lgVarsTbl or DefaultTable

local scriptName = lgVarsTbl['scriptName'] or 'nil'
local DiscordId = lgVarsTbl['DiscordId'] or 'nil'
local DiscordUsername = lgVarsTbl['DiscordUsername'] or 'nil'


SavedJoinCodes = {}



function SaveSchematicaFile(filename)
    if CanDoSaves then
        local convertedBlocks = {}
        for blockType, cframes in pairs(CopiedBlocks.Blocks) do
            convertedBlocks[blockType] = {}
            for index, cframe in ipairs(cframes) do
                -- Convert the CFrame to an array of 12 numeric values
                local cframeData = {
                    cframe:components()
                }

                table.insert(convertedBlocks[blockType], cframeData)
            end
        end

        CopiedBlocks.Blocks = convertedBlocks
        local json = HttpService:JSONEncode(CopiedBlocks.Blocks)
        writefile("Project_Z/Islands/Builds/"..filename, json)
    else
        error('Executor Does NOT Support Save Files.')
    end
end


function LoadSchematicaFile(selectedFile)
    if CanDoSaves then
        local pathstring = 'Project_Z/Islands/Builds/'
        print(pathstring)
        local filePath = nil
        if isfile(pathstring .. tostring(selectedFile)) then
            filePath = pathstring .. tostring(selectedFile)
        elseif isfile(pathstring .. tostring(selectedFile) .. '.txt') then
            filePath = pathstring .. tostring(selectedFile) .. '.txt'
        elseif isfile(pathstring .. tostring(selectedFile) .. '.lua') then
            filePath = pathstring .. tostring(selectedFile) .. '.lua'
        elseif isfile(pathstring .. tostring(selectedFile) .. '.json') then
            filePath = pathstring .. tostring(selectedFile) .. '.json'
        end
        print(filePath)

        if filePath then
            local fileData = readfile(filePath)
            if fileData then
                local decodedData = HttpService:JSONDecode(fileData)
                if decodedData then
                    local loadedBlocks = {}
                    for blockType, blockData in pairs(decodedData) do
                        loadedBlocks[blockType] = {}
                        for _, cframeData in ipairs(blockData) do
                            -- Reconstruct CFrame from the array of 12 numeric values
                            local cframe = CFrame.new(unpack(cframeData))
    
                            table.insert(loadedBlocks[blockType], cframe)
                        end
                    end
    
                    -- Replace CopiedBlocks.Blocks with the loaded data
                    CopiedBlocks.Blocks = loadedBlocks
                end
            end
        else
            -- path not found
        end 
    end
end



function GetExecutor()
    return 'nil'
end


local ErrorIgnoreList = {'Timed out','Could not find','Caught error flushing store updates','Attempted to yield','Error updating props','Theme'}

function LogError(errormessage)
    if http_request then
     --   local msg = 'Script: '.. tostring(scriptName) .. '\nError Message: ' .. errormessage .. '\nExecutor: ' .. tostring(GetExecutor()) -- .. '\nDiscord User: ' .. tostring(DiscordUsername) .. '\nDiscord ID: ' .. tostring(DiscordId)
        --SendWebhook(msg, '1142954492673925120/e2FjbGAPjyFEmSC4wBeTf-IyiM0crtxOA_vOFZ1yMZwu09OfaCipicaevcuJ26tYRXJK')
    end
end

--------------------
-- Main Functions --
--------------------

function HashGen()
    return HttpService:GenerateGUID(false)
end


IslandsTable = {}

function GetIslands()
    for i,v in ipairs(Islands:GetChildren()) do
        if v:IsA('Model') then
            if v:FindFirstChild('Owners') then
                if v.Owners:FindFirstChildWhichIsA('NumberValue') then
                    local ThisPlayer = Players:GetNameFromUserIdAsync(v.Owners:FindFirstChildWhichIsA('NumberValue').Value)
                    IslandsTable[ThisPlayer.."'s Island"] = v
                end
            end
        end
    end
end

function GetOwner(Island)
    return tostring(Players:GetNameFromUserIdAsync(Island.Owners:FindFirstChildWhichIsA('NumberValue').Value))
end

function GetIsland()
    for i,v in ipairs(Islands:GetChildren()) do
        if v:IsA('Model') and v:FindFirstChild('Owners') and v:FindFirstChild('AccessBuild') then
            if v.Owners:FindFirstChild(lp.UserId) then
                return v
            elseif v.AccessBuild:FindFirstChild(lp.UserId) then
                return v
            else
                return v
            end
        end
     end
end



GetIslands()


-------------------------
-- Important Variables --
-------------------------

local Island = GetIsland() or nil
local Blocks = Island:FindFirstChild('Blocks') or nil
local Drops = Island:FindFirstChild('Drops') or nil
local Entities = Island:FindFirstChild('Entities') or nil 

local WildernessEntities = workspace.WildernessIsland.Entities or nil

local spawnPrefabs = workspace:FindFirstChild('spawnPrefabs') or nil
local Void = workspace:FindFirstChild('spawnPrefabs') and workspace:FindFirstChild('spawnPrefabs'):FindFirstChild('WildIslands.void') or nil
local WildEventTriggers = workspace:FindFirstChild('spawnPrefabs') and workspace:FindFirstChild('spawnPrefabs'):FindFirstChild('WildEventTriggers') or nil
local FossilSites = workspace:FindFirstChild('spawnPrefabs') and workspace:FindFirstChild('spawnPrefabs'):FindFirstChild('FossilSites') or nil


----------------------
-- Main Functions 2 --
----------------------




function DoPathFind(Goal)
    local human = Character.Humanoid
    local hrp = Character:FindFirstChild('HumanoidRootPart')
    if Character and human and hrp then
        local path = PathfindingService:CreatePath()
        path:ComputeAsync(hrp.Position, Goal)
        local waypoints = path:GetWaypoints()
        if path.Status == Enum.PathStatus.Success then
            -- Path Found!
                path.Blocked:Connect(function()
                    human:ChangeState(Enum.HumanoidStateType.Jumping)
                end)
                for i, waypoint in ipairs(waypoints) do
                    if waypoint.Action == Enum.PathWaypointAction.Jump then
                        human:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                    human:MoveTo(waypoint.Position)
                    human.MoveToFinished:Wait()
                end
        else
            -- No Path Found!
        end
    end   
end


ActiveTweens = {}

function CancelTweens()
    for tween in pairs(ActiveTweens) do
        tween:Cancel()
    end
    if Character.HumanoidRootPart:FindFirstChild('BodyVelocity') then
        Character.HumanoidRootPart.BodyVelocity:Destroy()
    end
    if Character.HumanoidRootPart:FindFirstChild('LinearVelocity') then
        Character.HumanoidRootPart.LinearVelocity:Destroy()
    end
    tpabort = false
end



local FloatName = 'fefgeEFGEWFGehwfh32ffevew'

    local doInstaTp = false -- false // true

    function TGoto(Goal, ForceTween, ModifiedSpeed, ForcePathfinding)
        
        ForceTween = ForceTween or false
        ModifiedSpeed = ModifiedSpeed or 1
        ForcePathfinding = ForcePathfinding or false
        MaxRange = 25
        
        if Character:FindFirstChildOfClass('Humanoid') and Character:FindFirstChildOfClass('Humanoid').SeatPart then
            Character:FindFirstChildOfClass('Humanoid').Sit = false
            task.wait(.1)
        end

        if GeneralSettings.TeleportType == 'Pathfinding' then -- or ForcePathfinding then
            DoPathFind(Goal)
        elseif GeneralSettings.TeleportType == 'Instant Teleport' then
          --   Character.HumanoidRootPart.CFrame = CFrame.new(Goal + Vector3.new(0, Character.Humanoid.HipHeight, 0))
            local Float = Instance.new('Part')
			Float.Name = FloatName
			Float.Parent = workspace
			Float.Transparency = 1
			Float.Size = Vector3.new(2,0.2,1.5)
			Float.Anchored = true
			local FloatValue = -3.1
			Float.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0,FloatValue,0)
            task.wait()
        elseif GeneralSettings.TeleportType == 'Tween' then

            local mag = (Character.HumanoidRootPart.Position - Goal).Magnitude
            if mag >= MaxRange or ForceTween then
                local tweenSpeed = GeneralSettings.tweenSpeed * 3 * ModifiedSpeed
                local time = mag / tweenSpeed

                local bp = Instance.new("BodyPosition")
                bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bp.P = 100000 -- Proportional gain
                bp.D = 1000 -- Derivative gain
                bp.Position = Goal + Vector3.new(0, Character.Humanoid.HipHeight, 0)

                local t = TweenService:Create(Character.HumanoidRootPart, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(Goal + Vector3.new(0, Character.Humanoid.HipHeight, 0))})
                t:Play()
                ActiveTweens[t] = true

                t.Completed:Connect(function()
                    bp:Destroy()
                    ActiveTweens[t] = nil

                    if workspace:FindFirstChild(FloatName) then
                        workspace[FloatName]:Destroy()
                    end

                    local Float = Instance.new('Part')
                    Float.Name = FloatName
                    Float.Parent = workspace
                    Float.Transparency = 1
                    Float.Size = Vector3.new(2, 0.2, 1.5)
                    Float.Anchored = true
                    local FloatValue = -3.1
                    Float.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, FloatValue, 0)
                end)
            end
        end
    end

    Character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
        if workspace:FindFirstChild(FloatName) then
            workspace[FloatName]:Destroy()
        end
    end)

function DistanceCheck(goal)
    return (goal - Character.HumanoidRootPart.Position).Magnitude
end


function EquipTool(tool)
    if not Character:FindFirstChild(tool) then
        if lp.Backpack:FindFirstChild(tool) then
            lp.Backpack:FindFirstChild(tool).Parent = Character
          --  Character.Humanoid:EquipTool(tool)
        end
    end
end

function BestWeapon_Inv()
    if Character:FindFirstChildWhichIsA('Tool') then return Character:FindFirstChildWhichIsA('Tool').Name end
    local BestWeapon, Damage = nil, 0
    for _,tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA('Tool') and (tool:FindFirstChild('sword') or tool:FindFirstChild('rageblade') ) then
            if Damage < require(game.ReplicatedStorage.TS.tool['tool-meta']).ToolMeta[tool.Name]['combat']['baseDamage'] then
                Damage = require(game.ReplicatedStorage.TS.tool['tool-meta']).ToolMeta[tool.Name]['combat']['baseDamage']
                BestWeapon = tool.Name 
            end
        end
    end
    return BestWeapon
end

LoadedIslands = {}
IslandsAndPositions = {}

function GetIslandsAndPositions()
    if workspace:FindFirstChild('spawnPrefabs') then
        if workspace.spawnPrefabs:FindFirstChild('Teleporter') then
            for i,v in ipairs(workspace.spawnPrefabs.Teleporter:GetChildren()) do
                if v:IsA('Model') and not IslandsAndPositions[v.Name] then
                    IslandsAndPositions[v.Name] = v:GetModelCFrame() + Vector3.new(0,50,0)
                end
            end
        end
    end
end

GetIslandsAndPositions()

function LoadIsland(island)
    if not LoadedIslands[island] then
        for i,v in ipairs(IslandsAndPositions) do
            if i == island then
                Character.HumanoidRootPart.CFrame = v
                table.insert(LoadedIslands, i)
            end
        end
    end                   
end

function GetClosestBlockForSchematica()
    local Distance, TargetBlock = math.huge, nil
    local IgnoreList = {'naturalRock1', 'tallGrass', 'sapling'}
    for i,v in next, Blocks:GetChildren() do
        if not table.find(IgnoreList, v.Name) and not string.find(string.lower(v.Name), 'fertile') and not string.find(string.lower(v.Name), 'sapling') then
            local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                TargetBlock = v
            end
        end
    end
    return TargetBlock
end

function CreateGuideBlock()
    for i,v in pairs(workspace:GetChildren()) do
        if v.Name == 'Area' and v:IsA('Folder') then
            v:Destroy()
        end
    end
    for i,v in pairs(CoreGui:GetChildren()) do
        if v.Name == 'Handles' and v:IsA('Handles') then
            v:Destroy()
        end
    end

    local AreaFolder = Instance.new('Folder', workspace)
    AreaFolder.Name = 'Area'

    local Guide = Instance.new('Part', AreaFolder)
    Guide.Name = 'Guide'
    Guide.BrickColor = BrickColor.new('Electric blue')
    Guide.CastShadow = false
    Guide.Anchored = true
    Guide.CanCollide = false
    Guide.Transparency = 1 -- 0.7
    Guide.Size = Vector3.new(3,3,3)
    Guide.Material = 'SmoothPlastic'
    Guide.Position = GetClosestBlockForSchematica().Position + Vector3.new(0,3,0)

    local SelectionBox = Instance.new('SelectionBox', Guide)
    SelectionBox.Color3 = Color3.fromRGB(255,255,255)
    SelectionBox.LineThickness = 0.05
    SelectionBox.SurfaceColor3 = Color3.fromRGB(255,255,255)
    SelectionBox.SurfaceTransparency = 1
    SelectionBox.Transparency = 0.4
    SelectionBox.Adornee = Guide
    SelectionBox.Visible = false
    
    local Handles = Instance.new('Handles', CoreGui)
    Handles.Color3 = Color3.fromRGB(155,255,255)
    Handles.Adornee = Guide
    Handles.Visible = false
    Handles.Name = 'Handles'
    Handles.MouseDrag:Connect(function(face, delta)
        currentTime = tick()
        if currentTime - lastResizeTime >= resizeCooldown then
            local axis
            local direction

            if delta >= 0.01 then
                if face == Enum.NormalId.Left then
                    axis = Vector3.new(resizeIncrement, 0, 0) -- X-axis in positive direction
                    direction = Vector3.new(-resizeIncrement, 0, 0)
                elseif face == Enum.NormalId.Right then
                    axis = Vector3.new(resizeIncrement, 0, 0) -- X-axis in positive direction
                    direction = Vector3.new(resizeIncrement, 0, 0)
                elseif face == Enum.NormalId.Top then
                    axis = Vector3.new(0, resizeIncrement, 0) -- Y-axis in positive direction
                    direction = Vector3.new(0, resizeIncrement, 0)
                elseif face == Enum.NormalId.Bottom then
                    axis = Vector3.new(0, resizeIncrement, 0) -- Y-axis in positive direction
                    direction = Vector3.new(0, -resizeIncrement, 0)
                elseif face == Enum.NormalId.Front then
                    axis = Vector3.new(0, 0, resizeIncrement) -- Z-axis in positive direction
                    direction = Vector3.new(0, 0, -resizeIncrement)
                elseif face == Enum.NormalId.Back then
                    axis = Vector3.new(0, 0, resizeIncrement) -- Z-axis in positive direction
                    direction = Vector3.new(0, 0, resizeIncrement)
                end
            else
                if face == Enum.NormalId.Left then
                    axis = Vector3.new(-resizeIncrement, 0, 0) -- X-axis in positive direction
                    direction = Vector3.new(resizeIncrement, 0, 0)
                elseif face == Enum.NormalId.Right then
                    axis = Vector3.new(-resizeIncrement, 0, 0) -- X-axis in positive direction
                    direction = Vector3.new(-resizeIncrement, 0, 0)
                elseif face == Enum.NormalId.Top then
                    axis = Vector3.new(0, -resizeIncrement, 0) -- Y-axis in positive direction
                    direction = Vector3.new(0, -resizeIncrement, 0)
                elseif face == Enum.NormalId.Bottom then
                    axis = Vector3.new(0, -resizeIncrement, 0) -- Y-axis in positive direction
                    direction = Vector3.new(0, resizeIncrement, 0)
                elseif face == Enum.NormalId.Front then
                    axis = Vector3.new(0, 0, -resizeIncrement) -- Z-axis in positive direction
                    direction = Vector3.new(0, 0, resizeIncrement)
                elseif face == Enum.NormalId.Back then
                    axis = Vector3.new(0, 0, -resizeIncrement) -- Z-axis in positive direction
                    direction = Vector3.new(0, 0, -resizeIncrement)
                end
            end
            
            if axis then
                Guide.Size = Guide.Size + axis
                Guide.Position = Guide.Position + direction / 2
                lastResizeTime = currentTime
            end
        end 
    end)
end

function CreatePreviewBlock()
    for i,v in pairs(workspace:GetChildren()) do
        if v.Name == 'PreviewBlock' or v.Name == 'PreviewHolder' then
            v:Destroy()
        end
    end
    for i,v in pairs(CoreGui:GetChildren()) do
        if v:IsA('Handles') then
            v:Destroy()
        end
    end

    local PreviewHolder = Instance.new('Folder', workspace)
    PreviewHolder.Name = 'PreviewHolder'

    local PreviewBlock = Instance.new('Part', workspace)
    PreviewBlock.Name = 'PreviewBlock'
    PreviewBlock.BrickColor = BrickColor.new('Sea green')
    PreviewBlock.CastShadow = false
    PreviewBlock.Anchored = true
    PreviewBlock.CanCollide = false
    PreviewBlock.Transparency = 1 -- 0.7
    PreviewBlock.Size = Vector3.new(3,3,3)
    PreviewBlock.Material = 'SmoothPlastic'
    PreviewBlock.Position = GetClosestBlockForSchematica().Position + Vector3.new(0,3,0)

    local SelectionBox = Instance.new('SelectionBox', PreviewBlock)
    SelectionBox.Color3 = Color3.fromRGB(255,255,255)
    SelectionBox.LineThickness = 0.05
    SelectionBox.SurfaceColor3 = Color3.fromRGB(255,255,255)
    SelectionBox.SurfaceTransparency = 1
    SelectionBox.Transparency = 0.4
    SelectionBox.Adornee = PreviewBlock
    SelectionBox.Visible = false
    
    local Handles = Instance.new('Handles', CoreGui)
    Handles.Color3 = Color3.fromRGB(255,255,255)
    Handles.Adornee = PreviewBlock
    Handles.Visible = false
    Handles.Name = 'Handles1'
    Handles.Style = Enum.HandlesStyle.Movement
    Handles.MouseDrag:Connect(function(face, delta)
        currentTime = tick()
        if currentTime - lastResizeTime >= resizeCooldown then
            local direction

            if delta >= 0.01 then
                if face == Enum.NormalId.Left then
                    direction = Vector3.new(-resizeIncrement, 0, 0)
                elseif face == Enum.NormalId.Right then
                    direction = Vector3.new(resizeIncrement, 0, 0)
                elseif face == Enum.NormalId.Top then
                    direction = Vector3.new(0, resizeIncrement, 0)
                elseif face == Enum.NormalId.Bottom then
                    direction = Vector3.new(0, -resizeIncrement, 0)
                elseif face == Enum.NormalId.Front then
                    direction = Vector3.new(0, 0, -resizeIncrement)
                elseif face == Enum.NormalId.Back then
                    direction = Vector3.new(0, 0, resizeIncrement)
                end
            else
                if face == Enum.NormalId.Left then
                    direction = Vector3.new(resizeIncrement, 0, 0)
                elseif face == Enum.NormalId.Right then
                    direction = Vector3.new(-resizeIncrement, 0, 0)
                elseif face == Enum.NormalId.Top then
                    direction = Vector3.new(0, -resizeIncrement, 0)
                elseif face == Enum.NormalId.Bottom then
                    direction = Vector3.new(0, resizeIncrement, 0)
                elseif face == Enum.NormalId.Front then
                    direction = Vector3.new(0, 0, resizeIncrement)
                elseif face == Enum.NormalId.Back then
                    direction = Vector3.new(0, 0, -resizeIncrement)
                end
            end
            
            if direction then
                PreviewBlock.Position = PreviewBlock.Position + direction
                for i,v in pairs(PreviewHolder:GetChildren()) do
                    v.Root.Position = v.Root.Position + direction
                end
			    lastResizeTime = currentTime
            end
        end 
    end)
end

CreatePreviewBlock()
CreateGuideBlock()

function GetGuideBlockPositions()
    local Start,End = nil,nil

    local Area = workspace:WaitForChild('Area')
    local Inside = Area:WaitForChild('Guide')

    Start = Inside.Position - Inside.Size / 2 + Vector3.new(1.5,1.5,1.5)
    
    End = Inside.Position + Inside.Size / 2 - Vector3.new(1.5,1.5,1.5)

    return Start,End
end


function GetClosestBlock(BlockList)
    local BlockList = BlockList or {}
    local Distance, TargetBlock = math.huge, nil
    for i,v in ipairs(Blocks:GetChildren()) do
        if table.find(BlockList, v.Name) then
            local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                TargetBlock = v
            end
        end
    end
    return TargetBlock
end

function GetClosestWildBlock(BlockList)
    local BlockList = BlockList or {}
    local Distance, TargetBlock = math.huge, nil
    for i,v in ipairs(WildernessBlocks:GetChildren()) do
        if table.find(BlockList, v.Name) then
            local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                TargetBlock = v
            end
        end
    end
    return TargetBlock
end

function HitBlock(block,part)
    if block and part then
        RemotePathMain.CLIENT_BLOCK_HIT_REQUEST:InvokeServer({
            block = block, 
            part = part, 
            pos = block.Position, 
            norm = Vector3.new(-1, 0, 0), 
            [onBlockHitName] = onBlockHitValue
        })
    end
end

function PlaceBlock(position,block)
    if position and block then
        local NewCF
        if tostring(type(position)) == 'userdata' then
            NewCF = position
        elseif tostring(type(position)) == 'vector' then
            NewCF = CFrame.new(position)
        end
        RemotePathMain.CLIENT_BLOCK_PLACE_REQUEST:InvokeServer({
            cframe = NewCF,
            blockType = block,
            [placeBlockName] = placeBlockValue,
            upperBlock = true
        })
    end
end

function CollectDrop(drop)
    if drop then
        RemotePathMain.CLIENT_TOOL_PICKUP_REQUEST:InvokeServer({
            tool = drop,
            [pickupToolName] = pickupToolValue
        })
    end
end

function HarvestCrop(plr, crop)
    if plr and crop then
        RemotePathMain.CLIENT_HARVEST_CROP_REQUEST:InvokeServer({
            [breakCropName] = breakCropValue,
            player = plr,
            model = crop
        })
    end
end

function ToolDeposit(blockType, tool, count)    
    if blockType and tool and count then
        RemotePathMain:WaitForChild("CLIENT_BLOCK_WORKER_DEPOSIT_TOOL_REQUEST"):InvokeServer({
            block = blockType,
            toolName = tool,
            amount = count,
            [depositToolName] = depositToolValue
        })
    end
end

function HitMob(mob)    
    if mob then
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)

     -- local animation = Character.Humanoid:LoadAnimation(Character.Animate.toolslash.ToolSlashAnim)
     -- animation:Play()
      
      
        local args = {[1] = HashGen(),[2] = {[1] = {[attemptHitName] = attemptHitKey,["hitUnit"] = mob}}}
        RemotePathMain:WaitForChild(MeleeRemote):FireServer(unpack(args))
    end
end

function ShootBow(mob)
    ArrowTypes = {'arrow1', 'arrow2', 'arrow3', 'longArrow1', 'longArrow2', 'longArrow3', 'crossbowBolt'}
    local NewBow, NewArrow = nil, 'empty'
    if mob and mob:FindFirstChild('HumanoidRootPart') and Character:FindFirstChildWhichIsA('Tool') then
        if string.find(Character:FindFirstChildWhichIsA('Tool').Name, 'bow') then
            NewBow = Character:FindFirstChildWhichIsA('Tool')
            for i,v in pairs(lp.Backpack:GetChildren()) do
                if table.find(ArrowTypes, v.Name) then
                    NewArrow = v.Name
                end
            end
            local NewDirection = (mob.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Unit
            if NewArrow ~= 'empty' and NewBow and NewDirection then
                local args = {[1] = HashGen(),[2] = {[1] = {["direction"] = NewDirection,["time"] = 1677028447.43909,["charge"] = 1,["arrowName"] = NewArrow,["bow"] = NewBow,[shootBowProjectileName] = shootBowProjectileValue}}}
                RemotePathMain:WaitForChild(ShootBowRemote):FireServer(unpack(args))
            end   
        end
    end            
end

function ShootSpell(mob)
   if mob and mob:FindFirstChild('HumanoidRootPart') then
    local NewDirection = (mob.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Unit
    local args = {[1] = HashGen(),[2] = {[1] = {[shootSpellProjectileName] = shootSpellProjectileValue,["direction"] = NewDirection,["shootType"] = 0,["spellBook"] = Character:FindFirstChildWhichIsA('Tool'),["time"] = 1677964067.174396,["charge"] = 1}}}
    RemotePathMain:WaitForChild(ShootSpellRemote):FireServer(unpack(args))
   end
end

-----------------------
-- Feature Functions --
-----------------------

function ShovelVoidGrass()
    local TargetBlock = GetClosestWildBlock({'grassVoid'})
    if TargetBlock and TargetBlock.Position then
        TGoto(TargetBlock.Position)
        task.spawn(function()
            local args = {[1] = {["shovelType"] = "shovelStone",["block"] = TargetBlock}}
            RemotePathMain.client_request_21:InvokeServer(unpack(args))
        end) 
    end   
end

function ShovelVoidSand()
    local TargetBlock = GetClosestWildBlock({'sandVoid'})
    if TargetBlock and TargetBlock.Position then
        TGoto(TargetBlock.Position)
        task.spawn(function()
            local args = {[1] = {["shovelType"] = "shovelStone",["block"] = TargetBlock}}
            RemotePathMain.client_request_21:InvokeServer(unpack(args))
        end)
    end
end


    function CollectChestItems()
        local Distance, Target = math.huge, nil
        for i,v in ipairs(Blocks:GetChildren()) do
            if string.find(string.lower(v.Name), 'chest') and not string.find(string.lower(v.Name), 'industrial') and v:FindFirstChild('Contents') and v.Contents:FindFirstChildWhichIsA('Tool') then
                local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                if mag <= Distance then
                    Distance = mag
                    Target = v
                end
            end
        end
        if Target and Target.Position and Target:FindFirstChild('Contents') and Target.Contents:FindFirstChildWhichIsA('Tool') then
            TGoto(Target.Position)
            local Contents = Target.Contents
            for i2,v2 in ipairs(Contents:GetChildren()) do
                if v2:IsA('Tool') and v2:FindFirstChild('Amount') then
                    local args = {[1] = {["chest"] = Target,["player_tracking_category"] = "join_from_web",["amount"] = v2.Amount.Value,["tool"] = v2,["action"] = "withdraw"}}
                    RemotePathMain:WaitForChild("CLIENT_CHEST_TRANSACTION"):InvokeServer(unpack(args))
                end
            end
        end
    end

    function CollectIndustrialChestItems()
        local Distance, Target = math.huge, nil
        for i,v in ipairs(Blocks:GetChildren()) do
            if string.find(string.lower(v.Name), 'chest') and string.find(string.lower(v.Name), 'industrial') and v:FindFirstChild('Contents') and v.Contents:FindFirstChildWhichIsA('Tool') then
                local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                if mag <= Distance then
                    Distance = mag
                    Target = v
                end
            end
        end
        if Target and Target.Position and Target:FindFirstChild('Contents') and Target.Contents:FindFirstChildWhichIsA('Tool') then
            TGoto(Target.Position)
            for i2,v2 in ipairs(Target.Contents:GetChildren()) do
                if v2:IsA('Tool') and v2:FindFirstChild('Amount') then
                    local args = {[1] = {["chest"] = Target,["player_tracking_category"] = "join_from_web",["amount"] = v2.Amount.Value,["tool"] = v2,["action"] = "withdraw"}}
                    RemotePathMain:WaitForChild("CLIENT_CHEST_TRANSACTION"):InvokeServer(unpack(args))
                end
            end
        end
    end
        
    function AutoSawmill()
        local Distance, Target, Type = math.huge, nil, ''
        for i,v in ipairs(Blocks:GetChildren()) do
            if v.Name == 'sawmill' and v:FindFirstChild('WorkerFuel') and v:FindFirstChild('WorkerContents') and v:FindFirstChild('WorkerOutputContents') then
                if v.WorkerOutputContents:FindFirstChildWhichIsA('Tool') then
                    local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                    if mag <= Distance then
                        Distance = mag
                        Target = v
                        Type = 'Collect'
                    end
                else
                    if not v.WorkerFuel:FindFirstChildWhichIsA('Tool') or not v.WorkerContents:FindFirstChildWhichIsA('Tool') then
                        local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                        if mag <= Distance then
                            Distance = mag
                            Target = v
                            Type = 'Fill'
                        end
                    end
                end   
            end
        end
        if Target and Target.Position and Target:FindFirstChild('WorkerFuel') and Target:FindFirstChild('WorkerContents') and Target:FindFirstChild('WorkerOutputContents') then
            TGoto(Target.Position)
            if Type == 'Collect' then
                for i,v in ipairs(Target.WorkerOutputContents:GetChildren()) do
                    if v:IsA('Tool') then
                        CollectDrop(v)
                    end
                end
            elseif Type == 'Fill' then
                if not Target.WorkerFuel:FindFirstChildWhichIsA('Tool') then
                    if lp.Backpack:FindFirstChild('coal') then
                        if lp.Backpack.coal:FindFirstChild('Amount') and lp.Backpack.coal.Amount.Value >= 2 then
                            ToolDeposit(Target, 'coal', 1)
                        end  
                    end
                end
                if not Target.WorkerContents:FindFirstChildWhichIsA('Tool') then
                    if Character:FindFirstChildWhichIsA('Tool') then
                        local Tool = Character:FindFirstChildWhichIsA('Tool')
                        if Tool:FindFirstChild('Amount') and lp.Backpack.coal.Amount.Value >= 1 then
                            ToolDeposit(Target, Tool.Name, 1)
                        end  
                    end
                end   
            end
        end
    end

    function AutoCampfire()
        local Distance, Target, Type = math.huge, nil, ''
        for i,v in ipairs(Blocks:GetChildren()) do
            if v.Name == 'campfire' and v:FindFirstChild('WorkerFuel') and v:FindFirstChild('WorkerContents') and v:FindFirstChild('WorkerOutputContents') then
                if v.WorkerOutputContents:FindFirstChildWhichIsA('Tool') then
                    local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                    if mag <= Distance then
                        Distance = mag
                        Target = v
                        Type = 'Collect'
                    end
                else
                    if not v.WorkerFuel:FindFirstChildWhichIsA('Tool') or not v.WorkerContents:FindFirstChildWhichIsA('Tool') then
                        local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                        if mag <= Distance then
                            Distance = mag
                            Target = v
                            Type = 'Fill'
                        end
                    end
                end   
            end
        end
        if Target and Target.Position and Target:FindFirstChild('WorkerFuel') and Target:FindFirstChild('WorkerContents') and Target:FindFirstChild('WorkerOutputContents') then
            TGoto(Target.Position)
            if Type == 'Collect' then
                for i,v in ipairs(Target.WorkerOutputContents:GetChildren()) do
                    if v:IsA('Tool') then
                        CollectDrop(v)
                    end
                end
            elseif Type == 'Fill' then
                if not Target.WorkerFuel:FindFirstChildWhichIsA('Tool') then
                    if lp.Backpack:FindFirstChild('coal') then
                        if lp.Backpack.coal:FindFirstChild('Amount') and lp.Backpack.coal.Amount.Value >= 2 then
                            ToolDeposit(Target, 'coal', 1)
                        end  
                    end
                end
                if not Target.WorkerContents:FindFirstChildWhichIsA('Tool') then
                    if Character:FindFirstChildWhichIsA('Tool') then
                        local Tool = Character:FindFirstChildWhichIsA('Tool')
                        if Tool:FindFirstChild('Amount') and lp.Backpack.coal.Amount.Value >= 1 then
                            ToolDeposit(Target, Tool.Name, 1)
                        end  
                    end
                end   
            end
        end
    end

    function AutoSmallFurnace()
        local Distance, Target, Type = math.huge, nil, ''
        for i,v in ipairs(Blocks:GetChildren()) do
            if v.Name == 'smallFurnace' and v:FindFirstChild('WorkerFuel') and v:FindFirstChild('WorkerContents') and v:FindFirstChild('WorkerOutputContents') then
                if v.WorkerOutputContents:FindFirstChildWhichIsA('Tool') then
                    local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                    if mag <= Distance then
                        Distance = mag
                        Target = v
                        Type = 'Collect'
                    end
                else
                    if not v.WorkerFuel:FindFirstChildWhichIsA('Tool') or not v.WorkerContents:FindFirstChildWhichIsA('Tool') then
                        local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                        if mag <= Distance then
                            Distance = mag
                            Target = v
                            Type = 'Fill'
                        end
                    end
                end   
            end
        end
        if Target and Target.Position and Target:FindFirstChild('WorkerFuel') and Target:FindFirstChild('WorkerContents') and Target:FindFirstChild('WorkerOutputContents') then
            TGoto(Target.Position)
            if Type == 'Collect' then
                for i,v in ipairs(Target.WorkerOutputContents:GetChildren()) do
                    if v:IsA('Tool') then
                        CollectDrop(v)
                    end
                end
            elseif Type == 'Fill' then
                if not Target.WorkerFuel:FindFirstChildWhichIsA('Tool') then
                    if lp.Backpack:FindFirstChild('coal') then
                        if lp.Backpack.coal:FindFirstChild('Amount') and lp.Backpack.coal.Amount.Value >= 2 then
                            ToolDeposit(Target, 'coal', 1)
                        end  
                    end
                end
                if not Target.WorkerContents:FindFirstChildWhichIsA('Tool') then
                    if Character:FindFirstChildWhichIsA('Tool') then
                        local Tool = Character:FindFirstChildWhichIsA('Tool')
                        if Tool:FindFirstChild('Amount') and lp.Backpack.coal.Amount.Value >= 1 then
                            ToolDeposit(Target, Tool.Name, 1)
                        end  
                    end
                end   
            end
        end
    end

    function AutoCompost()
        local Distance, Target, Type = math.huge, nil, ''
        for i,v in ipairs(Blocks:GetChildren()) do
            if v.Name == 'composter' and v:FindFirstChild('WorkerContents') and v:FindFirstChild('WorkerOutputContents') then
                if v.WorkerOutputContents:FindFirstChildWhichIsA('Tool') then
                    local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                    if mag <= Distance then
                        Distance = mag
                        Target = v
                        Type = 'Collect'
                    end
                else
                    if not v.WorkerFuel:FindFirstChildWhichIsA('Tool') or not v.WorkerContents:FindFirstChildWhichIsA('Tool') then
                        local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                        if mag <= Distance then
                            Distance = mag
                            Target = v
                            Type = 'Fill'
                        end
                    end
                end   
            end
        end
        if Target and Target.Position then
            TGoto(Target.Position)
            if Type == 'Collect' then
                for i,v in ipairs(Target.WorkerOutputContents:GetChildren()) do
                    if v:IsA('Tool') then
                        CollectDrop(v)
                    end
                end
            elseif Type == 'Fill' then
                if not Target.WorkerContents:FindFirstChildWhichIsA('Tool') then
                    if Character:FindFirstChildWhichIsA('Tool') then
                        local Tool = Character:FindFirstChildWhichIsA('Tool')
                        if Tool:FindFirstChild('Amount') then
                            ToolDeposit(Target, Tool.Name, 1)
                        end  
                    end
                end   
            end
        end
    end

    function AutoCratePacker()
        if lp and Character and Character:FindFirstChildWhichIsA('Tool') then
            Character.Humanoid.Sit = true
            local args = {[1] = {["player_tracking_category"] = "join_from_web",["tool"] = Character:FindFirstChildWhichIsA('Tool'),["amount"] = 1}}
            RemotePathMain:WaitForChild("CLIENT_DROP_TOOL_REQUEST"):InvokeServer(unpack(args))
        end
    end

    function AutoStonecutter()
        local Distance, Target, Type = math.huge, nil, ''
        for i,v in ipairs(Blocks:GetChildren()) do
            if v.Name == 'stonecutter' and v:FindFirstChild('WorkerFuel') and v:FindFirstChild('WorkerContents') and v:FindFirstChild('WorkerOutputContents') then
                if v.WorkerOutputContents:FindFirstChildWhichIsA('Tool') then
                    local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                    if mag <= Distance then
                        Distance = mag
                        Target = v
                        Type = 'Collect'
                    end
                else
                    if not v.WorkerFuel:FindFirstChildWhichIsA('Tool') or not v.WorkerContents:FindFirstChildWhichIsA('Tool') then
                        local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                        if mag <= Distance then
                            Distance = mag
                            Target = v
                            Type = 'Fill'
                        end
                    end
                end   
            end
        end
        if Target and Target.Position and Target:FindFirstChild('WorkerFuel') and Target:FindFirstChild('WorkerContents') and Target:FindFirstChild('WorkerOutputContents') then
            TGoto(Target.Position)
            if Type == 'Collect' then
                for i,v in ipairs(Target.WorkerOutputContents:GetChildren()) do
                    if v:IsA('Tool') then
                        CollectDrop(v)
                    end
                end
            elseif Type == 'Fill' then
                if not Target.WorkerFuel:FindFirstChildWhichIsA('Tool') then
                    if lp.Backpack:FindFirstChild('coal') then
                        if lp.Backpack.coal:FindFirstChild('Amount') and lp.Backpack.coal.Amount.Value >= 2 then
                            ToolDeposit(Target, 'coal', 1)
                        end  
                    end
                end
                if not Target.WorkerContents:FindFirstChildWhichIsA('Tool') then
                    if Character:FindFirstChildWhichIsA('Tool') then
                        local Tool = Character:FindFirstChildWhichIsA('Tool')
                        if Tool:FindFirstChild('Amount') and lp.Backpack.coal.Amount.Value >= 1 then
                            ToolDeposit(Target, Tool.Name, 1)
                        end  
                    end
                end   
            end
        end
    end

    function AutoBlastFurnace()
        local Distance, Target, Type = math.huge, nil, ''
        for i,v in ipairs(Blocks:GetChildren()) do
            if v.Name == 'blastFurnace' and v:FindFirstChild('WorkerFuel') and v:FindFirstChild('WorkerContents') and v:FindFirstChild('WorkerOutputContents') then
                if v.WorkerOutputContents:FindFirstChildWhichIsA('Tool') then
                    local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                    if mag <= Distance then
                        Distance = mag
                        Target = v
                        Type = 'Collect'
                    end
                else
                    if not v.WorkerFuel:FindFirstChildWhichIsA('Tool') or not v.WorkerContents:FindFirstChildWhichIsA('Tool') then
                        local mag = (Character.HumanoidRootPart.Position - v.Position).Magnitude
                        if mag <= Distance then
                            Distance = mag
                            Target = v
                            Type = 'Fill'
                        end
                    end
                end   
            end
        end
        if Target and Target.Position and Target:FindFirstChild('WorkerFuel') and Target:FindFirstChild('WorkerContents') and Target:FindFirstChild('WorkerOutputContents') then
            TGoto(Target.Position)
            if Type == 'Collect' then
                for i,v in ipairs(Target.WorkerOutputContents:GetChildren()) do
                    if v:IsA('Tool') then
                        CollectDrop(v)
                    end
                end
            elseif Type == 'Fill' then
                if not Target.WorkerFuel:FindFirstChildWhichIsA('Tool') then
                    if lp.Backpack:FindFirstChild('coal') then
                        if lp.Backpack.coal:FindFirstChild('Amount') and lp.Backpack.coal.Amount.Value >= 2 then
                            ToolDeposit(Target, 'coal', 1)
                        end  
                    end
                end
                if not Target.WorkerContents:FindFirstChildWhichIsA('Tool') then
                    if Character:FindFirstChildWhichIsA('Tool') then
                        local Tool = Character:FindFirstChildWhichIsA('Tool')
                        if Tool:FindFirstChild('Amount') and lp.Backpack.coal.Amount.Value >= 1 then
                            ToolDeposit(Target, Tool.Name, 1)
                        end  
                    end
                end   
            end
        end
    end

    FLYING = false
    QEfly = true
    FlightSpeed = 0.5
    VehicleFlightSpeed = 1
    IYMouse = lp:GetMouse()

function sFLY(vfly)
	repeat wait() until lp and Character and Character.HumanoidRootPart and Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until IYMouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = Character.HumanoidRootPart
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat task.wait()
				if not vfly and Character:FindFirstChildOfClass('Humanoid') then
					Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Character:FindFirstChildOfClass('Humanoid') then
				Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and VehicleFlightSpeed or FlightSpeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and VehicleFlightSpeed or FlightSpeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and VehicleFlightSpeed or FlightSpeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and VehicleFlightSpeed or FlightSpeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and VehicleFlightSpeed or FlightSpeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and VehicleFlightSpeed or FlightSpeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Character:FindFirstChildOfClass('Humanoid') then
		Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

Noclipping = nil
Clip = true
function NoclipLoop()
    if Clip == false and Character ~= nil then
        for _, child in ipairs(Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= FloatName and child.Name ~= AuraFloatName then
                child.CanCollide = false
            end
        end
    end
end



function FilledCheck(Position)
    local Parts = workspace:FindPartsInRegion3(Region3.new(Position, Position), nil, math.huge)
    for i, v in next, Parts do
        if v and v.Parent and v.Parent.Name == "Blocks" then
            return true
        end
    end
    return false
end



function isAreaFilled(Start,End)
    local Parts = workspace:FindPartsInRegion3(Region3.new(Start, End), nil, math.huge)
    for i, v in next, Parts do
        if v and v.Parent and v.Parent.Name == "Blocks" then
            return true
        end
    end
    return false
end

function GetSelectedAreaBlockCount(Start, End)
    local CurrentCount = 0
    for X = Start.X, End.X, 3 do
        for Y = Start.Y, End.Y, 3 do
            for Z = Start.Z, End.Z, 3 do
                CurrentCount += 1
            end
        end
    end
    return CurrentCount
end


function PlaceBlocks(Start, End, Block)
    local Start, End = Vector3.new(math.min(Start.X, End.X), math.min(Start.Y, End.Y), math.min(Start.Z, End.Z)), Vector3.new(math.max(Start.X, End.X), math.max(Start.Y, End.Y), math.max(Start.Z, End.Z))
    Block = Block or 'grass'
    local Blockas, Completed = {}, false
    for X = Start.X, End.X, 3 do
        for Y = Start.Y, End.Y, 3 do
            for Z = Start.Z, End.Z, 3 do
                if Abort == true then return end
                local Position = Vector3.new(X, Y, Z)
                if not FilledCheck(Position) then
                    Blockas[#Blockas + 1] = Position
                end
            end
        end
    end
    while not Abort and task.wait() and not Completed do
        local Distance, TargetPosition, Index = math.huge, nil, 0
        for i,v in next, Blockas do
            local mag = (v - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                TargetPosition = v
                Index = i
            end
        end
        if TargetPosition and Character:FindFirstChildWhichIsA('Tool') then
            TGoto(TargetPosition + Vector3.new(0,5,0), false, BlockPrinterSettings.FastPrint)    
            task.spawn(function()
                PlaceBlock(TargetPosition,Block)
            end)
            Blockas[Index] = nil
        else
            Completed = true
        end
    end
end


function BreakBlocks(Start, End)
    local Distance, TargetBlock = math.huge, nil
    local Start, End = Vector3.new(math.min(Start.X, End.X), math.min(Start.Y, End.Y), math.min(Start.Z, End.Z)), Vector3.new(math.max(Start.X, End.X), math.max(Start.Y, End.Y), math.max(Start.Z, End.Z))
    local Region = Region3.new(Start, End)
    for i, v in next, workspace:FindPartsInRegion3(Region, nil, math.huge) do
        if Abort then -- or not BlockPrinterSettings.BreakingBlocks then 
            Abort = false
         --   BlockPrinterSettings.BreakingBlocks = false
            break 
        end
        if v.Name ~= "bedrock" and v.Parent ~= nil and v.Parent.Parent ~= nil and (not v:FindFirstChild("portal-to-spawn")) and v.Parent and v.Parent.Name == "Blocks" and not Abort then
            local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                TargetBlock = v
            end
        end
    end
    if TargetBlock and TargetBlock.Position then
        TGoto(TargetBlock.Position)
        repeat task.wait(0.001)
            
            if TargetBlock ~= nil and TargetBlock:IsDescendantOf(workspace) then
                task.spawn(function()
                    HitBlock(TargetBlock,TargetBlock)
                end)
            end
        until TargetBlock == nil or (not TargetBlock:IsDescendantOf(workspace)) or Abort == true -- or BlockPrinterSettings.BreakingBlocks == false
    --  BlockPrinterSettings.BreakingBlocks = false
    end
end


function EncodeCFrame(cfr)
    return {cfr:components()}
end

function DecodeCFrame(tbl)
    return CFrame.new(unpack(tbl))
end




function FindFossilSite()
    local Distance, Closest = math.huge, nil
    for i,v in pairs(FossilSites:GetChildren()) do
        if v:IsA('Part') then
            local mag = (v.Position - Character.Head.Position).Magnitude
            if mag < Distance then
                Distance = mag
                Closest = v
            end
        end
    end
    return Closest
end

function CopyBlocks(Start, End)
    local ClosestBlockPos = GetClosestBlockForSchematica().Position
    CopiedBlocks.Blocks = {}
    local Start, End = Vector3.new(math.min(Start.X, End.X), math.min(Start.Y, End.Y), math.min(Start.Z, End.Z)), Vector3.new(math.max(Start.X, End.X), math.max(Start.Y, End.Y), math.max(Start.Z, End.Z))
    local Region = Region3.new(Start, End)
    for i, v in next, workspace:FindPartsInRegion3(Region, nil, math.huge) do
        if v.Name ~= "bedrock" and v.Parent ~= nil and v.Parent.Parent ~= nil and (not v:IsA('Highlight')) and (not v:FindFirstChild("portal-to-spawn")) and v.Parent.Name == "Blocks" then
            local modifiedString = v.Name
            if v.Name == 'dirt' or v.Name == 'soil' then
                modifiedString = 'grass'
            end
            local cf = (v.CFrame - ClosestBlockPos)
            if not CopiedBlocks.Blocks[modifiedString] then
                CopiedBlocks.Blocks[modifiedString] = {}
            end

            table.insert(CopiedBlocks.Blocks[modifiedString], cf)
        end
    end
end

function CheckIfAreaIsClear(Start, End)
    local Start, End = Vector3.new(math.min(Start.X, End.X), math.min(Start.Y, End.Y), math.min(Start.Z, End.Z)), Vector3.new(math.max(Start.X, End.X), math.max(Start.Y, End.Y), math.max(Start.Z, End.Z))
    local Region, BlockList = Region3.new(Start, End), {}
    for i, v in next, workspace:FindPartsInRegion3(Region, nil, math.huge) do
        if v.Parent ~= nil and v.Parent.Parent ~= nil and v.Parent and v.Parent.Name == "Blocks" then
            table.insert(BlockList, v)
        end
    end
    if #BlockList == 0 then
        return true
    else
        return false
    end
end


function PasteBlocks()
    if Abort then return end
    for BlockType,CFrames in pairs(CopiedBlocks.Blocks) do
        if Abort then break end
        --[[
        local Block = lp.Backpack:FindFirstChild(BlockType) or nil
        if not Block or (Block and Block:FindFirstChild('Amount') and Block:FindFirstChild('Amount').Value < #CFrames) then
            warn('Missing: ' .. tostring(#CFrames - Block:FindFirstChild('Amount').Value) .. ' ' .. Block.Name)
        end]]
      --  if not Block then continue end
           -- print(Block)
            for i2,CF in pairs(CFrames) do
                if Abort then break end
                local NewCF = CF + workspace:FindFirstChild('PreviewBlock').Position
                if NewCF and not FilledCheck(NewCF.Position) and not Abort then
                    TGoto(NewCF.Position + Vector3.new(0,6,0))
                    task.spawn(function()    
                        PlaceBlock(NewCF, BlockType)
                    end)
                    task.wait()
                end
            end     
    end
end

function PasteBlocks2()
    while not Abort do
        local closestDistance = math.huge
        local closestCF = nil
        local closestBlockType = nil
        
        for BlockType, CFrames in pairs(CopiedBlocks.Blocks) do
            for i2, CF in pairs(CFrames) do
                local NewCF = CF + workspace:FindFirstChild('PreviewBlock').Position
                
                if NewCF and not FilledCheck(NewCF.Position) then
                    local distance = (NewCF.Position - CF.Position).Magnitude
                    
                    if distance < closestDistance then
                        closestDistance = distance
                        closestCF = NewCF
                        closestBlockType = BlockType
                    end
                end
            end
        end
        
        if closestCF then
            TGoto(closestCF.Position + Vector3.new(0, 6, 0))
            PlaceBlock(closestCF, closestBlockType)
            task.wait()
        else
            break  -- No available blocks found, exit the loop
        end
    end
end

function PasteBlocks3()
    if Abort then return end
    local Blockas, Completed,BType = {}, false, nil
    for BlockType,CFrames in pairs(CopiedBlocks.Blocks) do
        Blockas = {}
        BType = BlockType
        for index, CF in pairs(CFrames) do
            local NewCF = CF + workspace:FindFirstChild('PreviewBlock').Position
            if not FilledCheck(NewCF.Position) then
                Blockas[#Blockas + 1] = NewCF
            end
        end


    end


    while not Abort and task.wait() and not Completed do
        local Distance, TargetCFrame, Index = math.huge, nil, 0
        for i,CF in next, Blockas do
            local mag = (CF.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                TargetCFrame = CF
                Index = i
            end
        end
        if TargetCFrame and (Character:FindFirstChild(BType) or lp.Backpack:FindFirstChild(BType)) then
            TGoto(TargetPosition + Vector3.new(0,6,0))    
            task.spawn(function()
                PlaceBlock(TargetCFrame,BType)
            end)
            Blockas[Index] = nil
        else
            Completed = true
        end
    end
end



    
             

    



--[[
local MerchantItemList = {
    general={grass=101,sand=102,gravel=103,glass_pane=104,glass_block=105,water_bucket=106,red_rug=107,checker_tiled_block=108,caution_block=109,haybale_block=110,hillside_hut_painting=1110,
            halycon_view_painting=1111,picnic_painting=1112,islands_painting=1113,luxury_ceiling_light=1200,luxury_wall_light=1225,luxury_lamp=1250,luxury_candle=1300,luxury_sink=1325,
            luxury_table=1350,luxury_sofa=1400,luxury_street_lamp=1450,luxury_bathtub=1500,luxury_egg_sculpture=1550},
    mechanic={spawn_block=3},
    seeds={wheat_seeds=101,tomato_seeds=102,potato_seeds=103,carrot_seeds=104,spinach_seeds=105,onion_seeds=106,grape_seeds=107,cactus_seeds=108,rice_seeds=109,dragon_fruit_seeds=110,
            oak_sapling=201,pine_sapling=202,birch_sapling=203,maple_sapling=204,avocado_tree_sapling=206,hickory_sapling=205,plum_tree_sapling=207},
    wholesaler={crate_packer=1},
    totems={stone_totem=1,andesite_totem=11,diorite_totem=12,granite_totem=13,coal_totem=3,clay_totem=4,wheat_totem=50,iron_totem=2,aquamarine_totem=7,tomato_totem=60,radish_totem=100,marble_totem=5,
            potato_totem=70,pumpkin_totem=110,slate_totem=6,watermelon_totem=120,carrot_totem=80,sandstone_totem=8,red_sandstone_totem=9,pineapple_totem=121,onion_totem=90,grape_totem=93,
            spinach_totem=91,starfruit_totem=130,dragonfruit_totem=92},
    tailor={sewing_button=1,white_yarn=2,red_yarn=3,orange_yarn=4,yellow_yarn=5,lightgetgenv()green_yarn=6,darkgetgenv()green_yarn=7,cyan_yarn=8,blue_yarn=9,purple_yarn=10,pink_yarn=11,black_yarn=12},
    adventurer={stone_short_arrow=18,iron_short_arrow=19,steel_short_arrow=20,stone_long_arrow=21,iron_long_arrow=22,steel_long_arrow=23,long_crossbow_bolt=24},
    animal={cow_spawn_egg_tier_1=10,potion_of_fertility=40,chicken_spawn_egg_tier_1=15,sheep_spawn_egg_tier_1=20,pig_spawn_egg_tier_1=30,duck_spawn_egg_tier_1=35,yak_spawn_egg_tier_1=36,horse_spawn_egg_tier_1=37},
    florist={fertile_yellow_daffodil=1,fertile_red_daffodil=2,pottery_bench=3,fertile_red_chrysanthemum=4,fertile_black_chrysanthemum=5},
    travellingPirate={treasure_map=1},
    pirateSlayer={crystalized_obsidian=2,obsidian_hilt=3},
    pirateBotanist={kiwifruit_tree_sapling=2},
    pirateMiner={obsidian_totem=1},
    oilBarron={oil_resource_deed=3},
    turkeyAnimals={turkey_spawn_egg_tier_1=10,raspberry_seeds=11},
    minerJade={copper_deposit_deed=3,gold_deposit_deed=4},
    banker={coin_pile=1,cash_pile=2,security_safe=3,security_rope=4,security_window=5}

}


function BuyItem(item, amount)
    for i,v in ipairs(MerchantItemList) do
        if table.find(v, item) then
            local args = {[1] = {["merchant"] = "general",["offerId"] = 106,["amount"] = amount}}
            RemotePathMain.CLIENT_MERCHANT_ORDER_REQUEST:InvokeServer(unpack(args))
        end
    end
end
]]


function RemoveTextures()
    local Terrain = workspace:FindFirstChildOfClass('Terrain')
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 0
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    settings().Rendering.QualityLevel = 1
    LPH_NO_VIRTUALIZE(function() -- removes obfuscation to make this section MUCH faster
        for i,v in ipairs(game:GetDescendants()) do
            task.wait(0.01)
            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
                v.CastShadow = false
            elseif v:IsA("Decal") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            end
        end
        for i,v in ipairs(Lighting:GetDescendants()) do
            task.wait(0.01)
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
    end)()
    workspace.DescendantAdded:Connect(function(child)
        coroutine.wrap(function()
            if child:IsA('ForceField') then
                RunService.Heartbeat:Wait()
                child:Destroy()
            elseif child:IsA('Sparkles') then
                RunService.Heartbeat:Wait()
                child:Destroy()
            elseif child:IsA('Smoke') or child:IsA('Fire') then
                RunService.Heartbeat:Wait()
                child:Destroy()
            end
        end)()
    end)
end

function CollectTotemItems()
    for i,v in ipairs(Blocks:GetChildren()) do
        if string.find(v.Name, 'totem') and v:FindFirstChild('WorkerContents') then
            if v and v.Position and v.WorkerContents and v.WorkerContents:FindFirstChildWhichIsA('Tool') then
                TGoto(v.Position)
                for i2, v2 in ipairs(v.WorkerContents:GetChildren()) do
                    if v2:IsA('Tool') then
                        CollectDrop(v2)
                    end     
                end
            end
        end
    end
end

function OpenVending(target, edit)
    edit = edit or false
    task.spawn(function()
        local args = {[1] = HashGen(),[2] = {[1] = {["vendingMachine"] = target}}}
        RemotePathMain:FindFirstChild(VendingRemotes.openVendingRemote):FireServer(unpack(args))
    end)
    task.wait()
    if edit then
        task.spawn(function()
            local args = {[1] = HashGen(),[2] = {[1] = {["vendingMachine"] = target}}}
            RemotePathMain:FindFirstChild(VendingRemotes.closeVendingRemote2):FireServer(unpack(args))
        end)
        task.spawn(function()
            local args = {[1] = HashGen(),[2] = {[1] = {["vendingMachine"] = target}}}
            RemotePathMain:FindFirstChild(VendingRemotes.closeVendingRemote1):FireServer(unpack(args))
        end)
        task.spawn(function()
            local args = {[1] = HashGen(),[2] = {[1] = {["vendingMachine"] = target}}}
            RemotePathMain:FindFirstChild(VendingRemotes.editVendingRemote):FireServer(unpack(args))
        end)
    end
end

function CloseVending(target, wasEditing)
    wasEditing = wasEditing or false
    task.wait(1)
    if wasEditing then
        task.spawn(function()
            local args = {[1] = HashGen(),[2] = {[1] = {["vendingMachine"] = target}}}
            RemotePathMain:FindFirstChild(VendingRemotes.stopEditingVendingRemote):FireServer(unpack(args))
        end)
    else
        task.wait()
        task.spawn(function()
            local args = {[1] = HashGen(),[2] = {[1] = {["vendingMachine"] = target}}}
            RemotePathMain:FindFirstChild(VendingRemotes.closeVendingRemote2):FireServer(unpack(args))
        end)
        task.wait(3)
        task.spawn(function()
            local args = {[1] = HashGen(),[2] = {[1] = {["vendingMachine"] = target}}}
            RemotePathMain:FindFirstChild(VendingRemotes.closeVendingRemote1):FireServer(unpack(args))
        end)
    end
    
end

function StockVendingMachines()
    local Distance, Target, Item = 9999999999, nil, nil
    for i,v in ipairs(Blocks:GetChildren()) do
        if string.find(v.Name, 'vendingMachine') and v:FindFirstChild('Mode') and v:FindFirstChild('Mode').Value == 0 and v:FindFirstChild('SellingContents') and v:FindFirstChild('SellingContents'):FindFirstChildWhichIsA('Tool') then 
            Item = v.SellingContents:FindFirstChildWhichIsA('Tool')
            if Item and lp.Backpack:FindFirstChild(Item.Name) and lp.Backpack:FindFirstChild(Item.Name).Amount.Value ~= 0 then
                if v.Name == 'vendingMachine1' and Item.Amount.Value >= 1000 then
                    continue
                end
                if v.Name == 'vendingMachine' and Item.Amount.Value >= 300 then
                    continue
                end
                local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                if mag < Distance then
                    Distance = mag
                    Target = v
                end
            end
        end
    end
    if Target and Target.Position then
        TGoto(Target.Position)
        OpenVending(Target, true)
        task.spawn(function()
            local args = {[1] = HashGen(),[2] = {[1] = {["player_tracking_category"] = "join_from_web",["amount"] = lp.Backpack[Item.Name].Amount.Value,["vendingMachine"] = Target,["tool"] = Item,["action"] = "deposit"}}}
            RemotePathMain:FindFirstChild(VendingRemotes.depositItemVendingRemote):FireServer(unpack(args))
        end)
        task.wait()
        CloseVending(Target, true)
    end          
end

function EmptyBuyVendingMachines()
    local Distance, Target, Item = 9999999999, nil, nil
    for i,v in ipairs(Blocks:GetChildren()) do
        if string.find(v.Name, 'vendingMachine') and v:FindFirstChild('Mode') and v:FindFirstChild('Mode').Value == 1 and v:FindFirstChild('SellingContents') and v:FindFirstChild('SellingContents'):FindFirstChildWhichIsA('Tool') then 
            Item = v.SellingContents:FindFirstChildWhichIsA('Tool')
            if lp.Backpack:FindFirstChild(Item.Name) and lp.Backpack:FindFirstChild(Item.Name).Amount.Value ~= 0 then
                local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                if mag < Distance then
                    Distance = mag
                    Target = v
                end
            end
        end
    end
    if Target and Target.Position then
        TGoto(Target.Position)
        OpenVending(Target, true)
        task.spawn(function()
            local args = {[1] = HashGen(),[2] = {[1] = {["player_tracking_category"] = "join_from_web",["amount"] = Item.Amount.Value,["vendingMachine"] = Target,["tool"] = Item,["action"] = "withdraw"}}}
            RemotePathMain:FindFirstChild(VendingRemotes.depositItemVendingRemote):FireServer(unpack(args))
        end)
        task.wait()
        CloseVending(Target, true)
    end 
end

function EmptyAllVendingMachines()
    local Distance, Target, Item = 9999999999, nil, nil
    for i,v in ipairs(Blocks:GetChildren()) do
        if string.find(v.Name, 'vendingMachine') and v:FindFirstChild('Mode') and v:FindFirstChild('Mode').Value ~= 2 and v:FindFirstChild('SellingContents') and v:FindFirstChild('SellingContents'):FindFirstChildWhichIsA('Tool') then 
            Item = v.SellingContents:FindFirstChildWhichIsA('Tool')
            if lp.Backpack:FindFirstChild(Item.Name) and lp.Backpack:FindFirstChild(Item.Name).Amount.Value ~= 0 then
                local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                if mag < Distance then
                    Distance = mag
                    Target = v
                end
            end
        end
    end
    if Target and Target.Position then
        TGoto(Target.Position)
        OpenVending(Target, true)
        task.spawn(function()
            local args = {[1] = HashGen(),[2] = {[1] = {["player_tracking_category"] = "join_from_web",["amount"] = Item.Amount.Value,["vendingMachine"] = Target,["tool"] = Item,["action"] = "withdraw"}}}
            RemotePathMain:FindFirstChild(VendingRemotes.depositItemVendingRemote):FireServer(unpack(args))
        end)
        task.wait()
        CloseVending(Target, true)
    end 
end

function UpgradeTotems(totem, upgrade, amount)
    local TotemType = ''
    if table.find(TotemData.Crop, totem) then
        TotemType = 'crop'
    elseif table.find(TotemData.Rock, totem) then
        TotemType = 'rock'
    else
        error('Totem Not Found')
    end
    local Distance, Target = math.huge, nil
    for i,v in ipairs(Blocks:GetChildren()) do
        if string.find(string.lower(v.Name), totem) and v:FindFirstChild('UpgradeProgress') then
            local UpgradeProgress = v.UpgradeProgress
            if UpgradeProgress[upgrade].Value < amount then
                local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                if mag < Distance then
                    Distance = mag
                    Target = v
                end
            end
        end
    end
    if Target and Target.Position then
        TGoto(Target.Position)
        while Target and Target.UpgradeProgress[upgrade].Value < amount and UpgradeTotemsToggle and task.wait() do
            if Target.UpgradeProgress[upgrade].Value < amount then
                local args = {[1] = Target,[2] = "totem_"..TotemType,[3] = upgrade}
                RemotePathMain:WaitForChild("UpgradeBlock"):InvokeServer(unpack(args))
            end
        end
    end
end


function NetEntity(entity)
    repeat task.wait() until WildernessEntities:FindFirstChild(entity) or Entities:FindFirstChild(entity) or NetEntityToggle == false
    if entity == 'spirit' then
        local Distance, Target = math.huge, nil
        for i,v in ipairs(WildernessEntities:GetChildren()) do
            if v.Name == entity and NetEntityToggle and v:FindFirstChild('HumanoidRootPart') then
                local mag = (v.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if mag <= Distance then
                    Distance = mag
                    Target = v
                end
            end
        end
        if Target and Target:FindFirstChild('HumanoidRootPart') and Target:FindFirstChild('HumanoidRootPart').Position then
            TGoto(Target.HumanoidRootPart.Position, true)
            task.spawn(function()
                local args = {[1] = HashGen(),[2] = {[1] = {["entity"] = Target}}}
                RemotePathMain:FindFirstChild(NetRemote):FireServer(unpack(args))
            end)
        end
    else
        local Distance, Target = math.huge, nil
        for i,v in ipairs(Entities:GetChildren()) do
            if v.Name == entity and v:FindFirstChild('HumanoidRootPart') and NetEntityToggle then
                local mag = (v.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if mag <= Distance then
                    Distance = mag
                    Target = v
                end
            end
        end
        if Target and Target:FindFirstChild('HumanoidRootPart') and Target:FindFirstChild('HumanoidRootPart').Position then
            TGoto(Target.HumanoidRootPart.Position, true)
            task.spawn(function()
                local args = {[1] = HashGen(),[2] = {[1] = {["entity"] = Target}}}
                RemotePathMain:FindFirstChild(NetRemote):FireServer(unpack(args))
            end)
        end
    end
end

function SpookTurkeys()
    for i,v in ipairs(WildernessEntities:GetChildren()) do
        if v.Name == 'turkey' and SpookTurkeysToggle then
           -- repeat task.wait() until (WildernessEntities:FindFirstChild('turkey') and WildernessEntities.turkey:FindFirstChild('HumanoidRootPart')) or SpookTurkeysToggle == false 
            if v and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('HumanoidRootPart').Position then
                TGoto(v.HumanoidRootPart.Position, true)
                task.spawn(function()
                    local args = {[1] = v}
                    RemotePathMain.SpookTurkey:FireServer(unpack(args))
                end)
            end  
        end
    end
end

function EatFood()
    if lp.Backpack:FindFirstChild(AutoEatToggleSettings.SelectedFood) then
        local OldTool = nil
        if Character:FindFirstChildWhichIsA('Tool') then
            OldTool = Character:FindFirstChildWhichIsA('Tool').Name
        end
        task.spawn(function()
            EquipTool(lp.Backpack:FindFirstChild(AutoEatToggleSettings.SelectedFood).Name)
            local args = {[1] = {["tool"] = Character[AutoEatToggleSettings.SelectedFood]}}
            RemotePathMain.CLIENT_EAT_FOOD:InvokeServer(unpack(args))
        end)
        if OldTool ~= nil then
            EquipTool(OldTool)
        end
    end
end

function CollectChests()
    for i,v in ipairs(Blocks:GetChildren()) do
        if v and string.find(string.lower(v.Name), 'chest') and v:FindFirstChild('Contents') and v.Contents:FindFirstChildWhichIsA('Tool') and v.Position then
            TGoto(v.Position)
            for i2, v2 in ipairs(v.Contents:GetChildren()) do
                if v2:FindFirstChild('Amount') then
                    task.spawn(function()
                        local args = {[1] = {["chest"] = v,["player_tracking_category"] = "join_from_web",["amount"] = v2.Amount.Value,["tool"] = v2,["action"] = "withdraw"}}  
                        RemotePathMain.CLIENT_CHEST_TRANSACTION:InvokeServer(unpack(args))
                    end)   
                end
            end
        end
    end
end

function MobFarmFunction(mob)
    local Distance, Target = math.huge, nil
    for i,v in ipairs(WildernessEntities:GetChildren()) do
        if v and string.find(v.Name, mob) and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('HumanoidRootPart').Position then
            local mag = (v.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                Target = v
            end
        end
    end
    while Target and Target:FindFirstChild('HumanoidRootPart') and Target:FindFirstChild('HumanoidRootPart').Position and task.wait() and MobFarmToggle do
        if Target and Target:FindFirstChild('HumanoidRootPart') and Target:FindFirstChild('HumanoidRootPart').Position and MobFarmToggle then

            local NewPosition = Target.HumanoidRootPart.Position

            if MobFarmToggleSettings.UndergroundFarming then
                local Offset = -Target.HumanoidRootPart.Size.Y - 3
                NewPosition = NewPosition + Vector3.new(0,Offset,0)
            elseif MobFarmToggleSettings.NoContact then
                local distanceBehind = 9
                local targetPosition = Target.HumanoidRootPart.Position
                local targetHeight = Target.HumanoidRootPart.Position.Y + Target.HumanoidRootPart.Size.Y/2
                local behindPosition = targetPosition - Target.HumanoidRootPart.CFrame.LookVector * distanceBehind

                -- Check if the player would collide with the target, if so, move higher
                local playerPosition = Character.HumanoidRootPart.Position
                local ray = Ray.new(playerPosition, (behindPosition - playerPosition).unit * distanceBehind)
                local part, position = workspace:FindPartOnRayWithIgnoreList(ray, {Character}, false, true)
                if part and part:IsDescendantOf(Target) then
                    local newBehindPosition = targetPosition + Vector3.new(0, Target.HumanoidRootPart.Size.Y + 12, 0)
                    local newRay = Ray.new(newBehindPosition, (behindPosition - newBehindPosition).unit * distanceBehind)
                    local newPart, _ = workspace:FindPartOnRay(newRay, Character, false, true)
                    if not newPart or not newPart:IsDescendantOf(Target) then
                        NewPosition = newBehindPosition
                    end
                end   
            elseif MobFarmToggleSettings.AboveFarming then
                NewPosition = NewPosition + Vector3.new(0,MobFarmToggleSettings.YOffset,0)
            end
            if NewPosition then
                TGoto(NewPosition,true,1,true)
                if Character:FindFirstChildWhichIsA('Tool') then
                    local Tool = Character:FindFirstChildWhichIsA('Tool')
                    if table.find(BookTypes, Tool.Name) then
                        task.spawn(function()
                            ShootSpell(Target)
                        end)
                    else
                        task.wait(MobFarmHitWait)
                        task.spawn(function()
                            HitMob(Target)
                        end)
                    end
                else
                    -- no tool
                    EquipTool(BestWeapon_Inv())
                end
            end 
        end
    end
end   --    60 --> 37 lines LOL



local bossProximityPrompts = {
    cletusHalloween = 'cletus_boss_spawn',
    slimeKing = 'slime_king_spawn',
    slimeQueen = 'slime_queen_spawn',
    wizardBoss = 'wizard_boss_spawn',
    voidSerpent = 'void_serpent_spawn',
    desertBoss = 'desert_boss_spawn',
    golem = 'golem_spawn',
    magmaDragon = 'dragon_boss_spawn'
}

local ProximityPrompt = nil
local promptName = nil
local AlreadySpawningBoss = false


function BossFarmFunction(boss)
    local function SpawnBoss()
        if WildEventTriggers then
            if not WildernessEntities:FindFirstChild(boss) and boss ~= 'skorpSerpent' and BossFarmToggleSettings.RespawnBoss and not AlreadySpawningBoss then
                promptName = bossProximityPrompts[boss]
                if promptName then
                    ProximityPrompt = WildEventTriggers:FindFirstChild(promptName):FindFirstChild('ProximityPrompt')
                    repeat task.wait(1)
                        if ProximityPrompt then
                            if ProximityPrompt.Parent and ProximityPrompt.Parent.Position then
                                TGoto(ProximityPrompt.Parent.Position)
                                task.wait(0.25)
                                fireproximityprompt(ProximityPrompt, 1, true)
                                AlreadySpawningBoss = true
                            else
                                error('no prompt parent')
                            end
                        else
                            error('no prompt')
                        end
                    until WildernessEntities:FindFirstChild(boss) or not BossFarmToggleSettings.RespawnBoss or not BossFarmToggle or not AlreadySpawningBoss
                    AlreadySpawningBoss = false
                else
                    error('Could not find prompt name')
                end
            end
        else
            error('Could not find WildEventTriggers')
        end
    end

    if not WildernessEntities:FindFirstChild(boss) and boss ~= 'skorpSerpent' and BossFarmToggleSettings.RespawnBoss and not AlreadySpawningBoss then
        if fireproximityprompt ~= nil then
            SpawnBoss()
            AlreadySpawningBoss = true
        else
            error('Executor does not support fireproximityprompt')
        end
    end

    task.wait(0.25)

    while WildernessEntities:FindFirstChild(boss) and WildernessEntities[boss]:FindFirstChild('HumanoidRootPart') and BossFarmToggle do
        if WildernessEntities:FindFirstChild(boss) and WildernessEntities[boss]:FindFirstChild('HumanoidRootPart') and BossFarmToggle then

            local Target = WildernessEntities:FindFirstChild(boss)
            local NewPosition = Target.HumanoidRootPart.Position

            if BossFarmToggleSettings.UndergroundFarming then
                local Offset = -Target.HumanoidRootPart.Size.Y - 3
                NewPosition = NewPosition + Vector3.new(0,Offset,0)
            elseif BossFarmToggleSettings.NoContact then
                local distanceBehind = 9
                local targetPosition = Target.HumanoidRootPart.Position
                local targetHeight = Target.HumanoidRootPart.Position.Y + Target.HumanoidRootPart.Size.Y/2
                local behindPosition = targetPosition - Target.HumanoidRootPart.CFrame.LookVector * distanceBehind
    
                -- Check if the player would collide with the target, if so, move higher
                local playerPosition = Character.HumanoidRootPart.Position
                local ray = Ray.new(playerPosition, (behindPosition - playerPosition).unit * distanceBehind)
                local part, position = workspace:FindPartOnRayWithIgnoreList(ray, {Character}, false, true)
                if part and part:IsDescendantOf(Target) then
                    local newBehindPosition = targetPosition + Vector3.new(0, Target.HumanoidRootPart.Size.Y + 12, 0)
                    local newRay = Ray.new(newBehindPosition, (behindPosition - newBehindPosition).unit * distanceBehind)
                    local newPart, _ = workspace:FindPartOnRay(newRay, Character, false, true)
                    if not newPart or not newPart:IsDescendantOf(Target) then
                        NewPosition = newBehindPosition
                    end
                end 
            elseif BossFarmToggleSettings.AboveFarming then
                NewPosition = NewPosition + Vector3.new(0,BossFarmToggleSettings.YOffset,0)
            end
            if NewPosition then
                TGoto(NewPosition,true,1,true)
                if Character:FindFirstChildWhichIsA('Tool') then
                    local Tool = Character:FindFirstChildWhichIsA('Tool')
                    if table.find(BookTypes, Tool.Name) then
                        task.spawn(function()
                            ShootSpell(Target)
                        end)
                    else
                        task.wait(MobFarmHitWait)
                        task.spawn(function()
                            HitMob(Target) 
                        end)
                    end
                else
                    -- no tool
                    EquipTool(BestWeapon_Inv())
                end
            end   
        end
    end
end


--[[
BOSS FARM ERRORS


PPE1 = ProximityPrompt not found
PPE2 = ProximityPrompt Parent not found

]]


function OreAura()
    local Distance, Target = math.huge, nil
    local centerPosition = Character.HumanoidRootPart.Position
    local regionSize = Vector3.new(OreAuraToggleSettings.Radius * 2, OreAuraToggleSettings.Radius * 2, OreAuraToggleSettings.Radius * 2)
    local Region = Region3.new(centerPosition - regionSize / 2, centerPosition + regionSize / 2)
    for i, v in ipairs(workspace:FindPartsInRegion3(Region, nil, math.huge)) do
        if v:FindFirstChild('1') then
            local mag = (v['1'].Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                Target = v
            end
        end
    end
    if Target and Target:FindFirstChild('1') then
        task.spawn(function()
            HitBlock(Target,Target:FindFirstChild("1"))
        end)
    end
end

function IslandOreAura()
    local Distance, Target = math.huge, nil
    local centerPosition = Character.HumanoidRootPart.Position
    local radius = 15
    local regionSize = Vector3.new(OreAuraToggleSettings.Radius * 2, OreAuraToggleSettings.Radius * 2, OreAuraToggleSettings.Radius * 2)
    local Region = Region3.new(centerPosition - regionSize / 2, centerPosition + regionSize / 2)
    for i, v in ipairs(workspace:FindPartsInRegion3(Region, nil, math.huge)) do
        if string.find(v.Name, 'rock') then
            local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                Target = v
            end
        end
    end
    if Target and Target:FindFirstChild('1') then
        task.spawn(function()
            HitBlock(Target,Target:FindFirstChild("1"))
        end)
    end
end

function TreeAura()
    if not TreeAuraToggle then return end

    local Distance, TargetTree,Base = math.huge, nil, nil
    local centerPosition = Character.HumanoidRootPart.Position
    local regionSize = Vector3.new(TreeAuraToggleSettings.Radius * 2, TreeAuraToggleSettings.Radius * 2, TreeAuraToggleSettings.Radius * 2)
    local Region = Region3.new(centerPosition - regionSize / 2, centerPosition + regionSize / 2)
    for i, v in ipairs(workspace:FindPartsInRegion3(Region, nil, math.huge)) do
        if string.find(v.Name, 'tree') and (v:FindFirstChild('trunk') or v:FindFirstChild('MeshPart')) then
            local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                TargetTree = v
                Base = v:FindFirstChild('trunk') or v:FindFirstChild('MeshPart')
            end
        end
    end
    task.spawn(function()
        if TargetTree and Base and TreeAuraToggle then
            HitBlock(TargetTree, TargetTree)
            task.wait()
        end
    end)  
end

function WaterFlowers()
    local Distance, TargetFlower = math.huge, nil
    for i,v in ipairs(Blocks:GetChildren()) do
        if string.find(v.Name, 'Fertile') and v:FindFirstChild('Watered') and v.Watered.Value == false and WaterFertileFlowersToggle and not string.find(v.Name, 'Picker') then
            local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                TargetFlower = v
            end
        end
    end
    if TargetFlower and TargetFlower.Position then
        TGoto(TargetFlower.Position)
        task.spawn(function()
            local args = {[1] = {["block"] = TargetFlower}}
            RemotePathMain.CLIENT_WATER_BLOCK:InvokeServer(unpack(args))
            task.wait(.03)
        end)
    end   
end

function CollectFlowers(type)
    local Distance, TargetFlower = math.huge, nil
    if type == 'fertile' then
        for i,v in ipairs(Blocks:GetChildren()) do
            if string.find(v.Name, 'Fertile') and not string.find(v.Name, 'Picker') and CollectFlowersToggle then
                local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                if mag < Distance then
                   Distance = mag
                   TargetFlower = v
                end
            end
        end
    elseif type == 'nonfertile' then
        for i,v in ipairs(Blocks:GetChildren()) do
            if not string.find(v.Name, 'Fertile') and not string.find(v.Name, 'Picker') and string.find(v.Name, 'flower') and CollectFlowersToggle then
                local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                if mag < Distance then
                    Distance = mag
                    TargetFlower = v
                end
            end
        end
    end
    if TargetFlower and TargetFlower.Position then
        TGoto(TargetFlower.Position)        
        task.spawn(function()
            local args = {[1] = {["flower"] = TargetFlower}}
            RemotePathMain.client_request_1:InvokeServer(unpack(args))
        end)
    end
end

function PetPets()
    local Distance, TargetPet = math.huge, nil
    for i,v in ipairs(Entities:GetChildren()) do
        if v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Favorites') and PetPetsToggle then
            local mag = (v.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                TargetPet = v
            end
        end
    end
    if TargetPet and TargetPet:FindFirstChild('HumanoidRootPart') and TargetPet:FindFirstChild('HumanoidRootPart').Position and PetPetsToggle then
        TGoto(TargetPet.HumanoidRootPart.Position)
        task.spawn(function()
            local args = {[1] = {["animal"] = TargetPet}}
            RemotePathMain.CLIENT_PET_ANIMAL:InvokeServer(unpack(args))
        end)
    end        
end

function CollectHoney()
    local Distance, TargetTree = math.huge, nil
    LPH_JIT_MAX(function()
        for i,v in ipairs(Blocks:GetChildren()) do
            if v:FindFirstChild('HiveLocations') then
                for i2, v2 in ipairs(v.HiveLocations:GetChildren()) do
                    if v2:FindFirstChild('beeHive') and v2.beeHive:FindFirstChild('Root') and v2.beeHive.Root:FindFirstChild('Nectar') and v2.beeHive.Root.Nectar.Value >= 250 then
                        local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                        if mag <= Distance then
                            Distance = mag
                            TargetTree = v
                        end
                    end
                end
            end
        end
    end)()
    if TargetTree and TargetTree.Position then
        TGoto(TargetTree.Position)
        task.spawn(function()
            local args = {[1] = {["tree"] = TargetTree}}
            RemotePathMain:WaitForChild("CLIENT_COLLECT_HONEY"):InvokeServer(unpack(args))
        end)
    end
end

function ClipLeaves()
    local Distance, TargetTree = math.huge, nil
    for i,v in ipairs(Blocks:GetChildren()) do
        if string.find(v.Name, 'tree') and not v:FindFirstChild('LastTrimmed') then
            local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag <= Distance then
                Distance = mag
                TargetTree = v
            end
        end    
    end
    if TargetTree and TargetTree.Position then
        TGoto(TargetTree.Position)
        task.spawn(function()
            local args = {[1] = {["tree"] = TargetTree}}
            RemotePathMain:WaitForChild("CLIENT_TRIM_TREE_REQUEST"):InvokeServer(unpack(args))    
        end)
    end
end



local ActualTreeNames = {'treeMaple1', 'treeMaple2', 'treeBirch1', 'treeBirch2', 'treePine1', 'treeSpirit1', 'treeSpirit2', 'treeHickory1', 'treeHickory2', 'treeCherryBlossom'}

function FindTree2()
    if not WoodFarmToggle then return end

    local Distance, TargetTree, Base = math.huge, nil, ''
    local selectedTree = WoodFarmToggleSettings.SelectedTree
    local ignoreFruitTrees = WoodFarmToggleSettings.IgnoreFruitTrees

    for _, v in ipairs(Blocks:GetChildren()) do
        local name = v.Name
        if string.find(name, 'tree') and (v:FindFirstChild('trunk') or v:FindFirstChild('MeshPart')) then

            if ignoreFruitTrees and v:FindFirstChild('FruitLocations') then
                continue -- Skip this tree if it's a fruit tree and WoodFarmToggleSettings.IgnoreFruitTrees is true
            end

            if (selectedTree == 'All' and Whitelisted) or (selectedTree == 'Oak' and not table.find(ActualTreeNames, name)) or string.find(name, selectedTree) then
                local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                if mag < Distance then
                    Distance = mag
                    TargetTree = v
                    Base = v:FindFirstChild('trunk') or v:FindFirstChild('MeshPart')
                end
            end
        end
    end

    if TargetTree and Base and TargetTree.Position then
        TGoto(TargetTree.Position)
        if WoodFarmToggleSettings.BreakBlockUnder then
            local TargetBlock, OldPos = nil, nil
            local region = workspace:FindPartsInRegion3(Region3.new(TargetTree.Position - Vector3.new(0, 3, 0), TargetTree.Position - Vector3.new(0, 3, 0)))
            if #region == 0 then
                -- error with finding block under
                error('No Block Found')
            elseif #region == 1 then
                -- perfect
                TargetBlock = region[1]
                OldPos = region[1].Position
            else
                -- too many
                local Distance, TargetBlock, OldPos = math.huge, nil, nil
                for i,v in ipairs(region) do
                    if v.Name == 'grass' and v.CFrame.Position.Y == TargetTree.CFrame.Position.Y - 3 then
                        local mag = (v.Position - TargetTree.Position).Magnitude
                        if mag < Distance then
                            Distance = mag
                            TargetBlock = v 
                            OldPos = v.Position
                        end
                    end
                end
            end
            
            while TargetBlock and TargetBlock.Parent and TargetTree and TargetTree.Parent and Base and WoodFarmToggleSettings.BreakBlockUnder and WoodFarmToggle and task.wait() do
                task.spawn(function()
                    HitBlock(TargetBlock, TargetBlock)
                    task.wait()
                end)
            end

            PlaceBlock(OldPos, 'grass')
            if WoodFarmToggleSettings.SelectedTree == 'Oak' then
                PlaceBlock(OldPos + Vector3.new(0,3,0), 'sapling')
            else
                PlaceBlock(OldPos + Vector3.new(0,3,0), 'sapling'..WoodFarmToggleSettings.SelectedTree)
            end
        else
            while TargetTree and TargetTree.Parent and Base and WoodFarmToggle and task.wait() do
                task.spawn(function()
                    HitBlock(TargetTree, TargetTree)
                    task.wait()
                end)
            end
        end
    end
end



function RemoveStoneAndTallGrass()
    local TargetBlock = GetClosestBlock({'naturalRock1', 'tallGrass'})
    if TargetBlock and TargetBlock.Position then
        TGoto(TargetBlock.Position)
        while TargetBlock and TargetBlock:FindFirstChild('MeshPart') and task.wait() and RemoveStoneAndTallGrassToggle do
            task.spawn(function()
                if TargetBlock and TargetBlock:FindFirstChild('MeshPart') then
                    HitBlock(TargetBlock,TargetBlock.MeshPart)
                end
            end)
        end
    end
end

function SetCustomConveyorSpeed()
    for i,part in pairs(Blocks:GetDescendants()) do
        if (part.Name == 'conveyorForward' or part.Name == 'conveyor1Forward') and part:FindFirstChild('conveyorPart') and part.conveyorPart.AssemblyLinearVelocity ~= Vector3.new(0,0,0) then
            local ConveyorPart = part:FindFirstChild('conveyorPart')
            if ConveyorPart.AssemblyLinearVelocity.X ~= 0 then
                if ConveyorPart.AssemblyLinearVelocity.X > 0.01 then
                    ConveyorPart.AssemblyLinearVelocity = Vector3.new(CustomConveyorSpeedToggleSettings.Speed,0,0)
                else
                    ConveyorPart.AssemblyLinearVelocity = Vector3.new(-CustomConveyorSpeedToggleSettings.Speed,0,0)
                end
            end
            if ConveyorPart.AssemblyLinearVelocity.Z ~= 0 then
                if ConveyorPart.AssemblyLinearVelocity.Z > 0.01 then
                    ConveyorPart.AssemblyLinearVelocity = Vector3.new(0,0,CustomConveyorSpeedToggleSettings.Speed)
                else
                    ConveyorPart.AssemblyLinearVelocity = Vector3.new(0,0,-CustomConveyorSpeedToggleSettings.Speed)
                end
            end
        end
    end
end

function CollectVoidParasites()
    local TargetVP = GetClosestWildBlock({'voidParasite'})
    if TargetVP and TargetVP.Position then
        TGoto(TargetVP.Position)
        task.spawn(function()
            HarvestCrop(lp, TargetVP)
        end)
    end 
end

function CollectWild()
    local TargetBlock = GetClosestWildBlock(WildFarmToggleSettings.SelectedWildCrops)
    if TargetBlock and TargetBlock.Position and WildFarmToggle then
        TGoto(TargetBlock.Position)
        if TargetBlock.Name == 'flowerCrocus' then
            task.spawn(function()
                local args = {[1] = {["flower"] = TargetBlock}}
                RemotePathMain.client_request_1:InvokeServer(unpack(args))  
            end)
        else
            task.spawn(function()
                HarvestCrop(lp, TargetBlock)
            end)
        end
    end
end

function CollectFruits()
    local Distance, TargetFruit = math.huge, nil
    LPH_JIT_MAX(function()
        for i,v in ipairs(Blocks:GetChildren()) do
            if v:FindFirstChild('FruitLocations') then
                for i2, v2 in ipairs(v.FruitLocations:GetChildren()) do
                    if v2:FindFirstChildWhichIsA('Tool') then
                        local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                        if mag <= Distance then
                            Distance = mag
                            TargetFruit = v2:FindFirstChildWhichIsA('Tool')
                        end
                    end
                end
            end
        end
    end)()
    if TargetFruit and TargetFruit.Parent and TargetFruit.Parent.Position then
        TGoto(TargetFruit.Parent.Position)
        task.spawn(function()
            CollectDrop(TargetFruit)
            Character.HumanoidRootPart.CFrame = CFrame.new(Character.HumanoidRootPart.Position)
        end)   
    end
end

function PlowArea(block)
    local centerPosition = Character.HumanoidRootPart.Position
    local regionSize = Vector3.new(PlowRadius * 2, PlowRadius * 2, PlowRadius * 2)
    local Region = Region3.new(centerPosition - regionSize / 2, centerPosition + regionSize / 2)
    for i, v in ipairs(workspace:FindPartsInRegion3(Region, nil, math.huge)) do
        if v.Name == block then
            task.spawn(function()
                local args = {[1] = {["block"] = v}}
                RemotePathMain.CLIENT_PLOW_BLOCK_REQUEST:InvokeServer(unpack(args))
            end)
        end
    end 
end
    


function SeedPlantAura(seed)
    local centerPosition = Character.HumanoidRootPart.Position
    local regionSize = Vector3.new(SeedPlantAuraToggleSettings.Radius * 2, SeedPlantAuraToggleSettings.Radius * 2, SeedPlantAuraToggleSettings.Radius * 2)
    local Region = Region3.new(centerPosition - regionSize / 2, centerPosition + regionSize / 2)
    for i, v in ipairs(workspace:FindPartsInRegion3(Region, nil, math.huge)) do
        if v.Name == 'soil' and not FilledCheck(v.Position + Vector3.new(0,3,0)) then
            task.spawn(function()
                PlaceBlock(v.Position + Vector3.new(0,3,0),seed)
            end)
        end
    end
end

function TreePlantAura(tree)
    local centerPosition = Character.HumanoidRootPart.Position
    local regionSize = Vector3.new(TreePlantAuraToggleSettings.Radius * 2, TreePlantAuraToggleSettings.Radius * 2, TreePlantAuraToggleSettings.Radius * 2)
    local Region = Region3.new(centerPosition - regionSize / 2, centerPosition + regionSize / 2)
    for i, v in ipairs(workspace:FindPartsInRegion3(Region, nil, math.huge)) do
        if v.Name == 'grass' and not FilledCheck(v.Position + Vector3.new(0,3,0)) then
            task.spawn(function()
                PlaceBlock(v.Position + Vector3.new(0,3,0),tree)
            end)
        end
    end
end

function CollectTreasureChests()
    if CollectTreasureChestsToggle then
        local map = nil
        if not Character:FindFirstChild('treasureMap') then
            if lp.Backpack:FindFirstChild('treasureMap') then
                EquipTool(lp.Backpack:FindFirstChild('treasureMap').Name)
            end
        end
        local mapState = RemotePathMain.GetPlayerActiveTreasureMap:InvokeServer(unpack({[1] = {["tool"] = Character:FindFirstChild('treasureMap')}}))
        if mapState then
            local goal = mapState.position
            local location = mapState.location
            local tpLocation = nil
            if goal and location then

                for i,v in pairs(PortalTPSpawns) do
                    if tostring(location) == tostring(i) then
                        tpLocation = PortalLocations[tostring(location)]
                    end
                end

                local DoubleCheckCounter = 0

                local function TPToLocation()
                    if not tpLocation then
                        if tostring(location) == 'hub' then
                            RemotePathMain:WaitForChild("client_request_37"):InvokeServer()
                        elseif tostring(location) == 'maple' then
                            local args = {[1] = false}
                            RemotePathMain.TravelMapleIsland:FireServer(unpack(args))
                        elseif tostring(location) == 'pirate' then
                            local args = {[1] = false}
                            RemotePathMain.TravelPirateIsland:FireServer(unpack(args))
                        end
                    else
                        Character.HumanoidRootPart.CFrame = CFrame.new(tpLocation)
                    end
                end

                repeat task.wait()
                    TPToLocation()
                    task.wait(3)
                until ((Character.HumanoidRootPart.Position - PortalTPSpawns[tostring(location)]).Magnitude <= 100) or not CollectTreasureChestsToggle

                task.wait(0.5)
                if goal then
                    TGoto(goal)
                end
                
                repeat task.wait() until DistanceCheck(Target.Position) <= 5 or not CollectTreasureChestsToggle

                RemotePathMain.PlayerDigTreasure:FireServer(HashGen(), {})
            end        
        end
    end
end

function CollectNearDrops()
    if Drops or Island:FindFirstChild('Drops') then
        for i,v in ipairs(Island:FindFirstChild('Drops'):GetChildren()) do
            if v:IsA('Tool') and CollectNearDropsToggle then -- (v.Position - Character.HumanoidRootPart.Position).Magnitude < 30 and CollectNearToggle then
                task.spawn(function()
                    CollectDrop(v)
                end)
            end    
        end
    end
end



function HarvestCrops3(croplist)
    if not CropFarmToggle then return end

    Distance, Target, TargetCrops = 999999999, nil, {}
    for _,v in next, Blocks:GetChildren() do
        if table.find(croplist, v.Name) and v:FindFirstChild('stage') and v.stage.Value >= 3 then
            local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
            if mag < Distance then
                Distance = mag
                Target = v
            end
        end
    end
    if Target and Target.Position then
        TGoto(Target.Position, true)
    end

    repeat task.wait() until (Target and DistanceCheck(Target.Position) <= 5) or not CropFarmToggle or not Target

    if Target and Target.Position then
        local centerPosition = Target.Position
        local radius = 15 -- 10
        local regionSize = Vector3.new(radius * 2, radius * 2, radius * 2)
        local Region = Region3.new(centerPosition - regionSize / 2, centerPosition + regionSize / 2)
    
    
        for i, v in ipairs(workspace:FindPartsInRegion3(Region, nil, math.huge)) do
            if table.find(croplist, v.Name) and v:FindFirstChild('stage') and v.stage.Value >= 3 and #TargetCrops < 100 then
                table.insert(TargetCrops, v)
            end
        end
        if #TargetCrops > 0 then
            task.spawn(function()
                RemotePathMain.SwingSickle:InvokeServer("sickleDiamond", TargetCrops)
            end)
    
            if CropFarmToggleSettings.ReplantSeeds then
                for _, seed in ipairs(TargetCrops) do
                    if seed and seed.Position then
                        TGoto(seed.Position)
                        task.spawn(function()
                            PlaceBlock(seed.Position, seed.Name)         
                        end)
                        task.wait(0.04)
                    end
                end
            end
    
            if CropFarmToggleSettings.WaterCrops then
                for _, crop in pairs(TargetCrops) do
                    if crop and crop.Position then
                        task.spawn(function()
                            TGoto(crop.Position)
                            local args = {[1] = {["block"] = crop}}
                            RemotePathMain.CLIENT_WATER_BLOCK:InvokeServer(unpack(args))
                        end)
                        task.wait()
                    end
                end
            end
        end
    end
end



function HarvestBerries()
    if not BerryFarmToggle then return end

    local function GetBerries()
        Distance, Target, NewBerryList = 999999999, nil, {}
        for _,v in next, Blocks:GetChildren() do
            if string.find(v.Name, 'berryBush') and not string.find(v.Name, 'rasp') and v:FindFirstChild('stage') and v.stage.Value >= 2 then
                local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                if mag < Distance then
                    Distance = mag
                    Target = v
                end
            end
        end
        if Target and Target.Position then
            TGoto(Target.Position, true)
        end
    
    
        local centerPosition = Target.Position
        local radius = 30
        local regionSize = Vector3.new(radius * 2, radius * 2, radius * 2)
        local Region = Region3.new(centerPosition - regionSize / 2, centerPosition + regionSize / 2)
    
    
        for i, v in ipairs(workspace:FindPartsInRegion3(Region, nil, math.huge)) do
            if string.find(v.Name, 'berryBush') and not string.find(v.Name, 'rasp') and v:FindFirstChild('stage') and v.stage.Value >= 2 then
                table.insert(NewBerryList, v)
            end
        end
        if #NewBerryList > 0 then
            return NewBerryList
        end
    end

    local Berries = GetBerries()
    if Berries then
        task.spawn(function()
            RemotePathMain.SwingSickle:InvokeServer("sickleDiamond", Berries)
        end)
    end
end


function SaveJoinCode()
    local Player = Players:GetNameFromUserIdAsync(Islands:GetChildren()[1].Owners:FindFirstChildWhichIsA('NumberValue').Value)
    local JoinCode = Players:FindFirstChild(Player).JoinCode.Value
    SavedJoinCodes[Player.Name] = tostring(JoinCode)
end



function FindOre(orelist)
    local Distance, TargetOre, HitPart = math.huge, nil, nil
    if OreFarmToggleSettings.CurrentIsland then
        local IslandDistance, OnIsland = math.huge, nil
        for i,v in pairs(PortalTPSpawns) do
            local mag = (v - Character.HumanoidRootPart.Position).Magnitude
            if mag < IslandDistance then
                IslandDistance = mag
                OnIsland = i
            end
        end
        
        for i,v in ipairs(WildernessBlocks:GetChildren()) do
            if string.find(v.Name, 'rock') then
                local str = v.Name
                local newStr, replaced = string.gsub(str, "rock", "")
                if table.find(IslandOres[OnIsland], newStr) then
                    local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                    if mag < Distance then
                        Distance = mag
                        TargetOre = v
                        HitPart = v:FindFirstChild('1') or v:FindFirstChild('Root') or v
                    end
                end
            end
        end
    else
        for i,v in ipairs(WildernessBlocks:GetChildren()) do
            if string.find(v.Name, 'rock') then
                local str = v.Name
                local newStr, replaced = string.gsub(str, "rock", "")
                if table.find(orelist, newStr) then
                    local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                    if mag < Distance then
                        Distance = mag
                        TargetOre = v
                        HitPart = v:FindFirstChild('1') or v:FindFirstChild('Root') or v
                    end
                end
            end
        end
    end
    if TargetOre and TargetOre.Position then
        TGoto(TargetOre.Position)
        task.spawn(function()
            HitBlock(TargetOre,HitPart)
        end)
    end
end


function FindIslandOre(orelist)
    local Distance, TargetOre = math.huge, nil
    for i,v in ipairs(Blocks:GetChildren()) do
        if string.find(v.Name, 'rock') then
            local str = v.Name
            local newStr, replaced = string.gsub(str, "rock", "")
            if table.find(orelist, newStr) then
                local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                if mag < Distance then
                    Distance = mag
                    TargetOre = v
                end
            end
        end
    end
    if TargetOre and TargetOre.Position and TargetOre:FindFirstChild('1') then
        TGoto(TargetOre.Position)
        if OreFarmToggleSettings.BreakBlockUnder then
            local Distance, TargetBlock, OldBlock, OldPos = math.huge, nil, '', nil
            for i,v in ipairs(Blocks:GetChildren()) do
                if v.Name ~= 'bedrock' and v.Parent ~= nil and v.Parent.Parent ~= nil and (not v:FindFirstChild("portal-to-spawn")) and v ~= TargetOre then
                    local mag = (v.Position - TargetOre.Position).Magnitude
                    if mag < Distance then
                        Distance = mag
                        TargetBlock = v
                        OldBlock = v.Name
                        OldPos = v.Position
                    end
                end
            end
            if TargetBlock then
                task.spawn(function()
                    HitBlock(TargetBlock,TargetBlock)
                    task.wait()
                    PlaceBlock(OldPos, OldBlock)
                end)
            end
        else
            task.spawn(function()
                HitBlock(TargetOre,TargetOre['1'])
            end)
        end
    end
end



function FastTools()
    lp.PlayerScripts.TS.modules.sound.footsteps.Disabled = true
    local hook
    hook = hookfunction(tick,function(...)
        return hook(...)*Multiplier
    end)
end




--------------------
-- UI Integration --
--------------------

local Status = 'Free'

if Whitelisted then
    Status = 'Premium'
end




-------------------
-- Making Folder --
-------------------



if CanDoSaves ~= nil then
    CanDoSaves = 'Project_Z/Islands/Settings/'
    if not isfolder('Project_Z') then
        makefolder('Project_Z')
    end
    if not isfolder('Project_Z/Islands') then
        makefolder('Project_Z/Islands')
    end
    if not isfolder('Project_Z/Islands/Settings') then
        makefolder('Project_Z/Islands/Settings')
    end 
    if not isfolder('Project_Z/Islands/Builds') then
        makefolder("Project_Z/Islands/Builds")
    end
else
    CanDoSaves = nil
    error("Executor Doesn't Support Files")
end


local SavedData = nil
if CanDoSaves ~= nil and isfile('Project_Z/Islands/Settings/configs.json') then
    local fileContents = readfile('Project_Z/Islands/Settings/configs.json')
    SavedData = HttpService:JSONDecode(fileContents)
end


-- Loading Saved Data --
local cancelSavedData = true
if SavedData and CanDoSaves and not cancelSavedData then
    ForceXPToggle = SavedData.ForceXPToggleFlag
    SelectedFieldOfViewAmount = SavedData.SelectedFieldOfViewFlag
    VendingMachineSniperMaxPrice = SavedData.VendingMachineSniperMaxPriceFlag
    TeleportWalkToggle = SavedData.TeleportWalkToggleFlag
    ShowScriptNotificationsToggle = SavedData.ShowScriptNotificationsToggleFlag

    CropFarmToggleSettings.SelectedCrops = SavedData.SelectedCropsFlag
    CropFarmToggleSettings.ReplantSeeds = SavedData.ReplantSeedsFlag
    CropFarmToggleSettings.WaterCrops = SavedData.WaterCropsFlag

    WoodFarmToggleSettings.SelectedTree = SavedData.SelectedTreeFlag
    WoodFarmToggleSettings.IgnoreFruitTrees = SavedData.IgnoreFruitTreesWoodFarmToggleFlag
    WoodFarmToggleSettings.BreakBlockUnder = SavedData.BreakUnderBlockWoodFarmToggleFlag
    TreePlantAuraToggleSettings.Radius = SavedData.TreePlantAuraRadiusFlag
    TreeAuraToggleSettings.Radius = SavedData.TreeAuraRadiusFlag
    SeedPlantAuraToggleSettings.Radius = SavedData.SeedPlantAuraRadiusFlag

    OreFarmToggleSettings.SelectedOres = SavedData.SelectedOresFlag
    OreFarmToggleSettings.BreakBlockUnder = SavedData.BreakUnderBlockIslandOreToggleFlag
    OreFarmToggleSettings.CurrentIsland = SavedData.CurrentIslandToggleFlag
    OreAuraToggleSettings.Radius = SavedData.OreAuraRadiusFlag

    MobFarmToggleSettings.SelectedMob = SavedData.SelectedMobsFlag
    MobFarmToggleSettings.NoContact = SavedData.MobNoContactFlag
    MobFarmToggleSettings.UndergroundFarming = SavedData.MobUndergroundFarmingFlag
    MobFarmToggleSettings.AboveFarming = SavedData.MobFarmAboveToggleFlag
    MobFarmToggleSettings.YOffset = SavedData.MobFarmAboveOffsetFlag

    BossFarmToggleSettings.SelectedBoss = SavedData.SelectedBossesFlag
    BossFarmToggleSettings.RespawnBoss = SavedData.RespawnBossToggleFlag
    BossFarmToggleSettings.NoContact = SavedData.BossNoContactFlag
    BossFarmToggleSettings.UndergroundFarming = SavedData.BossUndergroundFarmingFlag
    BossFarmToggleSettings.AboveFarming = SavedData.BossFarmAboveToggleFlag
    BossFarmToggleSettings.YOffset = SavedData.BossFarmAboveOffsetFlag

    BowAuraToggleSettings.Delay = SavedData.BowAuraDelaySliderFlag

    NetEntityToggleSettings.SelectedEntity = SavedData.SelectedEntityFlag

    GeneralSettings.tweenSpeed = SavedData.TweenSpeedSliderFlag

    PlowRadius = SavedData.PlowRadiusFlag
    AutoEatToggleSettings.Time = SavedData.AutoEatWaitTimeSliderToggleFlag

    FishFarmToggleSettings.FishFarmCatchWait = SavedData.FishFarmCatchWaitSliderFlag

    WildFarmToggleSettings.SelectedWildCrops = SavedData.SelectedWildCropsFlag

    TotemToggleSettings.SelectedTotem = SavedData.SelectedTotemFlag
    TotemToggleSettings.UpgradeType = SavedData.TotemUpgradeTypeFlag
    TotemToggleSettings.UpgradeAmount = SavedData.TotemUpgradeAmountFlag

    CustomConveyorSpeedToggleSettings.Speed = SavedData.ConveyorSpeedSliderFlag

    
    KeyBindsFolder.ToggleUIKeyBind = SavedData.ToggleUIKeyBindPickerFlag
    KeyBindsFolder.FlyKeybind = SavedData.FlyKeyPickerFlag
    KeyBindsFolder.NoclipKeybind = SavedData.NoclipKeyPickerFlag
end

-- Making Window & Tabs

--local Atlas = loadstring(game:HttpGet("https://siegehub.net/Atlas_v2.lua"))()
local librarySource = game:HttpGet("https://raw.githubusercontent.com/Vastly7801/Projects/refs/heads/main/UI")
local loadedCode = loadstring(librarySource)
loadedCode()
local Atlas = (library or createLibrary)()

local Window = Atlas:CreateWindow({Name = "Islands v3 - Project Z ["..Status.." Version]";Color = Color3.fromRGB(135,135,255);Version = ScriptVersion;ConfigFolder = 'Project_Z_Islands_Settings';Bind = "RightShift";})









        

Window:Notify('Script Is Loading..')

function ToggleNotification(toggle, content)
    if ShowScriptNotificationsToggle then
        if toggle ~= nil and content ~= nil then
            if toggle == true then
                Window:Notify(tostring(content)..' Is Toggled: ON')
            elseif toggle == false then
                Window:Notify(tostring(content)..' Is Toggled: OFF')
            end
        end
    end
end

function DropdownNotification(contents)
    if ShowScriptNotificationsToggle then
        if content ~= nil then
            local ContentsString = ''
            for _,v in next, contents do
                ContentsString = tostring(v)..', '..ContentsString
            end
            if #contents == 0 then
                ContentsString = 'None'
            end
            Window:Notify('Now Selected: '..tostring(ContentsString))
        end
    end
end


local HomeTab = Window:CreatePage("Home")
local FarmingTab = Window:CreatePage("Farming")
local CombatTab = Window:CreatePage("Combat")
local MiscTab = Window:CreatePage("Misc")
local MachineryTab = Window:CreatePage("Machinery")
local WorldEditTab = Window:CreatePage("World Edit") -- Premium Feature
local TeleportTab = Window:CreatePage("Teleport")
local StatsTab = Window:CreatePage("Stats")
local SettingsTab = Window:CreatePage("Settings")

--------------
-- Home Tab --
--------------

-- left section
--- left tab box
local HomeTabLeftTabBox = HomeTab:CreateLeftTabbox()
local MainInfo = HomeTabLeftTabBox:CreateTab({Name = "Main Info"})
local IslandInjection = HomeTabLeftTabBox:CreateTab({Name = "Island Injection"})

MainInfo:CreateLabel("Thank you for choosing Project Z",false)
MainInfo:CreateLabel(LastUpdated,false)
MainInfo:CreateButton("Copy Discord Invite", function()
    if setclipboard then
        setclipboard(DiscordInvite)
        Window:Notify("Discord server invite has been coppied to your clipboard! Use Ctrl + V to paste!")
    end
end)
IslandInjection:CreateLabel("Script will auto inject into your island.",false)
for i,v in pairs(IslandsTable) do
    IslandInjection:CreateButton(i, function()
        Island = v
        Blocks = v.Blocks
        Drops = v.Drops
        Entities = v.Entities
        Window:Notify("Script injected into "..tostring(i))
    end)
end

Islands.ChildAdded:Connect(function(v)
    if v:IsA('Model') then
        repeat task.wait(0.1)
        until v:FindFirstChild('Owners') and v.Owners:FindFirstChildWhichIsA('NumberValue')
        local ThisPlayer = Players:GetNameFromUserIdAsync(v.Owners:FindFirstChildWhichIsA('NumberValue').Value)
        IslandsTable[ThisPlayer.."'s Island"] = v
    end
end)

-- right section
HomeTabRightSection = HomeTab:CreateRightSection("Credits")
HomeTabRightSection:CreateLabel("Creator: _Enfirnio",false)
HomeTabRightSection:CreateLabel("Scripter: _Enfirni",false)
HomeTabRightSection:CreateLabel("Helpers:Enfirnio",true)


-- left section 2
HomeTabLeftSection2 = HomeTab:CreateLeftSection("Contact")
HomeTabLeftSection2:CreateLabel("If you have questions or concerns, join the Discord Server, invite is in the field above!",true)
HomeTabLeftSection2:CreateLabel("If you want to submit a suggestion or a bug report, join the Discord Server in the field above and make a post in the forum!",true)

-----------------
-- Farming Tab --
-----------------

-- left section
--- left tab box
local FarmingTabLeftTabBox = FarmingTab:CreateLeftTabbox()
local CropFarm = FarmingTabLeftTabBox:CreateTab({Name = "Crop Farms"})
local WoodFarm = FarmingTabLeftTabBox:CreateTab({Name = "Tree Farms"})
local OreFarm = FarmingTabLeftTabBox:CreateTab({Name = "Ore Farms"})
local FlowerFarm = FarmingTabLeftTabBox:CreateTab({Name = "Flower Farms"})


CropFarm:CreateToggle("BerryFarmToggleFlag", {
    Name = "Berry Farm";
    Callback = function(value)
        BerryFarmToggle = value        ToggleNotification(value, 'Berry Farm')
        lp.PlayerScripts.TS.modules.experience["experience-listener"].Disabled = not ForceXPToggle
        while BerryFarmToggle and task.wait(0.25) do
            HarvestBerries()

        end
    end;
    Default = false;})
CropFarm:CreateToggle("CropFarmToggleFlag", {
    Name = "Crop Farm";
    Callback = function(value)
        CropFarmToggle = value
        ToggleNotification(value, 'Crop Farm')
        lp.PlayerScripts.TS.modules.experience["experience-listener"].Disabled = not ForceXPToggle
        while CropFarmToggle and task.wait(0.25) do
           HarvestCrops3(CropFarmToggleSettings.SelectedCrops)
        end
    end;
    Default = false;})
CropFarm:CreateToggle("ReplantSeedsFlag", {
    Name = "  - Replant Seeds";
    Callback = function(value)
        ToggleNotification(value, 'Replant Seeds')
        CropFarmToggleSettings.ReplantSeeds = value
    end;
    Default = CropFarmToggleSettings.ReplantSeeds;})
CropFarm:CreateToggle("WaterCropsFlag", {
    Name = "  - Water Crops";
    Callback = function(value)
        ToggleNotification(value, 'Water Crops')
        CropFarmToggleSettings.WaterCrops = value
    end;
    Default = CropFarmToggleSettings.WaterCrops;})
local SelectedCropsDropdown
SelectedCropsDropdown = CropFarm:CreateDropdown("SelectedCropsFlag", {
    Name = "  - Selected Crops",
    Values = CropTypes,
    SelectType = MultiOrSingle; -- if u want multi dropdown change Single to Multi
    Callback = function(value)
        if MultiOrSingle == 'Multi' then
            CropFarmToggleSettings.SelectedCrops = SelectedCropsDropdown:Get()
        else
            CropFarmToggleSettings.SelectedCrops = {}
            table.insert(CropFarmToggleSettings.SelectedCrops,value)
        end
        DropdownNotification(CropFarmToggleSettings.SelectedCrops)
    end})
    if not Whitelisted then
        buyprem6 = CropFarm:CreateLabel("<b>You're missing out!</b> Buy Premium to be able to select Multiple crop types!",true)
    end
CropFarm:CreateToggle("ForceXPToggleFlag", {
    Name = "Force XP [Causes Lag]";
    Callback = function(value)
        ToggleNotification(value, 'Force XP')
        ForceXPToggle = value
    end;
    Default = ForceXPToggle;})
CropFarm:CreateToggle("SeedPlantAuraToggleFlag", {
    Name = "Seed Plant Aura";
    Callback = function(value)
        SeedPlantAuraToggle = value
        ToggleNotification(value, 'Seed Plant Aura')
        while SeedPlantAuraToggle and task.wait(0.5) do
            if Character:FindFirstChildWhichIsA('Tool') then
                local Tool = Character:FindFirstChildWhichIsA('Tool')
                if string.find(Tool.Name, 'Seeds') then
                    local str = Tool.Name
                    local newStr, replaced = string.gsub(str, "Seeds", "")
                    SeedPlantAura(newStr)
                end
            end    
        end
    end;
    Default = false;})
    
CropFarm:CreateSlider("SeedPlantAuraRadiusFlag",{
    Name = "  - Radius",
    Min = 1;
    Max = 25;
    Default = SeedPlantAuraToggleSettings.Radius;
    DecimalPlaces = 1;
    AllowValuesOutsideRange = false;
    Callback = function(value)
        SeedPlantAuraToggleSettings.Radius = value
    end,})
CropFarm:CreateToggle("FertilizeAuraToggleFlog", {
    Name = "Fertilize Aura";
    Callback = function(value)
        FertilizeAuraToggle = value
        ToggleNotification(value, 'Fertilize Aura')
        while FertilizeAuraToggle and task.wait(0.1) do 
            local Distance, TargetSoil = math.huge, nil
            for i,v in ipairs(Blocks:GetChildren()) do
                if v.Name == 'soil' and v:FindFirstChild('Fertilized') and v.Fertilized.Value == 0 then
                    local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                    if mag < Distance then
                        Distance = mag
                        TargetSoil = v
                    end
                end
            end 
            if TargetSoil then
                task.spawn(function()
                    local args = {[1] = {["block"] = TargetSoil}}
                    RemotePathMain:WaitForChild("CLIENT_FERTILIZE_BLOCK"):InvokeServer(unpack(args))  
                end)
            end
        end
    end;
    Default = false;})

   
   
    

WoodFarm:CreateToggle("WoodFarmToggleFlag", {
    Name = "Wood Farm";
    Callback = function(value)
        WoodFarmToggle = value
        ToggleNotification(value, 'Wood Farm')
        while WoodFarmToggle and task.wait() do
            FindTree2()
        end
    end;
    Default = false;})
WoodFarm:CreateDropdown("SelectedTreeFlag", {
    Name = "  - Selected Tree",
    Values = TreeTypes,
    SelectType = "Single"; -- if u want multi dropdown change Single to Multi
    Callback = function(value)
        WoodFarmToggleSettings.SelectedTree = value
        local modified = {}
        table.insert(modified, value)
        DropdownNotification(modified)
    end})
    if not Whitelisted then
        buyprem5 = WoodFarm:CreateLabel("<b>You're missing out!</b> Buy Premium to be able to select All tree types!",true)
    end
WoodFarm:CreateToggle("IgnoreFruitTreesWoodFarmToggleFlag", {
    Name = "  - Ignore Fruit Trees";
    Callback = function(value)
        WoodFarmToggleSettings.IgnoreFruitTrees = value
        ToggleNotification(value, 'Ignore Fruit Trees')
    end;
    Default = WoodFarmToggleSettings.IgnoreFruitTrees;})
WoodFarm:CreateToggle("BreakUnderBlockWoodFarmToggleFlag", {
    Name = "  - Break Block Under";
    Callback = function(value)
        WoodFarmToggleSettings.BreakBlockUnder = value
        ToggleNotification(value, 'Break Block Under')
    end;
    Default = WoodFarmToggleSettings.BreakBlockUnder;})
WoodFarm:CreateToggle("TreeAuraToggleFlag", {
    Name = "Tree Aura";
    Callback = function(value)
        TreeAuraToggle = value
        ToggleNotification(value, 'Tree Aura')
        while TreeAuraToggle and task.wait(0.3) do
            TreeAura()
        end
    end;
    Default = false;})
    
WoodFarm:CreateSlider("TreeAuraRadiusFlag",{
    Name = "  - Radius",
    Min = 1;
    Max = 20;
    Default = TreeAuraToggleSettings.Radius;
    DecimalPlaces = 1;
    AllowValuesOutsideRange = false;
    Callback = function(value)
        TreeAuraToggleSettings.Radius = value
    end,})
WoodFarm:CreateToggle("CollectFruitsToggleFlag", {
    Name = "Collect Fruits";
    Callback = function(value)
        CollectFruitsToggle = value
        ToggleNotification(value, 'Collect Fruits')
        while CollectFruitsToggle and task.wait() do
            CollectFruits()
        end
    end;
    Default = false;})
WoodFarm:CreateToggle("CollectHoneyToggleFlag", {
    Name = "Collect Honey";
    Callback = function(value)
        CollectHoneyToggle = value
        ToggleNotification(value, 'Collect Honey')
        while CollectHoneyToggle and task.wait() do
            CollectHoney()
        end
    end;
    Default = false;})
WoodFarm:CreateToggle("AutoClipLeavesToggleFlag", {
    Name = "Auto Clip Leaves";
    Callback = function(value)
        AutoClipLeavesToggle = value
        ToggleNotification(value, 'Auto Clip Leaves')
        while AutoClipLeavesToggle and task.wait() do
            ClipLeaves()
        end
    end;
    Default = false;})
WoodFarm:CreateToggle("TreePlantAuraToggleFlag", {
    Name = "Tree Plant Aura";
    Callback = function(value)
        TreePlantAuraToggle = value
        ToggleNotification(value, 'Tree Plant Aura')
        while TreePlantAuraToggle and task.wait(0.5) do
            if Character:FindFirstChildWhichIsA('Tool') then
                local Tool = Character:FindFirstChildWhichIsA('Tool')
                if string.find(string.lower(Tool.Name), 'sapling') then
                    TreePlantAura(Tool.Name)
                end 
            end    
        end
    end;
    Default = false;})
    
WoodFarm:CreateSlider("TreePlantAuraRadiusFlag",{
    Name = "  - Radius",
    Min = 1;
    Max = 25;
    Default = TreePlantAuraToggleSettings.Radius;
    DecimalPlaces = 1;
    AllowValuesOutsideRange = false;
    Callback = function(value)
        TreePlantAuraToggleSettings.Radius = value
    end,})
OreFarm:CreateToggle("IslandOreFarmToggleFlag", {
    Name = "Personal Island Ore Farm";
    Callback = function(value)
        IslandOreFarmToggle = value
        ToggleNotification(value, 'Personal Island Ore Farm')
        while IslandOreFarmToggle and task.wait() do
            FindIslandOre(OreFarmToggleSettings.SelectedOres)
        end
    end;
    Default = false;})
OreFarm:CreateToggle("OreFarmToggleFlag", {
    Name = "Ore Farm";
    Callback = function(value)
        OreFarmToggle = value
        ToggleNotification(value, 'Ore Farm')
        while OreFarmToggle and task.wait() do
            FindOre(OreFarmToggleSettings.SelectedOres)
        end
    end;
    Default = false;})
OreFarm:CreateToggle("BreakUnderBlockIslandOreToggleFlag", {
    Name = "  - Break Block Under";
    Callback = function(value)
        OreFarmToggleSettings.BreakBlockUnder = value
        ToggleNotification(value, 'Break Block Under')
    end;
    Default = OreFarmToggleSettings.BreakBlockUnder;})


local SelectedOresDropdown
SelectedOresDropdown = OreFarm:CreateDropdown("SelectedOresFlag", {
    Name = "  - Selected Ores",
    Values = OreTypes,
    SelectType = MultiOrSingle; -- if u want multi dropdown change Single to Multi
    Callback = function(value)
        if MultiOrSingle == 'Multi' then
            OreFarmToggleSettings.SelectedOres = SelectedOresDropdown:Get()
        else
            CropFarmToggleSettings.SelectedCrops = {}
            table.insert(OreFarmToggleSettings.SelectedOres,value)
        end
        DropdownNotification(OreFarmToggleSettings.SelectedOres)
    end})
    
if Whitelisted then
    OreFarm:CreateToggle("CurrentIslandToggleFlag", {
     Name = "  - Current Island";
    Callback = function(value)
        OreFarmToggleSettings.CurrentIsland = value
        ToggleNotification(value, 'Current Island')
    end;
    Default = OreFarmToggleSettings.CurrentIsland;})
else
    if not Whitelisted then
        buyprem7 = OreFarm:CreateLabel("<b>You're missing out!</b> Buy Premium to be able to select Multiple ore types, and farm the Current Island that you're on ores!",true)
    end
end

    
    if Whitelisted then
        OreFarm:CreateToggle("OreAuraToggleFlag", {
            Name = "Ore Aura";
            Callback = function(value)
                OreAuraToggle = value
                ToggleNotification(value, 'Ore Aura')
                while OreAuraToggle and task.wait(0.3) do
                    OreAura()
                end
            end;
            Default = false;})
        OreFarm:CreateToggle("IslandOreAuraToggleFlag", {
            Name = "Island Ore Aura";
            Callback = function(value)
                IslandOreAuraToggle = value
                ToggleNotification(value, 'Island Ore Aura')
                while IslandOreAuraToggle and task.wait(0.3) do
                    IslandOreAura()
                end
            end;
            Default = false;})
            
        OreFarm:CreateSlider("OreAuraRadiusFlag",{
            Name = "  - Radius",
            Min = 1;
            Max = 20;
            Default = OreAuraToggleSettings.Radius;
            DecimalPlaces = 1;
            AllowValuesOutsideRange = false;
            Callback = function(value)
                OreAuraToggleSettings.Radius = value
            end,})
        
    else
        buyprem4 = OreFarm:CreateLabel("<b>You're missing out!</b> Buy Premium to get gain access to these features. These features includes: Ore Aura, Island Aura Aura",true)
    end
FlowerFarm:CreateToggle("WaterFertileFlowersToggleFlag", {
    Name = "Water Fertile Flowers";
    Callback = function(value)
        WaterFertileFlowersToggle = value
        ToggleNotification(value, 'Water Fertile Flowers')
        while WaterFertileFlowersToggle and task.wait() do
            WaterFlowers()
        end
    end;
    Default = false;})
FlowerFarm:CreateToggle("CollectFertileFlowersToggleFlag", {
    Name = "Collect Fertile Flowers";
    Callback = function(value)
        CollectFlowersToggle = value
        ToggleNotification(value, 'Collect Fertile Flowers')
        while CollectFlowersToggle and task.wait() do
            CollectFlowers('fertile')
        end
    end;
    Default = false;})

FlowerFarm:CreateToggle("CollectNonFertileFlowersToggleFlag", {
    Name = "Collect Non-Fertile Flowers";
    Callback = function(value)
        CollectFlowersToggle = value
        ToggleNotification(value, 'Collect Non-Fertile Flowers')
        while CollectFlowersToggle and task.wait() do
            CollectFlowers('nonfertile')
        end
    end;
    Default = false;})

-- right section
--- right tab box
local FarmingTabRightTabBox = FarmingTab:CreateRightTabbox()
local FishFarm = FarmingTabRightTabBox:CreateTab({Name = "Fish Farm"})
local WildFarm = FarmingTabRightTabBox:CreateTab({Name = "Wild Farms"})

if Whitelisted then
    FishFarm:CreateToggle("FishFarmToggleFlag", {
        Name = "Fish Farm";
        Callback = function(value)
            FishFarmToggle = value
            ToggleNotification(value, 'Fish Farm')
            local AlreadyFishing = false
            while FishFarmToggle and task.wait() and not AlreadyFishing do
                AlreadyFishing = true
                local FishingSpots = {Vector3.new(-246, 26, -777), Vector3.new(912, 171, -242), Vector3.new(1500, 303, -58), Vector3.new(1550, 357, -820), Vector3.new(697, 279, -1738), Vector3.new(-312, 369, -1929), Vector3.new(-888, 239, -971)}
                local Distance, ClosestSpot = math.huge, nil
                for i,v in ipairs(FishingSpots) do
                    local mag = (v - Character.HumanoidRootPart.Position).Magnitude
                    if mag < Distance then
                        Distance = mag
                        ClosestSpot = v 
                    end
                end
                if ClosestSpot then
                    TGoto(ClosestSpot)
                    repeat task.wait(0.5) until DistanceCheck(ClosestSpot) <= 3
                end   
                task.wait(.5)
                local args = {[1] = HashGen(),[2] = {[1] = {["playerLocation"] = Character.HumanoidRootPart.Position,["direction"] = Vector3.new(0, 0, 0),["strength"] = 0.20603609085083008}}}
                RemotePathMain:FindFirstChild(ThrowRemote):FireServer(unpack(args))
                repeat task.wait() until workspace:FindFirstChild('bubbles') or not FishFarmToggle
                task.wait(FishFarmToggleSettings.FishFarmCatchWait)
                local args = {[1] = {["success"] = true}}  
                RemotePathMain:FindFirstChild(CatchRemote):FireServer(unpack(args))
                task.wait(FishFarmToggleSettings.FishFarmCatchWait)
                AlreadyFishing = false
            end
        end;
        Default = false;})

    FishFarm:CreateSlider("FishFarmCatchWaitSliderFlag",{
        Name = "  - Catch Fish Wait Timer",
        Min = 0.5;
        Max = 15;
        Default = FishFarmToggleSettings.FishFarmCatchWait;
        DecimalPlaces = 1;
        AllowValuesOutsideRange = false;
        Callback = function(value)
            FishFarmToggleSettings.FishFarmCatchWait = value
        end,})
        
else
    buyprem2 = FishFarm:CreateLabel("<b>You're missing out!</b> Buy Premium to get gain access to this section. This section includes amazing features such as: Fish Farm, Catch Fish Wait Timer, & More Coming Soon!",true)
end



WildFarm:CreateToggle("WildFarmToggleFlag", {
    Name = "Wild Farm";
    Callback = function(value)
        WildFarmToggle = value
        ToggleNotification(value, 'Wild Farm')
        while WildFarmToggle and task.wait() do
            CollectWild()
        end
    end;
    Default = false;})
local SelectedWildCropsDropdown
SelectedWildCropsDropdown = WildFarm:CreateDropdown("SelectedWildCropsFlag", {
    Name = "  - Selected Wild Crops",
    Values = {'starfruit', 'acorn', 'flowerCrocus', 'horseradish', 'mushroomRed'},
    SelectType = MultiOrSingle;
    Callback = function(value)
        if MultiOrSingle == 'Multi' then
            WildFarmToggleSettings.SelectedWildCrops = SelectedWildCropsDropdown:Get()
        else
            CropFarmToggleSettings.SelectedCrops = {}
            table.insert(WildFarmToggleSettings.SelectedWildCrops,value)
        end
        DropdownNotification(WildFarmToggleSettings.SelectedWildCrops)
    end})
    if Whitelisted then
        WildFarm:CreateToggle("CollectVoidParasitesToggleFlag", {
            Name = "Collect Void Parasites";
            Callback = function(value)
                CollectVoidParasitesToggle = value
                ToggleNotification(value, 'Collect Void Parasites')
                while CollectVoidParasitesToggle and task.wait() do
                    CollectVoidParasites()
                end
            end;
            Default = false;})
        WildFarm:CreateToggle("VoidSandFarmToggleFlag", {
            Name = "Collect Void Sand";
            Callback = function(value)
                VoidSandFarmToggle = value
                ToggleNotification(value, 'Collect Void Sand')
                while VoidSandFarmToggle and task.wait() do
                    ShovelVoidSand()
                end
            end;
            Default = false;})
        WildFarm:CreateToggle("VoidGrassFarmToggleFlag", {
            Name = "Collect Void Grass";
            Callback = function(value)
                VoidGrassFarmToggle = value
                ToggleNotification(value, 'Collect Void Grass')
                while VoidGrassFarmToggle and task.wait() do
                    ShovelVoidGrass()
                end
            end;
            Default = false;})
    else
        buyprem = WildFarm:CreateLabel("<b>You're missing out!</b> Buy Premium to get gain access to this section. This section includes amazing features such as: Collect Void Parasites, Collect Void Sand, Collect Void Grass & More Coming Soon!",true)
    end

    WildFarm:CreateToggle("AutoFossilFlag", {
        Name = "Auto Fossil";
        Callback = function(value)
            AutoFossilToggle = value
            ToggleNotification(value, 'Fossil Farm')
            while AutoFossilToggle and task.wait() do
                if lp.PlayerGui:FindFirstChild('ActionBarScreenGui') and lp.PlayerGui:FindFirstChild('ActionBarScreenGui'):FindFirstChild('ActionBar') then
                    local ActionBar = lp.PlayerGui:FindFirstChild('ActionBarScreenGui'):FindFirstChild('ActionBar')
                    if ActionBar:FindFirstChild('RoactTree') and AutoFossilToggle then
                        local Minigame = ActionBar.RoactTree["3"].Minigame
                        local marker = Minigame.Marker
                        local hitZone = Minigame.HitZone
            
                        local markerPos = marker.AbsolutePosition
                        local markerSize = marker.AbsoluteSize
                        local hitZonePos = hitZone.AbsolutePosition
                        local hitZoneSize = hitZone.AbsoluteSize
                
                        if markerPos.X >= hitZonePos.X and markerPos.X + markerSize.X <= hitZonePos.X + hitZoneSize.X and markerPos.Y >= hitZonePos.Y and markerPos.Y + markerSize.Y <= hitZonePos.Y + hitZoneSize.Y then
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                        end
                    else
                        local Fossil = FindFossilSite()
                        if Fossil and Fossil.Position and Fossil:FindFirstChildWhichIsA('ProximityPrompt') then
                            TGoto(Fossil.Position)
                            task.wait(0.5)
                            fireproximityprompt(Fossil:FindFirstChildWhichIsA('ProximityPrompt'), 1, true)
                        else
                            error('Unable to find Proxmity Prompt')
                        end 
                    end
                end
            end
        end;
        Default = false;})


    -------------
    -- Mob Tab --
    -------------
--[[
local pp1 = 'As you may have noticed, I have removed all Combat features from my script.'
local pp2 = " This is because the game has updated and I have not figured out how to fix this yet, and probably won't as I have already tried."
local pp3 = ' I took a very long break from scripting and forgot how to do some things.'
local pp4 = " You can find the source code in the Project Z discord server and try to solve it yourself if you'd like to."
local pp5 = ' Although please be cautious as being incorrect will result in your account being banned from Islands permanently.'
local pp6 = ' If someone wanted to solve this for me and send me the code, I will consider implementing it into the script.'
local pp7 = ' You can find the Discord Server invite on the Home page. :)'
local entireString = pp1..pp2..pp3..pp4..pp5..pp6..pp7
]]





CombatTabLeftSection = CombatTab:CreateLeftSection("Mob Farm")
local mobInfo = CombatTabLeftSection:CreateLabel('To get access to the Combat features you first need to manually hit a mob.',true)
task.spawn(function()
    repeat task.wait(1) until attemptHitKey

    -- left section
    CombatTabLeftSection:CreateToggle("MobFarmToggleFlag", {
        Name = "Mob Farm";
        Callback = function(value)
            MobFarmToggle = value
            ToggleNotification(value, 'Mob Farm')
            while MobFarmToggle and task.wait() do
                MobFarmFunction(MobFarmToggleSettings.SelectedMob)
            end
        end;
        Default = false;})
    local SelectedMobsDropdown
    SelectedMobsDropdown = CombatTabLeftSection:CreateDropdown("SelectedMobsFlag", {
        Name = "  - Selected Mob",
        Values = MobTypes,
        SelectType = "Single"; -- if u want multi dropdown change Single to Multi
        Callback = function(value)
            MobFarmToggleSettings.SelectedMob = value --s = SelectedMobsDropdown:Get()
            local modified = {}
            table.insert(modified, value)
            DropdownNotification(modified)
        end})
    CombatTabLeftSection:CreateToggle("MobNoContactFlag", {
        Name = "  - No Contact";
        Callback = function(value)
            MobFarmToggleSettings.NoContact = value
            ToggleNotification(value, 'No Contact')
        end;
        Default = MobFarmToggleSettings.NoContact;})
        --
    CombatTabLeftSection:CreateToggle("MobUndergroundFarmingFlag", {
        Name = "  - Underground Farming";
        Callback = function(value)
            MobFarmToggleSettings.UndergroundFarming = value
            ToggleNotification(value, 'Underground Farming')
        end;
        Default = MobFarmToggleSettings.UndergroundFarming;})
    CombatTabLeftSection:CreateToggle("MobFarmAboveToggleFlag", {
        Name = "  - Above Mob Farming";
        Callback = function(value)
            MobFarmToggleSettings.AboveFarming = value
            ToggleNotification(value, 'Above Mob Farming')
        end;
        Default = MobFarmToggleSettings.AboveFarming;})
    CombatTabLeftSection:CreateSlider("MobFarmAboveOffsetFlag",{
        Name = "   - Above Y Offset",
        Min = 1;
        Max = 25;
        Default = MobFarmToggleSettings.YOffset;
        DecimalPlaces = 0;
        AllowValuesOutsideRange = true;
        Callback = function(state)
            MobFarmToggleSettings.YOffset = state
        end,})

        --[[
    CombatTabLeftSection:CreateSliderToggle("MobFarmAboveOffsetFlag","MobFarmAboveToggleFlag",{
            Name = "Y Offset / Above Farm";
            Min = 1;
            Max = 25;
            SliderDefault = MobFarmToggleSettings.YOffset;
            ToggleDefault = false;
            DecimalPlaces = 0;
            AllowValuesOutsideRange = true;
            SliderCallback = function(state)
                MobFarmToggleSettings.YOffset = state
            end;
            ToggleCallback = function(value)
                MobFarmToggleSettings.AboveFarming = value
                ToggleNotification(value, 'Above Farming')
            end;})

    --
    MobFarmAboveFarmSliderToggle = CombatTabLeftSection:CreateSliderToggle("MobFarmAboveOffsetFlag","MobFarmAboveToggleFlag",{
        Name = "Y Offset / Above Farm";
        Min = 1;
        Max = 25;
        SliderDefault = MobFarmToggleSettings.YOffset;
        ToggleDefault = false;
        DecimalPlaces = 0;
        AllowValuesOutsideRange = true;
        SliderCallback = function(state)
            MobFarmToggleSettings.YOffset = state
        end;
        ToggleCallback = function(value)
            MobFarmToggleSettings.AboveFarming = value
            ToggleNotification(value, 'Above Farming')
        end;})
    ]]


    -- right section

    CombatTabRightSection = CombatTab:CreateRightSection("Boss Farm")
    CombatTabRightSection:CreateToggle("BossFarmToggleFlag", {
        Name = "Boss Farm";
        Callback = function(value)
            BossFarmToggle = value
            ToggleNotification(value, 'Boss Farm')
            while BossFarmToggle and task.wait() do
                BossFarmFunction(BossFarmToggleSettings.SelectedBoss)
            end
        end;
        Default = false;})
    local SelectedBossesDropdown
    SelectedBossesDropdown = CombatTabRightSection:CreateDropdown("SelectedBossesFlag", {
        Name = "  - Selected Boss",
        Values = BossTypes,
        SelectType = "Single"; -- if u want multi dropdown change Single to Multi
        Callback = function(value)
            BossFarmToggleSettings.SelectedBoss = value --es = SelectedMobsDropdown:Get()
            local modified = {}
            table.insert(modified, value)
            DropdownNotification(modified)
        end})
    CombatTabRightSection:CreateToggle("BossUndergroundFarmingFlag", {
        Name = "  - Underground Farming";
        Callback = function(value)
            BossFarmToggleSettings.UndergroundFarming = value
            ToggleNotification(value, 'Underground Farming')
        end;
        Default = BossFarmToggleSettings.UndergroundFarming;})
        --[[
    BossFarmAboveFarmSliderToggle = CombatTabRightSection:CreateSliderToggle("BossFarmAboveOffsetFlag","BossFarmAboveToggleFlag",{
        Name = "Y Offset / Above Farm";
        Min = 1;
        Max = 25;
        SliderDefault = BossFarmToggleSettings.YOffset;
        ToggleDefault = false;
        DecimalPlaces = 0;
        AllowValuesOutsideRange = true;
        SliderCallback = function(state)
            BossFarmToggleSettings.YOffset = state
        end;
        ToggleCallback = function(value)
            BossFarmToggleSettings.AboveFarming = value
            ToggleNotification(value, 'Above Farming')
        end;})
    -- ]]
    --
    CombatTabRightSection:CreateToggle("BossFarmAboveToggleFlag", {
        Name = "  - Above Boss Farming";
        Callback = function(value)
            BossFarmToggleSettings.AboveFarming = value
            ToggleNotification(value, 'Above Boss Farming')
        end;
        Default = BossFarmToggleSettings.AboveFarming;})
    CombatTabRightSection:CreateSlider("BossFarmAboveOffsetFlag",{
        Name = "   - Above Y Offset",
        Min = 1;
        Max = 25;
        Default = BossFarmToggleSettings.YOffset;
        DecimalPlaces = 0;
        AllowValuesOutsideRange = true;
        Callback = function(state)
            BossFarmToggleSettings.YOffset = state
        end,})


    CombatTabRightSection:CreateToggle("RespawnBossToggleFlag", {
        Name = "  - Auto Respawn Boss";
        Callback = function(value)
            ToggleNotification(value, 'Auto Respawn Boss')
            BossFarmToggleSettings.RespawnBoss = valuew
        end;
        Default = BossFarmToggleSettings.RespawnBoss;})
        

    CombatTabRightSection:CreateToggle("BossNoContactFlag", {
        Name = "  - No Contact";
        Callback = function(value)
            BossFarmToggleSettings.NoContact = value
            ToggleNotification(value, 'No Contact')
        end;
        Default = BossFarmToggleSettings.NoContact;})

    -- left section2
    CombatTabLeftSection2 = CombatTab:CreateLeftSection("Combat Utilities")
    if Whitelisted then
        CombatTabLeftSection2:CreateToggle("MobKillAuraToggleFlag", {
            Name = "Mob Kill Aura";
            Callback = function(value)
                KillAuraToggle = value
                ToggleNotification(value, 'Mob Kill Aura')
                while KillAuraToggle and task.wait() do
                    local Distance, Target = math.huge, nil
                    for i,v in ipairs(WildernessEntities:GetChildren()) do
                        if v:FindFirstChild('HumanoidRootPart') then
                            local mag = (v.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                            if mag < Distance then
                                Distance = mag
                                Target = v
                            end
                        end
                    end
                    if Target then
                        if Character:FindFirstChildWhichIsA('Tool') then
                            local Tool = Character:FindFirstChildWhichIsA('Tool')
                            if table.find(BookTypes, Tool.Name) then
                                task.spawn(function()
                                    ShootSpell(Target)
                                end)
                            else
                                task.wait(MobFarmHitWait)
                                task.spawn(function()
                                    HitMob(Target) 
                                end)
                            end
                        else
                            -- no tool
                            EquipTool(BestWeapon_Inv())
                        end  
                    end  
                end
            end;
            Default = false;})

            CombatTabLeftSection2:CreateToggle("PlayerKillAuraToggleFlag", {
                Name = "Player Kill Aura";
                Callback = function(value)
                    PlayerKillauraToggle = value
                    ToggleNotification(value, 'Player Kill Aura')
                    while PlayerKillauraToggle and task.wait(MobFarmHitWait) do
                        local Distance, Target = math.huge, nil
                        for i,v in pairs(Players:GetChildren()) do
                            if v ~= lp and v.Character and v.Character:FindFirstChild('HumanoidRootPart') then
                                local mag = (v.Character.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                                if mag < Distance then
                                    Distance = mag
                                    Target = v
                                end
                            end
                        end
                        if Target and Target.Character then
                            HitMob(Target.Character)
                        end
                    end
                end;
                Default = false;})

                CombatTabLeftSection2:CreateToggle("BowAuraFlag", {
                    Name = "Bow Aura";
                    Callback = function(value)
                        BowAuraToggle = value
                        ToggleNotification(value, 'Bow Aura')
                        task.spawn(function()
                            while BowAuraToggle and task.wait(BowAuraToggleSettings.Delay) do
                                local Distance, Target = math.huge, nil
                                for i,v in ipairs(WildernessEntities:GetChildren()) do
                                    if v:FindFirstChild('HumanoidRootPart') then
                                        local mag = (v.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                                        if mag < Distance then
                                            Distance = mag
                                            Target = v
                                        end
                                    end
                                end
                                if Target then
                                    task.spawn(function()
                                        ShootBow(Target)
                                    end)   
                                end  
                            end
                        end)
                    end;
                    Default = false;})
                    
            BowAuraDelaySlider = CombatTabLeftSection2:CreateSlider("BowAuraDelaySliderFlag",{
                Name = "  - Bow Aura Delay";
                Min = 0.1;
                Max = 2;
                Default = 0.5;
                DecimalPlaces = 1;
                AllowValuesOutsideRange = false;
                Callback = function(value)
                    BowAuraToggleSettings.Delay = value
            end})
                

            CombatTabLeftSection2:CreateToggle("DisableCombatIndicatorsFlag", {
                    Name = "Disable Damage Indicators";
                    Callback = function(value)
                        lp.PlayerScripts.TS.combat["damage-indicators"].Disabled = value
                        ToggleNotification(value, 'Disable Damage Indicators')
                    end;
                    Default = BowAuraToggleSettings.Delay;})
        else
        CombatTabLeftSection21 = CombatTabLeftSection2:CreateLabel("<b>You're missing out!</b> Buy Premium to get gain access to this section. This section includes amazing features such as: Killaura, Player Killaura, Bow Aura, Disable Damage Indicators & More Coming Soon!",true)
    end

end)

--


    --[[
local GodmodeButton = CombatTabLeftSection2:CreateButton("Godmode V2", function()
        if Character:FindFirstChild('LastDamagedTick') then
            Character.LastDamagedTick:Destroy()
            local LastDamagedTick = Instance.new('NumberValue', Character)
            LastDamagedTick.Name = 'LastDamagedTick'
        end
    end)
   ]]
   
-- ]]
    
--------------
-- Misc Tab --
--------------



-- left section
MiscTabLeftSection = MiscTab:CreateLeftSection("Inventory & Items")
MiscTabLeftSection:CreateToggle("CollectTreasureChestsToggleFlag", {
    Name = "Collect Treasure Chests";
    Callback = function(value)
        CollectTreasureChestsToggle = value
        ToggleNotification(value, 'Collect Treasure Chests')
        CollectTreasureChests()
    end;
    Default = false;})
MiscTabLeftSection:CreateToggle("CollectNearDropsToggleFlag", {
    Name = "Collect Near Drops";
    Callback = function(value)
        CollectNearDropsToggle = value
        ToggleNotification(value, 'Collect Near Drops')
        while CollectNearDropsToggle and task.wait() do
            CollectNearDrops()
        end
    end;
    Default = false;})
DisableDropButton = MiscTabLeftSection:CreateButton("Disable Drop", function()
    Window:Notify('Disable Drop Is Now Activated!')
    workspace:FindFirstChild('Sounds').Name = 'Sounds2'
    workspace.Sounds["tool_drop"]:Destroy()
    workspace.Sounds2["tool_drop"]:Destroy()
    RemotePathMain["CLIENT_DROP_TOOL_REQUEST"]:Destroy()
    workspace:FindFirstChild('Sounds2').Name = 'Sounds'
end)

MiscTabLeftSection:CreateToggle("AutoEatToggleFlag", {
    Name = "Auto Eat";
    Callback = function(value)
        AutoEatToggle = value
        ToggleNotification(value, 'Auto Eat')
    end;
    Default = false;})
MiscTabLeftSection:CreateSlider("AutoEatWaitTimeSliderToggleFlag",{
    Name = "   - Auto Eat Wait Time",
    Min = 60;
    Max = 900;
    Default = AutoEatToggleSettings.Time;
    DecimalPlaces = 0;
    AllowValuesOutsideRange = true;
    Callback = function(state)
        AutoEatToggleSettings.Time = state
    end,})
--[[
AutoEatWaitTimeSliderToggle = MiscTabLeftSection:CreateSliderToggle("AutoEatToggleFlag","AutoEatWaitTimeSliderToggleFlag",{
    Name = "Auto Eat / Wait Time";
    Min = 60;
    Max = 900;
    SliderDefault = AutoEatToggleSettings.Time;
    ToggleDefault = false;
    DecimalPlaces = 0;
    AllowValuesOutsideRange = true;
    SliderCallback = function(state)
        AutoEatToggleSettings.Time = state
    end;
    ToggleCallback = function(value)
        AutoEatToggle = value
        ToggleNotification(value, 'Auto Eat')
        while AutoEatToggle and task.wait(AutoEatToggleSettings.Time) do
            EatFood()
        end
    end;})
]]
SetFoodButton = MiscTabLeftSection:CreateButton("Set Food", function()
    if Character:FindFirstChildWhichIsA('Tool') then
        AutoEatToggleSettings.SelectedFood = Character:FindFirstChildWhichIsA('Tool').Name
        Window:Notify('Set Food Is Now: '..tostring(Character:FindFirstChildWhichIsA('Tool').Name)..'!')
    end
end)

local PromptButtonHoldBegan = nil
QuickOpenEggsButton = MiscTabLeftSection:CreateButton("Quick Open Eggs", function()
    PromptButtonHoldBegan = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
        fireproximityprompt(prompt)
    end)
    Window:Notify('Quick Open Eggs Activated!')
end)

PotionMetadata = require(ReplicatedStorage.TS.combat.potion["potion-effect-meta"]).PotionMetadata
for i,v in ipairs(PotionMetadata) do
    for i2,v2 in pairs(v) do
        if tostring(i2) == 'id' then
            table.insert(PotionTypes, tostring(v2))
        end
    end
end



-- right section 
MiscTabRightSection = MiscTab:CreateRightSection("Crafting & Building")
MiscTabRightSection:CreateToggle("PlowAreaToggleFlag", {
    Name = "Plow Aura";
    Callback = function(value)
        PlowAreaToggle = value
        ToggleNotification(value, 'Plow Aura')
        while PlowAreaToggle and task.wait(0.1) do 
            PlowArea('grass')
        end
    end;
    Default = false;})


MiscTabRightSection:CreateToggle("UnPlowAreaToggleFlag", {
    Name = "UnPlow Aura";
    Callback = function(value)
        UnPlowAreaToggle = value
        ToggleNotification(value, 'UnPlow Aura')
        while UnPlowAreaToggle and task.wait(0.1) do 
            PlowArea('soil')
        end
    end;
    Default = false;})
MiscTabRightSection:CreateSlider("PlowRadiusFlag",{
    Name = "  - Radius",
    Min = 1;
    Max = 20;
    Default = PlowRadius;
    DecimalPlaces = 0;
    AllowValuesOutsideRange = false;
    Callback = function(value)
        PlowRadius = value
    end,})



FastToolsButton = MiscTabRightSection:CreateButton("Fast Tools", function()
    Window:Notify('Fast Tools Is Now Activated!')
    lp.PlayerScripts.TS.modules.sound.footsteps.Disabled = true
    local hook
    hook = hookfunction(tick,function(...)
        return hook(...)*Multiplier
    end)
end)
MiscTabRightSection:CreateToggle("RemoveStoneAndTallGrassToggleFlag", {
    Name = "Remove Stone & Tall Grass";
    Callback = function(value)
        RemoveStoneAndTallGrassToggle = value
        ToggleNotification(value, 'Remove Stone & Tall Grass')
        while RemoveStoneAndTallGrassToggle and task.wait() do
            RemoveStoneAndTallGrass()
        end
    end;
    Default = false;})



-- right section 2
MiscTabRightSection2 = MiscTab:CreateRightSection("Mobility & Interaction")
MiscTabRightSection2:CreateToggle("FlyToggleFlag", {
    Name = "Fly";
    Callback = function(value)
        ToggleNotification(value, 'Fly')
        if value == true then
            sFLY()
        else
            NOFLY()
        end
    end;
    Default = false;})
MiscTabRightSection2:CreateToggle("NoclipToggleFlag", {
    Name = "Noclip";
    Callback = function(value)
        IsNoclipping = value
        ToggleNotification(IsNoclipping, 'Noclip')
        Clip = false
        task.wait(0.1)
        if IsNoclipping == true then
            Noclipping = RunService.Stepped:Connect(NoclipLoop)
        else
            Noclipping:Disconnect()
        end 
    end;
    Default = false;})




-- left section 2
MiscTabLeftSection2 = MiscTab:CreateLeftSection("Pets & Creatures")
MiscTabLeftSection2:CreateToggle("NetEntityToggleFlag", {
    Name = "Net Entity";
    Callback = function(value)
        NetEntityToggle = value
        ToggleNotification(value, 'Net Entity')
        while NetEntityToggle and task.wait() do
            NetEntity(NetEntityToggleSettings.SelectedEntity)
        end
    end;
    Default = false;})
MiscTabLeftSection2:CreateDropdown("SelectedEntityFlag", {
    Name = "  - Selected Entity",
    Values = EntityTypes,
    SelectType = "Single";
    Callback = function(value)
        NetEntityToggleSettings.SelectedEntity = value
        local modified = {}
        table.insert(modified, value)
        DropdownNotification(modified)
    end})
MiscTabLeftSection2:CreateToggle("PetPetsToggleFlag", {
    Name = "Pet Pets";
    Callback = function(value)
        PetPetsToggle = value
        ToggleNotification(value, 'Pet Pets')
        while PetPetsToggle and task.wait() do
            PetPets()
        end
    end;
    Default = false;})
MiscTabLeftSection2:CreateToggle("SpookTurkeysToggleFlag", {
    Name = "Spook Turkeys";
    Callback = function(value)
        SpookTurkeysToggle = value
        ToggleNotification(value, 'Spook Turkeys')
        while SpookTurkeysToggle and task.wait() do
            SpookTurkeys()
        end
    end;
    Default = false;})


-- right section 3
MiscTabRightSection3 = MiscTab:CreateRightSection("Other Misc")

MiscTabRightSection3:CreateDropdown("SelectedPotionFlag", {
    Name = "Give Potion",
    Values = PotionTypes,
    SelectType = "Single";
    Callback = function(value)
        local modified = {}
        table.insert(modified, value)
        DropdownNotification(modified)
        if value == 'Remove All' then
            for i,v in ipairs(Character.PotionEffects:GetChildren()) do
                v:Destroy()
            end
        else
            local effect = Instance.new('BoolValue', Character.PotionEffects)
            effect.Name = value
            effect.Value = true
        
            local TimeStarted = Instance.new('NumberValue', effect)
            TimeStarted.Name = 'TimeStarted'
            TimeStarted.Value = 1675122532.236848
            
            local Duration = Instance.new('NumberValue', effect)
            Duration.Name = 'Duration'
            Duration.Value = math.huge
        
            local SourceEntity = Instance.new('ObjectValue', effect)
            SourceEntity.Name = 'SourceEntity'
            SourceEntity.Value = nil
        end
    end})

MiscTabRightSection3:CreateDropdown("SetSeasonFlag", {
    Name = "Set Season",
    Values = {'summer','spring','winter','fall'},
    SelectType = "Single";
    Callback = function(value)
        local modified = {}
        table.insert(modified, value)
        DropdownNotification(modified)
        if workspace:FindFirstChild('Season') then
            workspace.Season.Value = tostring(value)
        end
    end})
MiscTabRightSection3:CreateToggle("UnlockDayAndNightSettingsToggleFlag", {
    Name = "Unlock Day & Night Settings";
    Callback = function(value)
        ToggleNotification(value, 'Unlock Day & Night Settings')
        lp.Gamepasses.PRO.Value = value
    end;
    Default = false;}) 
MiscTabRightSection3:CreateSlider("SelectedFieldOfViewFlag",{
    Name = "Field Of View",
    Min = 10;
    Max = 120;
    Default = SelectedFieldOfViewAmount;
    DecimalPlaces = 0;
    AllowValuesOutsideRange = false;
    Callback = function(value)
        SelectedFieldOfViewAmount = value
    end,})
ReadAllMailButton = MiscTabRightSection3:CreateButton("Read All Mail", function()
    for i = 1,1000 do
        local args = {[1] = "game_update_" .. tostring(i)}
        RemotePathMain:WaitForChild("Mailbox/ReadMail"):FireServer(unpack(args))
    end
    Window:Notify('Read all mail!')
end)




-------------------
-- Machinery Tab --
-------------------

-- left section
MachineryTabLeftSection = MachineryTab:CreateLeftSection("Auto Utility")
AutoUtilityInstructions = MachineryTabLeftSection:CreateLabel("<b>Instructions:</b> Hold the item you want to input into the workstation. Script will auto use coal and auto collect outputs.",true)

MachineryTabLeftSection:CreateToggle("AutoBlastFurnaceToggleFlag", {
    Name = "Auto Blast Furnace";
    Callback = function(value)
        AutoBlastFurnaceToggle = value
        ToggleNotification(value, 'Auto Blast Furnace')
        while AutoBlastFurnaceToggle and task.wait(0.5) do
            if not Character:FindFirstChildWhichIsA('Tool') then
                Window:Notify('Make sure to hold an item!')
            else
                AutoBlastFurnace()
            end
        end 
    end;
    Default = false;})
MachineryTabLeftSection:CreateToggle("AutoStonecutterToggleFlag", {
    Name = "Auto Stonecutter";
    Callback = function(value)
        AutoStonecutterToggle = value
        ToggleNotification(value, 'Auto Stonecutter')
        while AutoStonecutterToggle and task.wait(0.5) do
            if not Character:FindFirstChildWhichIsA('Tool') then
                Window:Notify('Make sure to hold an item!')
            else
                AutoStonecutter()
            end
        end
    end;
    Default = false;})
MachineryTabLeftSection:CreateToggle("AutoSawmillToggleFlag", {
    Name = "Auto Sawmill";
    Callback = function(value)
        AutoSawmillToggle = value
        ToggleNotification(value, 'Auto Sawmill')
        while AutoSawmillToggle and task.wait(0.5) do
            if not Character:FindFirstChildWhichIsA('Tool') then
                Window:Notify('Make sure to hold an item!')
            else
                AutoSawmill()
            end
        end
    end;
    Default = false;})
MachineryTabLeftSection:CreateToggle("AutoSmallFurnaceToggleFlag", {
    Name = "Auto Small Furnace";
    Callback = function(value)
        AutoSmallFurnaceToggle = value
        ToggleNotification(value, 'Auto Small Furnace')
        while AutoSmallFurnaceToggle and task.wait(0.5) do
            if not Character:FindFirstChildWhichIsA('Tool') then
                Window:Notify('Make sure to hold an item!')
            else
                AutoSmallFurnace()
            end
        end
    end;
    Default = false;})
MachineryTabLeftSection:CreateToggle("AutoCampfireToggleFlag", {
    Name = "Auto Campfire";
    Callback = function(value)
        AutoCampfireToggle = value
        ToggleNotification(value, 'Auto Campfire')
        while AutoCampfireToggle and task.wait(0.5) do
            if not Character:FindFirstChildWhichIsA('Tool') then
                Window:Notify('Make sure to hold an item!')
            else
                AutoCampfire()
            end
        end
    end;
    Default = false;})
MachineryTabLeftSection:CreateToggle("AutoCratePackerToggleFlag", {
    Name = "Auto Crate Packer";
    Callback = function(value)
        AutoCratePackerToggle = value
        ToggleNotification(value, 'Auto Crate Packer')
        while AutoCratePackerToggle and task.wait(0.1) do
            if not Character:FindFirstChildWhichIsA('Tool') then
                Window:Notify('Make sure to hold an item!')
            else
                AutoCratePacker()
            end
        end
    end;
    Default = false;})
MachineryTabLeftSection:CreateToggle("AutoComposterToggleFlag", {
    Name = "Auto Composter";
    Callback = function(value)
        AutoComposterToggle = value
        ToggleNotification(value, 'Auto Crate Packer')
        while AutoComposterToggle and task.wait(0.1) do
            if not Character:FindFirstChildWhichIsA('Tool') then
                Window:Notify('Make sure to hold an item!')
            else
                AutoCompost()
            end
        end
    end;
    Default = false;})



   
    
-- right section
MachineryTabRightSection = MachineryTab:CreateRightSection("Collection")
MachineryTabRightSection:CreateToggle("CollectIndustrialChestItemsToggleFlag", {
    Name = "Collect Industrial Chest Items";
    Callback = function(value)
        CollectIndustrialChestItemsToggle = value
        ToggleNotification(value, 'Collect Industrial Chest Items')
        while CollectIndustrialChestItemsToggle and task.wait(0.15) do
            CollectIndustrialChestItems()
        end
    end;
    Default = false;})
MachineryTabRightSection:CreateToggle("CollectChestItemsToggleFlag", {
    Name = "Collect Chest Items";
    Callback = function(value)
        CollectChestItemsToggle = value
        ToggleNotification(value, 'Collect Chest Items')
        while CollectChestItemsToggle and task.wait(0.15) do
            CollectChestItems()
        end
    end;
    Default = false;})




-- right section 2
MachineryTabRightSection2 = MachineryTab:CreateRightSection("Totems")
MachineryTabRightSection2:CreateToggle("UpgradeTotemsToggleFlag", {
    Name = "Upgrade Totems";
    Callback = function(value)
        UpgradeTotemsToggle = value
        ToggleNotification(value, 'Upgrade Totems')
        while UpgradeTotemsToggle and task.wait(0.15) do
            UpgradeTotems(TotemToggleSettings.SelectedTotem, TotemToggleSettings.UpgradeType, TotemToggleSettings.UpgradeAmount)
        end
    end;
    Default = false;})
MachineryTabRightSection2:CreateDropdown("SelectedTotemFlag", {
    Name = "  - Selected Totem",
    Values = TotemTypes,
    SelectType = "Single";
    Callback = function(value)
        TotemToggleSettings.SelectedTotem = value
        local modified = {}
        table.insert(modified, value)
        DropdownNotification(modified)
    end})
MachineryTabRightSection2:CreateDropdown("TotemUpgradeTypeFlag", {
    Name = "  - Upgrade Type",
    Values = {'utility','efficiency','quality'},
    SelectType = "Single";
    Callback = function(value)
        TotemToggleSettings.UpgradeType = value
        local modified = {}
        table.insert(modified, value)
        DropdownNotification(modified)
    end})
MachineryTabRightSection2:CreateSlider("TotemUpgradeAmountFlag",{
    Name = "  - Upgrade Amount",
    Min = 1;
    Max = 53;
    Default = TotemToggleSettings.UpgradeAmount;
    DecimalPlaces = 0;
    AllowValuesOutsideRange = false;
    Callback = function(value)
        TotemToggleSettings.UpgradeAmount = value
    end,})

MachineryTabRightSection2:CreateToggle("AutoCollectTotemItemsToggleFlag", {
    Name = "Auto Collect Totem Items";
    Callback = function(value)
        AutoCollectTotemItemsToggle = value
        ToggleNotification(value, 'Auto Collect Totem Items')
        while AutoCollectTotemItemsToggle and task.wait() do
            CollectTotemItems()
        end
    end;
    Default = false;})

-- left section 2
MachineryTabLeftSection2 = MachineryTab:CreateLeftSection("Vending Machines")
local VendingTypes = {'vendingMachine', 'vendingMachine1'}

MachineryTabLeftSection2:CreateTextbox("VendingLocatorItemFlag",{
    Name = "Search For Item";
    DefaultText = "";
    PlaceholderText = "nil";
    Callback = function(inputtedText)
        if string.lower(inputtedText) == 'nil' or inputtedText == '' then
            for i, v in ipairs(Blocks:GetChildren()) do
                if table.find(VendingTypes, v.Name) and v:FindFirstChild('VendingMachine') and v.VendingMachine:FindFirstChildWhichIsA('Highlight') then
                    v.VendingMachine:FindFirstChildWhichIsA('Highlight'):Destroy()
                end
            end
        else
            local ItemToSearchFor, replaced = string.lower(string.gsub(inputtedText, " ", ""))  
            local Distance, TargetBlock = math.huge, nil
            for i, v in ipairs(Blocks:GetChildren()) do
                if table.find(VendingTypes, v.Name) and v:FindFirstChild('Mode') and v:FindFirstChild('UserEditing') and v.UserEditing.Value == nil and v:FindFirstChild('SellingContents') and v.SellingContents:FindFirstChildWhichIsA('Tool') then
                    local str2 = v.SellingContents:FindFirstChildWhichIsA('Tool').Name
                    local newStr2, replaced = string.lower(string.gsub(str2, " ", ""))   
                    if string.find(newStr2, ItemToSearchFor) and v:FindFirstChild('VendingMachine') and not v.VendingMachine:FindFirstChildWhichIsA('Highlight')  then
                        local Highlight = Instance.new('Highlight', v.VendingMachine) 
                        Highlight.FillTransparency = 0.5
                        if v.Mode.Value == 0 then
                            Highlight.FillColor = Color3.fromRGB(0,255,0)
                        elseif v.Mode.Value == 1 then
                            Highlight.FillColor = Color3.fromRGB(255,0,0)
                        elseif v.Mode.Value == 2 then
                            Highlight.FillColor = Color3.fromRGB(255,255,255)
                        end 
                    end
                end
            end
        end  
    end;
    ClearTextOnFocus = false;
    OnlyCallbackOnEnterPressed = true;})



MachineryTabLeftSection2:CreateToggle("VendingMachineSniperToggleFlag", {
    Name = "Vending Sniper";
    Callback = function(value)
        VendingMachineSniperToggle = value
        ToggleNotification(value, 'Vending Sniper')
        while VendingMachineSniperToggle and task.wait(0.1) do
            local Distance, TargetBlock = math.huge, nil, 0
            for i, v in ipairs(Blocks:GetChildren()) do
                if table.find(VendingTypes, v.Name) and v:FindFirstChild('TransactionPrice') and v.TransactionPrice.Value <= VendingMachineSniperMaxPrice and v:FindFirstChild('Mode') and v.Mode.Value == 0 and v:FindFirstChild('UserEditing') and v.UserEditing.Value == nil then
                    if v:FindFirstChild('SellingContents') and v.SellingContents:FindFirstChildWhichIsA('Tool') and v.SellingContents:FindFirstChildWhichIsA('Tool'):FindFirstChild('Amount') and v.SellingContents:FindFirstChildWhichIsA('Tool').Amount.Value >= 1 then
                        local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                        if mag < Distance then
                            Distance = mag
                            TargetBlock = v
                        end
                    end
                end
            end
            if TargetBlock and TargetBlock.Position then
                TGoto(TargetBlock.Position)
                OpenVending(TargetBlock)
                task.spawn(function()
                    local args = {[1] = HashGen(),[2] = {[1] = {["vendingMachine"] = TargetBlock,["player_tracking_category"] = "join_from_web",["amount"] = TargetBlock.SellingContents:FindFirstChildWhichIsA('Tool'):FindFirstChild('Amount').Value}}}
                    RemotePathMain:WaitForChild(VendingRemotes.buyVendingRemote):FireServer(unpack(args))
                end)
                task.wait()
                CloseVending(TargetBlock)
            end
        end
    end;
    Default = false;})
MachineryTabLeftSection2:CreateSlider("VendingMachineSniperMaxPriceFlag",{
    Name = "  - Maximum Price",
    Min = 10;
    Max = 10000;
    Default = VendingMachineSniperMaxPrice;
    DecimalPlaces = 0;
    AllowValuesOutsideRange = true;
    Callback = function(state)
        VendingMachineSniperMaxPrice = state
    end,})

--[[
VendingMachineSniperSliderToggle = MachineryTabLeftSection2:CreateSliderToggle("VendingMachineSniperToggleFlag","VendingMachineSniperMaxPriceFlag",{
    Name = "Vending Sniper";
    Min = 10;
    Max = 10000;
    SliderDefault = VendingMachineSniperMaxPrice;
    ToggleDefault = false;
    DecimalPlaces = 0;
    AllowValuesOutsideRange = true;
    SliderCallback = function(state)
        VendingMachineSniperMaxPrice = state
    end;
    ToggleCallback = function(value)
        VendingMachineSniperToggle = value
        ToggleNotification(value, 'Vending Sniper')
        while VendingMachineSniperToggle and task.wait(0.1) do
            local Distance, TargetBlock = math.huge, nil, 0
            for i, v in ipairs(Blocks:GetChildren()) do
                if table.find(VendingTypes, v.Name) and v:FindFirstChild('TransactionPrice') and v.TransactionPrice.Value <= VendingMachineSniperMaxPrice and v:FindFirstChild('Mode') and v.Mode.Value == 0 and v:FindFirstChild('UserEditing') and v.UserEditing.Value == nil then
                    if v:FindFirstChild('SellingContents') and v.SellingContents:FindFirstChildWhichIsA('Tool') and v.SellingContents:FindFirstChildWhichIsA('Tool'):FindFirstChild('Amount') and v.SellingContents:FindFirstChildWhichIsA('Tool').Amount.Value >= 1 then
                        local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                        if mag < Distance then
                            Distance = mag
                            TargetBlock = v
                        end
                    end
                end
            end
            if TargetBlock and TargetBlock.Position then
                TGoto(TargetBlock.Position)
                OpenVending(TargetBlock)
                task.spawn(function()
                    local args = {[1] = HashGen(),[2] = {[1] = {["vendingMachine"] = TargetBlock,["player_tracking_category"] = "join_from_web",["amount"] = TargetBlock.SellingContents:FindFirstChildWhichIsA('Tool'):FindFirstChild('Amount').Value}}}
                    RemotePathMain:WaitForChild(VendingRemotes.buyVendingRemote):FireServer(unpack(args))
                end)
                task.wait()
                CloseVending(TargetBlock)
            end
        end
    end;})
]]
--[[
MachineryTabLeftSection2:CreateToggle("StockVendingMachinesToggleFlag", {
    Name = "Stock Vending Machines BETA";
    Callback = function(value)
        StockVendingMachinesToggle = value
        ToggleNotification(value, 'Stock Vending Machines')
        while StockVendingMachinesToggle and task.wait() do
            StockVendingMachines()
        end
    end;
    Default = false;})
MachineryTabLeftSection2:CreateToggle("EmptyBuyVendingMachinesToggleFlag", {
    Name = "Empty Buy Vending Machines BETA";
    Callback = function(value)
        EmptyBuyVendingMachinesToggle = value
        ToggleNotification(value, 'Empty Buy Vending Machines')
        while EmptyBuyVendingMachinesToggle and task.wait() do
            EmptyBuyVendingMachines()
        end
    end;
    Default = false;})
MachineryTabLeftSection2:CreateToggle("EmptyAllVendingMachinesToggleFlag", {
    Name = "Empty All Vending Machines BETA";
    Callback = function(value)
        EmptyAllVendingMachinesToggle = value
        ToggleNotification(value, 'Empty All Vending Machines')
        while EmptyAllVendingMachinesToggle and task.wait() do
            EmptyAllVendingMachines()
        end
    end;
    Default = false;})
]]
-- right section 3
MachineryTabRightSection3 = MachineryTab:CreateRightSection("Machinery Misc")
--[[
ConveyorSpeedSliderToggle = MachineryTabRightSection3:CreateSliderToggle("ConveyorSpeedSliderFlag","ConveyorSpeedToggleFlag",{
    Name = "Custom Conveyor Speed";
    Min = 1;
    Max = 25;
    SliderDefault = CustomConveyorSpeedToggleSettings.Speed;
    ToggleDefault = false;
    DecimalPlaces = 0;
    AllowValuesOutsideRange = true;
    SliderCallback = function(state)
        CustomConveyorSpeedToggleSettings.Speed = state
    end;
    ToggleCallback = function(value)
        CustomConveyorSpeedToggle = value
        ToggleNotification(value, 'Custom Conveyor Speed')
        while CustomConveyorSpeedToggle and task.wait(0.25) do
            SetCustomConveyorSpeed()
        end   
    end;})
]]
MachineryTabRightSection3:CreateToggle("ConveyorSpeedToggleFlag", {
    Name = "Custom Conveyor Speed";
    Callback = function(value)
        CustomConveyorSpeedToggle = value
        ToggleNotification(value, 'Custom Conveyor Speed')
        while CustomConveyorSpeedToggle and task.wait(0.25) do
            SetCustomConveyorSpeed()
        end
    end;
    Default = false;})
MachineryTabRightSection3:CreateSlider("ConveyorSpeedSliderFlag",{
    Name = "  - Conveyor Speed",
    Min = 1;
    Max = 25;
    Default = CustomConveyorSpeedToggleSettings.Speed;
    DecimalPlaces = 0;
    AllowValuesOutsideRange = true;
    Callback = function(state)
        CustomConveyorSpeedToggleSettings.Speed = state
    end,})

--------------------
-- World Edit Tab --
--------------------
if Whitelisted then
    -- left section
    WorldEditTabLeftSection = WorldEditTab:CreateLeftSection("Block Printer")
    WorldEditInstructions1 = WorldEditTabLeftSection:CreateLabel("<b>Instructions:</b> Press Spawn Guide, configure the guide block to your desired area. Then hold the block you want to build with and press Place Blocks.",true)
    BlockPrinterStatus = WorldEditTabLeftSection:CreateLabel("<b>Status: Waiting For Input</b>",true)
    SpawnAndRemoveGuideButtons = WorldEditTabLeftSection:CreateSubButtons("Spawn Guide","Remove Guide",function()
        
        local Inside = workspace.Area:FindFirstChild('Guide')
        Inside.Transparency = 0.7
        Inside.Size = Vector3.new(3,3,3)
        Inside.Position = GetClosestBlockForSchematica().Position + Vector3.new(0,3,0)
       
        Inside:FindFirstChild('SelectionBox').Visible = true
        CoreGui:FindFirstChild('Handles').Visible = true

        Window:Notify('Spawned Guide Block.')
    end,function()

        Inside = workspace.Area:FindFirstChildWhichIsA('Part')
        Inside.Transparency = 1
        Inside.Size = Vector3.new(0.1,0.1,0.1)
        Inside:FindFirstChildWhichIsA('SelectionBox').Visible = false
        CoreGui:FindFirstChild('Handles').Visible = false

        Window:Notify('Removed Guide Block.')
    end)
    local PlaceBlocksButton = WorldEditTabLeftSection:CreateButton("Place Blocks", function()
        if Character:FindFirstChildWhichIsA('Tool') then
            local Tool = Character:FindFirstChildWhichIsA('Tool')
            local StartPos,EndPos = GetGuideBlockPositions()
            if string.find(Tool.Name, 'Seeds') then
                local str = Tool.Name
                local newStr, replaced = string.gsub(str, "Seeds", "")
                BlockPrinterStatus:Update("<b>Status: Placing Seeds..</b>") 
                Window:Notify('Printing Seeds!')
                PlaceBlocks(StartPos, EndPos, newStr) -- try making it 1 line
            else
                BlockPrinterStatus:Update("<b>Status: Placing Blocks..</b>")
                Window:Notify('Printing Blocks!')
                PlaceBlocks(StartPos, EndPos, Tool.Name)
            end
        else
            Window:Notify('Please Hold A Block!')
            BlockPrinterStatus:Update("<b>Please Hold A Block!</b>")
            task.wait(5)
            BlockPrinterStatus:Update("<b>Status: Waiting For Input</b>")
        end
    end)

    WorldEditTabLeftSection:CreateToggle("FastPrintToggleFlag", {
        Name = "  - Fast Print";
        Callback = function(value)
            ToggleNotification(value, 'Fast Print')
            if value == true then
                BlockPrinterSettings.FastPrint = 19
            elseif value == false then
                BlockPrinterSettings.FastPrint = 1
            end
        end;
        Default = false;})

    local BreakBlocks = WorldEditTabLeftSection:CreateButton("Destroy Area", function()
        local StartPos,EndPos = GetGuideBlockPositions()
        BlockPrinterStatus:Update("<b>Status: Destroying Area..</b>")
        Window:Notify('Destroying Area...')
        BlockPrinterSettings.BreakingBlocks = true
        while BlockPrinterSettings.BreakingBlocks and task.wait() and isAreaFilled(StartPos,EndPos) do
            BreakBlocks(StartPos, EndPos)
        end
    end)
    
        
    local AbortPrinterButton = WorldEditTabLeftSection:CreateButton("Abort", function()
        Window:Notify('Aborting Action!')
        BlockPrinterStatus:Update("<b>Status: Aborting..</b>")
        Abort = true
        BlockPrinterSettings.BreakingBlocks = false
        BlockPrinterStatus:Update("<b>Status: Aborted!</b>")
        task.wait(2)
        Abort = false
        BlockPrinterStatus:Update("<b>Status: Waiting For Input</b>")
        Window:Notify('Aborted Action!')
    end)


    -- right section
    WorldEditTabRightSection = WorldEditTab:CreateRightSection("Schematica (Copy / Paste Builds)")
    WorldEditInstructions2 = WorldEditTabRightSection:CreateLabel("<b>Instructions:</b> Press Spawn Guide, configure the guide block to your desired area. Then Click Copy Build, use Show Preview if you'd like to, move to where you want the build to be pasted and click Paste Build.",true)
    SchematicaStatus = WorldEditTabRightSection:CreateLabel("<b>Status: Waiting For Input</b>",true)
    SpawnAndRemoveGuideButtonsSchematica = WorldEditTabRightSection:CreateSubButtons("Spawn Guide","Remove Guide",function()
        
        local Inside = workspace.Area:FindFirstChild('Guide')
        Inside.Transparency = 0.7
        Inside.Size = Vector3.new(3,3,3)
        Inside.Position = GetClosestBlockForSchematica().Position + Vector3.new(0,3,0)
       
        Inside:FindFirstChild('SelectionBox').Visible = true
        CoreGui:FindFirstChild('Handles').Visible = true

        Window:Notify('Spawned Guide Block.')
    end,function()

        Inside = workspace.Area:FindFirstChildWhichIsA('Part')
        Inside.Transparency = 1
        Inside:FindFirstChildWhichIsA('SelectionBox').Visible = false
        CoreGui:FindFirstChild('Handles').Visible = false

        Window:Notify('Removed Guide Block.')
    end)
    SchematicaCopyButton = WorldEditTabRightSection:CreateButton("Copy Build", function()
        local StartPos,EndPos = GetGuideBlockPositions()
        SchematicaStatus:Update("<b>Status: Copying Build..</b>")
        CopyBlocks(StartPos, EndPos)
        Window:Notify('Copied Build!')
    end)

WorldEditTabRightSection:CreateToggle("ShowPreviewToggleFlag", {
        Name = "  - Show Preview";
        Callback = function(value)
            SchematicaSettings.ShowPreview = value
            ToggleNotification(value, 'Show Preview')

            if SchematicaSettings.ShowPreview then
                for _, Block in ipairs(workspace:FindFirstChild('PreviewHolder'):GetChildren()) do
                    Block:Destroy()
                end

                local PreviewBlock = workspace:FindFirstChild('PreviewBlock')
                PreviewBlock.Transparency = 0.3
                PreviewBlock.Size = Vector3.new(3,3,3)
                PreviewBlock.Position = GetClosestBlockForSchematica().Position + Vector3.new(0,3,0)
               
                PreviewBlock:FindFirstChild('SelectionBox').Visible = true
                CoreGui:FindFirstChild('Handles1').Visible = true

                for BlockType,CFrames in pairs(CopiedBlocks.Blocks) do
                    for i2,CF in pairs(CFrames) do
                        local NewCF = CF + PreviewBlock.Position
                        if ReplicatedStorage.Blocks:FindFirstChild(BlockType) and not FilledCheck(NewCF.Position) then
                            local ReplicatedBlock = ReplicatedStorage.Blocks:FindFirstChild(BlockType):Clone()
                            ReplicatedBlock.Root.CanCollide = false
                            ReplicatedBlock.Root.CFrame = NewCF
                            ReplicatedBlock.Parent = workspace:FindFirstChild('PreviewHolder')
                            ReplicatedBlock.Root.Transparency = 0.5
                        end
                    end
                end
            else
                workspace:FindFirstChild('PreviewHolder'):ClearAllChildren()
                local PreviewBlock = workspace:FindFirstChild('PreviewBlock')
                PreviewBlock.Transparency = 1
                PreviewBlock.Size = Vector3.new(0.1,0.1,0.1)
               
                PreviewBlock:FindFirstChild('SelectionBox').Visible = false
                CoreGui:FindFirstChild('Handles1').Visible = false
            end

            if not SchematicaSettings.ShowPreview then
                workspace:FindFirstChild('PreviewHolder'):ClearAllChildren()
                local PreviewBlock = workspace:FindFirstChild('PreviewBlock')
                PreviewBlock.Transparency = 1
                PreviewBlock.Size = Vector3.new(0.1,0.1,0.1)
               
                PreviewBlock:FindFirstChild('SelectionBox').Visible = false
                CoreGui:FindFirstChild('Handles1').Visible = false
            end 
        end;
        Default = false;})
        --[[
    SchematicaRotateX = WorldEditTabRightSection:CreateButton("Rotate X", function()
        for _, block in ipairs(workspace:FindFirstChild('PreviewHolder'):GetChildren()) do
            if block:FindFirstChild('Root') then
                block.Root.CFrame = block.Root.CFrame * CFrame.Angles(math.rad(90), 0, 0)
            end
        end
        Window:Notify('Success!','Rotated on X axis!')
    end)
    SchematicaRotateY = WorldEditTabRightSection:CreateButton("Rotate Y", function()
        for _, block in ipairs(workspace:FindFirstChild('PreviewHolder'):GetChildren()) do
            if block:FindFirstChild('Root') then
                block.Root.CFrame = block.Root.CFrame * CFrame.Angles(0, math.rad(90), 0)
            end
        end
        Window:Notify('Success!','Rotated on Y axis!')
    end)
    ]]

    local SchematicaPasteButton = WorldEditTabRightSection:CreateButton("Paste Build", function()
        SchematicaStatus:Update("<b>Status: Pasting Build..</b>")
        PasteBlocks()
        Window:Notify('Pasted Build!')
    end)
    local SchematicaAbortButton = WorldEditTabRightSection:CreateButton("Abort", function()
        Window:Notify('Aborting Action!')
        SchematicaStatus:Update("<b>Status: Aborting..</b>")
        Abort = true
        task.wait(1)
        SchematicaStatus:Update("<b>Status: Aborted!</b>")
        Abort = false
        task.wait(5)
        SchematicaStatus:Update("<b>Status: Waiting For Input</b>")
        Window:Notify('Aborted Action!')
    end)

    
    --

        local filetext = ''
        local loadfile = ''

        WorldEditTabRightSection:CreateTextbox("filetextflag",{
            Name = "File Name";
            DefaultText = "Example Build";
            PlaceholderText = "Example Build";
            Callback = function(inputtedText)
                filetext = inputtedText
            end;
            ClearTextOnFocus = false;
            OnlyCallbackOnEnterPressed = true;})

--[[
        if #listfiles('Project_Z/Islands/Builds') ~= 0 then
            SelectedSchematicaFileDropdown = WorldEditTabRightSection:CreateDropdown("SelectedSchematicaFileDropdownFlag", {
                Name = "Select File",
                Values = listfiles('Project_Z/Islands/Builds'),
                SelectType = Single;
                Callback = function(value)
                    loadfile = tostring(value)
            end})
        end
]]
        local SaveAndLoadFileButtons = WorldEditTabRightSection:CreateSubButtons("Save File","Load File",function()
            if not string.find(filetext, '.json') then
                filetext = filetext .. '.json'
            end
            SaveSchematicaFile(filetext)
        end,function()
            
            LoadSchematicaFile(filetext)
        end)
       
        

        
        

    

    


    -- right section 2
    WorldEditTabRightSection2 = WorldEditTab:CreateRightSection("More World Edit Tools")
    IslandBlockTypes = {}
    task.spawn(function()
        repeat task.wait(1) until Blocks ~= nil
        for i,v in ipairs(Blocks:GetChildren()) do
            if v.Name ~= 'bedrock' and not string.find(v.Name, 'portalToSpawn') and not table.find(IslandBlockTypes, v.Name) then
                table.insert(IslandBlockTypes, v.Name)
            end
        end

        WorldEditTabRightSection2:CreateToggle("DestroySpecificBlockFlag", {
            Name = "Destroy Specific Block";
            Callback = function(value)
                BreakSpecificBlocksToggle = value
                ToggleNotification(value, 'Destroy Blocks')
                while BreakSpecificBlocksToggle and task.wait() do
                    local Distance, TargetBlock = math.huge, nil
                    for i, v in ipairs(Blocks:GetChildren()) do
                        if v.Name == BlockPrinterSettings.SelectedSpecificBlock and v.Name ~= 'bedrock' and v.Parent ~= nil and v.Parent.Parent ~= nil and (not v:FindFirstChild("portal-to-spawn")) and v.Parent and v.Parent.Name == "Blocks" and BreakSpecificBlocksToggle then
                            local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                            if mag < Distance then
                                Distance = mag
                                TargetBlock = v
                            end
                        end
                    end
                    repeat task.wait(0.001)
                        if TargetBlock and TargetBlock.Position then
                            TGoto(TargetBlock.Position)
                            if TargetBlock ~= nil and TargetBlock:IsDescendantOf(workspace) then
                                task.spawn(function()
                                    HitBlock(TargetBlock, TargetBlock)
                                end)
                            end
                        end        
                    until TargetBlock == nil or (not TargetBlock:IsDescendantOf(workspace)) or not BreakSpecificBlocksToggle
                end   
            end;
            Default = false;})

        WorldEditTabRightSection2:CreateDropdown("SelectedDestroyBlockFlag", {
            Name = "  - Selected Block",
            Values = IslandBlockTypes,
            SelectType = "Single";
            Callback = function(value)
                BlockPrinterSettings.SelectedSpecificBlock = value
                local modified = {}
                table.insert(modified, value)
                DropdownNotification(modified)
            end})

            
    end)
    
    

    WorldEditTabRightSection2:CreateToggle("NukerToggleFlag", {
        Name = "Nuker";
        Callback = function(value)
            NukerToggle = value
            ToggleNotification(value, 'Nuker')
            while NukerToggle and task.wait(0.3) do
                local Distance, TargetBlock = math.huge, nil
                for i, v in ipairs(Blocks:GetChildren()) do
                    if v.Name ~= 'bedrock' and v.Parent ~= nil and v.Parent.Parent ~= nil and (not v:FindFirstChild("portal-to-spawn")) and v.Parent and v.Parent.Name == "Blocks" and NukerToggle then
                        local mag = (v.Position - Character.HumanoidRootPart.Position).Magnitude
                        if mag < Distance then
                            Distance = mag
                            TargetBlock = v
                        end
                    end
                end
                if TargetBlock then
                    if TargetBlock ~= nil and TargetBlock:IsDescendantOf(workspace) then
                        task.spawn(function()
                            HitBlock(TargetBlock, TargetBlock)
                        end)
                    end
                end
            end   
        end;
        Default = false;})
        WorldEditTabRightSection2:CreateToggle("ScaffoldToggleFlag", {
        Name = "Scaffold";
        Callback = function(value)
            ScaffoldToggle = value
            ToggleNotification(value, 'Scaffold')
            while ScaffoldToggle and task.wait() do
                if ScaffoldToggle then
                    if Character:FindFirstChildWhichIsA('Tool') then
                        local Tool = Character:FindFirstChildWhichIsA('Tool')
                        if not string.find(Tool.Name, 'Seed') then
                            if Character.Humanoid.MoveDirection ~= Vector3.new(0,0,0) then
                                local Amount = 7
                                PlaceBlock(Character.Head.Position - Vector3.new(0,Amount,0), Tool.Name)
                            end
                        end
                        
                    end
                end   
            end  
        end;
        Default = false;})


        -- left section 2

       

    WorldEditTabLeftSection2 = WorldEditTab:CreateLeftSection("Shape Generator") -- ShapeGeneratorSettings
    WorldEditInstructions3 = WorldEditTabLeftSection2:CreateLabel("<b>Instructions:</b> Hold the block you wish to generate the shape with, move the preview to your desired area. Then press Generate.",true)
    WorldEditTabLeftSection2:CreateDropdown("ShapeDropdownFlag", {
        Name = "Selected Shape",
        Values = {'Circle','Sphere'},
        SelectType = "Single";
        Callback = function(value)
            ShapeGeneratorSettings.SelectedShape = value
            Window:Notify('Selected: '..tostring(value)..'!')
        end})

    WorldEditTabLeftSection2:CreateSlider("ShapeRadiusFlag",{
        Name = "  - Radius",
        Min = 1;
        Max = 250;
        Default = ShapeGeneratorSettings.Radius;
        DecimalPlaces = 1;
        AllowValuesOutsideRange = true;
        Callback = function(value)
            ShapeGeneratorSettings.Radius = value
        end,})
        
        WorldEditTabLeftSection2:CreateToggle("ShapeHollowFlag", {
            Name = "  - Hollow";
            Callback = function(value)
                ShapeGeneratorSettings.Hollow = value
                ToggleNotification(value, 'Hollow')
            end;
            Default = false;})

    WorldEditTabLeftSection2:CreateToggle("ShapeShowPreviewFlag", {
        Name = "  - Show Preview";
        Callback = function(value)
            ShapeGeneratorSettings.ShowPreview = value
            ToggleNotification(value, 'Show Preview')
            local BlockType = lp.Character:FindFirstChildWhichIsA('Tool') and lp.Character:FindFirstChildWhichIsA('Tool').Name or 'dirt'
                if ShapeGeneratorSettings.ShowPreview then
                    for _, Block in ipairs(workspace:FindFirstChild('PreviewHolder'):GetChildren()) do
                        Block:Destroy()
                    end

                    radius = ShapeGeneratorSettings.Radius
    
                    local centerPosition = GetClosestBlockForSchematica().Position
                    local regionSize = Vector3.new(radius * 2, radius * 2, radius * 2)
                    local Region = Region3.new(centerPosition - regionSize / 2, centerPosition + regionSize / 2)


                    local PreviewBlock = workspace:FindFirstChild('PreviewBlock')
                    PreviewBlock.Transparency = 0.3
                    PreviewBlock.Size = Vector3.new(3,3,3)
                    PreviewBlock.Position = centerPosition
                   
                    PreviewBlock:FindFirstChild('SelectionBox').Visible = true
                    CoreGui:FindFirstChild('Handles1').Visible = true
    
    
                    if ShapeGeneratorSettings.SelectedShape == 'Circle' then
                        for x = Region.CFrame.p.x - radius, Region.CFrame.p.x + radius, 3 do
                            for z = Region.CFrame.p.z - radius, Region.CFrame.p.z + radius, 3 do
                                local currentPosition = Vector3.new(x, centerPosition.Y, z)
                                local distance = (currentPosition - centerPosition).Magnitude
                                if (ShapeGeneratorSettings.Hollow and distance >= radius - 3 and distance <= radius) or (not ShapeGeneratorSettings.Hollow and distance <= radius) then
                                    if ReplicatedStorage.Blocks:FindFirstChild(BlockType) then
                                        local ReplicatedBlock = ReplicatedStorage.Blocks:FindFirstChild(BlockType):Clone()
                                        ReplicatedBlock.Root.CanCollide = false
                                        ReplicatedBlock.Root.CFrame = CFrame.new(currentPosition)
                                        ReplicatedBlock.Root.Transparency = 0.5
                                        ReplicatedBlock.Parent = workspace:FindFirstChild('PreviewHolder')    
                                    end
                                end
                            end
                        end
                    elseif ShapeGeneratorSettings.SelectedShape == 'Sphere' then
                        for x = Region.CFrame.p.x - radius, Region.CFrame.p.x + radius, 3 do
                            for y = Region.CFrame.p.y - radius, Region.CFrame.p.y + radius, 3 do
                                for z = Region.CFrame.p.z - radius, Region.CFrame.p.z + radius, 3 do
                                    local currentPosition = Vector3.new(x, y, z)
                                    local distance = (currentPosition - centerPosition).Magnitude
                                    if (SphereHollowToggle and distance >= radius - 3 and distance <= radius) or (not SphereHollowToggle and distance <= radius) then
                                        local ReplicatedBlock = ReplicatedStorage.Blocks:FindFirstChild(BlockType):Clone()
                                        ReplicatedBlock.Root.CanCollide = false
                                        ReplicatedBlock.Root.CFrame = CFrame.new(currentPosition)
                                        ReplicatedBlock.Root.Transparency = 0.5
                                        ReplicatedBlock.Parent = workspace:FindFirstChild('PreviewHolder')  
                                    end
                                end
                            end
                        end
                    end
                else
                    workspace:FindFirstChild('PreviewHolder'):ClearAllChildren()
                    local PreviewBlock = workspace:FindFirstChild('PreviewBlock')
                    PreviewBlock.Transparency = 1
                    PreviewBlock.Size = Vector3.new(0.1,0.1,0.1)
                   
                    PreviewBlock:FindFirstChild('SelectionBox').Visible = false
                    CoreGui:FindFirstChild('Handles1').Visible = false
                end

            
            if not ShapeGeneratorSettings.ShowPreview then
                workspace:FindFirstChild('PreviewHolder'):ClearAllChildren()
                local PreviewBlock = workspace:FindFirstChild('PreviewBlock')
                PreviewBlock.Transparency = 1
                PreviewBlock.Size = Vector3.new(0.1,0.1,0.1)
               
                PreviewBlock:FindFirstChild('SelectionBox').Visible = false
                CoreGui:FindFirstChild('Handles1').Visible = false
            end 
        end;
        Default = false;})

        GenerateShapeButton = WorldEditTabLeftSection2:CreateButton("Generate", function()
            Window:Notify('Generating Shape...')
            for i,v in pairs(workspace:FindFirstChild('PreviewHolder'):GetChildren()) do
                if Abort == true then return end
                TGoto(v.Root.Position)
                PlaceBlock(v.Root.Position, v.Name)
            end
            Window:Notify('Generated Shape!')
        end)
        AportGeneratingButton = WorldEditTabLeftSection2:CreateButton("Abort", function()
            Window:Notify('Aborting..')
            Abort = true
            task.wait(2)
            Abort = false
            Window:Notify('Successfully Aborted Generation!')
        end)

else
    -- left section
    WorldEditTabFreeSec1 = WorldEditTab:CreateLeftSection("Buy Premium!")
    WorldEditTabFreeSec1label = WorldEditTabFreeSec1:CreateLabel("<b>You're missing out!</b> Buy Premium to get gain access to this page. This page includes amazing features such as: Block Printer, Block Destroyer, Schematica (Copy & Paste Builds), Nuker, Scaffold, Destroy Specific Blocks, & More!",true)
end


------------------
-- Teleport Tab --
------------------

-- left section
TeleportTabLeftSection = TeleportTab:CreateLeftSection("Teleports")
local SaveAndLoadPositionSubButtons = TeleportTabLeftSection:CreateSubButtons("Save Position","Load Position",function()
    if lp and Character and Character:FindFirstChild('HumanoidRootPart') then
        SaveAndLoadPositionSettings.SavedPosition = Character.HumanoidRootPart.Position
        Window:Notify('Successfully Saved Position!')
    end
end,function()
       -- Character.HumanoidRootPart.CFrame = SaveAndLoadPositionSettings.SavedPosition
        TGoto(SaveAndLoadPositionSettings.SavedPosition, true)
        Window:Notify('Successfully Loaded Position!')
end)
local HomeAndHubTeleportsSubButtons = TeleportTabLeftSection:CreateSubButtons("Home","Hub",function()
    RemotePathMain:WaitForChild("client_request_18"):InvokeServer()
    Window:Notify('Teleported To Home!')
end,function()
    RemotePathMain:WaitForChild("client_request_37"):InvokeServer()
    Window:Notify('Teleported To Hub!')
    --[[
    local hubPortal = nil
    if Blocks:FindFirstChild('portalToSpawn') then
        hubPortal = Blocks.portalToSpawn
    elseif Blocks:FindFirstChild('portalToSpawnVip') then
        hubPortal = Blocks.portalToSpawnVip
    elseif Blocks:FindFirstChild('portalToSpawnPro') then
        hubPortal = Blocks.portalToSpawnPro
    end
    Character.HumanoidRootPart.CFrame = CFrame.new(hubPortal.Position)
    ]]
end)

TeleportTabLeftSection:CreateDropdown("IslandTeleportFlag", {
    Name = "Teleport To Island",
    Values = IslandsList,
    SelectType = "Single";
    Callback = function(value)
        
        if value == 'Slime Island' then
            Character.HumanoidRootPart.CFrame = CFrame.new(151,33,-737)
        elseif value == 'Spirit Island' then
            Character.HumanoidRootPart.CFrame = CFrame.new(1709.62317, 448.131409, -204.412949, 0.789979517)
        elseif value == 'Buffalkor Island' then
            Character.HumanoidRootPart.CFrame = CFrame.new(885.671,173.853,24.1171)
        elseif value == 'Wizard Island' then
            Character.HumanoidRootPart.CFrame = CFrame.new(1709.62317, 448.131409, -204.412949)
        elseif value == 'Desert Island' then
            Character.HumanoidRootPart.CFrame = CFrame.new(1475.5, 337.77, -875.76)
        elseif value == 'Void Isles' then
            Character.HumanoidRootPart.CFrame = CFrame.new(-10169.7666015625,109.2248306274414,10282.6201171875)
        elseif value == 'Pirate Island' then
            local args = {[1] = false}
            RemotePathMain.TravelPirateIsland:FireServer(unpack(args))
        elseif value == 'Maple Island' then
            local args = {[1] = false}
            RemotePathMain.TravelMapleIsland:FireServer(unpack(args))
        elseif value == 'Underworld' then
            TeleportService:Teleport(7456800858, lp)
        elseif value == 'Diamond Mines' then
            Character.HumanoidRootPart.CFrame = CFrame.new()
            TGoto(Vector3.new(1578.18,207.697,106.508))
        end
        Window:Notify('Teleported To: '..tostring(value)..'!')
    end})


    --[[

    local MerchantList = {}
    local MerchantPositionList = {}
    if spawnPrefabs and spawnPrefabs:FindFirstChild('merchants') then
        for i,v in ipairs(spawnPrefabs.merchants:GetChildren()) do
            if not table.find(MerchantList, v.Name) then
                table.insert(MerchantList, v.Name)
                MerchantPositionList[v.Name] = v:GetPivot()
            end 
        end
    end


    
TeleportTabLeftSection:CreateDropdown("MerchantTeleportFlag", {
    Name = "Teleport To Merchant",
    Values = MerchantList,
    SelectType = "Single";
    Callback = function(value)
        TGoto(MerchantPositionList[value])       
    end})
    ]]
    
-- right section
TeleportTabRightSection = TeleportTab:CreateRightSection("Quick Teleports")



local SlimeTeleportButton = TeleportTabRightSection:CreateButton("Slime Island", function()
    Character.HumanoidRootPart.CFrame = CFrame.new(PortalLocations['slime'])
    Window:Notify('Teleported To: Slime Island!')
end)
local SpiritTeleportButton = TeleportTabRightSection:CreateButton("Spirit Island", function()
    Character.HumanoidRootPart.CFrame = CFrame.new(PortalLocations['spirit'])
    Window:Notify('Teleported To: Spirit Island!')
end)
local BuffalkorTeleportButton = TeleportTabRightSection:CreateButton("Buffalkor Island", function()
    Character.HumanoidRootPart.CFrame = CFrame.new(PortalLocations['buffalkor'])
    Window:Notify('Teleported To: Buffalkor Island!')
end)
local WizardTeleportButton = TeleportTabRightSection:CreateButton("Wizard Island", function()
    Character.HumanoidRootPart.CFrame = CFrame.new(PortalLocations['wizard'])
    Window:Notify('Teleported To: Wizard Island!')
end)
local DesertTeleportButton = TeleportTabRightSection:CreateButton("Desert Island", function()
    Character.HumanoidRootPart.CFrame = CFrame.new(PortalLocations['desert'])
    Window:Notify('Teleported To: Desert Island!')
end)
local VoidTeleportButton = TeleportTabRightSection:CreateButton("Void Island", function()
    Character.HumanoidRootPart.CFrame = CFrame.new(-10169.7666015625,109.2248306274414,10282.6201171875)
    Window:Notify('Teleported To: Void Island!')
end)
local PirateTeleportButton = TeleportTabRightSection:CreateButton("Pirate Island", function()
    local args = {[1] = false}
    RemotePathMain.TravelPirateIsland:FireServer(unpack(args))
    Window:Notify('Teleported To: Pirate Island!')
end)
local MapleTeleportButton = TeleportTabRightSection:CreateButton("Maple Island", function()
    local args = {[1] = false}
    RemotePathMain.TravelMapleIsland:FireServer(unpack(args))
    Window:Notify('Teleported To: Maple Island!')
end)
local UnderworldTeleportButton = TeleportTabRightSection:CreateButton("Underworld Island", function()
    TeleportService:Teleport(7456800858, lp)
end)
local DiamondMinesTeleportButton = TeleportTabRightSection:CreateButton("Diamond Mines", function()
    Character.HumanoidRootPart.CFrame = CFrame.new(PortalLocations['DiamondMines'])
    Window:Notify('Teleported To: Diamond Mines!')
end)



------------------
-- Stats Tab --
------------------

if Whitelisted then
    -- left section
    StatsTabLeftSection = StatsTab:CreateLeftSection("Session Stats")
    SessionStatsText = StatsTabLeftSection:CreateLabel("Collected Items:",true)
    itemsCount = {}
    for _, item in ipairs(lp.Backpack:GetChildren()) do
        if item:IsA("Tool") and item:FindFirstChild("Amount") then
            local itemCountValue = item.Amount
            if itemCountValue and itemCountValue:IsA("IntValue") then
                local itemName = item.Name
                local itemCount = itemCountValue.Value
                itemsCount[itemName] = itemCount
            end
        end
    end

    lp.Backpack.ChildAdded:Connect(function(item)
        itemsCount[item.Name] = item:WaitForChild('Amount').Value
    end)

    task.spawn(function()
        while task.wait(5) do
            NewString = ''
            for _, item in ipairs(lp.Backpack:GetChildren()) do
                if item:IsA("Tool") and item:FindFirstChild("Amount") then
                    if item.Amount and item.Amount:IsA("IntValue") and item.Amount.Value > itemsCount[item.Name] then
                        NewString = NewString .. item.Name .. ': ' .. tostring(item.Amount.Value - itemsCount[item.Name]) .. '\n'
                    end
                end
            end
            SessionStatsText:Update('Collected Items:\n' .. NewString)
        end
    end)



    -- right section
    StatsTabRightSection = StatsTab:CreateRightSection("Player Stats")


    PlayerName = StatsTabRightSection:CreateLabel("@nil's Stats",true)
    PlayerStats = StatsTabRightSection:CreateLabel("<b>Coins:</b> nil \n<b>AP:</b> nil \n<b>Country Code:</b> nil \n<b>Device Type:</b> nil \n<b>Hardcode Mode:</b> nil \n<b>Join Code:</b> nil \n",true)

    StatsTabRightSection:CreateTextbox("PlayersStatsFlag",{
        Name = "Player Name";
        DefaultText = lp.DisplayName;
        PlaceholderText = lp.DisplayName;
        Callback = function(inputtedText) 
            for i,v in pairs(Players:GetChildren()) do
                if string.find(string.lower(v.Name), string.lower(inputtedText)) or string.find(string.lower(v.DisplayName), string.lower(inputtedText)) then
                    PlayerName:Update("<b>@"..v.DisplayName.."'s Stats.<b>")
                    PlayerStats:Update('<b>Coins:</b> Unable to grab value.'..'\n<b>AP:</b> '..tostring(v.leaderstats.AP.Value) .. '\n<b>Country Code:</b> '..v.CountryCode.Value .. '\n<b>DeviceType:</b> '..v.DeviceType.Value .. '\n<b>Hardcore Mode:</b> '..tostring(v.HardcoreMode.Value) .. '\n<b>Join Code:</b> '..v.JoinCode.Value)
                    break
                end
            end
        end})

    --[[ right section 2
    StatsTabRightSection2 = StatsTab:CreateRightSection("Saved Join Codes")

    local joinCodeStr = ''
    for player,code in pairs(SavedJoinCodes) do
        joinCodeStr = joinCodeStr .. '\n' .. player .. ': <b>' .. code .. '</b>'
    end

    CurrentJoinCodes = StatsTabRightSection2:CreateLabel("<b>Saved Join Codes:</b>" .. joinCodeStr ,true)
    
    local SaveJoinCodeButton = StatsTabRightSection2:CreateButton("Save Join Code", function()
        SaveJoinCode()

        joinCodeStr = ''
        for player,code in pairs(SavedJoinCodes) do
            joinCodeStr = joinCodeStr .. '\n' .. player .. ': <b>' .. code .. '</b>'
        end

        local json = HttpService:JSONEncode(SavedJoinCodes)
        writefile("Project_Z/Islands/Builds/"..filename, json)

        CurrentJoinCodes:Update("<b>Saved Join Codes:</b>" .. joinCodeStr)
        Window:Notify('Saved Join Code!')
    end)
    ]]
else
    local StatsTabFreeSec1 = StatsTab:CreateLeftSection("Buy Premium!")
    local buyprem3 = StatsTabFreeSec1:CreateLabel("<b>You're missing out!</b> Buy Premium to get gain access to this feature. This feature includes: Teleport Walk! (Very fast movement without getting detected by anti-cheat)",true)
end

    ------------------
    -- Settings Tab --
    ------------------
-- left section
SettingsTabLeftSection = SettingsTab:CreateLeftSection("Script Settings")
local AbortAllTweensButton = SettingsTabLeftSection:CreateButton("Abort All Tweens", function()
    CancelTweens()
    tpabort = true
    Window:Notify('Aborted All Tweens!')
end)
SettingsTabLeftSection:CreateDropdown("SelectedTeleportTypeFlag", {
    Name = "Teleport Type",
    Values = TeleportTypes,
    SelectType = "Single";
    Callback = function(value)
        GeneralSettings.TeleportType = value
        local modified = {}
        table.insert(modified, value)
        DropdownNotification(modified)
    end})
    GeneralSettings.TeleportType = 'Tween'
SettingsTabLeftSection:CreateSlider("TweenSpeedSliderFlag",{
    Name = "Tween Speed",
    Min = 1;
    Max = 11; -- 11
    Default = GeneralSettings.tweenSpeed;
    DecimalPlaces = 1;
    AllowValuesOutsideRange = false;
    Callback = function(value)
        GeneralSettings.tweenSpeed = value
    end,})
    if Whitelisted then
        local hb = RunService.Heartbeat
        SettingsTabLeftSection:CreateToggle("TeleportWalkToggleFlag", {
            Name = "Teleport Walk";
            Callback = function(value)
                TeleportWalkToggle = value
                ToggleNotification(value, 'Teleport Walk')
                task.spawn(function()
                    local chr = Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while TeleportWalkToggle and chr and hum and hum.Parent do
                        local delta = hb:Wait()
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection * 2 * delta * 10)
                        end
                    end
                end)    
            end;
            Default = TeleportWalkToggle;})
    else
        -- left section
        
        buyprem8 = SettingsTabLeftSection:CreateLabel("<b>You're missing out!</b> Buy Premium to get gain access to this feature. This feature includes: Teleport Walk! (Very fast movement without getting detected by anti-cheat)",true)
    end

    local AuraFloatName = 'bfbewz$343FfGyfgee'

local RadiusController
local Amount = Character.HumanoidRootPart.Size.Y + Character.Head.Size.Y + 0.5
SettingsTabLeftSection:CreateToggle("ShowAuraRadiusToggleFlag", {
    Name = "Show Aura Radius";
    Callback = function(value)
        ShowAuraRadiusToggle = value
        ToggleNotification(value, 'Show Aura Radius')
        if ShowAuraRadiusToggle then
            Radius = Instance.new('Part')
            Radius.Shape = 'Cylinder'
            Radius.Name = AuraFloatName
            Radius.Transparency = 0.6
            Radius.BrickColor = BrickColor.new(Color3.fromRGB(0,255,0))
            Radius.Size = Vector3.new(0.1, 60, 60)
            Radius.CanCollide = false
            Radius.Anchored = false
            Radius.Orientation = Vector3.new(0,0,90)
            Radius.Parent = Character
            Radius.Material = 'SmoothPlastic'
            task.spawn(function()
                RadiusController = RunService.RenderStepped:Connect(function()
                    Radius.Position = Character.Head.Position - Vector3.new(0,Amount,0)
                end)
            end)
        else
            RadiusController:Disconnect()
            Radius:Destroy()
        end
    end;
    Default = false;})
    --[[
local ColorLabel2 = SettingsTabLeftSection:CreateLabel("  - Aura Radius Color")
ColorLabel2:CreateColorPicker("AuraRadiusColorFlag", Color3.fromRGB(0,255,0), function(new)
    if Radius then
        Radius.BrickColor = BrickColor.new(new)
    end
end)
]]
-- right section
SettingsTabRightSection = SettingsTab:CreateRightSection("Performance Settings")
SettingsTabRightSection:CreateToggle("DisableXPLagGlag", {
    Name = "Disable XP [Reduces Lag]";
    Callback = function(value)
        ToggleNotification(value, 'Disable XP')
        lp.PlayerScripts.TS.modules.experience["experience-listener"].Disabled = true
    end;
    Default = false;})
SettingsTabRightSection:CreateToggle("DisableRenderingFlag", {
    Name = "Disable Rendering";
    Callback = function(value)
        ToggleNotification(value, 'Disable Rendering')
        RunService:Set3dRenderingEnabled(not value)
    end;
    Default = false;})
local RemoveTexturesButton = SettingsTabRightSection:CreateButton("Remove Textures", function()
    RemoveTextures()
    Window:Notify('Remove Textures Is Now Activated!')
end)

antiafknote = SettingsTabRightSection:CreateLabel("<b>Anti-Afk Auto Loads!</b>",true)

-- right section 2
SettingsTabRightSection2 = SettingsTab:CreateRightSection("UI Settings")
SettingsTabRightSection2:CreateToggle("ShowScriptNotificationsToggleFlag", {
    Name = "Show Script Notifications";
    Callback = function(value)
        ToggleNotification(value, 'Show Script Notifications')
        ShowScriptNotificationsToggle = value
    end;
    Default = ShowScriptNotificationsToggle;})
-- left section 2
SettingsTabLeftSection2 = SettingsTab:CreateLeftSection("Keybinds")

--[[
UIKeyBindPickerLabel = SettingsTabLeftSection2:CreateLabel("Toggle UI")


Window:SetBind(KeyBindsFolder.ToggleUIKeyBind)
UIKeybindPicker = UIKeyBindPickerLabel:CreateKeyPicker("ToggleUIKeyBindPickerFlag",KeyBindsFolder.ToggleUIKeyBind,"Custom","Toggle UI",function(state)
    Window:SetBind(state)
   -- Window:Notify('Success!','Set Toggle UI Bind To: '..tostring(state.Name)..'.')
end)

FlyKeyPickerLabel = SettingsTabLeftSection2:CreateLabel("Fly Keybind")

FlyKeyPicker = FlyKeyPickerLabel:CreateKeyPicker("FlyKeyPickerFlag",KeyBindsFolder.FlyKeybind,"Custom","Fly",function(state)
    FlyBind = state
   -- Window:Notify('Success!','Set Fly Bind To: '..tostring(state.Name)..'.')
end)

NoclipKeyPickerLabel = SettingsTabLeftSection2:CreateLabel("Noclip Keybind")

NoclipKeyPicker = NoclipKeyPickerLabel:CreateKeyPicker("NoclipKeyPickerFlag",KeyBindsFolder.NoclipKeybind,"Custom","Noclip",function(state)
    NoclipBind = state
   -- Window:Notify('Success!','Set Noclip Bind To: '..tostring(state.Name)..'.')
end)
]]



----------------------------------
-- Make Sure This Stuff Is Last --
----------------------------------

-- Grab attemptHitKey
task.spawn(function()
    local oldNamecall
    oldNamecall = hookmetamethod(game, '__namecall', function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if attemptHitKey then
            return oldNamecall(self, ...)
        end

        if method == 'FireServer' and self.Name == MeleeRemote then
            local targetTable = args[2][1]
            attemptHitKey = targetTable[attemptHitName]
        end

        return oldNamecall(self, ...)
    end)
end)

-- destroy seats
task.spawn(function()
    LPH_NO_VIRTUALIZE(function() -- removes obfuscation to make this section MUCH faster
        for i,v in pairs(game:GetDescendants()) do
            if v:IsA('Seat') or v:IsA('SeatPart') then
                v:Destroy()
            end
        end
    end)()
end)

-- Inputs
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == FlyBind then   
        if not FLYING then
            sFLY()
        else
            NOFLY()
        end
        ToggleNotification(FLYING, 'Fly') 
    end

    if input.KeyCode == NoclipBind then   
        IsNoclipping = not IsNoclipping
        ToggleNotification(IsNoclipping, 'Noclip')
        Clip = false
        task.wait(0.1)
        if IsNoclipping == true then
            Noclipping = RunService.Stepped:Connect(NoclipLoop)
        else
            Noclipping:Disconnect()
        end 
    end
end)



 -- Anti-Afk
  --  task.spawn(function()
        local GC = getconnections or get_signal_cons
        if GC then
            for i,v in pairs(GC(lp.Idled)) do v.Disable(v) end
        else
            lp.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
   -- end)

-- FOV Loop
task.spawn(function()
    while task.wait(0.01) do
        if SelectedFieldOfViewAmount ~= 70 then
            workspace.CurrentCamera.FieldOfView = SelectedFieldOfViewAmount
        end
    end
end)

task.spawn(function()
    local olderror
    olderror = hookfunction(error, function(txt, ...)
        for i,v in pairs(ErrorIgnoreList) do
            if not string.find(string.lower(txt), string.lower(v)) then
                LogError(txt)
                return olderror(txt, ...)
            end
        end
        return olderror(txt, ...)
    end)
end)




--FinishedLoading = true
--ScreenGui:Destroy()

Window:Notify("Script injected into " ..GetOwner(Island) .. "'s Island!")
Window:Notify('Script Successfully Loaded!')
