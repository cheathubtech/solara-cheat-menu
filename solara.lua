-- SOLARA CHEAT MENU
-- Rayfield Interface Suite Implementation
-- GitHub Ready Script

--[[
Rayfield Interface Suite
by Sirius
shlex | Designing + Programming
iRay  | Programming
]]

local Release = "Beta 5"
local NotificationDuration = 6.5
local ConfigurationFolder = "SOLARA Interface Suite"
local ConfigurationExtension = ".rfld"

local RayfieldLibrary = {}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Rayfield = game:GetObjects("rbxassetid://10804731440")[1]

if gethui then
	Rayfield.Parent = gethui()
elseif syn.protect_gui then
	syn.protect_gui(Rayfield)
	Rayfield.Parent = CoreGui
elseif CoreGui:FindFirstChild("RobloxGui") then
	Rayfield.Parent = CoreGui:FindFirstChild("RobloxGui")
else
	Rayfield.Parent = CoreGui
end

if gethui then
	for _, Interface in ipairs(gethui():GetChildren()) do
		if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
			Interface.Enabled = false
			Interface.Name = "Rayfield-Old"
		end
	end
else
	for _, Interface in ipairs(CoreGui:GetChildren()) do
		if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
			Interface.Enabled = false
			Interface.Name = "Rayfield-Old"
		end
	end
end

local Camera = workspace.CurrentCamera
local Main = Rayfield.Main
local Topbar = Main.Topbar
local Elements = Main.Elements
local LoadingFrame = Main.LoadingFrame
local TabList = Main.TabList

Rayfield.DisplayOrder = 100
LoadingFrame.Version.Text = Release

local CFileName = nil
local CEnabled = false
local Minimised = false
local Hidden = false
local Debounce = false
local Flags = {}
local NotificationStack = {}
local Notifications = Rayfield.Notifications

-- Переменные для читов
local player = Players.LocalPlayer
local character = nil
local humanoid = nil
local rootPart = nil
local currentSpeed = 50
local flyEnabled = false
local noclipEnabled = false
local infiniteJumpEnabled = false
local autoCollectEnabled = false
local flySpeed = 50

-- Функции для читов
local function setSpeed(speed)
    if type(speed) ~= "number" then
        speed = 50
    end
    
    if speed < 20 then
        speed = 20
    elseif speed > 200 then
        speed = 200
    end
    
    currentSpeed = speed
    
    if humanoid and humanoid:IsA("Humanoid") then
        humanoid.WalkSpeed = speed
    end
end

local function toggleFly()
    flyEnabled = not flyEnabled
    if flyEnabled then
        if humanoid then
            humanoid.PlatformStand = true
        end
        if rootPart then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = rootPart
        end
    else
        if humanoid then
            humanoid.PlatformStand = false
        end
        if rootPart then
            local bodyVelocity = rootPart:FindFirstChild("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
        end
    end
end

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    if character then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = not noclipEnabled
            end
        end
    end
end

local function toggleInfiniteJump()
    infiniteJumpEnabled = not infiniteJumpEnabled
end

local function toggleAutoCollect()
    autoCollectEnabled = not autoCollectEnabled
end

local function collectMoney()
    if not autoCollectEnabled or not rootPart then return end
    
    local moneyParts = workspace:GetChildren()
    for _, part in pairs(moneyParts) do
        if part.Name:lower():find("money") or part.Name:lower():find("coin") or part.Name:lower():find("cash") then
            if part:IsA("BasePart") then
                local distance = (part.Position - rootPart.Position).Magnitude
                if distance < 50 then
                    part.CFrame = rootPart.CFrame
                end
            end
        end
    end
end

local function updateFly()
    if not flyEnabled or not rootPart then return end
    
    local camera = Workspace.CurrentCamera
    local moveVector = Vector3.new(0, 0, 0)
    
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        moveVector = moveVector + camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        moveVector = moveVector - camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        moveVector = moveVector - camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        moveVector = moveVector + camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        moveVector = moveVector + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        moveVector = moveVector - Vector3.new(0, 1, 0)
    end
    
    local bodyVelocity = rootPart:FindFirstChild("BodyVelocity")
    if bodyVelocity then
        bodyVelocity.Velocity = moveVector * flySpeed
    end
end

local function infiniteJump()
    if not infiniteJumpEnabled or not humanoid then return end
    
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        humanoid.Jump = true
    end
end

local function initializeCharacter()
    if player.Character then
        character = player.Character
        humanoid = character:FindFirstChild("Humanoid")
        rootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoid then
            setSpeed(currentSpeed)
        end
    end
end

-- Rayfield библиотека загружается отдельно

-- Создаем окно
local Window = Rayfield:CreateWindow({
    Name = "SOLARA CHEAT MENU",
    LoadingTitle = "SOLARA Interface Suite",
    LoadingSubtitle = "by Your Name",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "SOLARA Interface Suite",
        FileName = "SOLARA_Hub"
    },
    KeySystem = false,
})

-- Уведомление
Rayfield:Notify("SOLARA LOADED", "Cheat menu loaded successfully!", 4483362458)

-- Вкладка Движение
local MovementTab = Window:CreateTab("Movement", 4483362458)

local MovementSection = MovementTab:CreateSection("Speed Control")

local SpeedSlider = MovementTab:CreateSlider({
    Name = "Walk Speed",
    Range = {20, 200},
    Increment = 5,
    Suffix = "studs/s",
    CurrentValue = 50,
    Flag = "SpeedSlider",
    Callback = function(Value)
        setSpeed(Value)
    end,
})

local QuickSpeedSection = MovementTab:CreateSection("Quick Speed")

local WalkButton = MovementTab:CreateButton({
    Name = "Walk Speed (16)",
    Callback = function()
        setSpeed(16)
        SpeedSlider:Set(16)
    end,
})

local RunButton = MovementTab:CreateButton({
    Name = "Run Speed (50)",
    Callback = function()
        setSpeed(50)
        SpeedSlider:Set(50)
    end,
})

local FastButton = MovementTab:CreateButton({
    Name = "Fast Speed (100)",
    Callback = function()
        setSpeed(100)
        SpeedSlider:Set(100)
    end,
})

local SuperButton = MovementTab:CreateButton({
    Name = "Super Speed (200)",
    Callback = function()
        setSpeed(200)
        SpeedSlider:Set(200)
    end,
})

-- Вкладка Читы
local CheatsTab = Window:CreateTab("Cheats", 4483362458)

local CheatsSection = CheatsTab:CreateSection("Cheat Functions")

local FlyToggle = CheatsTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        toggleFly()
    end,
})

local NoclipToggle = CheatsTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(Value)
        toggleNoclip()
    end,
})

local JumpToggle = CheatsTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "JumpToggle",
    Callback = function(Value)
        toggleInfiniteJump()
    end,
})

local CollectToggle = CheatsTab:CreateToggle({
    Name = "Auto Collect Money",
    CurrentValue = false,
    Flag = "CollectToggle",
    Callback = function(Value)
        toggleAutoCollect()
    end,
})

-- Вкладка Настройки
local SettingsTab = Window:CreateTab("Settings", 4483362458)

local SettingsSection = SettingsTab:CreateSection("Information")

local InfoLabel = SettingsTab:CreateLabel("SOLARA CHEAT MENU")
local InfoParagraph = SettingsTab:CreateParagraph({
    Title = "Controls",
    Content = "WASD - Fly Movement\nSpace - Jump/Up\nShift - Down\nRightShift - Toggle Menu"
})

local DestroyButton = SettingsTab:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        Rayfield:Destroy()
    end,
})

-- Обработчик персонажа
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    if humanoid and humanoid:IsA("Humanoid") then
        setSpeed(currentSpeed)
    end
end)

-- Циклы для читов
RunService.Heartbeat:Connect(function()
    updateFly()
    infiniteJump()
    collectMoney()
end)

-- Инициализация
initializeCharacter()

print("🔥 SOLARA CHEAT MENU LOADED! Press RightShift to toggle menu!")
