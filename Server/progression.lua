local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local existingGui = game:GetService("CoreGui"):FindFirstChild("progressBar")
if existingGui then
    existingGui:Destroy()
end

local progressionBar = {}

function progressionBar.new()
    local self = {}
    
    -- UI-Elemente erstellen
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "progressBar"
    screenGui.Parent = game:GetService("CoreGui")
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local mainContainer = Instance.new("ImageLabel")
    mainContainer.Name = "ProgressContainer"
    mainContainer.BackgroundTransparency = 1
    mainContainer.Position = UDim2.new(0, 10, 1, -30)
    mainContainer.Size = UDim2.new(0, 200, 0, 24)
    mainContainer.Image = "rbxassetid://2851926732"
    mainContainer.ImageColor3 = Color3.fromRGB(20, 21, 23)
    mainContainer.ScaleType = Enum.ScaleType.Slice
    mainContainer.SliceCenter = Rect.new(12, 12, 12, 12)
    mainContainer.Parent = screenGui
    
    local progressBar = Instance.new("ImageLabel")
    progressBar.Name = "ProgressBar"
    progressBar.BackgroundTransparency = 1
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.Image = "rbxassetid://2851926732"
    progressBar.ImageColor3 = Color3.fromRGB(41, 74, 122)
    progressBar.ScaleType = Enum.ScaleType.Slice
    progressBar.SliceCenter = Rect.new(12, 12, 12, 12)
    progressBar.Parent = mainContainer
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 8, 0, 0)
    titleLabel.Size = UDim2.new(0, 80, 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Progression"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = mainContainer
    
    local percentageLabel = Instance.new("TextLabel")
    percentageLabel.Name = "Percentage"
    percentageLabel.BackgroundTransparency = 1
    percentageLabel.Position = UDim2.new(0, 95, 0, 0)
    percentageLabel.Size = UDim2.new(1, -95, 1, 0)
    percentageLabel.Font = Enum.Font.GothamBold
    percentageLabel.Text = "0%"
    percentageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    percentageLabel.TextSize = 14
    percentageLabel.TextXAlignment = Enum.TextXAlignment.Left
    percentageLabel.Parent = mainContainer
    
    -- Status-Variablen
    local totalBlocks = 0
    local processedBlocks = 0
    local isVisible = true
    
    function self:Update(text)
        local progress = percentageLabel
        local progressBarFill = progressBar
        
        if typeof(text) == "number" then
            local percentage = math.clamp(text, 0, 100)
            progress.Text = string.format("%d%%", math.floor(percentage))
            progressBarFill.Size = UDim2.new(percentage / 100, 0, 1, 0)
        else
            progress.Text = tostring(text)
            progressBarFill.Size = UDim2.new(1, 0, 1, 0)
        end
    end
    
    function self:SetTotalBlocks(count)
        totalBlocks = count
        processedBlocks = 0
        self:Update(0)
    end
    
    function self:Increment()
        if totalBlocks > 0 then
            processedBlocks = processedBlocks + 1
            local percentage = (processedBlocks / totalBlocks) * 100
            self:Update(percentage)
        end
    end
    
    function self:SetVisibility(visible)
        isVisible = visible
        screenGui.Enabled = visible
    end
    
    function self:Destroy()
        screenGui:Destroy()
    end
    
    return self
end

return progressionBar
