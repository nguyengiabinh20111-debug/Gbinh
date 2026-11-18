-- Gui to Lua (Hirose - CHILLI x VENYX Loader - Compact & Optimized)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

-- Xóa GUI cũ nếu đã tồn tại
if CoreGui:FindFirstChild("HiroseHubLoader") then
	CoreGui.HiroseHubLoader:Destroy()
end

-- Cấu hình Script & Link
local DISCORD_LINK = "https://discord.gg/uqhEpzXy9q"
local SCRIPTS = {
	Chilli = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()',
	Venyx = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"))()'
}

local SelectedHub = "Chilli"
local SoundEnabled = true
local FpsBoostEnabled = true

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HiroseHubLoader"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Khung chính (Main Frame - Thu gọn lại)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 380, 0, 395)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(45, 45, 55)
MainStroke.Thickness = 1.2
MainStroke.Parent = MainFrame

-- Cho phép kéo thả cửa sổ
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- ==================== TOP BAR ====================
local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundTransparency = 1

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TopBar
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "🌶️ CHILLI x VENYX"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local VersionBadge = Instance.new("TextLabel")
VersionBadge.Parent = TopBar
VersionBadge.Position = UDim2.new(1, -94, 0.5, -10)
VersionBadge.Size = UDim2.new(0, 54, 0, 20)
VersionBadge.BackgroundColor3 = Color3.fromRGB(45, 28, 18)
VersionBadge.Font = Enum.Font.GothamBold
VersionBadge.Text = "v11.0.0"
VersionBadge.TextColor3 = Color3.fromRGB(255, 140, 50)
VersionBadge.TextSize = 10
Instance.new("UICorner", VersionBadge).CornerRadius = UDim.new(1, 0)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.Position = UDim2.new(1, -34, 0.5, -11)
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
CloseBtn.TextSize = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- ==================== PROFILE CARD (HIROSE) ====================
local ProfileCard = Instance.new("Frame")
ProfileCard.Parent = MainFrame
ProfileCard.Position = UDim2.new(0, 12, 0, 38)
ProfileCard.Size = UDim2.new(1, -24, 0, 54)
ProfileCard.BackgroundColor3 = Color3.fromRGB(38, 18, 20)
local ProfileStroke = Instance.new("UIStroke", ProfileCard)
ProfileStroke.Color = Color3.fromRGB(95, 35, 35)
Instance.new("UICorner", ProfileCard).CornerRadius = UDim.new(0, 8)

local IconBox = Instance.new("TextLabel")
IconBox.Parent = ProfileCard
IconBox.Position = UDim2.new(0, 10, 0.5, -16)
IconBox.Size = UDim2.new(0, 32, 0, 32)
IconBox.BackgroundColor3 = Color3.fromRGB(55, 22, 24)
IconBox.Text = "🌶️"
IconBox.TextSize = 18
Instance.new("UICorner", IconBox).CornerRadius = UDim.new(0, 8)

local NameLabel = Instance.new("TextLabel")
NameLabel.Parent = ProfileCard
NameLabel.Position = UDim2.new(0, 50, 0, 7)
NameLabel.Size = UDim2.new(1, -60, 0, 14)
NameLabel.BackgroundTransparency = 1
NameLabel.Font = Enum.Font.GothamBold
NameLabel.Text = "Hirose Loader"
NameLabel.TextColor3 = Color3.fromRGB(255, 190, 120)
NameLabel.TextSize = 12
NameLabel.TextXAlignment = Enum.TextXAlignment.Left

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = ProfileCard
StatusLabel.Position = UDim2.new(0, 50, 0, 26)
StatusLabel.Size = UDim2.new(1, -60, 0, 18)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Text = "● Tối ưu hóa mượt mà · Sẵn sàng"
StatusLabel.TextColor3 = Color3.fromRGB(80, 220, 120)
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ==================== CHỌN HUB ====================
local Sec2Title = Instance.new("TextLabel")
Sec2Title.Parent = MainFrame
Sec2Title.Position = UDim2.new(0, 12, 0, 100)
Sec2Title.Size = UDim2.new(0, 150, 0, 18)
Sec2Title.BackgroundTransparency = 1
Sec2Title.Font = Enum.Font.GothamBold
Sec2Title.Text = "🎮 CHỌN HUB"
Sec2Title.TextColor3 = Color3.fromRGB(220, 220, 230)
Sec2Title.TextSize = 11
Sec2Title.TextXAlignment = Enum.TextXAlignment.Left

local SoundBtn = Instance.new("TextButton")
SoundBtn.Parent = MainFrame
SoundBtn.Position = UDim2.new(1, -128, 0, 97)
SoundBtn.Size = UDim2.new(0, 116, 0, 22)
SoundBtn.BackgroundColor3 = Color3.fromRGB(28, 120, 68)
SoundBtn.Font = Enum.Font.GothamBold
SoundBtn.Text = "🔊 ÂM THANH: BẬT"
SoundBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SoundBtn.TextSize = 9
Instance.new("UICorner", SoundBtn).CornerRadius = UDim.new(1, 0)

SoundBtn.MouseButton1Click:Connect(function()
	SoundEnabled = not SoundEnabled
	SoundBtn.Text = SoundEnabled and "🔊 ÂM THANH: BẬT" or "🔇 ÂM THANH: TẮT"
	SoundBtn.BackgroundColor3 = SoundEnabled and Color3.fromRGB(28, 120, 68) or Color3.fromRGB(55, 55, 65)
end)

-- Container 2 nút chọn menu
local HubContainer = Instance.new("Frame")
HubContainer.Parent = MainFrame
HubContainer.Position = UDim2.new(0, 12, 0, 123)
HubContainer.Size = UDim2.new(1, -24, 0, 84)
HubContainer.BackgroundTransparency = 1

local function CreateHubCard(name, pos, icon, title, subtitle)
	local Card = Instance.new("TextButton")
	Card.Name = name
	Card.Parent = HubContainer
	Card.Position = pos
	Card.Size = UDim2.new(0.485, 0, 1, 0)
	Card.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
	Card.Text = ""
	Card.AutoButtonColor = false
	Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)

	local Stroke = Instance.new("UIStroke", Card)
	Stroke.Name = "Stroke"
	Stroke.Color = Color3.fromRGB(50, 50, 60)
	Stroke.Thickness = 1.2

	local Icon = Instance.new("TextLabel")
	Icon.Parent = Card
	Icon.Position = UDim2.new(0, 10, 0, 8)
	Icon.Size = UDim2.new(0, 28, 0, 28)
	Icon.BackgroundTransparency = 1
	Icon.Text = icon
	Icon.TextSize = 18

	local Title = Instance.new("TextLabel")
	Title.Parent = Card
	Title.Position = UDim2.new(0, 42, 0, 8)
	Title.Size = UDim2.new(1, -48, 0, 16)
	Title.BackgroundTransparency = 1
	Title.Font = Enum.Font.GothamBold
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 12
	Title.TextXAlignment = Enum.TextXAlignment.Left

	local Sub = Instance.new("TextLabel")
	Sub.Parent = Card
	Sub.Position = UDim2.new(0, 42, 0, 24)
	Sub.Size = UDim2.new(1, -48, 0, 14)
	Sub.BackgroundTransparency = 1
	Sub.Font = Enum.Font.Gotham
	Sub.Text = subtitle
	Sub.TextColor3 = Color3.fromRGB(160, 160, 175)
	Sub.TextSize = 10
	Sub.TextXAlignment = Enum.TextXAlignment.Left

	local StatusPill = Instance.new("TextLabel")
	StatusPill.Name = "StatusPill"
	StatusPill.Parent = Card
	StatusPill.Position = UDim2.new(0, 10, 1, -28)
	StatusPill.Size = UDim2.new(1, -20, 0, 20)
	StatusPill.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
	StatusPill.Font = Enum.Font.GothamBold
	StatusPill.Text = "Chọn"
	StatusPill.TextColor3 = Color3.fromRGB(180, 180, 190)
	StatusPill.TextSize = 10
	Instance.new("UICorner", StatusPill).CornerRadius = UDim.new(0, 6)

	return Card
end

local ChilliCard = CreateHubCard("ChilliCard", UDim2.new(0, 0, 0, 0), "🔥", "Chilli VIP", "Hub 1")
local VenyxCard = CreateHubCard("VenyxCard", UDim2.new(0.515, 0, 0, 0), "⚡", "Venyx", "Hub 2")

local function UpdateHubSelection()
	if SelectedHub == "Chilli" then
		ChilliCard.BackgroundColor3 = Color3.fromRGB(68, 28, 22)
		ChilliCard.Stroke.Color = Color3.fromRGB(255, 255, 255)
		ChilliCard.Stroke.Thickness = 1.5
		ChilliCard.StatusPill.BackgroundColor3 = Color3.fromRGB(235, 95, 50)
		ChilliCard.StatusPill.TextColor3 = Color3.fromRGB(255, 255, 255)
		ChilliCard.StatusPill.Text = "✓ ĐÃ CHỌN"

		VenyxCard.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
		VenyxCard.Stroke.Color = Color3.fromRGB(50, 50, 60)
		VenyxCard.Stroke.Thickness = 1.2
		VenyxCard.StatusPill.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
		VenyxCard.StatusPill.TextColor3 = Color3.fromRGB(180, 180, 190)
		VenyxCard.StatusPill.Text = "Chọn"
	else
		VenyxCard.BackgroundColor3 = Color3.fromRGB(32, 30, 68)
		VenyxCard.Stroke.Color = Color3.fromRGB(255, 255, 255)
		VenyxCard.Stroke.Thickness = 1.5
		VenyxCard.StatusPill.BackgroundColor3 = Color3.fromRGB(95, 90, 235)
		VenyxCard.StatusPill.TextColor3 = Color3.fromRGB(255, 255, 255)
		VenyxCard.StatusPill.Text = "✓ ĐÃ CHỌN"

		ChilliCard.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
		ChilliCard.Stroke.Color = Color3.fromRGB(50, 50, 60)
		ChilliCard.Stroke.Thickness = 1.2
		ChilliCard.StatusPill.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
		ChilliCard.StatusPill.TextColor3 = Color3.fromRGB(180, 180, 190)
		ChilliCard.StatusPill.Text = "Chọn"
	end
end

ChilliCard.MouseButton1Click:Connect(function()
	SelectedHub = "Chilli"
	UpdateHubSelection()
end)

VenyxCard.MouseButton1Click:Connect(function()
	SelectedHub = "Venyx"
	UpdateHubSelection()
end)

UpdateHubSelection()

-- ==================== FPS BOOST CARD ====================
local FpsCard = Instance.new("Frame")
FpsCard.Parent = MainFrame
FpsCard.Position = UDim2.new(0, 12, 0, 215)
FpsCard.Size = UDim2.new(1, -24, 0, 38)
FpsCard.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
Instance.new("UICorner", FpsCard).CornerRadius = UDim.new(0, 8)

local FpsTitle = Instance.new("TextLabel")
FpsTitle.Parent = FpsCard
FpsTitle.Position = UDim2.new(0, 10, 0, 4)
FpsTitle.Size = UDim2.new(0, 200, 0, 15)
FpsTitle.BackgroundTransparency = 1
FpsTitle.Font = Enum.Font.GothamBold
FpsTitle.Text = "🌙 Fix Lag / Tối ưu FPS"
FpsTitle.TextColor3 = Color3.fromRGB(240, 240, 250)
FpsTitle.TextSize = 11
FpsTitle.TextXAlignment = Enum.TextXAlignment.Left

local FpsSub = Instance.new("TextLabel")
FpsSub.Parent = FpsCard
FpsSub.Position = UDim2.new(0, 10, 0, 20)
FpsSub.Size = UDim2.new(0, 220, 0, 14)
FpsSub.BackgroundTransparency = 1
FpsSub.Font = Enum.Font.Gotham
FpsSub.Text = "Tắt hiệu ứng nặng, chống giật lag"
FpsSub.TextColor3 = Color3.fromRGB(150, 150, 165)
FpsSub.TextSize = 9
FpsSub.TextXAlignment = Enum.TextXAlignment.Left

local FpsBtn = Instance.new("TextButton")
FpsBtn.Parent = FpsCard
FpsBtn.Position = UDim2.new(1, -58, 0.5, -11)
FpsBtn.Size = UDim2.new(0, 48, 0, 22)
FpsBtn.BackgroundColor3 = Color3.fromRGB(28, 135, 75)
FpsBtn.Font = Enum.Font.GothamBold
FpsBtn.Text = "BẬT"
FpsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FpsBtn.TextSize = 10
Instance.new("UICorner", FpsBtn).CornerRadius = UDim.new(1, 0)

FpsBtn.MouseButton1Click:Connect(function()
	FpsBoostEnabled = not FpsBoostEnabled
	FpsBtn.Text = FpsBoostEnabled and "BẬT" or "TẮT"
	FpsBtn.BackgroundColor3 = FpsBoostEnabled and Color3.fromRGB(28, 135, 75) or Color3.fromRGB(55, 55, 65)
end)

-- ==================== DISCORD CARD ====================
local DiscordCard = Instance.new("Frame")
DiscordCard.Parent = MainFrame
DiscordCard.Position = UDim2.new(0, 12, 0, 259)
DiscordCard.Size = UDim2.new(1, -24, 0, 38)
DiscordCard.BackgroundColor3 = Color3.fromRGB(26, 26, 46)
local DiscordStroke = Instance.new("UIStroke", DiscordCard)
DiscordStroke.Color = Color3.fromRGB(65, 65, 130)
Instance.new("UICorner", DiscordCard).CornerRadius = UDim.new(0, 8)

local DiscordTitle = Instance.new("TextLabel")
DiscordTitle.Parent = DiscordCard
DiscordTitle.Position = UDim2.new(0, 10, 0, 4)
DiscordTitle.Size = UDim2.new(0, 220, 0, 15)
DiscordTitle.BackgroundTransparency = 1
DiscordTitle.Font = Enum.Font.GothamBold
DiscordTitle.Text = "💬 THAM GIA DISCORD"
DiscordTitle.TextColor3 = Color3.fromRGB(135, 145, 255)
DiscordTitle.TextSize = 10
DiscordTitle.TextXAlignment = Enum.TextXAlignment.Left

local DiscordLinkText = Instance.new("TextLabel")
DiscordLinkText.Parent = DiscordCard
DiscordLinkText.Position = UDim2.new(0, 10, 0, 20)
DiscordLinkText.Size = UDim2.new(0, 230, 0, 14)
DiscordLinkText.BackgroundTransparency = 1
DiscordLinkText.Font = Enum.Font.Gotham
DiscordLinkText.Text = DISCORD_LINK
DiscordLinkText.TextColor3 = Color3.fromRGB(220, 225, 255)
DiscordLinkText.TextSize = 10
DiscordLinkText.TextXAlignment = Enum.TextXAlignment.Left

local CopyBtn = Instance.new("TextButton")
CopyBtn.Parent = DiscordCard
CopyBtn.Position = UDim2.new(1, -84, 0.5, -11)
CopyBtn.Size = UDim2.new(0, 74, 0, 22)
CopyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.Text = "📋 SAO CHÉP"
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.TextSize = 9
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 6)

CopyBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(DISCORD_LINK)
	end
	CopyBtn.Text = "✓ ĐÃ CHÉP"
	task.wait(1.5)
	CopyBtn.Text = "📋 SAO CHÉP"
end)

-- ==================== NÚT CHẠY SCRIPT ====================
local RunBtn = Instance.new("TextButton")
RunBtn.Parent = MainFrame
RunBtn.Position = UDim2.new(0, 12, 1, -34)
RunBtn.Size = UDim2.new(1, -24, 0, 28)
RunBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 35)
RunBtn.Font = Enum.Font.GothamBold
RunBtn.Text = "🚀 CHẠY SCRIPT"
RunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunBtn.TextSize = 12
Instance.new("UICorner", RunBtn).CornerRadius = UDim.new(1, 0)

RunBtn.MouseButton1Click:Connect(function()
	RunBtn.Text = "⏳ ĐANG TẢI " .. string.upper(SelectedHub) .. "..."
	
	-- Tối ưu hóa Fix Lag tối đa khi người dùng bật
	if FpsBoostEnabled then
		pcall(function()
			-- Giảm cấu hình đồ họa chung của Roblox
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
			UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.Level1
			
			-- Tắt hiệu ứng đổ bóng và ánh sáng nặng
			Lighting.GlobalShadows = false
			Lighting.Brightness = 1
			for _, v in pairs(Lighting:GetChildren()) do
				if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
					v:Destroy()
				end
			end
			
			-- Giảm tải hiệu ứng nước và các vật thể trong workspace
			if Workspace:FindFirstChildOfClass("Terrain") then
				Workspace.Terrain.WaterWaveSize = 0
				Workspace.Terrain.WaterWaveSpeed = 0
				Workspace.Terrain.WaterReflectance = 0
				Workspace.Terrain.WaterTransparency = 0
			end
			
			for _, obj in pairs(Workspace:GetDescendants()) do
				if obj:IsA("BasePart") then
					obj.CastShadow = false
				elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") then
					obj.Enabled = false
				end
			end
		end)
	end

	local targetCode = SCRIPTS[SelectedHub]
	task.spawn(function()
		local func, err = loadstring(targetCode)
		if func then
			func()
		else
			warn("Lỗi load script: " .. tostring(err))
		end
	end)

	task.wait(0.5)
	ScreenGui:Destroy()
end)
