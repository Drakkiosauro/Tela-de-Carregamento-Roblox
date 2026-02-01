local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Teams = game:GetService("Teams")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local controls = require(player.PlayerScripts:WaitForChild("PlayerModule")):GetControls()

ReplicatedFirst:RemoveDefaultLoadingScreen()
controls:Disable()
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

local selectedTeamName = ""

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PortfolioSystem"
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 10000
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.fromScale(1, 1)
mainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local loadContainer = Instance.new("Frame")
loadContainer.Size = UDim2.fromScale(1, 1)
loadContainer.BackgroundTransparency = 1
loadContainer.Parent = mainFrame

local centerFrame = Instance.new("Frame")
centerFrame.Size = UDim2.fromScale(0.4, 0.2)
centerFrame.Position = UDim2.fromScale(0.5, 0.5)
centerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
centerFrame.BackgroundTransparency = 1
centerFrame.Parent = loadContainer

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.fromScale(1, 0.3)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.Text = "INICIALIZANDO..."
statusLabel.Parent = centerFrame

local assetNameLabel = Instance.new("TextLabel")
assetNameLabel.Size = UDim2.fromScale(1, 0.2)
assetNameLabel.Position = UDim2.fromScale(0, 0.35)
assetNameLabel.BackgroundTransparency = 1
assetNameLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
assetNameLabel.TextSize = 10
assetNameLabel.Font = Enum.Font.Gotham
assetNameLabel.Text = ""
assetNameLabel.Parent = centerFrame

local barBg = Instance.new("Frame")
barBg.Size = UDim2.fromScale(1, 0.02)
barBg.Position = UDim2.fromScale(0, 0.6)
barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barBg.BorderSizePixel = 0
barBg.Parent = centerFrame

local barFill = Instance.new("Frame")
barFill.Size = UDim2.fromScale(0, 1)
barFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBg

local playButton = Instance.new("TextButton")
playButton.Size = UDim2.fromOffset(160, 45)
playButton.Position = UDim2.fromScale(0.5, 0.75)
playButton.AnchorPoint = Vector2.new(0.5, 0.5)
playButton.BackgroundTransparency = 1
playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
playButton.TextSize = 16
playButton.Font = Enum.Font.GothamBold
playButton.Text = "AVANÇAR"
playButton.Visible = false
playButton.TextTransparency = 1
playButton.Parent = loadContainer

local playStroke = Instance.new("UIStroke")
playStroke.Color = Color3.fromRGB(255, 255, 255)
playStroke.Thickness = 1
playStroke.Transparency = 1
playStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
playStroke.Parent = playButton

local teamContainer = Instance.new("Frame")
teamContainer.Size = UDim2.fromScale(1, 1)
teamContainer.BackgroundTransparency = 1
teamContainer.Visible = false
teamContainer.Parent = mainFrame

local teamTitle = Instance.new("TextLabel")
teamTitle.Size = UDim2.fromScale(1, 0.1)
teamTitle.Position = UDim2.fromScale(0, 0.15)
teamTitle.BackgroundTransparency = 1
teamTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
teamTitle.TextSize = 24
teamTitle.Font = Enum.Font.GothamBold
teamTitle.Text = "SELECIONE SEU TIME"
teamTitle.TextTransparency = 1
teamTitle.Parent = teamContainer

local cardsFrame = Instance.new("Frame")
cardsFrame.Size = UDim2.fromScale(0.6, 0.4)
cardsFrame.Position = UDim2.fromScale(0.5, 0.5)
cardsFrame.AnchorPoint = Vector2.new(0.5, 0.5)
cardsFrame.BackgroundTransparency = 1
cardsFrame.Parent = teamContainer

local finalPlayBtn = Instance.new("TextButton")
finalPlayBtn.Size = UDim2.fromOffset(200, 50)
finalPlayBtn.Position = UDim2.fromScale(0.5, 0.85)
finalPlayBtn.AnchorPoint = Vector2.new(0.5, 0.5)
finalPlayBtn.BackgroundTransparency = 1
finalPlayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
finalPlayBtn.TextSize = 18
finalPlayBtn.Font = Enum.Font.GothamBold
finalPlayBtn.Text = "ENTRAR NA PARTIDA"
finalPlayBtn.Visible = false
finalPlayBtn.TextTransparency = 1
finalPlayBtn.Parent = teamContainer

local finalStroke = Instance.new("UIStroke")
finalStroke.Color = Color3.fromRGB(255, 255, 255)
finalStroke.Thickness = 1.5
finalStroke.Transparency = 1
finalStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
finalStroke.Parent = finalPlayBtn

Instance.new("UICorner", playButton).CornerRadius = UDim.new(0, 6)
Instance.new("UICorner", finalPlayBtn).CornerRadius = UDim.new(0, 6)

local function createTeamCard(teamName, position)
	local card = Instance.new("TextButton")
	card.Size = UDim2.fromScale(0.45, 1)
	card.Position = position
	card.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	card.BackgroundTransparency = 1
	card.Text = ""
	card.Parent = cardsFrame
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(80, 80, 80)
	stroke.Thickness = 1
	stroke.Transparency = 1
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = card
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.fromScale(1, 0.3)
	nameLabel.Position = UDim2.fromScale(0, 0.2)
	nameLabel.BackgroundTransparency = 1
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.TextSize = 20
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.Text = teamName
	nameLabel.TextTransparency = 1
	nameLabel.Parent = card
	local countLabel = Instance.new("TextLabel")
	countLabel.Size = UDim2.fromScale(1, 0.2)
	countLabel.Position = UDim2.fromScale(0, 0.5)
	countLabel.BackgroundTransparency = 1
	countLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
	countLabel.TextSize = 14
	countLabel.Font = Enum.Font.Gotham
	countLabel.TextTransparency = 1
	countLabel.Parent = card
	task.spawn(function()
		while task.wait(0.5) do
			local t = Teams:FindFirstChild(teamName)
			if t then countLabel.Text = #t:GetPlayers() .. " JOGADORES" end
		end
	end)
	return card, stroke, nameLabel, countLabel
end

local card1, stroke1, name1, count1 = createTeamCard("TESTE1", UDim2.fromScale(0, 0))
local card2, stroke2, name2, count2 = createTeamCard("TESTE2", UDim2.fromScale(0.55, 0))

local function updateSelection(chosenCard, chosenStroke, chosenName, chosenCount, otherCard, otherStroke, otherName, otherCount)
	TweenService:Create(chosenCard, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0}):Play()
	TweenService:Create(chosenStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
	TweenService:Create(chosenName, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(0, 0, 0)}):Play()
	TweenService:Create(chosenCount, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(50, 50, 50)}):Play()
	TweenService:Create(otherCard, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(20, 20, 20), BackgroundTransparency = 0.5}):Play()
	TweenService:Create(otherStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(80, 80, 80), Transparency = 0}):Play()
	TweenService:Create(otherName, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(otherCount, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
	finalPlayBtn.Visible = true
	TweenService:Create(finalPlayBtn, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
	TweenService:Create(finalStroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
end

card1.MouseButton1Click:Connect(function()
	selectedTeamName = "TESTE1"
	updateSelection(card1, stroke1, name1, count1, card2, stroke2, name2, count2)
end)

card2.MouseButton1Click:Connect(function()
	selectedTeamName = "TESTE2"
	updateSelection(card2, stroke2, name2, count2, card1, stroke1, name1, count1)
end)

task.spawn(function()
	local assets = game:GetDescendants()
	local total = #assets
	local loaded = 0

	for i, asset in ipairs(assets) do
		ContentProvider:PreloadAsync({asset})
		loaded = i
		local progress = loaded / total
		barFill.Size = UDim2.fromScale(progress, 1)
		statusLabel.Text = "CARREGANDO: " .. math.floor(progress * 100) .. "%"
		assetNameLabel.Text = "BAIXANDO: " .. asset.Name
		if i % 10 == 0 then task.wait() end
	end

	assetNameLabel.Text = ""
	statusLabel.Text = "CARREGAMENTO COMPLETO"
	task.wait(0.5)
	playButton.Visible = true
	TweenService:Create(playButton, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
	TweenService:Create(playStroke, TweenInfo.new(0.5), {Transparency = 0}):Play()
end)

playButton.MouseButton1Click:Connect(function()
	loadContainer:Destroy()
	teamContainer.Visible = true
	TweenService:Create(teamTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
	TweenService:Create(card1, TweenInfo.new(0.5), {BackgroundTransparency = 0.5}):Play()
	TweenService:Create(card2, TweenInfo.new(0.5), {BackgroundTransparency = 0.5}):Play()
	TweenService:Create(stroke1, TweenInfo.new(0.5), {Transparency = 0}):Play()
	TweenService:Create(stroke2, TweenInfo.new(0.5), {Transparency = 0}):Play()
	TweenService:Create(name1, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
	TweenService:Create(name2, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
	TweenService:Create(count1, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
	TweenService:Create(count2, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
end)

finalPlayBtn.MouseButton1Click:Connect(function()
	if selectedTeamName == "" then return end
	local event = ReplicatedStorage:WaitForChild("SetTeamEvent")
	event:FireServer(selectedTeamName)
	local slide = TweenService:Create(mainFrame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {Position = UDim2.fromScale(0, -1)})
	slide:Play()
	slide.Completed:Connect(function()
		controls:Enable()
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
		screenGui:Destroy()
	end)
end)
