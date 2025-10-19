-- Utils module for W-Hub
-- Contains utility functions and helpers

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

return Utils
