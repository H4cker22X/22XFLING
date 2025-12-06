
local Targets = {}
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local AllBool = false

local GetPlayer = function(Name)
    Name = Name:lower()
    if Name == "all" or Name == "others" then
        AllBool = true
        return
    elseif Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers,Player) then
            table.remove(GetPlayers,table.find(GetPlayers,Player))
        end
        return GetPlayers[math.random(#GetPlayers)]
    elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
        for _,x in next, Players:GetPlayers() do
            if x ~= Player then
                if x.Name:lower():match("^"..Name) then
                    return x;
                elseif x.DisplayName:lower():match("^"..Name) then
                    return x;
                end
            end
        end
    else
        return
    end
end

local Message = function(_Title, _Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local SkidFling = function(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart
    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessory and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit and not AllBool then
            return Message("Error Occurred", "Targeting is sitting", 5)
        end

        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end

        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end

        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end

        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0
            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end

        workspace.FallenPartsDestroyHeight = 0/0
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            return Message("Error Occurred", "Target is missing everything", 5)
        end

        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid

        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        return Message("Error Occurred", "Random error", 5)
    end
end

-- GUI
do
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FlingControlUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui") or Player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 300, 0, 180)
    frame.Position = UDim2.new(0.7, 0, 0.2, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    frame.AnchorPoint = Vector2.new(0,0)

    local uiCorner = Instance.new("UICorner", frame)
    uiCorner.CornerRadius = UDim.new(0, 8)

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -12, 0, 30)
    title.Position = UDim2.new(0, 6, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "Fling GUI"
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local input = Instance.new("TextBox")
    input.Name = "TargetBox"
    input.Size = UDim2.new(1, -12, 0, 32)
    input.Position = UDim2.new(0, 6, 0, 42)
    input.PlaceholderText = "Enter target name/username"
    input.BackgroundColor3 = Color3.fromRGB(40,40,40)
    input.TextColor3 = Color3.fromRGB(255,255,255)
    input.ClearTextOnFocus = false
    input.Font = Enum.Font.SourceSans
    input.TextSize = 16
    input.Parent = frame

    local inputCorner = Instance.new("UICorner", input)
    inputCorner.CornerRadius = UDim.new(0,6)

    local attackBtn = Instance.new("TextButton")
    attackBtn.Name = "Attack"
    attackBtn.Size = UDim2.new(1, -12, 0, 34)
    attackBtn.Position = UDim2.new(0, 6, 0, 84)
    attackBtn.Text = "Attack"
    attackBtn.Font = Enum.Font.SourceSansBold
    attackBtn.TextSize = 16
    attackBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    attackBtn.TextColor3 = Color3.fromRGB(255,255,255)
    attackBtn.Parent = frame

    local allBtn = Instance.new("TextButton")
    allBtn.Name = "AllToggle"
    allBtn.Size = UDim2.new(1, -12, 0, 34)
    allBtn.Position = UDim2.new(0, 6, 0, 128)
    allBtn.Text = "Attack All: OFF"
    allBtn.Font = Enum.Font.SourceSansBold
    allBtn.TextSize = 16
    allBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    allBtn.TextColor3 = Color3.fromRGB(255,255,255)
    allBtn.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.Position = UDim2.new(1, -26, 0, 6)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.TextSize = 14
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextColor3 = Color3.fromRGB(255,100,100)
    closeBtn.Parent = frame

    local dragging = false
    local dragInput, dragStart, startPos
    local function update(inputPos)
        local delta = inputPos - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(inputObj)
        if inputObj.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = inputObj.Position
            startPos = frame.Position
            inputObj.Changed:Connect(function()
                if inputObj.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(inputObj)
        if inputObj.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = inputObj
        end
    end)

    UserInputService.InputChanged:Connect(function(inputObj)
        if inputObj == dragInput and dragging then
            update(inputObj.Position)
        end
    end)

    local allState = false

    allBtn.MouseButton1Click:Connect(function()
        allState = not allState
        allBtn.Text = allState and "Attack All: ON" or "Attack All: OFF"
    end)

    attackBtn.MouseButton1Click:Connect(function()
        local name = tostring(input.Text or "")
        if name == "" then
            return Message("Error", "Enter a target name", 4)
        end

        Targets = {name}
        AllBool = false

        if allState or name:lower() == "all" or name:lower() == "others" then
            AllBool = true
        end

        if AllBool then
            for _, pl in next, Players:GetPlayers() do
                if pl ~= Player then
                    pcall(function()
                        SkidFling(pl)
                    end)
                end
            end
            return
        end

        local target = GetPlayer(name)
        if target and target ~= Player then
            if target.UserId ~= 1414978355 then
                pcall(function()
                    SkidFling(target)
                end)
            else
                Message("Error Occurred", "This user is whitelisted! (Owner)", 5)
            end
        else
            Message("Error Occurred", "Username Invalid", 5)
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        screenGui.Enabled = false
    end)

    -- M key toggle GUI
    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.M then
            screenGui.Enabled = not screenGui.Enabled
        end
    end)
end

if not getgenv().Welcome then
    Message("Script by H4cker_22X", "Have fun!", 5)
end
getgenv().Welcome = true
