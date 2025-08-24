local existingGui = game:GetService("CoreGui"):FindFirstChild("progressBar")
if existingGui then
    existingGui:Destroy()
end

-- Create simple progress bar
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

local progressBarFill = Instance.new("ImageLabel")
progressBarFill.Name = "ProgressBar"
progressBarFill.BackgroundTransparency = 1
progressBarFill.Size = UDim2.new(0, 0, 1, 0)
progressBarFill.Image = "rbxassetid://2851926732"
progressBarFill.ImageColor3 = Color3.fromRGB(176, 27, 16)
progressBarFill.ScaleType = Enum.ScaleType.Slice
progressBarFill.SliceCenter = Rect.new(12, 12, 12, 12)
progressBarFill.Parent = mainContainer

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

-- Progress bar functions
local progressionBar = {}
local totalBlocks = 0
local processedBlocks = 0

function progressionBar:Update(value)
    if typeof(value) == "number" then
        local percentage = math.clamp(value, 0, 100)
        percentageLabel.Text = string.format("%d%%", math.floor(percentage))
        progressBarFill.Size = UDim2.new(percentage / 100, 0, 1, 0)
    else
        percentageLabel.Text = tostring(value)
    end
end

function progressionBar:SetTotalBlocks(count)
    totalBlocks = count
    processedBlocks = 0
    self:Update(0)
end

function progressionBar:Increment()
    if totalBlocks > 0 then
        processedBlocks = processedBlocks + 1
        local percentage = (processedBlocks / totalBlocks) * 100
        self:Update(percentage)
    end
end

function progressionBar:Reset()
    totalBlocks = 0
    processedBlocks = 0
    self:Update(0)
    return self
end

function progressionBar:Destroy()
    screenGui:Destroy()
end

return progressionBar
