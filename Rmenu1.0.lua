-- Função para executar o hack 1
local function hack1()
    print("Hack 1 ativado!")
    local isFlying = false
    local flySpeed = 50 -- Velocidade de voo inicial
    local menuOpen = false
    local collidedObjects = {} -- Armazena os objetos que tinham colisão ativa

    local player = game.Players.LocalPlayer
    local rootPart = player.Character.HumanoidRootPart
    local camera = workspace.CurrentCamera

    -- Função para criar o menu de ajuste de velocidade de voo
    local function createMenu()
        local gui = Instance.new("ScreenGui")
        gui.Parent = player.PlayerGui

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.2, 0, 0.4, 0)
        frame.Position = UDim2.new(0.4, 0, 0.3, 0)
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.BorderSizePixel = 2
        frame.BorderColor3 = Color3.new(1, 1, 1)
        frame.Visible = false
        frame.Parent = gui

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
        titleLabel.Position = UDim2.new(0, 0, 0, 0)
        titleLabel.Text = "Rfly"
        titleLabel.TextColor3 = Color3.new(1, 1, 1)
        titleLabel.BackgroundColor3 = Color3.new(0, 0, 0)
        titleLabel.BorderSizePixel = 0
        titleLabel.Font = Enum.Font.SourceSansBold -- Texto em negrito
        titleLabel.TextSize = 24 -- Tamanho do texto aumentado
        titleLabel.Parent = frame

        local speedLabel = Instance.new("TextLabel")
        speedLabel.Size = UDim2.new(1, 0, 0.1, 0)
        speedLabel.Position = UDim2.new(0, 0, 0.1, 0)
        speedLabel.Text = "Speed: " .. flySpeed
        speedLabel.TextColor3 = Color3.new(1, 1, 1)
        speedLabel.BackgroundColor3 = Color3.new(0, 0, 0)
        speedLabel.BorderSizePixel = 0
        speedLabel.Parent = frame

        local increaseButton = Instance.new("TextButton")
        increaseButton.Size = UDim2.new(0.8, 0, 0.15, 0)
        increaseButton.Position = UDim2.new(0.1, 0, 0.3, 0)
        increaseButton.Text = "Increase"
        increaseButton.TextColor3 = Color3.new(1, 1, 1)
        increaseButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        increaseButton.BorderSizePixel = 0
        increaseButton.Parent = frame
        increaseButton.MouseButton1Click:Connect(function()
            flySpeed = flySpeed + 10
            speedLabel.Text = "Speed: " .. flySpeed
        end)

        local decreaseButton = Instance.new("TextButton")
        decreaseButton.Size = UDim2.new(0.8, 0, 0.15, 0)
        decreaseButton.Position = UDim2.new(0.1, 0, 0.5, 0)
        decreaseButton.Text = "Decrease"
        decreaseButton.TextColor3 = Color3.new(1, 1, 1)
        decreaseButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        decreaseButton.BorderSizePixel = 0
        decreaseButton.Parent = frame
        decreaseButton.MouseButton1Click:Connect(function()
            flySpeed = math.max(10, flySpeed - 10)
            speedLabel.Text = "Speed: " .. flySpeed
        end)

        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0.8, 0, 0.15, 0)
        closeButton.Position = UDim2.new(0.1, 0, 0.7, 0)
        closeButton.Text = "Close Menu"
        closeButton.TextColor3 = Color3.new(1, 1, 1)
        closeButton.BackgroundColor3 = Color3.new(0.8, 0, 0)
        closeButton.BorderSizePixel = 0
        closeButton.Parent = frame
        closeButton.MouseButton1Click:Connect(function()
            frame.Visible = false
            menuOpen = false
        end)

        return gui
    end

    local menuGui = createMenu()

    -- Desativa a colisão dos objetos que tinham colisão ativa
    local function disableCollision()
        for _, object in pairs(workspace:GetDescendants()) do
            if object:IsA("BasePart") and object.CanCollide then
                object.CanCollide = false
                table.insert(collidedObjects, object)
            end
        end
    end

    -- Ativa a colisão dos objetos que foram desativados pelo script
    local function enableCollision()
        for _, object in pairs(collidedObjects) do
            object.CanCollide = true
        end
        collidedObjects = {} 
    end

    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.F then
            isFlying = not isFlying
            if isFlying then
                disableCollision()
                -- Desativa a gravidade ao ativar o modo de voo
                player.Character.HumanoidRootPart.Anchored = true
            else
                enableCollision()
                -- Ativa a gravidade ao desativar o modo de voo
                player.Character.HumanoidRootPart.Anchored = false
            end
        elseif input.KeyCode == Enum.KeyCode.M then
            menuOpen = not menuOpen
            menuGui.Frame.Visible = menuOpen
        end
    end)

game:GetService("RunService").Stepped:Connect(function()
    if isFlying then
        local moveVector = Vector3.new(0, 0, 0)
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
            moveVector = moveVector + camera.CFrame.lookVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
            moveVector = moveVector - camera.CFrame.lookVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
            moveVector = moveVector - camera.CFrame.rightVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
            moveVector = moveVector + camera.CFrame.rightVector
        end

        -- Normaliza o vetor de movimento para manter a mesma velocidade em todas as direções
        if moveVector.Magnitude > 0 then
            moveVector = moveVector.unit * flySpeed
        end

        rootPart.Velocity = moveVector
    end

    -- Atualiza a propriedade Anchored fora das condições
    if isFlying then
        player.Character.HumanoidRootPart.Anchored = true
    else
        player.Character.HumanoidRootPart.Anchored = false
    end
end)

end

-- Função para executar o hack 2
local function hack2()
    print("Hack 2 ativado!")

    local player = game.Players.LocalPlayer
    local originalID = player.UserId
    local originalNameVisibility = true
    local menuOpen = false

    -- Função para criar o menu de alteração de ID e visibilidade do nome
    local function createMenu()
        local gui = Instance.new("ScreenGui")
        gui.Parent = player.PlayerGui

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.2, 0, 0.2, 0)
        frame.Position = UDim2.new(0.4, 0, 0.3, 0)
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.BorderSizePixel = 2
        frame.BorderColor3 = Color3.new(1, 1, 1)
        frame.Visible = false
        frame.Parent = gui

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
        titleLabel.Position = UDim2.new(0, 0, 0, 0)
        titleLabel.Text = "Player Settings"
        titleLabel.TextColor3 = Color3.new(1, 1, 1)
        titleLabel.BackgroundColor3 = Color3.new(0, 0, 0)
        titleLabel.BorderSizePixel = 0
        titleLabel.Font = Enum.Font.SourceSansBold
        titleLabel.TextSize = 18
        titleLabel.Parent = frame

        local changeIDButton = Instance.new("TextButton")
        changeIDButton.Size = UDim2.new(0.8, 0, 0.2, 0)
        changeIDButton.Position = UDim2.new(0.1, 0, 0.3, 0)
        changeIDButton.Text = "Change ID"
        changeIDButton.TextColor3 = Color3.new(1, 1, 1)
        changeIDButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        changeIDButton.BorderSizePixel = 0
        changeIDButton.Parent = frame
        changeIDButton.MouseButton1Click:Connect(function()
            local newID = math.random(1000000000, 9999999999)
            player.UserId = newID
        end)

        local toggleNameVisibilityButton = Instance.new("TextButton")
        toggleNameVisibilityButton.Size = UDim2.new(0.8, 0, 0.2, 0)
        toggleNameVisibilityButton.Position = UDim2.new(0.1, 0, 0.6, 0)
        toggleNameVisibilityButton.Text = "Toggle Name Visibility"
        toggleNameVisibilityButton.TextColor3 = Color3.new(1, 1, 1)
        toggleNameVisibilityButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        toggleNameVisibilityButton.BorderSizePixel = 0
        toggleNameVisibilityButton.Parent = frame
        toggleNameVisibilityButton.MouseButton1Click:Connect(function()
            if originalNameVisibility then
                player.Character:WaitForChild("Head").NameDisplayDistance = 0
                originalNameVisibility = false
            else
                player.Character:WaitForChild("Head").NameDisplayDistance = 100
                originalNameVisibility = true
            end
        end)

        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0.8, 0, 0.1, 0)
        closeButton.Position = UDim2.new(0.1, 0, 0.9, 0)
        closeButton.Text = "Close Menu"
        closeButton.TextColor3 = Color3.new(1, 1, 1)
        closeButton.BackgroundColor3 = Color3.new(0.8, 0, 0)
        closeButton.BorderSizePixel = 0
        closeButton.Parent = frame
        closeButton.MouseButton1Click:Connect(function()
            frame.Visible = false
            menuOpen = false
        end)

        return gui
    end

    local menuGui = createMenu()

    -- Função para abrir/fechar o menu
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.M then
            menuOpen = not menuOpen
            menuGui.Frame.Visible = menuOpen
        end
    end)

end

-- Função para executar o hack 3
local function hack3()
    -- Script em Lua para Roblox (hack) que cria um UI com botões para abrir diferentes menus, com opção de fechar
    -- Este script é invasivo e pode violar os termos de serviço do Roblox

    -- Pega o jogador local
    local player = game.Players.LocalPlayer

    -- Função para criar o menu de copiar skins de outros jogadores
    local function createCopySkinMenu()
        -- Cria uma tela de GUI
        local gui = Instance.new("ScreenGui")
        gui.Parent = player.PlayerGui
    
        -- Define a cor roxa para todos os menus
        local backgroundColor = Color3.fromRGB(128, 0, 128)
    
        -- Cria o frame do menu
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.5, 0, 0.8, 0)
        frame.Position = UDim2.new(0.25, 0, 0.1, 0)
        frame.BackgroundColor3 = backgroundColor
        frame.BorderSizePixel = 2
        frame.Parent = gui
    
        -- Cria botão de fechar
        local closeButton = Instance.new("TextButton")
        closeButton.Text = "Fechar"
        closeButton.TextColor3 = Color3.new(1, 1, 1)
        closeButton.TextSize = 20
        closeButton.Font = Enum.Font.SourceSans
        closeButton.Position = UDim2.new(0, 0, 0.95, 0)
        closeButton.Size = UDim2.new(1, 0, 0.05, 0)
        closeButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        closeButton.BorderSizePixel = 0
        closeButton.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)
        closeButton.Parent = frame
    
        -- Cria o scrollFrame para listar os jogadores
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Size = UDim2.new(0.9, 0, 0.8, 0)
        scrollFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
        scrollFrame.CanvasSize = UDim2.new(0, 0, 5, 0) -- Defina a altura conforme necessário
        scrollFrame.Parent = frame
    
        -- Função para copiar a aparência de um jogador
        local function copySkin(playerToCopy)
            local targetPlayer = game.Players:FindFirstChild(playerToCopy)
            if targetPlayer then
                -- Pega o personagem do jogador alvo
                local targetCharacter = targetPlayer.Character or targetPlayer.CharacterAdded:Wait()
                local targetHumanoid = targetCharacter:WaitForChild("Humanoid")
        
                -- Pega o personagem do jogador local
                local localCharacter = player.Character or player.CharacterAdded:Wait()
                local localHumanoid = localCharacter:WaitForChild("Humanoid")
        
                -- Limpa a aparência do jogador local
                for _,v in pairs(localCharacter:GetChildren()) do
                    if v:IsA("Accessory") or v:IsA("Clothing") or v:IsA("CharacterMesh") then
                        v:Destroy()
                    end
                end
        
                -- Copia a aparência do jogador alvo para o jogador local
                for _,v in pairs(targetCharacter:GetChildren()) do
                    if v:IsA("Accessory") or v:IsA("Clothing") or v:IsA("CharacterMesh") then
                        v:Clone().Parent = localCharacter
                    end
                end
        
                -- Copia o corpo do jogador alvo para o jogador local
                local targetBody = targetCharacter:FindFirstChildOfClass("BodyColors")
                local localBody = localCharacter:FindFirstChildOfClass("BodyColors")
                if targetBody and localBody then
                    localBody:Clone().Parent = localCharacter
                end
        
                -- Copia modelos de partes do jogador alvo para o jogador local
                local targetParts = {"Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso"}
                for _, partName in ipairs(targetParts) do
                    local targetPart = targetCharacter:FindFirstChild(partName)
                    local localPart = localCharacter:FindFirstChild(partName)
                    if targetPart and localPart then
                        localPart.Transparency = 1 -- Torna o modelo local invisível para evitar sobreposição visual
                        targetPart:Clone().Parent = localCharacter
                    end
                end
        
                print("Aparência copiada de " .. playerToCopy)
            else
                print("Jogador não encontrado")
            end
        end
    
        -- Função para listar os jogadores
        local function listPlayers()
            -- Limpa a lista atual de jogadores antes de adicionar os jogadores novamente
            for _, child in ipairs(scrollFrame:GetChildren()) do
                child:Destroy()
            end
        
            for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
                if otherPlayer ~= player then
                    local label = Instance.new("TextButton")
                    label.Text = otherPlayer.Name
                    label.TextColor3 = Color3.new(1, 1, 1)
                    label.TextSize = 20
                    label.Font = Enum.Font.SourceSans
                    label.Position = UDim2.new(0, 0, 0, (#scrollFrame:GetChildren() + 1) * 40)
                    label.Size = UDim2.new(1, 0, 0, 40)
                    label.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                    label.BorderSizePixel = 0
                    label.Parent = scrollFrame
                    label.MouseButton1Click:Connect(function()
                        copySkin(otherPlayer.Name)
                    end)
                end
            end
        end
    
        -- Atualiza a lista de jogadores quando um jogador entra ou sai do jogo
        game.Players.PlayerAdded:Connect(function(newPlayer)
            listPlayers()
        end)
    
        game.Players.PlayerRemoving:Connect(function(removedPlayer)
            listPlayers()
        end)
    
        listPlayers()
    end

    -- Função para criar o menu de acelerar/diminuir velocidade
    local function createSpeedMenu()
        -- Cria uma tela de GUI
        local gui = Instance.new("ScreenGui")
        gui.Parent = player.PlayerGui
    
        -- Define a cor roxa para todos os menus
        local backgroundColor = Color3.fromRGB(128, 0, 128)
    
        -- Cria o frame do menu
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.3, 0, 0.6, 0)
        frame.Position = UDim2.new(0.7, 0, 0.2, 0)
        frame.BackgroundColor3 = backgroundColor
        frame.BorderSizePixel = 2
        frame.Parent = gui
    
        -- Cria botão de fechar
        local closeButton = Instance.new("TextButton")
        closeButton.Text = "Fechar"
        closeButton.TextColor3 = Color3.new(1, 1, 1)
        closeButton.TextSize = 20
        closeButton.Font = Enum.Font.SourceSans
        closeButton.Position = UDim2.new(0, 0, 0.95, 0)
        closeButton.Size = UDim2.new(1, 0, 0.05, 0)
        closeButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        closeButton.BorderSizePixel = 0
        closeButton.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)
        closeButton.Parent = frame
    
        -- Cria botão de acelerar
        local accelerateButton = Instance.new("TextButton")
        accelerateButton.Parent = frame
        accelerateButton.Position = UDim2.new(0.1, 0, 0.1, 0)
        accelerateButton.Size = UDim2.new(0.8, 0, 0.2, 0)
        accelerateButton.Text = "Acelerar"
        accelerateButton.MouseButton1Click:Connect(function()
            player.Character.Humanoid.WalkSpeed = player.Character.Humanoid.WalkSpeed + 5 -- aumenta a velocidade em 5
        end)
    
        -- Cria botão de diminuir
        local decelerateButton = Instance.new("TextButton")
        decelerateButton.Parent = frame
        decelerateButton.Position = UDim2.new(0.1, 0, 0.4, 0)
        decelerateButton.Size = UDim2.new(0.8, 0, 0.2, 0)
        decelerateButton.Text = "Diminuir"
        decelerateButton.MouseButton1Click:Connect(function()
            player.Character.Humanoid.WalkSpeed = player.Character.Humanoid.WalkSpeed - 5 -- diminui a velocidade em 5
        end)
    end

    -- Função para criar o menu de teletransporte
    local function createTeleportMenu()
        -- Cria uma tela de GUI
        local gui = Instance.new("ScreenGui")
        gui.Name = "PlayerTeleporterGui"
        gui.ResetOnSpawn = false -- Evita que o GUI seja reiniciado ao renascer no jogo
        gui.Parent = player.PlayerGui
    
        -- Define a cor roxa para todos os menus
        local backgroundColor = Color3.fromRGB(128, 0, 128)
    
        -- Cria o frame do menu
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.3, 0, 0.6, 0)
        frame.Position = UDim2.new(0.7, 0, 0.2, 0)
        frame.BackgroundColor3 = backgroundColor
        frame.BorderSizePixel = 2
        frame.Parent = gui
    
        -- Cria botão de fechar
        local closeButton = Instance.new("TextButton")
        closeButton.Text = "Fechar"
        closeButton.TextColor3 = Color3.new(1, 1, 1)
        closeButton.TextSize = 20
        closeButton.Font = Enum.Font.SourceSans
        closeButton.Position = UDim2.new(0, 0, 0.95, 0)
        closeButton.Size = UDim2.new(1, 0, 0.05, 0)
        closeButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        closeButton.BorderSizePixel = 0
        closeButton.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)
        closeButton.Parent = frame
    
        -- Cria o scrollFrame para listar os jogadores
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Size = UDim2.new(0.9, 0, 0.9, 0)
        scrollFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
        scrollFrame.CanvasSize = UDim2.new(0, 0, 5, 0) -- Defina a altura conforme necessário
        scrollFrame.Parent = frame
    
        -- Função para teletransportar para um jogador
        local function teleportToPlayer(playerToTeleport)
            local targetPosition = playerToTeleport.Character and playerToTeleport.Character.PrimaryPart and playerToTeleport.Character.PrimaryPart.Position
            if targetPosition then
                player.Character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
                print("Teleportado para " .. playerToTeleport.Name)
            else
                print("Não foi possível obter a posição de " .. playerToTeleport.Name)
            end
        end
    
        -- Função para listar os jogadores
        local function listPlayers()
            -- Limpa a lista atual de jogadores antes de adicionar os jogadores novamente
            for _, child in ipairs(scrollFrame:GetChildren()) do
                child:Destroy()
            end
        
            for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
                if otherPlayer ~= player then
                    local label = Instance.new("TextButton")
                    label.Text = otherPlayer.Name
                    label.TextColor3 = Color3.new(1, 1, 1)
                    label.TextSize = 20
                    label.Font = Enum.Font.SourceSans
                    label.Position = UDim2.new(0, 0, 0, (#scrollFrame:GetChildren() + 1) * 40)
                    label.Size = UDim2.new(1, 0, 0, 40)
                    label.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                    label.BorderSizePixel = 0
                    label.Parent = scrollFrame
                    label.MouseButton1Click:Connect(function()
                        teleportToPlayer(otherPlayer)
                    end)
                end
            end
        end
    
        -- Atualiza a lista de jogadores quando um jogador entra ou sai do jogo
        game.Players.PlayerAdded:Connect(function(newPlayer)
            listPlayers()
        end)
    
        game.Players.PlayerRemoving:Connect(function(removedPlayer)
            listPlayers()
        end)
    
        listPlayers()
    end

    -- Função para criar o menu principal
    local function createMainMenu()
        -- Cria uma tela de GUI
        local gui = Instance.new("ScreenGui")
        gui.Parent = player.PlayerGui
    
        -- Define a cor roxa para todos os menus
        local backgroundColor = Color3.fromRGB(128, 0, 128)
    
        -- Cria o frame do menu
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.3, 0, 0.6, 0)
        frame.Position = UDim2.new(0.7, 0, 0.2, 0)
        frame.BackgroundColor3 = backgroundColor
        frame.BorderSizePixel = 2
        frame.Parent = gui
    
        -- Cria botão de fechar
        local closeButton = Instance.new("TextButton")
        closeButton.Text = "Fechar"
        closeButton.TextColor3 = Color3.new(1, 1, 1)
        closeButton.TextSize = 20
        closeButton.Font = Enum.Font.SourceSans
        closeButton.Position = UDim2.new(0, 0, 0.95, 0)
        closeButton.Size = UDim2.new(1, 0, 0.05, 0)
        closeButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        closeButton.BorderSizePixel = 0
        closeButton.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)
        closeButton.Parent = frame
    
        -- Cria botão para abrir o menu de acelerar/diminuir velocidade
        local speedButton = Instance.new("TextButton")
        speedButton.Parent = frame
        speedButton.Position = UDim2.new(0.1, 0, 0.1, 0)
        speedButton.Size = UDim2.new(0.8, 0, 0.2, 0)
        speedButton.Text = "Acelerar/Diminuir Velocidade"
        speedButton.MouseButton1Click:Connect(function()
            createSpeedMenu()
        end)
    
        -- Cria botão para abrir o menu de teletransporte
        local teleportButton = Instance.new("TextButton")
        teleportButton.Parent = frame
        teleportButton.Position = UDim2.new(0.1, 0, 0.4, 0)
        teleportButton.Size = UDim2.new(0.8, 0, 0.2, 0)
        teleportButton.Text = "Teletransporte"
        teleportButton.MouseButton1Click:Connect(function()
            createTeleportMenu()
        end)
    
        -- Cria botão para abrir o menu de copiar skins
        local copySkinButton = Instance.new("TextButton")
        copySkinButton.Parent = frame
        copySkinButton.Position = UDim2.new(0.1, 0, 0.7, 0)
        copySkinButton.Size = UDim2.new(0.8, 0, 0.2, 0)
        copySkinButton.Text = "Copiar Skins de Outros Jogadores"
        copySkinButton.MouseButton1Click:Connect(function()
            createCopySkinMenu()
        end)
    end

    -- Chama a função para criar o menu principal
    createMainMenu()

end

-- Função para criar o UI Mod Menu
local function createModMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ModMenu"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
    mainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)  -- Posicionado centralmente
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    mainFrame.ZIndex = 2
    mainFrame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "RModMenu 1.0"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    title.BorderSizePixel = 0
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20
    title.ZIndex = 3
    title.Parent = mainFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0.1, 0, 0.05, 0)
    closeButton.Position = UDim2.new(0.9, 0, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    closeButton.BorderSizePixel = 0
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 20
    closeButton.ZIndex = 3
    closeButton.Parent = mainFrame
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local hack1Button = Instance.new("TextButton")
    hack1Button.Size = UDim2.new(0.8, 0, 0.1, 0)
    hack1Button.Position = UDim2.new(0.1, 0, 0.15, 0)
    hack1Button.Text = "Rfly (Gosta de voar?)"
    hack1Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    hack1Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    hack1Button.BorderSizePixel = 0
    hack1Button.Font = Enum.Font.SourceSansBold
    hack1Button.TextSize = 16
    hack1Button.ZIndex = 3
    hack1Button.Parent = mainFrame
    hack1Button.MouseButton1Click:Connect(hack1)

    local hack2Button = Instance.new("TextButton")
    hack2Button.Size = UDim2.new(0.8, 0, 0.1, 0)
    hack2Button.Position = UDim2.new(0.1, 0, 0.3, 0)
    hack2Button.Text = "RID (Mude seu ID)"
    hack2Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    hack2Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    hack2Button.BorderSizePixel = 0
    hack2Button.Font = Enum.Font.SourceSansBold
    hack2Button.TextSize = 16
    hack2Button.ZIndex = 3
    hack2Button.Parent = mainFrame
    hack2Button.MouseButton1Click:Connect(hack2)

    local hack3Button = Instance.new("TextButton")
    hack3Button.Size = UDim2.new(0.8, 0, 0.1, 0)
    hack3Button.Position = UDim2.new(0.1, 0, 0.45, 0)
    hack3Button.Text = "Menu Teleport/Velocidade/Skin"
    hack3Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    hack3Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    hack3Button.BorderSizePixel = 0
    hack3Button.Font = Enum.Font.SourceSansBold
    hack3Button.TextSize = 16
    hack3Button.ZIndex = 3
    hack3Button.Parent = mainFrame
    hack3Button.MouseButton1Click:Connect(hack3)
end

createModMenu()
