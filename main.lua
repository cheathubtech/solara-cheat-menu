-- W-Hub - Main Script
-- Created for Roblox
-- Version: 1.0

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/main/library.txt'))()

local Window = Rayfield:CreateWindow({
    Name = "W-Hub",
    LoadingTitle = "W-Hub",
    LoadingSubtitle = "Loading...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "W-Hub",
        FileName = "W-Hub_Config"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "W-Hub",
        Subtitle = "Key System",
        Note = "Enter your key below",
        FileName = "W-Hub_Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = "W-Hub-Key-2024"
    }
})

-- Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)

-- Welcome Section
local WelcomeSection = MainTab:CreateSection("Welcome to W-Hub")

local WelcomeLabel = MainTab:CreateLabel("Welcome to W-Hub! Your ultimate Roblox utility hub.")
local VersionLabel = MainTab:CreateLabel("Version: 1.0")

-- Player Info Section
local PlayerSection = MainTab:CreateSection("Player Information")

local PlayerName = game.Players.LocalPlayer.Name
local PlayerLabel = MainTab:CreateLabel("Player: " .. PlayerName)

local PlayerId = game.Players.LocalPlayer.UserId
local PlayerIdLabel = MainTab:CreateLabel("User ID: " .. PlayerId)

-- Game Info Section
local GameSection = MainTab:CreateSection("Game Information")

local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local GameLabel = MainTab:CreateLabel("Game: " .. GameName)

local PlaceId = game.PlaceId
local PlaceIdLabel = MainTab:CreateLabel("Place ID: " .. PlaceId)

-- Utility Tab
local UtilityTab = Window:CreateTab("Utility", 4483362458)

-- Teleport Section
local TeleportSection = UtilityTab:CreateSection("Teleportation")

local TeleportButton = UtilityTab:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
            Rayfield:Notify("Teleported to spawn!", "Success", 4483362458)
        end
    end,
})

-- Speed Section
local SpeedSection = UtilityTab:CreateSection("Movement")

local SpeedSlider = UtilityTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = Value
        end
    end,
})

local JumpSlider = UtilityTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200},
    Increment = 1,
    CurrentValue = 50,
    Flag = "JumpSlider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = Value
        end
    end,
})

-- Visual Tab
local VisualTab = Window:CreateTab("Visual", 4483362458)

-- ESP Section
local ESPSection = VisualTab:CreateSection("ESP")

local ESPToggle = VisualTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(Value)
        if Value then
            Rayfield:Notify("ESP Enabled!", "Success", 4483362458)
            -- ESP functionality would go here
        else
            Rayfield:Notify("ESP Disabled!", "Info", 4483362458)
            -- ESP cleanup would go here
        end
    end,
})

-- Settings Tab
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- Theme Section
local ThemeSection = SettingsTab:CreateSection("Theme Settings")

local ThemeDropdown = SettingsTab:CreateDropdown({
    Name = "Theme",
    Options = {"Dark", "Light", "Rose", "Plant", "Red", "Indigo", "Sky", "Violet", "Amber", "Emerald", "Midnight", "Crimson", "MonokaiPro", "CottonCandy", "Rainbow"},
    CurrentOption = "Dark",
    Flag = "ThemeDropdown",
    Callback = function(Option)
        Rayfield:SetTheme(Option)
        Rayfield:Notify("Theme changed to " .. Option, "Success", 4483362458)
    end,
})

-- Notification Section
local NotificationSection = SettingsTab:CreateSection("Notifications")

local TestNotificationButton = SettingsTab:CreateButton({
    Name = "Test Notification",
    Callback = function()
        Rayfield:Notify("This is a test notification!", "Info", 4483362458)
    end,
})

-- Credits Section
local CreditsSection = SettingsTab:CreateSection("Credits")

local CreditsLabel = SettingsTab:CreateLabel("W-Hub v1.0")
local AuthorLabel = SettingsTab:CreateLabel("Created by: W-Hub Team")
local LibraryLabel = SettingsTab:CreateLabel("UI Library: WindUI by Footagesus")

-- Auto-save settings
Rayfield:SetTheme("Dark")

-- Welcome notification
Rayfield:Notify("W-Hub loaded successfully!", "Success", 4483362458)

print("W-Hub loaded successfully!")
