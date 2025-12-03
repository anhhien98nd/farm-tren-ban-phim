local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Cấu hình (bạn có thể thay đổi)
local spamKey = Enum.KeyCode.J          -- Phím muốn spam (J)
local useVIM = true                     -- true = dùng VirtualInputManager (nhanh hơn nhưng dễ detect ở game lớn)
local delayTime = 0.4                  -- Tốc độ (0.03 ~ 0.05 là ổn nhất)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local Toggle = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

ScreenGui.Name = "AutoSpamFixed"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

Frame.Size = UDim2.new(0, 320, 0, 180)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local corner = Instance.new("UICorner", Frame); corner.CornerRadius = UDim.new(0, 12)

Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "AUTO SPAM KEY 2025"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Frame

CloseBtn.Size = UDim2.new(0,30,0,30)
CloseBtn.Position = UDim2.new(1,-35,0,5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Parent = Frame
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0,8)

Toggle.Size = UDim2.new(0,260,0,50)
Toggle.Position = UDim2.new(0.5,-130,0,60)
Toggle.Text = "OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(255,50,50)
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 24
Toggle.Parent = Frame
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,10)

Status.Size = UDim2.new(1,-20,0,30)
Status.Position = UDim2.new(0,10,1,-40)
Status.BackgroundTransparency = 1
Status.Text = "Trạng thái: Tắt"
Status.TextColor3 = Color3.fromRGB(255,100,100)
Status.Font = Enum.Font.Gotham
Status.TextSize = 16
Status.Parent = Frame

local isRunning = false

local function pressKey()
    if useVIM then
        VirtualInputManager:SendKeyEvent(true, spamKey, false, game)
        task.wait(0.02)
        VirtualInputManager:SendKeyEvent(false, spamKey, false, game)
    else
        -- Cách an toàn hơn (dùng keypress/keyrelease - khó detect hơn)
        keypress(spamKey.Value)
        task.wait(0.02)
        keyrelease(spamKey.Value)
    end
end

local function spamLoop()
    while isRunning do
        if not isRunning then break end
        pcall(pressKey)  -- pcall để tránh lỗi crash
        task.wait(delayTime)
    end
end

Toggle.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        Toggle.Text = "ON"
        Toggle.BackgroundColor3 = Color3.fromRGB(50,255,50)
        Status.Text = "Đang spam phím " .. spamKey.Name .. " (siêu nhanh)"
        Status.TextColor3 = Color3.fromRGB(50,255,50)
        spawn(spamLoop)
    else
        Toggle.Text = "OFF"
        Toggle.BackgroundColor3 = Color3.fromRGB(255,50,50)
        Status.Text = "Trạng thái: Tắt"
        Status.TextColor3 = Color3.fromRGB(255,100,100)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- F10 hiện/ẩn GUI
UIS.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.F10 then
        Frame.Visible = not Frame.Visible
    end
end)

print("Auto Spam Key 2025 đã load! Nhấn F10 để bật/tắt GUI")
