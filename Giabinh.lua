-- Gui to Lua (Hirose - CHILLI x VENYX Loader Size 300 & Fixed Image BG)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

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

-- Hàm Fix Lag chuyên sâu khi load script
local function ApplyFixLag()
	pcall(function()
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 9e9
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		
		if Terrain then
			Terrain.WaterWaveSize = 0
			Terrain.WaterWaveTransparency = 1
			Terrain.WaterReflectance = 0
		end
		
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Material = Enum.Material.SmoothPlastic
				v.Reflectance = 0
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
				v.Enabled = false
			end
		end
	end)
end

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HiroseHubLoader"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Khung chính (Size ngang 300)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 410)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(70, 70, 85)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Hình nền Roblox (Dùng Stretch để hiển thị chuẩn xác không bị đen)
local BgImage = Instance.new("ImageLabel")
BgImage.Parent = MainFrame
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.Image = "rbxassetid://139482010748688"
BgImage.ScaleType = Enum.ScaleType.Stretch
BgImage.ZIndex = 0

-- Kéo thả cửa sổ
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
TopBar.ZIndex = 2

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TopBar
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.Size = UDim2.new(0, 160, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "🌶️ CHILLI x VENYX"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 12
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 2

local VersionBadge = Instance.new("TextLabel")
VersionBadge.Parent = TopBar
VersionBadge.Position = UDim2.new(1, -86, 0.5, -9)
VersionBadge.Size = UDim2.new(0, 48, 0, 18)
VersionBadge.BackgroundColor3 = Color3.fromRGB(50, 30, 20)
VersionBadge.Font = Enum.Font.GothamBold
VersionBadge.Text = "v11.0"
VersionBadge.TextColor3 = Color3.fromRGB(255, 140, 50)
VersionBadge.TextSize = 9
VersionBadge.ZIndex = 2
Instance.new("UICorner", VersionBadge).CornerRadius = UDim.new(1, 0)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.Position = UDim2.new(1, -30, 0.5, -10)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(220, 220, 230)
CloseBtn.TextSize = 10
CloseBtn.ZIndex = 2
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- ==================== PROFILE CARD (HIROSE) ====================
local ProfileCard = Instance.new("Frame")
ProfileCard.Parent = MainFrame
ProfileCard.Position = UDim2.new(0, 8, 0, 38)
ProfileCard.Size = UDim2.new(1, -16, 0, 56)
ProfileCard.BackgroundColor3 = Color3.fromRGB(25, 12, 14)
ProfileCard.BackgroundTransparency = 0.4
ProfileCard.ZIndex = 2
local ProfileStroke = Instance.new("UIStroke", ProfileCard)
ProfileStroke.Color = Color3.fromRGB(120, 45, 45)
Instance.new("UICorner", ProfileCard).CornerRadius = UDim.new(0, 8)

local IconBox = Instance.new("TextLabel")
IconBox.Parent = ProfileCard
IconBox.Position = UDim2.new(0, 8, 0.5, -16)
IconBox.Size = UDim2.new(0, 32, 0, 32)
IconBox.BackgroundColor3 = Color3.fromRGB(60, 25, 28)
IconBox.Text = "🌶️"
IconBox.TextSize = 18
IconBox.ZIndex = 2
Instance.new("UICorner", IconBox).CornerRadius = UDim.new(0, 6)

local NameLabel = Instance.new("TextLabel")
NameLabel.Parent = ProfileCard
NameLabel.Position = UDim2.new(0, 46, 0, 6)
NameLabel.Size = UDim2.new(1, -54, 0, 15)
NameLabel.BackgroundTransparency = 1
NameLabel.Font = Enum.Font.GothamBold
NameLabel.Text = "Hirose"
NameLabel.TextColor3 = Color3.fromRGB(255, 190, 120)
NameLabel.TextSize = 12
NameLabel.TextXAlignment = Enum.TextXAlignment.Left
NameLabel.ZIndex = 2

local SubLabel = Instance.new("TextLabel")
SubLabel.Parent = ProfileCard
SubLabel.Position = UDim2.new(0, 46, 0, 21)
SubLabel.Size = UDim2.new(1, -54, 0, 14)
SubLabel.BackgroundTransparency = 1
SubLabel.Font = Enum.Font.Gotham
SubLabel.Text = "Finder Free chuẩn cao · Giảm lag ⚡"
SubLabel.TextColor3 = Color3.fromRGB(210, 210, 220)
SubLabel.TextSize = 9
SubLabel.TextXAlignment = Enum.TextXAlignment.Left
SubLabel.ZIndex = 2

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = ProfileCard
StatusLabel.Position = UDim2.new(0, 46, 0, 35)
StatusLabel.Size = UDim2.new(1, -54, 0, 14)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Text = "● Sẵn sàng · Delta"
StatusLabel.TextColor3 = Color3.fromRGB(90, 240, 140)
StatusLabel.TextSize = 9
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.ZIndex = 2

-- ==================== TÍNH NĂNG MỚI V11 ====================
local VirexCard = Instance.new("Frame")
VirexCard.Parent = MainFrame
VirexCard.Position = UDim2.new(0, 8, 0, 100)
VirexCard.Size = UDim2.new(1, -16, 0, 38)
VirexCard.BackgroundColor3 = Color3.fromRGB(12, 35, 26)
VirexCard.BackgroundTransparency = 0.4
VirexCard.ZIndex = 2
local VirexStroke = Instance.new("UIStroke", VirexCard)
VirexStroke.Color = Color3.fromRGB(40, 110, 80)
Instance.new("UICorner", VirexCard).CornerRadius = UDim.new(0, 8)

local VirexName = Instance.new("TextLabel")
VirexName.Parent = VirexCard
VirexName.Position = UDim2.new(0, 8, 0, 5)
VirexName.Size = UDim2.new(0, 150, 0, 14)
VirexName.BackgroundTransparency = 1
VirexName.Font = Enum.Font.GothamBold
VirexName.Text = "🔍 VIREX - FINDER"
VirexName.TextColor3 = Color3.fromRGB(100, 255, 180)
VirexName.TextSize = 10
VirexName.TextXAlignment = Enum.TextXAlignment.Left
VirexName.ZIndex = 2

local VirexDesc = Instance.new("TextLabel")
VirexDesc.Parent = VirexCard
VirexDesc.Position = UDim2.new(0, 8, 0, 19)
VirexDesc.Size = UDim2.new(0, 150, 0, 14)
VirexDesc.BackgroundTransparency = 1
VirexDesc.Font = Enum.Font.Gotham
VirexDesc.Text = "Tính năng nổi bật V11"
VirexDesc.TextColor3 = Color3.fromRGB(180, 210, 195)
VirexDesc.TextSize = 8
VirexDesc.TextXAlignment = Enum.TextXAlignment.Left
VirexDesc.ZIndex = 2

local RateBadge = Instance.new("TextLabel")
RateBadge.Parent = VirexCard
RateBadge.Position = UDim2.new(1, -100, 0.5, -10)
RateBadge.Size = UDim2.new(0, 92, 0, 20)
RateBadge.BackgroundColor3 = Color3.fromRGB(30, 80, 60)
RateBadge.Font = Enum.Font.GothamBold
RateBadge.Text = "✨ CHUẨN CAO"
RateBadge.TextColor3 = Color3.fromRGB(120, 255, 190)
RateBadge.TextSize = 8
RateBadge.ZIndex = 2
Instance.new("UICorner", RateBadge).CornerRadius = UDim.new(1, 0)

-- ==================== CHỌN HUB ====================
local Sec2Title = Instance.new("TextLabel")
Sec2Title.Parent = MainFrame
Sec2Title.Position = UDim2.new(0, 10, 0, 144)
Sec2Title.Size = UDim2.new(0, 90, 0, 18)
Sec2Title.BackgroundTransparency = 1
Sec2Title.Font = Enum.Font.GothamBold
Sec2Title.Text = "🎮 CHỌN HUB"
Sec2Title.TextColor3 = Color3.fromRGB(240, 240, 250)
Sec2Title.TextSize = 10
Sec2Title.TextXAlignment = Enum.TextXAlignment.Left
Sec2Title.ZIndex = 2

local SoundBtn = Instance.new("TextButton")
SoundBtn.Parent = MainFrame
SoundBtn.Position = UDim2.new(1, -110, 0, 143)
SoundBtn.Size = UDim2.new(0, 102, 0, 18)
SoundBtn.BackgroundColor3 = Color3.fromRGB(32, 140, 78)
SoundBtn.Font = Enum.Font.GothamBold
SoundBtn.Text = "🔊 ÂM THANH: BẬT"
SoundBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SoundBtn.TextSize = 8
SoundBtn.ZIndex = 2
Instance.new("UICorner", SoundBtn).CornerRadius = UDim.new(1, 0)

SoundBtn.MouseButton1Click:Connect(function()
	SoundEnabled = not SoundEnabled
	SoundBtn.Text = SoundEnabled and "🔊 ÂM THANH: BẬT" or "🔇 ÂM THANH: TẮT"
	SoundBtn.BackgroundColor3 = SoundEnabled and Color3.fromRGB(32, 140, 78) or Color3.fromRGB(60, 60, 70)
end)

-- Container 2 nút chọn menu
local HubContainer = Instance.new("Frame")
HubContainer.Parent = MainFrame
HubContainer.Position = UDim2.new(0, 8, 0, 164)
HubContainer.Size = UDim2.new(1, -16, 0, 80)
HubContainer.BackgroundTransparency = 1
HubContainer.ZIndex = 2

local function CreateHubCard(name, pos, icon, title, subtitle)
	local Card = Instance.new("TextButton")
	Card.Name = name
	Card.Parent = HubContainer
	Card.Position = pos
	Card.Size = UDim2.new(0.485, 0, 1, 0)
	Card.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
	Card.BackgroundTransparency = 0.4
	Card.Text = ""
	Card.AutoButtonColor = false
	Card.ZIndex = 2
	Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

	local Stroke = Instance.new("UIStroke", Card)
	Stroke.Name = "Stroke"
	Stroke.Color = Color3.fromRGB(70, 70, 85)
	Stroke.Thickness = 1.2

	local Icon = Instance.new("TextLabel")
	Icon.Parent = Card
	Icon.Position = UDim2.new(0, 8, 0, 6)
	Icon.Size = UDim2.new(0, 24, 0, 24)
	Icon.BackgroundTransparency = 1
	Icon.Text = icon
	Icon.TextSize = 16
	Icon.ZIndex = 2

	local Title = Instance.new("TextLabel")
	Title.Parent = Card
	Title.Position = UDim2.new(0, 36, 0, 6)
	Title.Size = UDim2.new(1, -44, 0, 14)
	Title.BackgroundTransparency = 1
	Title.Font = Enum.Font.GothamBold
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 11
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 2

	local Sub = Instance.new("TextLabel")
	Sub.Parent = Card
	Sub.Position = UDim2.new(0, 36, 0, 20)
	Sub.Size = UDim2.new(1, -44, 0, 14)
	Sub.BackgroundTransparency = 1
	Sub.Font = Enum.Font.Gotham
	Sub.Text = subtitle
	Sub.TextColor3 = Color3.fromRGB(190, 190, 205)
	Sub.TextSize = 9
	Sub.TextXAlignment = Enum.TextXAlignment.Left
	Sub.ZIndex = 2

	local StatusPill = Instance.new("TextLabel")
	StatusPill.Name = "StatusPill"
	StatusPill.Parent = Card
	StatusPill.Position = UDim2.new(0, 6, 1, -26)
	StatusPill.Size = UDim2.new(1, -12, 0, 20)
	StatusPill.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
	StatusPill.Font = Enum.Font.GothamBold
	StatusPill.Text = "Chọn"
	StatusPill.TextColor3 = Color3.fromRGB(220, 220, 230)
	StatusPill.TextSize = 9
	StatusPill.ZIndex = 2
	Instance.new("UICorner", StatusPill).CornerRadius = UDim.new(0, 5)

	return Card
end

local ChilliCard = CreateHubCard("ChilliCard", UDim2.new(0, 0, 0, 0), "🔥", "Chilli", "VIP")
local VenyxCard = CreateHubCard("VenyxCard", UDim2.new(0.515, 0, 0, 0), "⚡", "Venyx", "Hub 2")

local function UpdateHubSelection()
	if SelectedHub == "Chilli" then
		ChilliCard.BackgroundColor3 = Color3.fromRGB(75, 30, 22)
		ChilliCard.Stroke.Color = Color3.fromRGB(255, 255, 255)
		ChilliCard.Stroke.Thickness = 1.5
		ChilliCard.StatusPill.BackgroundColor3 = Color3.fromRGB(245, 100, 50)
		ChilliCard.StatusPill.TextColor3 = Color3.fromRGB(255, 255, 255)
		ChilliCard.StatusPill.Text = "✓ CHỌN"

		VenyxCard.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
		VenyxCard.Stroke.Color = Color3.fromRGB(70, 70, 85)
		VenyxCard.Stroke.Thickness = 1.2
		VenyxCard.StatusPill.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
		VenyxCard.StatusPill.TextColor3 = Color3.fromRGB(220, 220, 230)
		VenyxCard.StatusPill.Text = "Chọn"
	else
		VenyxCard.BackgroundColor3 = Color3.fromRGB(38, 35, 78)
		VenyxCard.Stroke.Color = Color3.fromRGB(255, 255, 255)
		VenyxCard.Stroke.Thickness = 1.5
		VenyxCard.StatusPill.BackgroundColor3 = Color3.fromRGB(110, 100, 255)
		VenyxCard.StatusPill.TextColor3 = Color3.fromRGB(255, 255, 255)
		VenyxCard.StatusPill.Text = "✓ CHỌN"

		ChilliCard.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
		ChilliCard.Stroke.Color = Color3.fromRGB(70, 70, 85)
		ChilliCard.Stroke.Thickness = 1.2
		ChilliCard.StatusPill.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
		ChilliCard.StatusPill.TextColor3 = Color3.fromRGB(220, 220, 230)
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
FpsCard.Position = UDim2.new(0, 8, 0, 250)
FpsCard.Size = UDim2.new(1, -16, 0, 36)
FpsCard.BackgroundColor3 = Color3.fromRGB(20, 28, 35)
FpsCard.BackgroundTransparency = 0.4
FpsCard.ZIndex = 2
Instance.new("UICorner", FpsCard).CornerRadius = UDim.new(0, 8)

local FpsTitle = Instance.new("TextLabel")
FpsTitle.Parent = FpsCard
FpsTitle.Position = UDim2.new(0, 8, 0, 4)
FpsTitle.Size = UDim2.new(0, 160, 0, 14)
FpsTitle.BackgroundTransparency = 1
FpsTitle.Font = Enum.Font.GothamBold
FpsTitle.Text = "🌙 FPS Boost & Fix Lag"
FpsTitle.TextColor3 = Color3.fromRGB(240, 240, 250)
FpsTitle.TextSize = 10
FpsTitle.TextXAlignment = Enum.TextXAlignment.Left
FpsTitle.ZIndex = 2

local FpsSub = Instance.new("TextLabel")
FpsSub.Parent = FpsCard
FpsSub.Position = UDim2.new(0, 8, 0, 18)
FpsSub.Size = UDim2.new(0, 180, 0, 14)
FpsSub.BackgroundTransparency = 1
FpsSub.Font = Enum.Font.Gotham
FpsSub.Text = "Tối ưu hóa game cực mượt"
FpsSub.TextColor3 = Color3.fromRGB(180, 180, 195)
FpsSub.TextSize = 8
FpsSub.TextXAlignment = Enum.TextXAlignment.Left
FpsSub.ZIndex = 2

local FpsBtn = Instance.new("TextButton")
FpsBtn.Parent = FpsCard
FpsBtn.Position = UDim2.new(1, -52, 0.5, -10)
FpsBtn.Size = UDim2.new(0, 44, 0, 20)
FpsBtn.BackgroundColor3 = Color3.fromRGB(32, 150, 85)
FpsBtn.Font = Enum.Font.GothamBold
FpsBtn.Text = "BẬT"
FpsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FpsBtn.TextSize = 9
FpsBtn.ZIndex = 2
Instance.new("UICorner", FpsBtn).CornerRadius = UDim.new(1, 0)

FpsBtn.MouseButton1Click:Connect(function()
	FpsBoostEnabled = not FpsBoostEnabled
	FpsBtn.Text = FpsBoostEnabled and "BẬT" or "TẮT"
	FpsBtn.BackgroundColor3 = FpsBoostEnabled and Color3.fromRGB(32, 150, 85) or Color3.fromRGB(60, 60, 70)
end)

-- ==================== DISCORD CARD ====================
local DiscordCard = Instance.new("Frame")
DiscordCard.Parent = MainFrame
DiscordCard.Position = UDim2.new(0, 8, 0, 290)
DiscordCard.Size = UDim2.new(1, -16, 0, 36)
DiscordCard.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
DiscordCard.BackgroundTransparency = 0.4
DiscordCard.ZIndex = 2
local DiscordStroke = Instance.new("UIStroke", DiscordCard)
DiscordStroke.Color = Color3.fromRGB(80, 80, 150)
Instance.new("UICorner", DiscordCard).CornerRadius = UDim.new(0, 8)

local DiscordTitle = Instance.new("TextLabel")
DiscordTitle.Parent = DiscordCard
DiscordTitle.Position = UDim2.new(0, 8, 0, 4)
DiscordTitle.Size = UDim2.new(0, 150, 0, 14)
DiscordTitle.BackgroundTransparency = 1
DiscordTitle.Font = Enum.Font.GothamBold
DiscordTitle.Text = "💬 DISCORD"
DiscordTitle.TextColor3 = Color3.fromRGB(160, 170, 255)
DiscordTitle.TextSize = 9
DiscordTitle.TextXAlignment = Enum.TextXAlignment.Left
DiscordTitle.ZIndex = 2

local DiscordLinkText = Instance.new("TextLabel")
DiscordLinkText.Parent = DiscordCard
DiscordLinkText.Position = UDim2.new(0, 8, 0, 18)
DiscordLinkText.Size = UDim2.new(0, 170, 0, 14)
DiscordLinkText.BackgroundTransparency = 1
DiscordLinkText.Font = Enum.Font.Gotham
DiscordLinkText.Text = DISCORD_LINK
DiscordLinkText.TextColor3 = Color3.fromRGB(230, 235, 255)
DiscordLinkText.TextSize = 9
DiscordLinkText.TextXAlignment = Enum.TextXAlignment.Left
DiscordLinkText.ZIndex = 2

local CopyBtn = Instance.new("TextButton")
CopyBtn.Parent = DiscordCard
CopyBtn.Position = UDim2.new(1, -74, 0.5, -10)
CopyBtn.Size = UDim2.new(0, 66, 0, 20)
CopyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.Text = "📋 SAO CHÉP"
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.TextSize = 8
CopyBtn.ZIndex = 2
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 5)

CopyBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(DISCORD_LINK)
	end
	CopyBtn.Text = "✓ CHÉP"
	task.wait(1.5)
	CopyBtn.Text = "📋 SAO CHÉP"
end)

-- ==================== NÚT CHẠY SCRIPT ====================
local RunBtn = Instance.new("TextButton")
RunBtn.Parent = MainFrame
RunBtn.Position = UDim2.new(0, 8, 1, -32)
RunBtn.Size = UDim2.new(1, -16, 0, 26)
RunBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 35)
RunBtn.Font = Enum.Font.GothamBold
RunBtn.Text = "🚀 CHẠY SCRIPT"
RunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunBtn.TextSize = 11
RunBtn.ZIndex = 2
Instance.new("UICorner", RunBtn).CornerRadius = UDim.new(1, 0)

RunBtn.MouseButton1Click:Connect(function()
	RunBtn.Text = "⏳ ĐANG TẢI & FIX LAG..."
	
	if FpsBoostEnabled then
		ApplyFixLag()
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
