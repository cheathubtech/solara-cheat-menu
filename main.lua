-- W-Hub Main Script (Refactored)
-- This is the main entry point that loads and initializes all components

-- Load WindUI library
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/cheathubtech/solara-cheat-menu/main/library.lua"))()
end)

if not success then
    error("Failed to load WindUI library: " .. tostring(WindUI))
end

-- Load our modules
local Utils = require(script.Parent.utils)
local Functions = require(script.Parent.functions)

-- Initialize WindUI settings
WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

-- Create localization
local Localization = Utils.createLocalization(WindUI)

-- Create gradient function
local gradient = Utils.gradient

-- Create welcome popup
Utils.createWelcomePopup(WindUI, gradient)

-- Create main window
local Window = Utils.createWindow(WindUI, gradient)

-- Set user settings
Window.User:SetAnonymous(true)

-- Create theme switcher
Utils.createThemeSwitcher(Window, WindUI)

-- Create sections and tabs
local Sections = Utils.createSections(Window)
local Tabs = Utils.createTabs(Sections)

-- Create main sections
local MainSections = Utils.createMainSections(Tabs)
local MainSection = MainSections.MainSection
local AutomationSection = MainSections.AutomationSection
local VisualsSection = MainSections.VisualsSection
local MiscSection = MainSections.MiscSection

-- Create UI elements
local ElementsSection = Utils.createUIElements(Tabs)

-- Create config sections
local ConfigSection, AppearanceSection = Utils.createConfigSections(Tabs)

-- Anti AFK Toggle
MiscSection:Toggle({
    Title = "Anti AFK",
    Desc = "Prevents you from being kicked for inactivity",
    Value = false,
    Flag = "anti_afk",
    Callback = function(state)
        Functions.setAntiAFK(state)
        if state then
            Utils.showNotification(WindUI, "Anti AFK", "Anti AFK enabled!", "shield-check")
        else
            Utils.showNotification(WindUI, "Anti AFK", "Anti AFK disabled!", "shield-x")
        end
    end,
})

-- Speed Hack Toggle
MainSection:Toggle({
    Title = "Speed Hack",
    Desc = "Enable/Disable speed modification",
    Value = false,
    Flag = "speed_enabled",
    Callback = function(state)
        Functions.setSpeed(state)
        if state then
            Utils.showNotification(WindUI, "Speed Hack", "Speed hack enabled!", "zap")
        else
            Utils.showNotification(WindUI, "Speed Hack", "Speed hack disabled!", "zap")
        end
    end,
})

-- Speed Slider
local speedSlider = MainSection:Slider({
    Title = "Speed Value",
    Desc = "Adjust your walking speed (16-500)",
    Value = { Min = 16, Max = 500, Default = 50 },
    Flag = "speed_value",
    Callback = function(value)
        Functions.updateSpeed(value)
    end,
})

-- Reset Speed Button
MainSection:Button({
    Title = "Reset Speed",
    Icon = "refresh-cw",
    Callback = function()
        Functions.resetSpeed()
        speedSlider:Set(16) -- Reset slider to default value
        Utils.showNotification(WindUI, "Speed Reset", "Speed reset to default!", "refresh-cw")
    end,
})

-- Infinite Jump Toggle
MainSection:Toggle({
    Title = "Infinite Jump",
    Desc = "Enable/Disable infinite jumping",
    Value = false,
    Flag = "infinite_jump",
    Callback = function(state)
        Functions.setInfiniteJump(state)
        if state then
            Utils.showNotification(WindUI, "Infinite Jump", "Infinite jump enabled!", "arrow-up")
        else
            Utils.showNotification(WindUI, "Infinite Jump", "Infinite jump disabled!", "arrow-up")
        end
    end,
})

-- NoClip Toggle
MainSection:Toggle({
    Title = "NoClip",
    Desc = "Enable/Disable noclip (walk through walls)",
    Value = false,
    Flag = "noclip",
    Callback = function(state)
        Functions.setNoClip(state)
        if state then
            Utils.showNotification(WindUI, "NoClip", "NoClip enabled!", "shield")
        else
            Utils.showNotification(WindUI, "NoClip", "NoClip disabled!", "shield")
        end
    end,
})

-- Fly Toggle
MainSection:Toggle({
    Title = "Fly",
    Desc = "Enable/Disable flying",
    Value = false,
    Flag = "fly_enabled",
    Callback = function(state)
        Functions.setFly(state)
        if state then
            Utils.showNotification(WindUI, "Fly", "Fly enabled!", "zap")
        else
            Utils.showNotification(WindUI, "Fly", "Fly disabled!", "zap")
        end
    end,
})

-- Fly Speed Control
MainSection:Slider({
    Title = "Fly Speed",
    Desc = "Adjust fly speed (1-10)",
    Value = { Min = 1, Max = 10, Default = 1 },
    Flag = "fly_speed",
    Callback = function(value)
        Functions.setFlySpeed(value)
    end,
})

-- Teleport to Player
MainSection:Dropdown({
    Title = "Teleport to Player",
    Desc = "Select player to teleport to them",
    Values = Functions.getPlayerList(),
    Value = "",
    Flag = "teleport_player",
    Callback = function(value)
        if Functions.teleportToPlayer(value) then
            Utils.showNotification(WindUI, "Teleport", "Teleported to " .. value .. "!", "user")
        else
            Utils.showNotification(WindUI, "Error", "Player not found!", "alert-circle")
        end
    end,
})

-- Configuration Section
ConfigSection:Button({
    Title = "Save Configuration",
    Icon = "save",
    Callback = function()
        Utils.showNotification(WindUI, "Configuration", "Configuration saved!", "save")
    end,
})

ConfigSection:Button({
    Title = "Load Configuration",
    Icon = "upload",
    Callback = function()
        Utils.showNotification(WindUI, "Configuration", "Configuration loaded!", "upload")
    end,
})

-- Appearance Section
AppearanceSection:Slider({
    Title = "Window Transparency",
    Desc = "Adjust window transparency (0-1)",
    Value = { Min = 0, Max = 1, Default = 0.2 },
    Flag = "window_transparency",
    Callback = function(value)
        WindUI.TransparencyValue = value
    end,
})

AppearanceSection:Dropdown({
    Title = "Select Theme",
    Desc = "Choose your preferred theme",
    Values = {"Dark", "Light"},
    Value = "Dark",
    Flag = "theme_selection",
    Callback = function(value)
        WindUI:SetTheme(value)
        Utils.showNotification(WindUI, "Theme Changed", "Theme changed to " .. value, "moon")
    end,
})

print("W-Hub loaded successfully!")
print("All modules loaded and initialized.")
