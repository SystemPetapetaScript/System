-- [[ REWRITTEN KEY SYSTEM UI (WINDUI STYLE) ]] --

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Configuration Table
local KeySystemConfig = {
    Title = "Key System Verification",
    SubTitle = "Nhập Key để tiếp tục sử dụng Script",
    Note = "Vui lòng vượt qua các bước liên kết để lấy key sử dụng trong ngày.",
    SavedFileName = "ScriptKeyCache.txt",
    
    -- Danh sách dịch vụ lấy key
    Services = {
        {
            Name = "Platoboost Service",
            Desc = "Hệ thống vượt link Platoboost tốc độ cao",
            Url = "https://platoboost.com/getkey",
            Icon = "rbxassetid://75920162824531"
        },
        {
            Name = "Panda Development",
            Desc = "Vượt link Panda qua hệ thống Ads",
            Url = "https://pandadevelopment.net/getkey",
            Icon = "rbxassetid://106310347705078"
        }
    },

    -- Hàm kiểm tra Key
    Validator = function(inputKey)
        -- Thay đổi logic xác minh key của bạn ở đây (có thể gọi API/HTTP Request)
        if inputKey == "AdminKey123" or #inputKey >= 10 then
            return true, "Xác thực thành công!"
        else
            return false, "Key không hợp lệ hoặc đã hết hạn!"
        end
    end
}

-- ScreenGui Parent Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomKeySystemUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

-- Helper Functions
local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(255, 255, 255)
    stroke.Transparency = transparency or 0.8
    stroke.Thickness = 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

-- Main Overlay & Container Frame
local Overlay = Instance.new("Frame")
Overlay.Name = "Overlay"
Overlay.Size = UDim2.fromScale(1, 1)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 1
Overlay.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
MainFrame.BackgroundTransparency = 0.05
MainFrame.ClipsDescendants = true
MainFrame.Parent = Overlay

CreateCorner(MainFrame, 16)
CreateStroke(MainFrame, Color3.fromRGB(60, 60, 65), 0.5)

-- Header Section
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 0, 25)
TitleLabel.Position = UDim2.new(0, 15, 0, 10)
TitleLabel.Text = KeySystemConfig.Title
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = Header

local SubTitleLabel = Instance.new("TextLabel")
SubTitleLabel.Size = UDim2.new(1, -20, 0, 15)
SubTitleLabel.Position = UDim2.new(0, 15, 0, 30)
SubTitleLabel.Text = KeySystemConfig.SubTitle
SubTitleLabel.TextColor3 = Color3.fromRGB(150, 150, 155)
SubTitleLabel.TextSize = 13
SubTitleLabel.Font = Enum.Font.SourceSans
SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubTitleLabel.BackgroundTransparency = 1
SubTitleLabel.Parent = Header

-- Content Container
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -30, 0, 190)
ContentFrame.Position = UDim2.new(0, 15, 0, 60)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 12)
UIList.Parent = ContentFrame

-- Note Label
local NoteLabel = Instance.new("TextLabel")
NoteLabel.Size = UDim2.new(1, 0, 0, 35)
NoteLabel.Text = KeySystemConfig.Note
NoteLabel.TextColor3 = Color3.fromRGB(180, 180, 185)
NoteLabel.TextSize = 13
NoteLabel.Font = Enum.Font.SourceSans
NoteLabel.TextWrapped = true
NoteLabel.TextXAlignment = Enum.TextXAlignment.Left
NoteLabel.BackgroundTransparency = 1
NoteLabel.Parent = ContentFrame

-- Key Input Field Box
local InputContainer = Instance.new("Frame")
InputContainer.Size = UDim2.new(1, 0, 0, 42)
InputContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
InputContainer.Parent = ContentFrame
CreateCorner(InputContainer, 8)
CreateStroke(InputContainer, Color3.fromRGB(50, 50, 55), 0.5)

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -20, 1, 0)
KeyBox.Position = UDim2.new(0, 10, 0, 0)
KeyBox.PlaceholderText = "Nhập Key của bạn vào đây..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 105)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14
KeyBox.Font = Enum.Font.SourceSans
KeyBox.TextXAlignment = Enum.TextXAlignment.Left
KeyBox.ClearTextOnFocus = false
KeyBox.BackgroundTransparency = 1
KeyBox.Parent = InputContainer

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.BackgroundTransparency = 1
StatusLabel.Parent = ContentFrame

-- Buttons Action Frame
local ActionsFrame = Instance.new("Frame")
ActionsFrame.Size = UDim2.new(1, -30, 0, 42)
ActionsFrame.Position = UDim2.new(0, 15, 1, -55)
ActionsFrame.BackgroundTransparency = 1
ActionsFrame.Parent = MainFrame

local ActionList = Instance.new("UIListLayout")
ActionList.FillDirection = Enum.FillDirection.Horizontal
ActionList.HorizontalAlignment = Enum.HorizontalAlignment.Right
ActionList.Padding = UDim.new(0, 10)
ActionList.Parent = ActionsFrame

-- Create Custom Button Utility
local function CreateButton(text, bgColor, textColor, width)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, width or 100, 1, 0)
    btn.BackgroundColor3 = bgColor
    btn.Text = text
    btn.TextColor3 = textColor
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansBold
    btn.AutoButtonColor = false
    CreateCorner(btn, 8)
    
    -- Hover Animations
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
    end)
    
    return btn
end

-- Service Dropdown Sub-Menu Frame
local ServiceMenu = Instance.new("Frame")
ServiceMenu.Size = UDim2.new(1, -30, 0, 0)
ServiceMenu.Position = UDim2.new(0, 15, 0, 220)
ServiceMenu.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
ServiceMenu.ClipsDescendants = true
ServiceMenu.Visible = false
ServiceMenu.Parent = MainFrame
CreateCorner(ServiceMenu, 8)
CreateStroke(ServiceMenu, Color3.fromRGB(60, 60, 65), 0.5)

local ServiceList = Instance.new("UIListLayout")
ServiceList.SortOrder = Enum.SortOrder.LayoutOrder
ServiceList.Padding = UDim.new(0, 5)
ServiceList.Parent = ServiceMenu

local ServicePadding = Instance.new("UIPadding")
ServicePadding.PaddingTop = UDim.new(0, 8)
ServicePadding.PaddingLeft = UDim.new(0, 8)
ServicePadding.PaddingRight = UDim.new(0, 8)
ServicePadding.Parent = ServiceMenu

for _, srv in ipairs(KeySystemConfig.Services) do
    local srvBtn = Instance.new("TextButton")
    srvBtn.Size = UDim2.new(1, 0, 0, 35)
    srvBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 42)
    srvBtn.Text = "  " .. srv.Name
    srvBtn.TextColor3 = Color3.fromRGB(220, 220, 225)
    srvBtn.TextSize = 13
    srvBtn.Font = Enum.Font.SourceSans
    srvBtn.TextXAlignment = Enum.TextXAlignment.Left
    srvBtn.Parent = ServiceMenu
    CreateCorner(srvBtn, 6)

    srvBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(srv.Url)
            StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
            StatusLabel.Text = "Đã sao chép liên kết: " .. srv.Name
        end
    end)
end

-- Action Buttons Initialization
local GetKeyBtn = CreateButton("Lấy Key", Color3.fromRGB(45, 45, 50), Color3.fromRGB(255, 255, 255), 100)
local SubmitBtn = CreateButton("Xác Nhận", Color3.fromRGB(0, 145, 255), Color3.fromRGB(255, 255, 255), 110)

GetKeyBtn.Parent = ActionsFrame
SubmitBtn.Parent = ActionsFrame

-- Interactivity & Logic
local isMenuOpen = false
GetKeyBtn.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    if isMenuOpen then
        ServiceMenu.Visible = true
        TweenService:Create(ServiceMenu, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(1, -30, 0, #KeySystemConfig.Services * 40 + 10)}):Play()
    else
        local tween = TweenService:Create(ServiceMenu, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Size = UDim2.new(1, -30, 0, 0)})
        tween:Play()
        tween.Completed:Connect(function()
            if not isMenuOpen then ServiceMenu.Visible = false end
        end)
    end
end)

-- Execute Verification Process
local function VerifyKey()
    local input = KeyBox.Text
    if input == "" then
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        StatusLabel.Text = "Vui lòng nhập Key trước khi xác nhận!"
        return
    end

    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 80)
    StatusLabel.Text = "Đang kiểm tra..."

    task.wait(0.5)

    local isValid, message = KeySystemConfig.Validator(input)
    if isValid then
        StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
        StatusLabel.Text = message or "Thành công!"
        
        -- Save Key Cache
        if writefile then
            pcall(writefile, KeySystemConfig.SavedFileName, input)
        end
        
        -- Smooth Fade-out Animation
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(Overlay, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        
        task.wait(0.35)
        ScreenGui:Destroy()
        
        -- Execute your script main code here
        print("Key Verified! Main Script Loaded.")
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        StatusLabel.Text = message or "Key không chính xác!"
    end
end

SubmitBtn.MouseButton1Click:Connect(VerifyKey)

-- Smooth GUI Entrance Animation
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Overlay, TweenInfo.new(0.25), {BackgroundTransparency = 0.5}):Play()
TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 420, 0, 320)}):Play()
