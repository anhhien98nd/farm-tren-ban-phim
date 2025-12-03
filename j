-- Auto Spam Key + GUI by Grok
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local Status = Instance.new("TextLabel")
-- Thiết kế GUI
ScreenGui.Name = "AutoFarmGUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
Frame.Size = UDim2.new(0, 320, 0, 180)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui
-- Bo góc
local corner = Instance.new("UICorner", Frame)
corner.CornerRadius = UDim.new(0, 12)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "🔥 AUTO FARM TOOL"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Frame
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Parent = Frame
local closeCorner = Instance.new("UICorner", CloseBtn)
closeCorner.CornerRadius = UDim.new(0, 8)
-- Nút toggle
local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(0, 260, 0, 50)
Toggle.Position = UDim2.new(0.5, -130, 0, 60)
Toggle.Text = "OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 20
Toggle.Parent = Frame
local toggleCorner = Instance.new("UICorner", Toggle)
Status.Size = UDim2.new(1, -20, 0, 30)
Status.Position = UDim2.new(0, 10, 1, -40)
Status.BackgroundTransparency = 1
Status.Text = "Trạng thái: Đã tắt"
Status.TextColor3 = Color3.fromRGB(255, 100, 100)
Status.Font = Enum.Font.Gotham
Status.TextSize = 16
Status.Parent = Frame
-- Biến trạng thái
local isSpamming = false
local spamKey = "J" -- Thay J hoặc K tùy ý, hoặc dùng A-Z
local delayTime = 0.01 -- Tốc độ spam (càng nhỏ càng nhanh)
-- Hàm spam phím
local function spam()
    while isSpamming do
        task.wait(delayTime)
        if not isSpamming then break end
        -- Gửi phím ảo
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode[spamKey], false, game)
        task.wait(0.01)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode[spamKey], false, game)
    end
end
-- Toggle bật/tắt
Toggle.MouseButton1Click:Connect(function()
    isSpamming = not isSpamming
    if isSpamming then
        Toggle.Text = "ON"
        Toggle.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        Status.Text = "Trạng thái: Đang spam phím " .. spamKey .. " (siêu nhanh)"
        Status.TextColor3 = Color3.fromRGB(50, 255, 50)
        spawn(spam)
    else
        Toggle.Text = "OFF"
        Toggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        Status.Text = "Trạng thái: Đã tắt"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)
-- Đóng GUI
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
-- Nhấn phím F10 để bật/tắt GUI
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F10 then
        Frame.Visible = not Frame.Visible
    end
end)
print("Auto Farm Tool loaded! Nhấn F10 để hiện/ẩn GUI")
