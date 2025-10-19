-- W-Hub Main Script (Refactored)
-- This is the main entry point that loads and initializes all components

-- Load WindUI library
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/cheathubtech/solara-cheat-menu/main/library.lua"))()
end)

if not success then
    error("Failed to load WindUI library: " .. tostring(WindUI))
end

-- ============================================================================
-- UTILS MODULE (Embedded)
-- ============================================================================
local Utils = {}

-- Gradient text function
function Utils.gradient(text, startColor, endColor)
    local result = ""
    for i = 1, #text do
        local t = (i - 1) / (#text - 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
    end
    return result
end

-- Notification helper
function Utils.showNotification(WindUI, title, content, icon, duration)
    WindUI:Notify({
        Title = title,
        Content = content,
        Icon = icon or "info",
        Duration = duration or 3
    })
end

-- Theme switcher function
function Utils.createThemeSwitcher(Window, WindUI)
    Window:CreateTopbarButton("theme-switcher", "moon", function()
        WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
        Utils.showNotification(WindUI, "Theme Changed", "Current theme: "..WindUI:GetCurrentTheme(), "moon", 2)
    end, 990)
end

-- Section creation helper
function Utils.createSections(Window)
    return {
        Main = Window:Section({ Title = "loc:FEATURES", Opened = true }),
        Settings = Window:Section({ Title = "loc:SETTINGS", Opened = true }),
        Utilities = Window:Section({ Title = "loc:UTILITIES", Opened = true })
    }
end

-- Tab creation helper
function Utils.createTabs(Sections)
    return {
        Main = Sections.Main:Tab({ Title = "loc:MAIN", Icon = "house", Desc = "Main hub features" }),
        Automation = Sections.Main:Tab({ Title = "Automation", Icon = "zap", Desc = "Automated features" }),
        Visuals = Sections.Main:Tab({ Title = "Visuals", Icon = "eye", Desc = "Visual effects and enhancements" }),
        Misc = Sections.Main:Tab({ Title = "Misc", Icon = "puzzle", Desc = "Miscellaneous features" }),
        Appearance = Sections.Main:Tab({ Title = "loc:APPEARANCE", Icon = "brush" }),
        Elements = Sections.Settings:Tab({ Title = "loc:UI_ELEMENTS", Icon = "layout-grid", Desc = "UI Elements Example" }),
        Config = Sections.Utilities:Tab({ Title = "loc:CONFIGURATION", Icon = "settings" }),
    }
end

-- Section content creation helpers
function Utils.createMainSections(Tabs)
    return {
        MainSection = Tabs.Main:Section({
            Title = "W-Hub Features",
            Icon = "star",
            Opened = true,
        }),
        AutomationSection = Tabs.Automation:Section({
            Title = "Automation Features",
            Icon = "zap",
            Opened = true,
        }),
        VisualsSection = Tabs.Visuals:Section({
            Title = "Visual Effects",
            Icon = "eye",
            Opened = true,
        }),
        MiscSection = Tabs.Misc:Section({
            Title = "Miscellaneous Features",
            Icon = "puzzle",
            Opened = true,
        })
    }
end

-- UI Elements creation helpers
function Utils.createUIElements(Tabs)
    Tabs.Elements:Section({
        Title = "Interactive Components",
        TextSize = 20,
    })

    Tabs.Elements:Section({
        Title = "Explore WindUI's powerful elements",
        TextSize = 16,
        TextTransparency = .25,
    })

    Tabs.Elements:Divider()

    local ElementsSection = Tabs.Elements:Section({
        Title = "Section Example",
        Icon = "bird",
        TextXAlignment = "Center",
        Opened = true,
        Box = true,
    })

    Tabs.Elements:Section({
        Title = "Section Example 2",
        TextXAlignment = "Center",
        Opened = true,
        Box = true,
    })

    Tabs.Elements:Section({
        Title = "Section Example 3",
        TextXAlignment = "Center",
        Opened = true,
    })

    return ElementsSection
end

-- Configuration helpers
function Utils.createConfigSections(Tabs)
    local ConfigSection = Tabs.Config:Section({
        Title = "Configuration",
        Icon = "settings",
        Opened = true,
    })

    local AppearanceSection = Tabs.Appearance:Section({
        Title = "Appearance Settings",
        Icon = "brush",
        Opened = true,
    })

    return ConfigSection, AppearanceSection
end

-- Localization helper
function Utils.createLocalization(WindUI)
    return WindUI:Localization({
        Enabled = true,
        Prefix = "loc:",
        DefaultLanguage = "en",
        Translations = {
            ["en"] = {
                ["WINDUI_EXAMPLE"] = "W-Hub",
                ["WELCOME"] = "Welcome to W-Hub!",
                ["LIB_DESC"] = "Your ultimate Roblox utility hub",
                ["SETTINGS"] = "Settings",
                ["APPEARANCE"] = "Appearance",
                ["FEATURES"] = "Features",
                ["UTILITIES"] = "Utilities",
                ["MAIN"] = "Main",
                ["UI_ELEMENTS"] = "UI Elements",
                ["CONFIGURATION"] = "Configuration",
                ["SAVE_CONFIG"] = "Save Configuration",
                ["LOAD_CONFIG"] = "Load Configuration",
                ["THEME_SELECT"] = "Select Theme",
                ["TRANSPARENCY"] = "Window Transparency",
                ["LOCKED_TAB"] = "Locked Tab"
            }
        }
    })
end

-- Window creation helper
function Utils.createWindow(WindUI, gradient)
    return WindUI:CreateWindow({
        Title = "loc:WINDUI_EXAMPLE",
        Author = "loc:WELCOME",
        Folder = "W-Hub",
        Size = UDim2.fromOffset(580, 490),
        Theme = "Dark",
        
        HidePanelBackground = false,
        NewElements = false,
        
        User = {
            Enabled = true,
            Anonymous = true,
            Callback = function()
                WindUI:Notify({
                    Title = "User Profile",
                    Content = "User profile clicked!",
                    Duration = 3
                })
            end
        },
        Acrylic = false,
        HideSearchBar = false,
        SideBarWidth = 200,
        
        OpenButton = {
            Title = "Open W-Hub",
            CornerRadius = UDim.new(1,0),
            StrokeThickness = 3,
            Enabled = true,
            OnlyMobile = false,
            
            Color = ColorSequence.new(
                Color3.fromHex("#E8E8E8"), 
                Color3.fromHex("#B0B0B0")
            ),
        },
    })
end

-- Popup creation helper
function Utils.createWelcomePopup(WindUI, gradient)
    WindUI:Popup({
        Title = gradient("W-Hub", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
        Icon = "sparkles",
        Content = "Your ultimate Roblox utility hub!",
        Buttons = {
            {
                Title = "Get Started",
                Icon = "arrow-right",
                Variant = "Primary",
                Callback = function() end
            }
        }
    })
end

-- ============================================================================
-- FUNCTIONS MODULE (Embedded)
-- ============================================================================
local Functions = {}

-- Anti AFK System
local antiAFKEnabled = false
local antiAFKConnection
local originalIdleTime

function Functions.enableAntiAFK()
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
    end
    
    -- Save original idle time
    originalIdleTime = game:GetService("Players").LocalPlayer.IdleTime
    
    antiAFKConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if antiAFKEnabled then
            -- Reset idle time to prevent AFK kick
            game:GetService("Players").LocalPlayer.IdleTime = 0
        end
    end)
end

function Functions.disableAntiAFK()
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
        antiAFKConnection = nil
    end
    
    -- Restore original idle time behavior
    if originalIdleTime then
        game:GetService("Players").LocalPlayer.IdleTime = originalIdleTime
    end
end

function Functions.setAntiAFK(state)
    antiAFKEnabled = state
    if state then
        Functions.enableAntiAFK()
    else
        Functions.disableAntiAFK()
    end
end

-- Speed Control
local speedEnabled = false
local originalSpeed = 16

function Functions.setSpeed(state, value)
    speedEnabled = state
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        if state then
            char.Humanoid.WalkSpeed = value or 50
        else
            char.Humanoid.WalkSpeed = originalSpeed
        end
    end
end

function Functions.updateSpeed(value)
    if speedEnabled then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value
        end
    end
end

function Functions.resetSpeed()
    if speedEnabled then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = originalSpeed
        end
    end
end

-- Infinite Jump Control
local infiniteJumpEnabled = false
local infiniteJumpConnection

function Functions.setInfiniteJump(state)
    infiniteJumpEnabled = state
    
    if state then
        -- Enable Infinite Jump
        infiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
            if infiniteJumpEnabled then
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        -- Disable Infinite Jump
        if infiniteJumpConnection then
            infiniteJumpConnection:Disconnect()
            infiniteJumpConnection = nil
        end
    end
end

-- NoClip Control
local noclipEnabled = false
local noclipConnection

function Functions.noclipParts(char)
    if char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

function Functions.restoreParts(char)
    if char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

function Functions.setNoClip(state)
    noclipEnabled = state
    local char = game.Players.LocalPlayer.Character
    
    if state then
        -- Enable NoClip
        Functions.noclipParts(char)
        
        -- Start noclip loop
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if noclipEnabled then
                local currentChar = game.Players.LocalPlayer.Character
                if currentChar then
                    Functions.noclipParts(currentChar)
                end
            end
        end)
    else
        -- Disable NoClip
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        Functions.restoreParts(char)
    end
end

-- Fly System
local flyEnabled = false
local flySpeed = 1
local tpwalking = false
local speaker = game:GetService("Players").LocalPlayer

function Functions.setFly(state)
    flyEnabled = state
    
    if state then
        -- Start tpwalking loops
        for i = 1, flySpeed do
            spawn(function()
                local hb = game:GetService("RunService").Heartbeat
                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end
        
        -- Disable animations
        game.Players.LocalPlayer.Character.Animate.Disabled = true
        local Char = game.Players.LocalPlayer.Character
        local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
        
        for i,v in next, Hum:GetPlayingAnimationTracks() do
            v:AdjustSpeed(0)
        end
        
        -- Disable humanoid states
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
        
        -- R6/R15 Fly Logic
        if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            Functions.setupR6Fly()
        else
            Functions.setupR15Fly()
        end
    else
        -- Re-enable humanoid states
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    end
end

function Functions.setupR6Fly()
    local plr = game.Players.LocalPlayer
    local torso = plr.Character.Torso
    local flying = true
    local deb = true
    local ctrl = {f = 0, b = 0, l = 0, r = 0}
    local lastctrl = {f = 0, b = 0, l = 0, r = 0}
    local maxspeed = 50
    local speed = 0

    local bg = Instance.new("BodyGyro", torso)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = torso.CFrame
    local bv = Instance.new("BodyVelocity", torso)
    bv.velocity = Vector3.new(0,0.1,0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    if flyEnabled == true then
        plr.Character.Humanoid.PlatformStand = true
    end
    
    spawn(function()
        while flyEnabled == true do
            game:GetService("RunService").RenderStepped:Wait()

            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = speed+.5+(speed/maxspeed)
                if speed > maxspeed then
                    speed = maxspeed
                end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = speed-1
                if speed < 0 then
                    speed = 0
                end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            else
                bv.velocity = Vector3.new(0,0,0)
            end
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speed = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        tpwalking = false
    end)
end

function Functions.setupR15Fly()
    local plr = game.Players.LocalPlayer
    local UpperTorso = plr.Character.UpperTorso
    local flying = true
    local deb = true
    local ctrl = {f = 0, b = 0, l = 0, r = 0}
    local lastctrl = {f = 0, b = 0, l = 0, r = 0}
    local maxspeed = 50
    local speed = 0

    local bg = Instance.new("BodyGyro", UpperTorso)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = UpperTorso.CFrame
    local bv = Instance.new("BodyVelocity", UpperTorso)
    bv.velocity = Vector3.new(0,0.1,0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    if flyEnabled == true then
        plr.Character.Humanoid.PlatformStand = true
    end
    
    spawn(function()
        while flyEnabled == true do
            wait()

            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = speed+.5+(speed/maxspeed)
                if speed > maxspeed then
                    speed = maxspeed
                end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = speed-1
                if speed < 0 then
                    speed = 0
                end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            else
                bv.velocity = Vector3.new(0,0,0)
            end
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speed = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        tpwalking = false
    end)
end

function Functions.setFlySpeed(value)
    flySpeed = value
    if flyEnabled == true then
        tpwalking = false
        for i = 1, flySpeed do
            spawn(function()
                local hb = game:GetService("RunService").Heartbeat
                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end
    end
end

-- Teleport Functions
function Functions.getPlayerList()
    local players = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(players, player.Name)
        end
    end
    return players
end

function Functions.teleportToPlayer(playerName)
    if playerName and playerName ~= "" then
        local targetPlayer = game.Players:FindFirstChild(playerName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                return true
            end
        end
    end
    return false
end

-- Character respawn handler
function Functions.handleCharacterRespawn()
    -- Disable NoClip
    if noclipEnabled then
        noclipEnabled = false
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        local newChar = game.Players.LocalPlayer.Character
        if newChar then
            Functions.restoreParts(newChar)
        end
    end
    
    -- Disable Infinite Jump
    if infiniteJumpEnabled then
        infiniteJumpEnabled = false
        if infiniteJumpConnection then
            infiniteJumpConnection:Disconnect()
            infiniteJumpConnection = nil
        end
    end
    
    -- Disable Fly
    if flyEnabled then
        flyEnabled = false
    end
    
    -- Disable Anti AFK
    if antiAFKEnabled then
        antiAFKEnabled = false
        Functions.disableAntiAFK()
    end
    
    -- Wait a bit then restore animations
    wait(0.7)
    local char = game.Players.LocalPlayer.Character
    if char then
        char.Humanoid.PlatformStand = false
        if char:FindFirstChild("Animate") then
            char.Animate.Disabled = false
        end
    end
end

-- Initialize character respawn handler
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    Functions.handleCharacterRespawn()
end)

-- ============================================================================
-- MAIN INITIALIZATION
-- ============================================================================

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
