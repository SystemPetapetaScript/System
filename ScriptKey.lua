-- [[ WINDUI STYLE KEY SYSTEM UI - FIXED IMAGE LOAD ]] --

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")

-- Configuration
local Config = {
    Title = "PetaHub",
    SubTitle = "Key System",
    IconId = "rbxassetid://124717824553107", -- ID Icon của bạn
    SavedKeyFile = "PetaHub_Key.txt",
    Services = {
        {Name = "Platoboost", Url = "https://platoboost.com/getkey"},
        {Name = "Panda Link", Url = "https://pandadevelopment.net/getkey"}
    },
    Validator = function(key)
        if key == "PetaHub2026" or #key >= 8 then
            return true, "Xác thực thành công!"
        end
        return false, "Key không chính xác!"
    end
}

-- ScreenGui Parent Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WindUI_KeySystem"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end

-- Helper Functions
local function AddCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 10)
    c.Parent = parent
    return c
end

local function AddStroke(parent, color, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(60, 60, 65)
    s.Transparency = transparency or 0.7
    s.Thickness = 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

-- Main Window Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 390, 0, 240)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

AddCorner(MainFrame, 12)
AddStroke(MainFrame, Color3.fromRGB(80, 80, 85), 0.6)

-- Top Header Bar
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

-- Khung chứa Icon Hình Tròn
local LogoContainer = Instance.new("Frame")
LogoContainer.Size = UDim2.new(0, 22, 0, 22)
LogoContainer.Position = UDim2.new(0, 10, 0, 6)
LogoContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
LogoContainer.ClipsDescendants = true
LogoContainer.Parent = Header
AddCorner(LogoContainer, 100)
AddStroke(LogoContainer, Color3.fromRGB(80, 80, 90), 0.5)

local LogoImage = Instance.new("ImageLabel")
LogoImage.Size = UDim2.fromScale(1, 1)
LogoImage.Image = Config.IconId
LogoImage.ScaleType = Enum.ScaleType.Fit
LogoImage.BackgroundTransparency = 1
LogoImage.Parent = LogoContainer

-- Load ảnh an toàn không làm đen màn hình
task.spawn(function()
    pcall(function()
        ContentProvider:PreloadAsync({LogoImage})
    end)
end)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 150, 0, 20)
TitleLabel.Position = UDim2.new(0, 38, 0, 4)
TitleLabel.Text = Config.Title
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = Header

local SubTitleLabel = Instance.new("TextLabel")
SubTitleLabel.Size = UDim2.new(0, 150, 0, 12)
SubTitleLabel.Position = UDim2.new(0, 38, 0, 20)
SubTitleLabel.Text = Config.SubTitle
SubTitleLabel.TextColor3 = Color3.fromRGB(120, 120, 130)
SubTitleLabel.TextSize = 10
SubTitleLabel.Font = Enum.Font.SourceSans
SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubTitleLabel.BackgroundTransparency = 1
SubTitleLabel.Parent = Header

-- Control Window Buttons (Minimize & Close)
local BtnMinimize = Instance.new("TextButton")
BtnMinimize.Size = UDim2.new(0, 30, 0, 30)
BtnMinimize.Position = UDim2.new(1, -65, 0, 2)
BtnMinimize.Text = "—"
BtnMinimize.TextColor3 = Color3.fromRGB(180, 180, 190)
BtnMinimize.TextSize = 12
BtnMinimize.BackgroundTransparency = 1
BtnMinimize.Parent = Header

local BtnClose = Instance.new("TextButton")
BtnClose.Size = UDim2.new(0, 30, 0, 30)
BtnClose.Position = UDim2.new(1, -35, 0, 2)
BtnClose.Text = "✕"
BtnClose.TextColor3 = Color3.fromRGB(180, 180, 190)
BtnClose.TextSize = 12
BtnClose.BackgroundTransparency = 1
BtnClose.Parent = Header

-- Sidebar Panel (Left)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 110, 1, -40)
Sidebar.Position = UDim2.new(0, 8, 0, 35)
Sidebar.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
Sidebar.Parent = MainFrame
AddCorner(Sidebar, 8)

local SideList = Instance.new("UIListLayout")
SideList.Padding = UDim.new(0, 4)
SideList.Parent = Sidebar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 6)
SidePadding.PaddingLeft = UDim.new(0, 6)
SidePadding.PaddingRight = UDim.new(0, 6)
SidePadding.Parent = Sidebar

local TabBtn = Instance.new("TextButton")
TabBtn.Size = UDim2.new(1, 0, 0, 28)
TabBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 42)
TabBtn.Text = "  ★ Key Verification"
TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TabBtn.TextSize = 11
TabBtn.Font = Enum.Font.SourceSansBold
TabBtn.TextXAlignment = Enum.TextXAlignment.Left
TabBtn.Parent = Sidebar
AddCorner(TabBtn, 6)

-- Content Panel (Right)
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -134, 1, -40)
Content.Position = UDim2.new(0, 124, 0, 35)
Content.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
Content.Parent = MainFrame
AddCorner(Content, 8)

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 10)
ContentPadding.PaddingLeft = UDim.new(0, 10)
ContentPadding.PaddingRight = UDim.new(0, 10)
ContentPadding.Parent = Content

local ContentList = Instance.new("UIListLayout")
ContentList.Padding = UDim.new(0, 8)
ContentList.Parent = Content

-- Key Input Box
local InputContainer = Instance.new("Frame")
InputContainer.Size = UDim2.new(1, 0, 0, 32)
InputContainer.BackgroundColor3 = Color3.fromRGB(32, 32, 36)
InputContainer.Parent = Content
AddCorner(InputContainer, 6)
AddStroke(InputContainer, Color3.fromRGB(55, 55, 60), 0.5)

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -12, 1, 0)
KeyBox.Position = UDim2.new(0, 8, 0, 0)
KeyBox.PlaceholderText = "Paste Key here..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(240, 240, 240)
KeyBox.TextSize = 12
KeyBox.Font = Enum.Font.SourceSans
KeyBox.TextXAlignment = Enum.TextXAlignment.Left
KeyBox.BackgroundTransparency = 1
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = InputContainer

-- Status Message
local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 0, 14)
StatusText.Text = ""
StatusText.TextColor3 = Color3.fromRGB(255, 85, 85)
StatusText.TextSize = 11
StatusText.Font = Enum.Font.SourceSans
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.BackgroundTransparency = 1
StatusText.Parent = Content

-- Action Buttons Container
local BtnGroup = Instance.new("Frame")
BtnGroup.Size = UDim2.new(1, 0, 0, 30)
BtnGroup.BackgroundTransparency = 1
BtnGroup.Parent = Content

local BtnGroupList = Instance.new("UIListLayout")
BtnGroupList.FillDirection = Enum.FillDirection.Horizontal
BtnGroupList.HorizontalAlignment = Enum.HorizontalAlignment.Right
BtnGroupList.Padding = UDim.new(0, 6)
BtnGroupList.Parent = BtnGroup

local function CreateActionBtn(text, color, width)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, width, 1, 0)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 11
    b.Font = Enum.Font.SourceSansBold
    AddCorner(b, 6)
    return b
end

local GetKeyBtn = CreateActionBtn("Get Key", Color3.fromRGB(40, 40, 45), 70)
local VerifyBtn = CreateActionBtn("Verify", Color3.fromRGB(50, 110, 220), 75)
GetKeyBtn.Parent = BtnGroup
VerifyBtn.Parent = BtnGroup

-- Get Key Options Dropdown
local ServiceMenu = Instance.new("Frame")
ServiceMenu.Size = UDim2.new(1, 0, 0, 50)
ServiceMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
ServiceMenu.Visible = false
ServiceMenu.Parent = Content
AddCorner(ServiceMenu, 6)
AddStroke(ServiceMenu, Color3.fromRGB(60, 60, 65), 0.5)

local SrvList = Instance.new("UIListLayout")
SrvList.Padding = UDim.new(0, 2)
SrvList.Parent = ServiceMenu

for _, s in ipairs(Config.Services) do
    local sb = Instance.new("TextButton")
    sb.Size = UDim2.new(1, 0, 0, 24)
    sb.BackgroundTransparency = 1
    sb.Text = "  • " .. s.Name
    sb.TextColor3 = Color3.fromRGB(200, 200, 210)
    sb.TextSize = 11
    sb.Font = Enum.Font.SourceSans
    sb.TextXAlignment = Enum.TextXAlignment.Left
    sb.Parent = ServiceMenu

    sb.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(s.Url)
            StatusText.TextColor3 = Color3.fromRGB(100, 230, 130)
            StatusText.Text = "Copied link to clipboard!"
        end
    end)
end

-- Floating Circle Open Button
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "OpenUI_Toggle"
ToggleButton.Size = UDim2.new(0, 42, 0, 42)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -21)
ToggleButton.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
ToggleButton.Image = Config.IconId
ToggleButton.ScaleType = Enum.ScaleType.Fit
ToggleButton.Visible = false
ToggleButton.Parent = ScreenGui
AddCorner(ToggleButton, 100)
AddStroke(ToggleButton, Color3.fromRGB(80, 80, 90), 0.6)

-- Draggable UI Feature
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Button Click Actions
GetKeyBtn.MouseButton1Click:Connect(function()
    ServiceMenu.Visible = not ServiceMenu.Visible
end)

local function CloseUI()
    MainFrame.Visible = false
    ToggleButton.Visible = true
end

BtnMinimize.MouseButton1Click:Connect(CloseUI)
BtnClose.MouseButton1Click:Connect(CloseUI)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleButton.Visible = false
end)

VerifyBtn.MouseButton1Click:Connect(function()
    local val = KeyBox.Text
    if val == "" then
        StatusText.TextColor3 = Color3.fromRGB(255, 85, 85)
        StatusText.Text = "Please enter a key!"
        return
    end

    StatusText.TextColor3 = Color3.fromRGB(255, 200, 80)
    StatusText.Text = "Checking..."
    task.wait(0.4)

    local success, msg = Config.Validator(val)
    if success then
        StatusText.TextColor3 = Color3.fromRGB(100, 230, 130)
        StatusText.Text = msg
        if writefile then pcall(writefile, Config.SavedKeyFile, val) end
        
        task.wait(0.5)
        ScreenGui:Destroy()
        print("Loaded Script Successfully!")
    else
        StatusText.TextColor3 = Color3.fromRGB(255, 85, 85)
        StatusText.Text = msg
    end
end)
