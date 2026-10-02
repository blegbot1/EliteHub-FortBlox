-- ============================================================
--  ELITE HUB | Fort Blox (place 8884043854)
--  ESP (lines + chams + 3D box) + Silent Aim (client) + Misc
--  Repo: https://github.com/blegbot1/EliteHub-FortBlox
--
--  Aiming is client-side (silent): the original shot is replaced in the __namecall
--  hook, no camera movement, no visible aimbot needed.
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

getgenv().FB_ESP = false
getgenv().FB_Tracers = true
getgenv().FB_Chams = true
getgenv().FB_Names = true
getgenv().FB_Box3D = false
getgenv().FB_BoxColor = Color3.fromRGB(255, 0, 0)
getgenv().FB_BoxThick = 2
getgenv().FB_Box3DScale = 10
getgenv().FB_TracerColor = Color3.fromRGB(0, 255, 0)
getgenv().FB_TracerThick = 2
getgenv().FB_TracerOrigin = "Bottom"
getgenv().FB_ChamsFill = Color3.fromRGB(255, 0, 0)
getgenv().FB_ChamsOut = Color3.fromRGB(255, 255, 255)
getgenv().FB_ChamsTransp = 0.5
getgenv().FB_TextSize = 14
getgenv().FB_ESPMaxDist = 0
getgenv().FB_Arrows = false
getgenv().FB_ArrowColor = Color3.fromRGB(255, 50, 50)
getgenv().FB_ArrowSize = 14
getgenv().FB_Radar = false
getgenv().FB_RadarSize = 150
getgenv().FB_RadarRange = 250
getgenv().FB_AutoHP = false
getgenv().FB_HPThresh = 50
getgenv().FB_AutoShield = false
getgenv().FB_ShieldThresh = 50
getgenv().FB_HealCD = 8
getgenv().FB_HealWait = 4
getgenv().FB_CrossShow = true
getgenv().FB_CrossSize = 8
getgenv().FB_CrossGap = 4
getgenv().FB_CrossThick = 2
getgenv().FB_CrossColor = Color3.fromRGB(0, 255, 0)
getgenv().FB_CrossDot = true
getgenv().FB_FOVColor = Color3.fromRGB(0, 255, 0)
getgenv().FB_FOVThick = 2
getgenv().FB_FOVPulse = 0
getgenv().FB_LockColor = Color3.fromRGB(255, 50, 50)
getgenv().FB_LockSize = 18
getgenv().FB_LockThick = 2
getgenv().FB_LockPulse = 0
getgenv().FB_Rainbow = false
getgenv().FB_RainbowESP = false
getgenv().FB_AnimSpeed = 3
getgenv().FB_Kills = 0
getgenv().FB_TracerPulse = 0
getgenv().FB_BoxPulse = 0
getgenv().FB_ChamsPulse = 0
getgenv().FB_RadarSweep = false
getgenv().FB_PanelTransp = 0.25
getgenv().FB_HPBar = true

getgenv().FB_Aim = false
getgenv().FB_AimFOV = 150
getgenv().FB_AimWallCheck = false
getgenv().FB_MaxDist = 2000
getgenv().FB_Priority = "Nearest"
getgenv().FB_HitPart = "Head"
getgenv().FB_Sticky = false
getgenv().FB_Trigger = false
getgenv().FB_TriggerDelay = 0.2
getgenv().FB_FarHit = true
getgenv().FB_SkipSquad = true
getgenv().FB_SpeedLock = false
getgenv().FB_WalkSpeed = 16
getgenv().FB_SprintSpeed = 32
getgenv().FB_Spin = false
getgenv().FB_SpinSpeed = 360
getgenv().FB_Chests = false
getgenv().FB_ChestESP = false
getgenv().FB_ChestNear = false
getgenv().FB_ChestNearDist = 16
getgenv().FB_ShowTargetPanel = true
getgenv().FB_LockIndicator = true
getgenv().FB_Friends = getgenv().FB_Friends or {}
getgenv().FB_FriendESP = true
getgenv().FB_EnemyGun = true

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua'))()

-- ================= ELITE HUB theme (black / purple, smooth) =================
-- passed as a table: Rayfield uses it as-is (ChangeTheme accepts any table)
getgenv().FB_Theme = {
    TextColor = Color3.fromRGB(235, 230, 245),

    Background = Color3.fromRGB(12, 10, 18),
    Topbar = Color3.fromRGB(20, 16, 30),
    Shadow = Color3.fromRGB(5, 4, 10),

    NotificationBackground = Color3.fromRGB(22, 18, 34),
    NotificationActionsBackground = Color3.fromRGB(190, 160, 230),

    TabBackground = Color3.fromRGB(30, 24, 44),
    TabStroke = Color3.fromRGB(60, 44, 90),
    TabBackgroundSelected = Color3.fromRGB(138, 84, 220),
    TabTextColor = Color3.fromRGB(200, 190, 220),
    SelectedTabTextColor = Color3.fromRGB(255, 255, 255),

    ElementBackground = Color3.fromRGB(24, 20, 36),
    ElementBackgroundHover = Color3.fromRGB(36, 30, 54),
    SecondaryElementBackground = Color3.fromRGB(18, 15, 28),
    ElementStroke = Color3.fromRGB(52, 40, 74),
    SecondaryElementStroke = Color3.fromRGB(44, 34, 64),

    SliderBackground = Color3.fromRGB(60, 44, 90),
    SliderProgress = Color3.fromRGB(150, 90, 235),
    SliderStroke = Color3.fromRGB(170, 110, 245),

    ToggleBackground = Color3.fromRGB(30, 24, 44),
    ToggleEnabled = Color3.fromRGB(150, 90, 235),
    ToggleDisabled = Color3.fromRGB(70, 55, 90),
    ToggleEnabledStroke = Color3.fromRGB(180, 130, 250),
    ToggleDisabledStroke = Color3.fromRGB(100, 80, 125),
    ToggleEnabledOuterStroke = Color3.fromRGB(110, 70, 160),
    ToggleDisabledOuterStroke = Color3.fromRGB(60, 48, 80),

    DropdownSelected = Color3.fromRGB(44, 34, 66),
    DropdownUnselected = Color3.fromRGB(22, 18, 34),

    InputBackground = Color3.fromRGB(22, 18, 34),
    InputStroke = Color3.fromRGB(70, 52, 100),
    PlaceholderColor = Color3.fromRGB(120, 105, 150),
}
local ELITE = getgenv().FB_Theme

local function notify(text, dur)
    pcall(function()
        Rayfield:Notify({ Title = "ELITE HUB", Content = text, Duration = dur or 3 })
    end)
end

local Window = Rayfield:CreateWindow({
    Name = "ELITE HUB | Fort Blox",
    LoadingTitle = "ELITE HUB",
    LoadingSubtitle = "Fort Blox | ESP + Silent Aim",
    Theme = ELITE,
    ConfigurationSaving = { Enabled = true, FolderName = "FBScripts", FileName = "EliteHub_FortBlox" }
})

-- smooth purple gradient on the topbar background ONLY (no icons/inputs)
pcall(function()
    local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not pg then return end
    -- Rayfield's ScreenGui comes from GetObjects(), so find it by structure, not by name
    local topbar = nil
    for _, g in ipairs(pg:GetChildren()) do
        if g:IsA("ScreenGui") then
            local m = g:FindFirstChild("Main", true)
            if m then
                local tb = m:FindFirstChild("Topbar")
                if tb then topbar = tb break end
            end
        end
    end
    if not topbar then return end
    local targets = {topbar}
    for _, child in ipairs(topbar:GetChildren()) do
        -- only plain container frames (skip buttons/icons/text/search)
        if child:IsA("Frame") and child.Name ~= "Search" and not child:FindFirstChildWhichIsA("GuiObject", true) then
            targets[#targets + 1] = child
        end
    end
    for _, d in ipairs(targets) do
        if d:IsA("Frame") and not d:FindFirstChildOfClass("UIGradient") then
            local g = Instance.new("UIGradient")
            g.Name = "EliteGradient"
            g.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 90, 235)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(105, 55, 190)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 25, 75)),
            })
            g.Rotation = 0
            pcall(function() d.BackgroundTransparency = 0 end)
            g.Parent = d
        end
    end
end)

local ESPTab = Window:CreateTab("ESP", 4483362458)
local AimTab = Window:CreateTab("Aim", 4483362458)

Players.PlayerRemoving:Connect(function(p)
    local d = getgenv().FB_ESPCache and getgenv().FB_ESPCache[p]
    if d then
        pcall(function() d.hl:Destroy() end)
        pcall(function() d.gui:Destroy() end)
        pcall(function()
            if d.line then
                d.line:Remove()
            end
        end)
        pcall(function()
            if d.box3d then
                for _, e in ipairs(d.box3d) do
                    e:Remove()
                end
            end
        end)
        pcall(function()
            if d.arr then
                for _, a in ipairs(d.arr) do
                    a:Remove()
                end
            end
        end)
        pcall(function()
            if d.arrTxt then d.arrTxt:Remove() end
        end)
        pcall(function()
            if d.rdot then d.rdot:Remove() end
        end)
        getgenv().FB_ESPCache[p] = nil
    end
    if getgenv().FB_RadarShow then getgenv().FB_RadarShow[p] = nil end
    if getgenv().FB_VisCache then getgenv().FB_VisCache[p] = nil end
end)

-- ================= ESP (lines + chams + names) =================
local function isFriend(p)
    return getgenv().FB_Friends and getgenv().FB_Friends[p.Name] == true
end

-- forward: defined later near remotes section
local getEquippedGun

-- squadmates can't be damaged (Damage.PlayerCanDamage) -> skip them in aim
local function getSquadmates()
    local set = {}
    pcall(function()
        local sq = game:GetService("ReplicatedStorage"):FindFirstChild("Squads")
        if sq then
            for _, s in ipairs(sq:GetChildren()) do
                local pls = s:FindFirstChild("Players")
                if pls and pls:FindFirstChild(LocalPlayer.Name) then
                    for _, m in ipairs(pls:GetChildren()) do
                        if m.Name ~= LocalPlayer.Name then set[m.Name] = true end
                    end
                    break
                end
            end
        end
    end)
    return set
end

-- gun Range from game Config (server ray can't reach beyond it -> wall shots fail there)
local gunRangeCache = {}
local function getGunRange(gun)
    if not gun then return nil end
    local n = gun.Name
    if gunRangeCache[n] then return gunRangeCache[n] end
    local r = nil
    pcall(function()
        local Config = require(game:GetService("ReplicatedStorage").Modules.Config)
        local c = Config:GetConfig(gun)
        if c and c.Range then r = c.Range end
    end)
    if r then gunRangeCache[n] = r end
    return r
end

getgenv().FB_ESPCache = {}

local function hasDrawing()
    local ok = pcall(function() return Drawing.new("Line") end)
    if ok then
        pcall(function()
            local l = Drawing.new("Line")
            l:Remove()
        end)
    end
    return ok
end
local DRAW_OK = hasDrawing()

local function getPG()
    local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    return pg
end

local function ensureESP(p)
    local cache = getgenv().FB_ESPCache
    if cache[p] then return cache[p] end
    local d = {}
    -- chams
    local hl = Instance.new("Highlight")
    hl.Name = "FB_Chams"
    hl.FillColor = Color3.fromRGB(255, 0, 0)
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Enabled = false
    local pg = getPG()
    if pg then hl.Parent = pg end
    d.hl = hl
    -- name
    local gui = Instance.new("BillboardGui")
    gui.Name = "FB_Name"
    gui.Size = UDim2.new(0, 220, 0, 60)
    gui.StudsOffset = Vector3.new(0, 3.5, 0)
    gui.AlwaysOnTop = true
    gui.Enabled = false
    local lbl = Instance.new("TextLabel")
    lbl.Name = "Text"
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextStrokeTransparency = 0
    lbl.TextSize = 14
    lbl.Text = p.Name
    lbl.Parent = gui
    if pg then gui.Parent = pg end
    d.gui = gui
    d.lbl = lbl
    -- tracer line + 3d box (12 edges)
    if DRAW_OK then
        local ok, line = pcall(function() return Drawing.new("Line") end)
        if ok and line then
            line.Visible = false
            line.Color = Color3.fromRGB(0, 255, 0)
            line.Thickness = 2
            d.line = line
        end
        d.box3d = {}
        for i = 1, 12 do
            local ok2, e = pcall(function() return Drawing.new("Line") end)
            if ok2 and e then
                e.Visible = false
                e.Color = Color3.fromRGB(255, 0, 0)
                e.Thickness = 2
                d.box3d[i] = e
            end
        end
        -- off-screen arrows: outlined triangle (3 black + 3 color) + distance text
        d.arr = {}
        for i = 1, 6 do
            local ok3, a = pcall(function() return Drawing.new("Line") end)
            if ok3 and a then
                a.Visible = false
                if i <= 3 then
                    a.Color = Color3.fromRGB(0, 0, 0)
                    a.Thickness = 5
                else
                    a.Color = Color3.fromRGB(255, 50, 50)
                    a.Thickness = 2
                end
                d.arr[i] = a
            end
        end
        local okT, tx = pcall(function() return Drawing.new("Text") end)
        if okT and tx then
            tx.Visible = false
            tx.Size = 13
            tx.Center = true
            tx.Outline = true
            tx.Color = Color3.fromRGB(255, 255, 255)
            d.arrTxt = tx
        end
        -- radar dot
        local ok4, rd = pcall(function() return Drawing.new("Circle") end)
        if ok4 and rd then
            rd.Visible = false
            rd.Radius = 3
            rd.Filled = true
            rd.Color = Color3.fromRGB(255, 0, 0)
            d.rdot = rd
        end
    end
    cache[p] = d
    return d
end

local function hideBox3d(d)
    if d.box3d then
        for _, e in ipairs(d.box3d) do
            pcall(function() e.Visible = false end)
        end
    end
end

-- visibility cache: red behind wall, GREEN on line of sight (refreshed every 0.3s per player)
getgenv().FB_VisCache = getgenv().FB_VisCache or {}
local function targetVisible(p, ch, head)
    local cam = Camera
    if not cam or not ch or not head then return false end
    local now = os.clock()
    local c = getgenv().FB_VisCache[p]
    if c and c.ch == ch and now - c.t < 0.3 then return c.v end
    local v = false
    pcall(function()
        local origin = cam.CFrame.Position
        local dir = head.Position - origin
        local params = RaycastParams.new()
        -- default FilterType already excludes the list (old + new API)
        params.FilterDescendantsInstances = {LocalPlayer.Character, ch}
        params.IgnoreWater = true
        local hit = workspace:Raycast(origin, dir, params)
        v = (hit == nil)
    end)
    getgenv().FB_VisCache[p] = {v = v, t = now, ch = ch}
    return v
end

RunService.RenderStepped:Connect(function()
    local on = getgenv().FB_ESP
    Camera = workspace.CurrentCamera
    if not Camera then return end
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
        local d = ensureESP(p)
        local ch = p.Character
        local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
        local hum = ch and ch:FindFirstChildOfClass("Humanoid")
        local head = ch and ch:FindFirstChild("Head")
        local alive = hum and hum.Health > 0 and hrp and head
        local maxED = getgenv().FB_ESPMaxDist or 0
        local dist3d = (myHRP and hrp) and (myHRP.Position - hrp.Position).Magnitude or 0
        if not on or not alive or (maxED > 0 and dist3d > maxED) then
            pcall(function() d.hl.Enabled = false end)
            pcall(function() d.gui.Enabled = false end)
            pcall(function()
                if d.line then
                    d.line.Visible = false
                end
            end)
            hideBox3d(d)
            pcall(function()
                if d.arr then
                    for _, a in ipairs(d.arr) do a.Visible = false end
                end
                if d.rdot then d.rdot.Visible = false end
                if d.arrTxt then d.arrTxt.Visible = false end
            end)
        else
        -- availability: red by default, GREEN on line of sight (not behind wall)
        local friend = isFriend(p)
        local available = targetVisible(p, ch, head)
        local mainCol, outCol, lineCol
        if friend and getgenv().FB_FriendESP then
            mainCol = Color3.fromRGB(0, 150, 255)
            outCol = Color3.fromRGB(150, 220, 255)
            lineCol = Color3.fromRGB(0, 150, 255)
        elseif available then
            mainCol = Color3.fromRGB(40, 230, 90)
            outCol = Color3.fromRGB(180, 255, 190)
            lineCol = Color3.fromRGB(40, 230, 90)
        else
            mainCol = getgenv().FB_ChamsFill or Color3.fromRGB(255, 0, 0)
            outCol = getgenv().FB_ChamsOut or Color3.fromRGB(255, 255, 255)
            lineCol = getgenv().FB_TracerColor or Color3.fromRGB(0, 255, 0)
        end
        if getgenv().FB_Rainbow or getgenv().FB_RainbowESP then
            if not friend then
                local rc = Color3.fromHSV((os.clock() * 0.15) % 1, 1, 1)
                mainCol, lineCol = rc, rc
            end
        end
        -- chams (friends blue, available green, else settings)
        pcall(function()
            d.hl.Adornee = ch
            d.hl.Enabled = getgenv().FB_Chams
            local cht = getgenv().FB_ChamsTransp or 0.5
            local chp = getgenv().FB_ChamsPulse or 0
            if chp > 0 then
                cht = cht + math.sin(os.clock() * (getgenv().FB_AnimSpeed or 3)) * (chp / 10)
                cht = math.clamp(cht, 0, 1)
            end
            d.hl.FillTransparency = cht
            if friend and getgenv().FB_FriendESP then
                d.hl.FillColor = Color3.fromRGB(0, 150, 255)
                d.hl.OutlineColor = Color3.fromRGB(150, 220, 255)
            else
                d.hl.FillColor = mainCol
                d.hl.OutlineColor = outCol
            end
        end)
        -- name + distance
        local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        pcall(function()
            d.gui.Adornee = head
            d.gui.Enabled = getgenv().FB_Names
            local dist = math.floor(dist3d)
            local gunName = ""
            if getgenv().FB_EnemyGun then
                gunName = "?"
                pcall(function()
                    local eq = ch:FindFirstChild("Equipped")
                    if eq then
                        local okV, v = pcall(function() return eq.Value end)
                        if okV and v ~= nil then
                            if typeof(v) == "Instance" then gunName = v.Name
                            else gunName = tostring(v) end
                        end
                    end
                    if gunName == "?" or gunName == "" then
                        local tool = ch:FindFirstChildOfClass("Tool")
                        if tool then gunName = tool.Name end
                    end
                end)
            end
            local txt = (friend and "[F] " or "") .. p.Name .. " [" .. dist .. "m]"
            if gunName ~= "" then txt = txt .. "\n" .. gunName end
            d.lbl.Text = txt
            d.lbl.TextSize = getgenv().FB_TextSize or 14
            if friend then
                d.lbl.TextColor3 = Color3.fromRGB(120, 200, 255)
            elseif getgenv().FB_Rainbow or getgenv().FB_RainbowESP then
                d.lbl.TextColor3 = Color3.fromHSV((os.clock() * 0.15) % 1, 1, 1)
            else
                d.lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end)
        -- tracer line to player
        pcall(function()
            if d.line then
                if getgenv().FB_Tracers and onScreen then
                    local vs = Camera.ViewportSize
                    local org = getgenv().FB_TracerOrigin or "Bottom"
                    if org == "Top" then
                        d.line.From = Vector2.new(vs.X / 2, 0)
                    elseif org == "Center" then
                        d.line.From = Vector2.new(vs.X / 2, vs.Y / 2)
                    else
                        d.line.From = Vector2.new(vs.X / 2, vs.Y)
                    end
                    d.line.To = Vector2.new(hrpPos.X, hrpPos.Y)
                    local ttp = getgenv().FB_TracerPulse or 0
                    local tth = getgenv().FB_TracerThick or 2
                    if ttp > 0 then
                        tth = tth + math.sin(os.clock() * (getgenv().FB_AnimSpeed or 3)) * ttp
                        if tth < 1 then tth = 1 end
                    end
                    d.line.Thickness = tth
                    if friend then
                        d.line.Color = Color3.fromRGB(0, 150, 255)
                    else
                        d.line.Color = lineCol
                    end
                    d.line.Visible = true
                else
                    d.line.Visible = false
                end
            end
        end)
        -- 3d box (12 edges around character)
        pcall(function()
            if not (d.box3d and getgenv().FB_Box3D and onScreen) then
                hideBox3d(d)
                return
            end
            local sc = (getgenv().FB_Box3DScale or 10) / 10
            local bxp = getgenv().FB_BoxPulse or 0
            if bxp > 0 then
                sc = sc + math.sin(os.clock() * (getgenv().FB_AnimSpeed or 3)) * (bxp / 10)
                if sc < 0.3 then sc = 0.3 end
            end
            local size = Vector3.new(4 * sc, 6 * sc, 2.5 * sc)
            local cf = hrp.CFrame
            local hx, hy, hz = size.X / 2, size.Y / 2, size.Z / 2
            local corners = {}
            for _, sx in ipairs({-1, 1}) do
                for _, sy in ipairs({-1, 1}) do
                    for _, sz in ipairs({-1, 1}) do
                        local wp = (cf * CFrame.new(hx * sx, hy * sy, hz * sz)).Position
                        local sp, vis = Camera:WorldToViewportPoint(wp)
                        if not vis then
                            hideBox3d(d)
                            return
                        end
                        corners[sx .. "," .. sy .. "," .. sz] = Vector2.new(sp.X, sp.Y)
                    end
                end
            end
            local edges = {
                {"-1,-1,-1", "1,-1,-1"}, {"1,-1,-1", "1,-1,1"}, {"1,-1,1", "-1,-1,1"}, {"-1,-1,1", "-1,-1,-1"},
                {"-1,1,-1", "1,1,-1"}, {"1,1,-1", "1,1,1"}, {"1,1,1", "-1,1,1"}, {"-1,1,1", "-1,1,-1"},
                {"-1,-1,-1", "-1,1,-1"}, {"1,-1,-1", "1,1,-1"}, {"1,-1,1", "1,1,1"}, {"-1,-1,1", "-1,1,1"},
            }
            local col
            if friend then
                col = Color3.fromRGB(0, 150, 255)
            else
                col = mainCol
            end
            local th = getgenv().FB_BoxThick or 2
            for i, e in ipairs(edges) do
                local ln = d.box3d[i]
                if ln then
                    ln.From = corners[e[1]]
                    ln.To = corners[e[2]]
                    ln.Color = col
                    ln.Thickness = th
                    ln.Visible = true
                end
            end
        end)
        -- off-screen arrow (triangle at screen edge)
        pcall(function()
            local showA = d.arr and getgenv().FB_Arrows and not onScreen
            if not showA then
                if d.arr then
                    for _, a in ipairs(d.arr) do a.Visible = false end
                end
                if d.arrTxt then d.arrTxt.Visible = false end
                return
            end
            local vs = Camera.ViewportSize
            local cx, cy = vs.X / 2, vs.Y / 2
            local dx, dy = hrpPos.X - cx, hrpPos.Y - cy
            if hrpPos.Z and hrpPos.Z < 0 then
                dx, dy = -dx, -dy
            end
            local ang = math.atan2(dy, dx)
            local R = math.min(vs.X, vs.Y) / 2 - 50
            local px, py = cx + math.cos(ang) * R, cy + math.sin(ang) * R
            local s = getgenv().FB_ArrowSize or 14
            local col
            if friend then
                col = Color3.fromRGB(0, 150, 255)
            elseif available then
                col = Color3.fromRGB(40, 230, 90)
            else
                col = getgenv().FB_ArrowColor or Color3.fromRGB(255, 50, 50)
            end
            local tip = Vector2.new(px + math.cos(ang) * s, py + math.sin(ang) * s)
            local b1 = Vector2.new(px - math.cos(ang) * s * 0.6 - math.sin(ang) * s * 0.6, py - math.sin(ang) * s * 0.6 + math.cos(ang) * s * 0.6)
            local b2 = Vector2.new(px - math.cos(ang) * s * 0.6 + math.sin(ang) * s * 0.6, py - math.sin(ang) * s * 0.6 - math.cos(ang) * s * 0.6)
            local pts = {{tip, b1}, {b1, b2}, {b2, tip}}
            for i = 1, 3 do
                local ol, ml = d.arr[i], d.arr[i + 3]
                if ol and ml then
                    ol.From = pts[i][1]
                    ol.To = pts[i][2]
                    ol.Color = Color3.fromRGB(0, 0, 0)
                    ol.Thickness = 5
                    ol.Visible = true
                    ml.From = pts[i][1]
                    ml.To = pts[i][2]
                    ml.Color = col
                    ml.Thickness = 2
                    ml.Visible = true
                end
            end
            if d.arrTxt then
                d.arrTxt.Text = p.Name .. " " .. math.floor(dist3d) .. "m"
                d.arrTxt.Position = Vector2.new(px, py + s + 4)
                d.arrTxt.Color = col
                d.arrTxt.Visible = true
            end
        end)
        -- radar dot (positioned by radar updater below)
        getgenv().FB_RadarShow = getgenv().FB_RadarShow or {}
        pcall(function()
            if d.rdot then
                if getgenv().FB_Radar and myHRP then
                    local rel = hrp.Position - myHRP.Position
                    local rr = getgenv().FB_RadarRange or 250
                    getgenv().FB_RadarShow[p] = rel.Magnitude <= rr
                    if not getgenv().FB_RadarShow[p] then
                        d.rdot.Visible = false
                    end
                else
                    getgenv().FB_RadarShow[p] = false
                    d.rdot.Visible = false
                end
            end
        end)
        end
        end
    end
end)

-- radar background + dot positioning (bottom-right)
local radarBg, radarSweep = nil, nil
if DRAW_OK then
    pcall(function()
        radarBg = Drawing.new("Square")
        radarBg.Filled = true
        radarBg.Color = Color3.fromRGB(10, 10, 15)
        radarBg.Transparency = 0.4
        radarBg.Visible = false
    end)
    pcall(function()
        radarSweep = Drawing.new("Line")
        radarSweep.Thickness = 2
        radarSweep.Color = Color3.fromRGB(0, 255, 150)
        radarSweep.Visible = false
    end)
end
RunService.RenderStepped:Connect(function()
    pcall(function()
        local cam = workspace.CurrentCamera
        if not radarBg then return end
        if not (cam and getgenv().FB_Radar) then
            radarBg.Visible = false
            if radarSweep then radarSweep.Visible = false end
            return
        end
        local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not myHRP then
            radarBg.Visible = false
            if radarSweep then radarSweep.Visible = false end
            return
        end
        local sz = getgenv().FB_RadarSize or 150
        local vs = cam.ViewportSize
        local rx, ry = vs.X - sz - 10, vs.Y - sz - 10
        radarBg.Position = Vector2.new(rx, ry)
        radarBg.Size = Vector2.new(sz, sz)
        radarBg.Visible = true
        local cx, cy = rx + sz / 2, ry + sz / 2
        if radarSweep then
            if getgenv().FB_RadarSweep then
                local sa = os.clock() * (getgenv().FB_AnimSpeed or 3)
                radarSweep.From = Vector2.new(cx, cy)
                radarSweep.To = Vector2.new(cx + math.cos(sa) * (sz / 2), cy + math.sin(sa) * (sz / 2))
                if getgenv().FB_Rainbow then
                    radarSweep.Color = Color3.fromHSV((os.clock() * 0.15) % 1, 1, 1)
                else
                    radarSweep.Color = Color3.fromRGB(0, 255, 150)
                end
                radarSweep.Visible = true
            else
                radarSweep.Visible = false
            end
        end
        local rr = getgenv().FB_RadarRange or 250
        local fwd = cam.CFrame.LookVector
        local ang = math.atan2(fwd.X, fwd.Z)
        local ca, sa = math.cos(ang), math.sin(ang)
        local cx, cy = rx + sz / 2, ry + sz / 2
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local cache = getgenv().FB_ESPCache
                local d = cache and cache[p]
                local show = getgenv().FB_RadarShow and getgenv().FB_RadarShow[p]
                if d and d.rdot and show then
                    local ch = p.Character
                    local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local rel = hrp.Position - myHRP.Position
                        local lx = (rel.X * ca - rel.Z * sa) / rr * (sz / 2)
                        local ly = (rel.X * sa + rel.Z * ca) / rr * (sz / 2)
                        local m = math.sqrt(lx * lx + ly * ly)
                        local lim = sz / 2 - 6
                        if m > lim then
                            lx, ly = lx / m * lim, ly / m * lim
                        end
                        d.rdot.Position = Vector2.new(cx + lx, cy - ly)
                        if isFriend(p) then
                            d.rdot.Color = Color3.fromRGB(0, 150, 255)
                        else
                            d.rdot.Color = Color3.fromRGB(255, 50, 50)
                        end
                        d.rdot.Visible = true
                    else
                        d.rdot.Visible = false
                    end
                end
            end
        end
        -- self dot
        -- (center marker skipped, bg center is you)
    end)
end)

ESPTab:CreateToggle({
    Name = "ESP ON/OFF",
    CurrentValue = false,
    Flag = "FB_ESP",
    Callback = function(Value)
        getgenv().FB_ESP = Value
        notify("ESP: " .. (Value and "ON" or "OFF"), 2)
    end,
})

ESPTab:CreateToggle({
    Name = "Lines (tracers)",
    CurrentValue = true,
    Flag = "FB_Tracers",
    Callback = function(Value)
        getgenv().FB_Tracers = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Chams (highlight)",
    CurrentValue = true,
    Flag = "FB_Chams",
    Callback = function(Value)
        getgenv().FB_Chams = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Blue friends",
    CurrentValue = true,
    Flag = "FB_FriendESP",
    Callback = function(Value)
        getgenv().FB_FriendESP = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Rainbow ESP",
    CurrentValue = false,
    Flag = "FB_RainbowESP",
    Callback = function(Value)
        getgenv().FB_RainbowESP = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Enemy gun ESP",
    CurrentValue = true,
    Flag = "FB_EnemyGun",
    Callback = function(Value)
        getgenv().FB_EnemyGun = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Chest ESP (unopened)",
    CurrentValue = false,
    Flag = "FB_ChestESP",
    Callback = function(Value)
        getgenv().FB_ChestESP = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Names + distance",
    CurrentValue = true,
    Flag = "FB_Names",
    Callback = function(Value)
        getgenv().FB_Names = Value
    end,
})

ESPTab:CreateToggle({
    Name = "3D Box",
    CurrentValue = false,
    Flag = "FB_Box3D",
    Callback = function(Value)
        getgenv().FB_Box3D = Value
    end,
})

ESPTab:CreateSlider({
    Name = "Box thickness",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 2,
    Callback = function(Value)
        getgenv().FB_BoxThick = Value
    end,
})

ESPTab:CreateSlider({
    Name = "3D Box size",
    Range = {5, 20},
    Increment = 1,
    CurrentValue = 10,
    Callback = function(Value)
        getgenv().FB_Box3DScale = Value
    end,
})

ESPTab:CreateSlider({
    Name = "Box pulse (0 = off)",
    Range = {0, 5},
    Increment = 1,
    CurrentValue = 0,
    Callback = function(Value)
        getgenv().FB_BoxPulse = Value
    end,
})

ESPTab:CreateSlider({
    Name = "Tracer thickness",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 2,
    Callback = function(Value)
        getgenv().FB_TracerThick = Value
    end,
})

ESPTab:CreateSlider({
    Name = "Tracer pulse (0 = off)",
    Range = {0, 5},
    Increment = 1,
    CurrentValue = 0,
    Callback = function(Value)
        getgenv().FB_TracerPulse = Value
    end,
})

ESPTab:CreateDropdown({
    Name = "Tracer origin",
    Options = {"Bottom", "Top", "Center"},
    CurrentOption = {"Bottom"},
    Callback = function(Option)
        local v = (typeof(Option) == "table") and Option[1] or Option
        getgenv().FB_TracerOrigin = v
    end,
})

ESPTab:CreateSlider({
    Name = "Chams transparency",
    Range = {0, 10},
    Increment = 1,
    CurrentValue = 5,
    Callback = function(Value)
        getgenv().FB_ChamsTransp = Value / 10
    end,
})

ESPTab:CreateSlider({
    Name = "Chams pulse (0 = off)",
    Range = {0, 5},
    Increment = 1,
    CurrentValue = 0,
    Callback = function(Value)
        getgenv().FB_ChamsPulse = Value
    end,
})

ESPTab:CreateSlider({
    Name = "Text size",
    Range = {8, 30},
    Increment = 1,
    CurrentValue = 14,
    Callback = function(Value)
        getgenv().FB_TextSize = Value
    end,
})

ESPTab:CreateSlider({
    Name = "Max ESP distance (0 = inf)",
    Range = {0, 2000},
    Increment = 50,
    CurrentValue = 0,
    Callback = function(Value)
        getgenv().FB_ESPMaxDist = Value
    end,
})

ESPTab:CreateColorPicker({
    Name = "ESP color (enemy)",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "FB_ESPColor",
    Callback = function(Value)
        getgenv().FB_ChamsFill = Value
        getgenv().FB_BoxColor = Value
    end,
})

ESPTab:CreateColorPicker({
    Name = "Tracer color",
    Color = Color3.fromRGB(0, 255, 0),
    Flag = "FB_TracerColor",
    Callback = function(Value)
        getgenv().FB_TracerColor = Value
    end,
})

ESPTab:CreateColorPicker({
    Name = "Chams outline color",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "FB_ChamsOut",
    Callback = function(Value)
        getgenv().FB_ChamsOut = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Off-screen arrows",
    CurrentValue = false,
    Flag = "FB_Arrows",
    Callback = function(Value)
        getgenv().FB_Arrows = Value
    end,
})

ESPTab:CreateColorPicker({
    Name = "Arrow color",
    Color = Color3.fromRGB(255, 50, 50),
    Flag = "FB_ArrowColor",
    Callback = function(Value)
        getgenv().FB_ArrowColor = Value
    end,
})

ESPTab:CreateSlider({
    Name = "Arrow size",
    Range = {6, 30},
    Increment = 1,
    CurrentValue = 14,
    Callback = function(Value)
        getgenv().FB_ArrowSize = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Radar (bottom-right)",
    CurrentValue = false,
    Flag = "FB_Radar",
    Callback = function(Value)
        getgenv().FB_Radar = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Radar sweep",
    CurrentValue = false,
    Flag = "FB_RadarSweep",
    Callback = function(Value)
        getgenv().FB_RadarSweep = Value
    end,
})

ESPTab:CreateSlider({
    Name = "Radar size",
    Range = {100, 250},
    Increment = 10,
    CurrentValue = 150,
    Callback = function(Value)
        getgenv().FB_RadarSize = Value
    end,
})

ESPTab:CreateSlider({
    Name = "Radar range (studs)",
    Range = {100, 1000},
    Increment = 50,
    CurrentValue = 250,
    Callback = function(Value)
        getgenv().FB_RadarRange = Value
    end,
})

if not DRAW_OK then
    ESPTab:CreateLabel("No Drawing API: lines/boxes disabled, chams+names work")
end

-- ================= CLIENT AIM (silent, camera stays) =================
-- Redirects YOUR shots to the nearest enemy head inside FOV.
-- Hook body is fully pcall-protected: any error -> original shot goes through.

local function wallClear(fromPos, targetChar, headPos)
    if not getgenv().FB_AimWallCheck then return true end -- through walls
    local ok, res = pcall(function()
        local params = RaycastParams.new()
        -- default FilterType already excludes the list (old + new API)
        local filter = {}
        if LocalPlayer.Character then table.insert(filter, LocalPlayer.Character) end
        if targetChar then table.insert(filter, targetChar) end
        params.FilterDescendantsInstances = filter
        params.IgnoreWater = true
        local dir = headPos - fromPos
        return workspace:Raycast(fromPos, dir, params)
    end)
    if not ok then return true end
    return res == nil
end

local function getAimTarget()
    local cam = workspace.CurrentCamera
    if not cam then return nil, nil end
    -- sticky lock: keep current target while alive + visible
    if getgenv().FB_Sticky and getgenv().FB_LockPlayer then
        local lp = getgenv().FB_LockPlayer
        local okS, still = pcall(function()
            if lp.Parent == nil then return false end
            local ch = lp.Character
            local hp2 = ch and ch:FindFirstChild(getgenv().FB_HitPart or "Head")
            if not hp2 then hp2 = ch and ch:FindFirstChild("Head") end
            local hum = ch and ch:FindFirstChildOfClass("Humanoid")
            if not hp2 or not hum or hum.Health <= 0 then return false end
            local _, vis = cam:WorldToViewportPoint(hp2.Position)
            return vis and hp2 or false
        end)
        if okS and still then
            return still, lp
        end
        getgenv().FB_LockPlayer = nil
    end
    -- crosshair is always screen center (mouse pos lies when cursor is free/locked)
    local vs = cam.ViewportSize
    local mx, my = vs.X / 2, vs.Y / 2
    local fov = getgenv().FB_AimFOV or 150
    -- distance ALWAYS from the gun in hands (short gun = no far locks)
    local maxD = getGunRange(getEquippedGun()) or 2000
    local squad = getgenv().FB_SkipSquad and getSquadmates() or {}
    local mode = "Crosshair" -- always POV: nearest to crosshair
    local hitPartName = getgenv().FB_HitPart or "Head"
    local best, bestPlayer, bestScore = nil, nil, nil
    local camPos = cam.CFrame.Position
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and not isFriend(p) and not squad[p.Name] then
        local ch = p.Character
        local part = ch and ch:FindFirstChild(hitPartName)
        if not part then part = ch and ch:FindFirstChild("Head") end
        local hum = ch and ch:FindFirstChildOfClass("Humanoid")
        local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
        if part and hum and hum.Health > 0 and hrp then
            local dist3d = myHRP and (myHRP.Position - hrp.Position).Magnitude or 0
            if dist3d <= maxD then
                local okP, pos, onScreen = pcall(function()
                    return cam:WorldToViewportPoint(part.Position)
                end)
                if okP and onScreen then
                    local d = math.sqrt((pos.X - mx) ^ 2 + (pos.Y - my) ^ 2)
                    if d < fov then
                        local score = (mode == "Nearest") and dist3d or d
                        if bestScore == nil or score < bestScore then
                            local clear = wallClear(camPos, ch, part.Position)
                            if clear then
                                bestScore = score
                                best = part
                                bestPlayer = p
                            end
                        end
                    end
                end
            end
        end
        end
    end
    if bestPlayer and getgenv().FB_Sticky then
        getgenv().FB_LockPlayer = bestPlayer
    end
    return best, bestPlayer
end

local ShootRemote = nil
local HitRemote = nil
pcall(function()
    ShootRemote = game:GetService("ReplicatedStorage").Remotes.Shoot
end)
pcall(function()
    HitRemote = game:GetService("ReplicatedStorage").Remotes.Hit
end)

-- session kills from Killfeed (killer, victim, weapon, ...)
pcall(function()
    local kf = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Killfeed")
    if kf then
        kf.OnClientEvent:Connect(function(killer, ...)
            if killer == LocalPlayer.Name then
                getgenv().FB_Kills = (getgenv().FB_Kills or 0) + 1
            end
        end)
    end
end)

-- equipped gun instance: Character.Items["<GunName>"] (see spy: workspace.<Name>.Items["Jonny Gun"])
-- prefers items with Ammo child (real guns, not pickaxe/build)
getEquippedGun = function()
    local ch = LocalPlayer.Character
    if not ch then return nil, "no character" end
    local items = ch:FindFirstChild("Items")
    if not items then return nil, "no Items folder" end
    local function isGun(it)
        return it and it:FindFirstChild("Ammo") ~= nil
    end
    local tool = ch:FindFirstChildOfClass("Tool")
    if tool then
        local it = items:FindFirstChild(tool.Name)
        if isGun(it) then return it, nil end
        if it then return nil, "holding " .. tool.Name .. " (no Ammo)" end
    end
    local eq = ch:FindFirstChild("Equipped")
    if eq then
        local okV, v = pcall(function() return eq.Value end)
        if okV and v ~= nil then
            if typeof(v) == "Instance" then
                if v.Parent == items and isGun(v) then return v, nil end
            else
                local it = items:FindFirstChild(tostring(v))
                if isGun(it) then return it, nil end
            end
        end
    end
    for _, it in ipairs(items:GetChildren()) do
        if isGun(it) then return it, "fallback: " .. it.Name end
    end
    return nil, "no gun with Ammo found"
end

getgenv().FB_SilentShots = 0
getgenv().FB_SilentDelay = 0.03

-- muzzle of the gun: game uses Handle -> Muzzle (Gun module: p2.Handle.Muzzle.WorldPosition)
local function getMuzzleEx(gun)
    if gun then
        local h = gun:FindFirstChild("Handle")
        if h then
            local mz = h:FindFirstChild("Muzzle")
            if mz and mz:IsA("BasePart") then
                return mz.Position, "Muzzle"
            end
        end
        for _, n in ipairs({"Muzzle", "Barrel", "Tip", "ShootPoint", "Shoot", "End", "Nozzle", "Front", "Sight"}) do
            local p = gun:FindFirstChild(n, true)
            if p and p:IsA("BasePart") then
                return p.Position, n
            end
        end
        local att = gun:FindFirstChild("Attachments", true)
        if att then
            for _, d in ipairs(att:GetDescendants()) do
                if d:IsA("BasePart") then
                    return d.Position, d.Name
                end
            end
        end
        if h and h:IsA("BasePart") then
            return h.Position, "Handle"
        end
    end
    local cam = workspace.CurrentCamera
    if cam then return cam.CFrame.Position, "camera" end
    return nil, "none"
end

local function getMuzzle(gun)
    local pos, _ = getMuzzleEx(gun)
    return pos
end

local function silentFire(head)
    local gun, gunErr = getEquippedGun()
    if not gun or not ShootRemote then
        return false, "gun: " .. tostring(gunErr or "no remote")
    end
    local from, mname = getMuzzleEx(gun)
    if not from then return false, "no muzzle" end
    local hp = head.Position
    local dir = hp - from
    if dir.Magnitude < 0.001 then return false, "too close" end
    dir = dir.Unit
    -- game form: Hit(part, 1) then Shoot(item, MUZZLE pos, {dir})
    if HitRemote then
        pcall(function()
            HitRemote:FireServer(head, 1)
        end)
    end
    local okF = pcall(function()
        ShootRemote:FireServer(gun, from, {[1] = dir})
    end)
    if okF then
        getgenv().FB_SilentShots = getgenv().FB_SilentShots + 1
        return true, gun.Name .. " via " .. mname
    end
    return false, "fire failed"
end

-- precomputed shot: RenderStepped refreshes it, hook ONLY swaps numbers (nothing throwable inside)
getgenv().FB_PreShot = nil
task.spawn(function()
    while true do
        task.wait(0.1)
        if getgenv().FB_Aim then
            local okP, errP = pcall(function()
                local head, plr = getAimTarget()
                if not head then
                    getgenv().FB_PreShot = nil
                    return
                end
                -- lock info always (even with no gun in hands)
                local shot = {part = head, player = plr, pos = head.Position}
                local gun = getEquippedGun()
                if gun then
                    local from = getMuzzle(gun)
                    if from then
                        local dir = head.Position - from
                        if dir.Magnitude > 0.001 then
                            shot.dir = dir.Unit
                            shot.dist = dir.Magnitude
                            local gr = getGunRange(gun)
                            shot.beyond = (gr ~= nil and dir.Magnitude > gr)
                        end
                    end
                end
                getgenv().FB_PreShot = shot
            end)
            if okP then
                getgenv().FB_PreErr = nil
            else
                getgenv().FB_PreShot = nil
                getgenv().FB_PreErr = tostring(errP):sub(1, 80)
            end
        else
            getgenv().FB_PreShot = nil
        end
    end
end)

local aimHooked = false
getgenv().FB_HookOK = false
local triggerOn = false

local function setTrigger(on)
    if triggerOn and not on then
        triggerOn = false
        return
    end
    if not on then return end
    if triggerOn then return end
    if typeof(mouse1click or nil) ~= "function" then
        notify("Triggerbot: no mouse1click in executor", 4)
        getgenv().FB_Trigger = false
        return
    end
    triggerOn = true
    task.spawn(function()
        while triggerOn and getgenv().FB_Trigger do
            if getgenv().FB_PreShot and getgenv().FB_PreShot.part then
                pcall(function()
                    mouse1click()
                end)
            end
            local dl = getgenv().FB_TriggerDelay or 0.2
            if dl < 0.05 then dl = 0.05 end
            task.wait(dl)
        end
        triggerOn = false
    end)
end

local function hookAim()
    if aimHooked then return true end
    if not ShootRemote then
        notify("No Shoot remote found", 4)
        return false
    end
    local ok = pcall(function()
        local old
        old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local okM, method = pcall(getnamecallmethod)
            if okM and method == "FireServer" and self == ShootRemote and getgenv().FB_Aim then
                local pre = getgenv().FB_PreShot
                if pre and pre.part and pre.part.Parent and pre.dir then
                    local n = select("#", ...)
                    if n >= 3 then
                        -- far target (beyond gun Range): Shoot can't reach, Hit-only attempt, keep original shot
                        if pre.beyond and getgenv().FB_FarHit then
                            local hr0 = HitRemote
                            if hr0 then
                                pcall(function()
                                    hr0:FireServer(pre.part, 1)
                                end)
                                getgenv().FB_SilentShots = getgenv().FB_SilentShots + 1
                            end
                            return old(self, ...)
                        end
                        local args = {...}
                        -- game form: Shoot(item, MUZZLE pos, {pellet dirs}); [1]/[2] stay EXACTLY
                        local nargs = {}
                        for i = 1, n do nargs[i] = args[i] end
                        local ndirs = {}
                        local cnt = 0
                        if type(nargs[3]) == "table" then
                            for k, _ in pairs(nargs[3]) do
                                if type(k) == "number" then
                                    ndirs[k] = pre.dir
                                    cnt = cnt + 1
                                end
                            end
                        else
                            ndirs = {[1] = pre.dir}
                            cnt = 1
                        end
                        if cnt < 1 then
                            ndirs = {[1] = pre.dir}
                            cnt = 1
                        end
                        nargs[3] = ndirs
                        -- game order: Hit(part, pellet) per pellet, then Shoot
                        local hr = HitRemote
                        if hr then
                            for i = 1, cnt do
                                pcall(function()
                                    hr:FireServer(pre.part, i)
                                end)
                            end
                        end
                        local done = false
                        pcall(function()
                            old(self, table.unpack(nargs, 1, n))
                            done = true
                        end)
                        if done then
                            getgenv().FB_SilentShots = getgenv().FB_SilentShots + 1
                        end
                        return
                    end
                end
            end
            return old(self, ...)
        end))
    end)
    if ok then
        aimHooked = true
        getgenv().FB_HookOK = true
        return true
    else
        getgenv().FB_HookOK = false
        notify("Aim hook failed: executor blocked", 4)
        return false
    end
end

local aimStatusLabel = AimTab:CreateLabel("HOOK: off | TARGET: none")
task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            local hook = getgenv().FB_HookOK and "on" or "off"
            local tgt = "none"
            local pre = getgenv().FB_PreShot
            if pre and pre.player and pre.part and pre.part.Parent then
                local dd = pre.dist
                if dd == nil and pre.pos and LocalPlayer.Character then
                    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then dd = (hrp.Position - pre.pos).Magnitude end
                end
                tgt = pre.player.Name .. " " .. math.floor(dd or 0) .. "m"
                if not pre.dir then
                    tgt = tgt .. " (no gun)"
                end
            elseif getgenv().FB_Aim then
                if getgenv().FB_PreErr then
                    tgt = "ERR: " .. getgenv().FB_PreErr
                else
                    local gun, gunErr = getEquippedGun()
                    if not gun then
                        tgt = "no gun (" .. tostring(gunErr) .. ")"
                    else
                        tgt = "searching... [" .. gun.Name .. "]"
                    end
                end
            end
            local txt = "HOOK: " .. hook .. " | TARGET: " .. tgt
            if aimStatusLabel then
                if aimStatusLabel.Set then
                    aimStatusLabel:Set(txt)
                else
                    aimStatusLabel.Text = txt
                end
            end
        end)
    end
end)

AimTab:CreateToggle({
    Name = "Client Aim (silent)",
    CurrentValue = false,
    Flag = "FB_Aim",
    Callback = function(Value)
        if Value then
            if hookAim() then
                getgenv().FB_Aim = true
                notify("Silent Aim: ON (shots redirect to head)", 2)
            else
                getgenv().FB_Aim = false
            end
        else
            getgenv().FB_Aim = false
            notify("Silent Aim: OFF", 2)
        end
    end,
})

AimTab:CreateSlider({
    Name = "Aim FOV (pixels)",
    Range = {30, 500},
    Increment = 10,
    CurrentValue = 150,
    Callback = function(Value)
        getgenv().FB_AimFOV = Value
    end,
})

-- visible FOV circle (Drawing API)
getgenv().FB_ShowFOV = true
local fovCircle = nil
if DRAW_OK then
    pcall(function()
        fovCircle = Drawing.new("Circle")
        fovCircle.Thickness = 2
        fovCircle.Color = Color3.fromRGB(0, 255, 0)
        fovCircle.Filled = false
        fovCircle.Visible = false
    end)
end

-- center crosshair REMOVED per request (only FOV circle stays)
RunService.RenderStepped:Connect(function()
    if not fovCircle then return end
    local okV = pcall(function()
        local cam = workspace.CurrentCamera
        if cam and getgenv().FB_ShowFOV then
            local vs = cam.ViewportSize
            fovCircle.Position = Vector2.new(vs.X / 2, vs.Y / 2)
            local pr = getgenv().FB_FOVPulse or 0
            local rad = getgenv().FB_AimFOV or 150
            if pr > 0 then
                rad = rad + math.sin(os.clock() * (getgenv().FB_AnimSpeed or 3)) * pr
            end
            if rad < 5 then rad = 5 end
            fovCircle.Radius = rad
            if getgenv().FB_Rainbow then
                fovCircle.Color = Color3.fromHSV((os.clock() * 0.15) % 1, 1, 1)
            else
                fovCircle.Color = getgenv().FB_FOVColor or Color3.fromRGB(0, 255, 0)
            end
            fovCircle.Thickness = getgenv().FB_FOVThick or 2
            fovCircle.Visible = true
        else
            fovCircle.Visible = false
        end
    end)
end)

AimTab:CreateToggle({
    Name = "Show FOV circle",
    CurrentValue = true,
    Flag = "FB_ShowFOV",
    Callback = function(Value)
        getgenv().FB_ShowFOV = Value
    end,
})

AimTab:CreateColorPicker({
    Name = "FOV circle color",
    Color = Color3.fromRGB(0, 255, 0),
    Flag = "FB_FOVColor",
    Callback = function(Value)
        getgenv().FB_FOVColor = Value
    end,
})

AimTab:CreateSlider({
    Name = "FOV circle thickness",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 2,
    Callback = function(Value)
        getgenv().FB_FOVThick = Value
    end,
})

AimTab:CreateSlider({
    Name = "FOV pulse (0 = off)",
    Range = {0, 30},
    Increment = 1,
    CurrentValue = 0,
    Callback = function(Value)
        getgenv().FB_FOVPulse = Value
    end,
})

AimTab:CreateSlider({
    Name = "Lock pulse (0 = off)",
    Range = {0, 10},
    Increment = 1,
    CurrentValue = 0,
    Callback = function(Value)
        getgenv().FB_LockPulse = Value
    end,
})

AimTab:CreateToggle({
    Name = "Rainbow visuals",
    CurrentValue = false,
    Flag = "FB_Rainbow",
    Callback = function(Value)
        getgenv().FB_Rainbow = Value
    end,
})

AimTab:CreateSlider({
    Name = "Animation speed",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 3,
    Callback = function(Value)
        getgenv().FB_AnimSpeed = Value
    end,
})

AimTab:CreateToggle({
    Name = "Wall check (off = through walls)",
    CurrentValue = false,
    Flag = "FB_WallCheck",
    Callback = function(Value)
        getgenv().FB_AimWallCheck = Value
        notify("Wall check: " .. (Value and "ON" or "OFF (through walls)"), 2)
    end,
})

AimTab:CreateToggle({
    Name = "Skip squadmates (no damage)",
    CurrentValue = true,
    Flag = "FB_SkipSquad",
    Callback = function(Value)
        getgenv().FB_SkipSquad = Value
    end,
})

AimTab:CreateDropdown({
    Name = "Hit part",
    Options = {"Head", "UpperTorso", "HumanoidRootPart"},
    CurrentOption = {"Head"},
    Callback = function(Option)
        local v = (typeof(Option) == "table") and Option[1] or Option
        getgenv().FB_HitPart = v
        notify("Hit part: " .. tostring(v), 2)
    end,
})

AimTab:CreateToggle({
    Name = "Sticky target (keep lock)",
    CurrentValue = false,
    Flag = "FB_Sticky",
    Callback = function(Value)
        getgenv().FB_Sticky = Value
        if not Value then getgenv().FB_LockPlayer = nil end
    end,
})

AimTab:CreateToggle({
    Name = "Triggerbot (auto shoot)",
    CurrentValue = false,
    Flag = "FB_Trigger",
    Callback = function(Value)
        getgenv().FB_Trigger = Value
        setTrigger(Value)
        notify("Triggerbot: " .. (Value and "ON" or "OFF"), 2)
    end,
})

AimTab:CreateSlider({
    Name = "Trigger delay (sec)",
    Range = {5, 100},
    Increment = 5,
    CurrentValue = 20,
    Callback = function(Value)
        getgenv().FB_TriggerDelay = Value / 100
    end,
})

AimTab:CreateToggle({
    Name = "Target info panel",
    CurrentValue = true,
    Flag = "FB_TargetPanel",
    Callback = function(Value)
        getgenv().FB_ShowTargetPanel = Value
    end,
})

AimTab:CreateSlider({
    Name = "Panel transparency",
    Range = {0, 9},
    Increment = 1,
    CurrentValue = 2,
    Callback = function(Value)
        getgenv().FB_PanelTransp = Value / 10
    end,
})

AimTab:CreateToggle({
    Name = "Panel HP bar",
    CurrentValue = true,
    Flag = "FB_HPBar",
    Callback = function(Value)
        getgenv().FB_HPBar = Value
    end,
})

AimTab:CreateToggle({
    Name = "Lock indicator (spinning)",
    CurrentValue = true,
    Flag = "FB_LockInd",
    Callback = function(Value)
        getgenv().FB_LockIndicator = Value
    end,
})

AimTab:CreateColorPicker({
    Name = "Lock indicator color",
    Color = Color3.fromRGB(255, 50, 50),
    Flag = "FB_LockColor",
    Callback = function(Value)
        getgenv().FB_LockColor = Value
    end,
})

AimTab:CreateSlider({
    Name = "Lock indicator size",
    Range = {8, 40},
    Increment = 1,
    CurrentValue = 18,
    Callback = function(Value)
        getgenv().FB_LockSize = Value
    end,
})

AimTab:CreateSlider({
    Name = "Lock thickness",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 2,
    Callback = function(Value)
        getgenv().FB_LockThick = Value
    end,
})

-- ================= FRIENDS =================
local FriendsTab = Window:CreateTab("Friends", 4483362458)
local friendInput = {name = ""}
local friendListLabel = nil
local playerDropdown = nil

local function getServerNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(names, p.Name)
        end
    end
    table.sort(names)
    if #names == 0 then names = {"No players"} end
    return names
end

local function selectedPlayerName()
    local v = friendInput.name
    if v and #v > 0 and v ~= "No players" then return v end
    return nil
end

local function refreshFriendList()
    local names = {}
    for n, _ in pairs(getgenv().FB_Friends) do table.insert(names, n) end
    table.sort(names)
    local txt = (#names == 0) and "No friends" or table.concat(names, ", ")
    if friendListLabel then
        pcall(function()
            if friendListLabel.Set then
                friendListLabel:Set(txt)
            else
                friendListLabel.Text = txt
            end
        end)
    end
end

playerDropdown = FriendsTab:CreateDropdown({
    Name = "Players on server",
    Options = getServerNames(),
    CurrentOption = {"No players"},
    Callback = function(opt)
        local v = (typeof(opt) == "table") and opt[1] or opt
        friendInput.name = v or ""
    end,
})

FriendsTab:CreateButton({
    Name = "Refresh player list",
    Callback = function()
        local names = getServerNames()
        if playerDropdown then
            pcall(function() playerDropdown:Refresh(names) end)
        end
        notify("Players: " .. #names, 2)
    end,
})

FriendsTab:CreateInput({
    Name = "Friend name (or pick above)",
    PlaceholderText = "Exact nickname...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local t = (text or ""):match("^%s*(.-)%s*$")
        if t and #t > 0 then
            friendInput.name = t
        end
    end,
})

FriendsTab:CreateButton({
    Name = "Add friend",
    Callback = function()
        local n = selectedPlayerName()
        if n then
            getgenv().FB_Friends[n] = true
            refreshFriendList()
            notify("Friend added: " .. n, 2)
        else
            notify("Pick a player first", 2)
        end
    end,
})

FriendsTab:CreateButton({
    Name = "Remove friend",
    Callback = function()
        local n = selectedPlayerName()
        if n and getgenv().FB_Friends[n] then
            getgenv().FB_Friends[n] = nil
            refreshFriendList()
            notify("Friend removed: " .. n, 2)
        end
    end,
})

friendListLabel = FriendsTab:CreateLabel("No friends")

FriendsTab:CreateButton({
    Name = "Show friends (list)",
    Callback = function()
        refreshFriendList()
        local names = {}
        for n, _ in pairs(getgenv().FB_Friends) do table.insert(names, n) end
        table.sort(names)
        local txt = (#names == 0) and "No friends" or table.concat(names, ", ")
        print("[FB Friends] " .. txt)
        notify(txt, 3)
    end,
})

FriendsTab:CreateLabel("Pick players above, they become friends. Aim NEVER targets friends.")

-- ================= MISC (speed + chests) =================
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateToggle({
    Name = "Speed lock (walk + sprint)",
    CurrentValue = false,
    Flag = "FB_SpeedLock",
    Callback = function(Value)
        getgenv().FB_SpeedLock = Value
        notify("Speed lock: " .. (Value and "ON" or "OFF"), 2)
    end,
})

MiscTab:CreateSlider({
    Name = "Walk speed",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        getgenv().FB_WalkSpeed = Value
    end,
})

MiscTab:CreateSlider({
    Name = "Sprint speed (hold Shift)",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 32,
    Callback = function(Value)
        getgenv().FB_SprintSpeed = Value
    end,
})

local FB_UIS = game:GetService("UserInputService")
local fbShiftHeld = false
pcall(function()
    FB_UIS.InputBegan:Connect(function(input, gp)
        if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
            fbShiftHeld = true
        end
    end)
    FB_UIS.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
            fbShiftHeld = false
        end
    end)
end)

local function fbTargetSpeed()
    if fbShiftHeld then
        return getgenv().FB_SprintSpeed or 32
    end
    return getgenv().FB_WalkSpeed or 16
end

local function fbApplySpeed()
    if not getgenv().FB_SpeedLock then return end
    pcall(function()
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = fbTargetSpeed() end
    end)
end

-- enforce every frame (game resets speed constantly) + instant reset on change + respawn
pcall(function()
    game:GetService("RunService").Heartbeat:Connect(function()
        fbApplySpeed()
    end)
end)
local fbSpeedConn = nil
local function fbHookSpeed(hum)
    if fbSpeedConn then pcall(function() fbSpeedConn:Disconnect() end) end
    fbSpeedConn = hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        fbApplySpeed()
    end)
end
pcall(function()
    local ch = LocalPlayer.Character
    local hum = ch and ch:FindFirstChildOfClass("Humanoid")
    if hum then fbHookSpeed(hum) end
end)
pcall(function()
    LocalPlayer.CharacterAdded:Connect(function(ch)
        ch:WaitForChild("Humanoid", 5)
        task.wait(0.3)
        local hum = ch:FindFirstChildOfClass("Humanoid")
        if hum then fbHookSpeed(hum) end
        fbApplySpeed()
    end)
end)

local ChestRemote = nil
pcall(function()
    ChestRemote = game:GetService("ReplicatedStorage").Remotes.Chest
end)

local function findChestPrompt(c)
    -- recursive flag on FindFirstChildOfClass is unreliable here: scan manually
    -- path is Chest > Key > ProximityPrompt
    for _, d in ipairs(c:GetDescendants()) do
        if d:IsA("ProximityPrompt") then return d end
    end
    return nil
end

local function chestPos(c)
    local cpos = nil
    pcall(function()
        local piv = c:GetPivot()
        cpos = piv.Position
    end)
    if not cpos then
        for _, d in ipairs(c:GetDescendants()) do
            if d:IsA("BasePart") then cpos = d.Position break end
        end
    end
    return cpos
end

local function isChestClosed(c)
    -- Closed/Open parts first (prompt may start disabled until near)
    local cl = c:FindFirstChild("Closed", true)
    if cl and cl:IsA("BasePart") then return cl.Transparency < 1 end
    local op = c:FindFirstChild("Open", true)
    if op and op:IsA("BasePart") then return op.Transparency >= 1 end
    local pr = findChestPrompt(c)
    if pr then return pr.Enabled end
    return true
end

local chestHL = {}
local chestFired = {}

local function fireChestPrompt(c)
    local pr = findChestPrompt(c)
    if not pr then return false end
    -- only zero the hold: distance/LOS untouched so prompts don't pop up from afar
    pcall(function()
        pr.HoldDuration = 0
    end)
    local fired = false
    pcall(function()
        if typeof(fireproximityprompt or nil) == "function" then
            fireproximityprompt(pr)
            fired = true
        end
    end)
    return fired
end

local function openChest(c)
    -- same as Dex manual: fire the prompt (game runs its own open code), plus direct remote backup
    local a = fireChestPrompt(c)
    local b = false
    if ChestRemote then
        pcall(function()
            ChestRemote:FireServer(true, c)
            b = true
        end)
    end
    return a or b
end

MiscTab:CreateToggle({
    Name = "Instant chests (no hold)",
    CurrentValue = false,
    Flag = "FB_Chests",
    Callback = function(Value)
        getgenv().FB_Chests = Value
        notify("Instant chests: " .. (Value and "ON" or "OFF"), 2)
    end,
})

MiscTab:CreateToggle({
    Name = "Auto open near chest",
    CurrentValue = false,
    Flag = "FB_ChestNear",
    Callback = function(Value)
        getgenv().FB_ChestNear = Value
        notify("Auto open near: " .. (Value and "ON" or "OFF"), 2)
    end,
})

getgenv().FB_PerfPanel = true

local BoosterRemote = nil
pcall(function()
    BoosterRemote = game:GetService("ReplicatedStorage").Remotes.Booster
end)
local EquipRemote = nil
pcall(function()
    EquipRemote = game:GetService("ReplicatedStorage").Remotes.Equip
end)

local function findHealItem(names)
    local ch = LocalPlayer.Character
    if not ch then return nil end
    local items = ch:FindFirstChild("Items")
    if not items then return nil end
    for _, n in ipairs(names) do
        local it = items:FindFirstChild(n)
        if it then return it end
    end
    return nil
end

local lastHealUse = 0

MiscTab:CreateToggle({
    Name = "Auto HP (Health Pack)",
    CurrentValue = false,
    Flag = "FB_AutoHP",
    Callback = function(Value)
        getgenv().FB_AutoHP = Value
    end,
})

MiscTab:CreateToggle({
    Name = "Auto Shield (Shield Potion)",
    CurrentValue = false,
    Flag = "FB_AutoShield",
    Callback = function(Value)
        getgenv().FB_AutoShield = Value
    end,
})

MiscTab:CreateSlider({
    Name = "HP threshold",
    Range = {10, 100},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        getgenv().FB_HPThresh = Value
    end,
})

MiscTab:CreateSlider({
    Name = "Shield threshold",
    Range = {0, 100},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        getgenv().FB_ShieldThresh = Value
    end,
})

MiscTab:CreateSlider({
    Name = "Heal cooldown (sec)",
    Range = {6, 25},
    Increment = 1,
    CurrentValue = 8,
    Callback = function(Value)
        getgenv().FB_HealCD = Value
    end,
})

MiscTab:CreateSlider({
    Name = "Heal hold time (sec)",
    Range = {2, 8},
    Increment = 1,
    CurrentValue = 4,
    Callback = function(Value)
        getgenv().FB_HealWait = Value
    end,
})

task.spawn(function()
    while true do
        task.wait(0.5)
        local now = os.clock()
        if (getgenv().FB_AutoHP or getgenv().FB_AutoShield) and BoosterRemote and now - lastHealUse >= (getgenv().FB_HealCD or 8) then
            pcall(function()
                local ch = LocalPlayer.Character
                local hum = ch and ch:FindFirstChildOfClass("Humanoid")
                if not hum or hum.Health <= 0 then return end
                local shield = 0
                local sh = ch:FindFirstChild("Shield")
                if sh then
                    local okV, v = pcall(function() return sh.Value end)
                    if okV and type(v) == "number" then shield = v end
                end
                local want = nil
                local kind = nil
                if getgenv().FB_AutoShield and shield < (getgenv().FB_ShieldThresh or 50) then
                    want = findHealItem({"Shield Potion", "Medkit"})
                    kind = "shield"
                end
                if not want and getgenv().FB_AutoHP and hum.Health < (getgenv().FB_HPThresh or 50) then
                    want = findHealItem({"Health Pack", "Medkit"})
                    kind = "hp"
                end
                if not want then return end
                -- equip in hands, HOLD fire while applying, then take gun back
                local curGun = getEquippedGun()
                if EquipRemote then
                    pcall(function() EquipRemote:FireServer(want) end)
                end
                task.wait(0.5)
                BoosterRemote:FireServer("Init", want)
                task.wait(0.2)
                BoosterRemote:FireServer("Use", want, 100)
                local held = false
                pcall(function()
                    if typeof(mouse1press or nil) == "function" then
                        mouse1press()
                        held = true
                    end
                end)
                task.wait(getgenv().FB_HealWait or 4)
                if held then
                    pcall(function()
                        if typeof(mouse1release or nil) == "function" then
                            mouse1release()
                        else
                            mouse1click()
                        end
                    end)
                end
                if curGun and curGun.Parent then
                    if EquipRemote then
                        pcall(function() EquipRemote:FireServer(curGun) end)
                    end
                end
                lastHealUse = os.clock()
                notify("Heal applied: " .. kind .. " (" .. want.Name .. ")", 2)
            end)
        end
    end
end)

-- ===== TP all players to me: they land behind me and follow =====
getgenv().FB_TPAll = false
getgenv().FB_TPDist = 12

MiscTab:CreateToggle({
    Name = "TP all players to me",
    CurrentValue = false,
    Flag = "FB_TPAll",
    Callback = function(Value)
        getgenv().FB_TPAll = Value
        notify("TP players: " .. (Value and "ON" or "OFF"), 2)
    end,
})

MiscTab:CreateSlider({
    Name = "TP distance behind",
    Range = {5, 60},
    Increment = 1,
    CurrentValue = 12,
    Callback = function(Value)
        getgenv().FB_TPDist = Value
    end,
})

task.spawn(function()
    while true do
        task.wait(0.07) -- fast: a freshly spawned player lands here immediately
        if getgenv().FB_TPAll then
            pcall(function()
                local ch = LocalPlayer.Character
                local myHRP = ch and ch:FindFirstChild("HumanoidRootPart")
                local myHum = ch and ch:FindFirstChildOfClass("Humanoid")
                if not myHRP or not myHum or myHum.Health <= 0 then return end
                local dist = getgenv().FB_TPDist or 12
                -- ONE spot behind my back, it moves with me -> they follow in a crowd
                local behind = (myHRP.CFrame * CFrame.new(0, 0, dist)).Position
                local spot = Vector3.new(behind.X, myHRP.Position.Y + 2, behind.Z)
                local i = 0
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer then
                        local c = p.Character
                        local hrp = c and c:FindFirstChild("HumanoidRootPart")
                        local hum = c and c:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            i = i + 1
                            -- small ring offset so they stand AROUND the spot, not inside each other
                            local ang = (i * 2.4)
                            local off = Vector3.new(math.cos(ang) * 2, 0, math.sin(ang) * 2)
                            local dest = spot + off
                            -- only pull them if they drifted (lets them walk a bit, then snap back)
                            local dSpot = (hrp.Position - dest).Magnitude
                            if dSpot > 4 then
                                pcall(function()
                                    hrp.Velocity = Vector3.zero
                                    hrp.RotVelocity = Vector3.zero
                                    hrp.CFrame = CFrame.lookAt(dest, Vector3.new(myHRP.Position.X, dest.Y, myHRP.Position.Z))
                                end)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

MiscTab:CreateToggle({
    Name = "Ping/FPS panel",
    CurrentValue = true,
    Flag = "FB_PerfPanel",
    Callback = function(Value)
        getgenv().FB_PerfPanel = Value
        local g = getgenv().FB_PerfGui
        if g then
            pcall(function() g.Enabled = Value end)
        end
    end,
})

-- ping/fps counter (bottom-left)
local perfFrames, perfFps = 0, 0
pcall(function()
    RunService.RenderStepped:Connect(function()
        perfFrames = perfFrames + 1
    end)
end)
task.spawn(function()
    local gui = nil
    pcall(function()
        local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if pg then
            gui = Instance.new("ScreenGui")
            gui.Name = "FB_Perf"
            gui.ResetOnSpawn = false
            gui.DisplayOrder = 40
            local lbl = Instance.new("TextLabel")
            lbl.Name = "Text"
            lbl.Size = UDim2.new(0, 230, 0, 24)
            lbl.Position = UDim2.new(0, 10, 1, -34)
            lbl.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
            lbl.BackgroundTransparency = 0.35
            lbl.TextColor3 = Color3.fromRGB(120, 255, 120)
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Text = "FPS: ? | Ping: ?"
            local pad = Instance.new("UIPadding")
            pad.PaddingLeft = UDim.new(0, 8)
            pad.Parent = lbl
            local cr = Instance.new("UICorner")
            cr.CornerRadius = UDim.new(0, 6)
            cr.Parent = lbl
            lbl.Parent = gui
            gui.Parent = pg
            getgenv().FB_PerfGui = gui
            getgenv().FB_PerfLabel = lbl
        end
    end)
    while true do
        task.wait(1.0)
        perfFps = perfFrames
        perfFrames = 0
        local ping = "?"
        pcall(function()
            ping = tostring(math.floor(LocalPlayer:GetNetworkPing() * 1000)) .. "ms"
        end)
        local lbl = getgenv().FB_PerfLabel
        if lbl and lbl.Parent then
            pcall(function()
                lbl.Text = "FPS: " .. perfFps .. " | Ping: " .. ping .. " | K: " .. tostring(getgenv().FB_Kills or 0)
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1.0)
        if getgenv().FB_Chests or getgenv().FB_ChestESP or getgenv().FB_ChestNear then
            pcall(function()
                local folder = workspace:FindFirstChild("Chests")
                if not folder then return end
                local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local now = os.clock()
                for _, c in ipairs(folder:GetChildren()) do
                    if c.Name == "Chest" then
                        local closed = isChestClosed(c)
                        if closed and (getgenv().FB_Chests or getgenv().FB_ChestNear) then
                            -- near mode works only within 16m (server needs proximity)
                            local nearOk = getgenv().FB_Chests
                            if not nearOk and getgenv().FB_ChestNear and hrp then
                                local cpos = chestPos(c)
                                if cpos and (hrp.Position - cpos).Magnitude <= 16 then
                                    nearOk = true
                                end
                            end
                            if nearOk then
                                local last = chestFired[c] or 0
                                if now - last > 3 then
                                    if openChest(c) then
                                        chestFired[c] = now
                                        print("[FB Chest] opened: " .. tostring(c:GetFullName()))
                                    end
                                end
                            end
                        end
                        if getgenv().FB_ChestESP and pg then
                            if closed then
                                local hl = chestHL[c]
                                if not hl then
                                    hl = Instance.new("Highlight")
                                    hl.Name = "FB_Chest"
                                    hl.FillColor = Color3.fromRGB(0, 255, 150)
                                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                    hl.FillTransparency = 0.6
                                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                    hl.Adornee = c
                                    hl.Parent = pg
                                    chestHL[c] = hl
                                end
                                hl.Enabled = true
                            else
                                local hl = chestHL[c]
                                if hl then hl.Enabled = false end
                            end
                        end
                    end
                end
                for c, hl in pairs(chestHL) do
                    if not c.Parent then
                        pcall(function() hl:Destroy() end)
                        chestHL[c] = nil
                        chestFired[c] = nil
                    elseif not getgenv().FB_ChestESP then
                        pcall(function() hl.Enabled = false end)
                    end
                end
            end)
        end
    end
end)

-- nearest chest watch: constantly fires the closest closed chest prompt
task.spawn(function()
    while true do
        task.wait(0.4)
        if getgenv().FB_ChestNear then
            pcall(function()
                local folder = workspace:FindFirstChild("Chests")
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not folder or not hrp then return end
                local best, bestD = nil, 16
                for _, c in ipairs(folder:GetChildren()) do
                    if c.Name == "Chest" and isChestClosed(c) then
                        local cpos = chestPos(c)
                        if cpos then
                            local d = (hrp.Position - cpos).Magnitude
                            if d < bestD then
                                bestD = d
                                best = c
                            end
                        end
                    end
                end
                if best then
                    if fireChestPrompt(best) then
                        chestFired[best] = os.clock()
                    end
                    if ChestRemote then
                        pcall(function()
                            ChestRemote:FireServer(true, best)
                        end)
                    end
                end
            end)
        end
    end
end)

-- ================= TARGET INFO PANEL (ELITE HUB style) =================
local targetGui, targetTitle, targetL1, targetL2, targetL3, targetHPBg, targetHPFill, targetAccent
pcall(function()
    local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if pg then
        targetGui = Instance.new("ScreenGui")
        targetGui.Name = "FB_TargetPanel"
        targetGui.ResetOnSpawn = false
        targetGui.DisplayOrder = 50
        local frame = Instance.new("Frame")
        frame.Name = "Panel"
        frame.Size = UDim2.new(0, 230, 0, 128)
        frame.Position = UDim2.new(1, -240, 0, 10)
        frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        frame.BackgroundTransparency = 0.25
        frame.BorderSizePixel = 0
        frame.Visible = false
        frame.Parent = targetGui
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(255, 60, 60)
        stroke.Transparency = 0.4
        stroke.Thickness = 1
        stroke.Parent = frame
        targetAccent = stroke
        targetTitle = Instance.new("TextLabel")
        targetTitle.Size = UDim2.new(1, 0, 0, 28)
        targetTitle.BackgroundTransparency = 1
        targetTitle.Text = "TARGET"
        targetTitle.TextColor3 = Color3.fromRGB(255, 70, 70)
        targetTitle.Font = Enum.Font.GothamBold
        targetTitle.TextSize = 17
        targetTitle.Parent = frame
        local function mkLine(y)
            local l = Instance.new("TextLabel")
            l.Size = UDim2.new(1, -12, 0, 20)
            l.Position = UDim2.new(0, 8, 0, y)
            l.BackgroundTransparency = 1
            l.Text = ""
            l.TextColor3 = Color3.fromRGB(235, 235, 235)
            l.Font = Enum.Font.Gotham
            l.TextSize = 14
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.Parent = frame
            return l
        end
        targetL1 = mkLine(30)
        targetL2 = mkLine(50)
        targetL3 = mkLine(70)
        targetHPBg = Instance.new("Frame")
        targetHPBg.Size = UDim2.new(1, -16, 0, 10)
        targetHPBg.Position = UDim2.new(0, 8, 0, 108)
        targetHPBg.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
        targetHPBg.BorderSizePixel = 0
        targetHPBg.Parent = frame
        local hpc = Instance.new("UICorner")
        hpc.CornerRadius = UDim.new(0, 5)
        hpc.Parent = targetHPBg
        targetHPFill = Instance.new("Frame")
        targetHPFill.Size = UDim2.new(1, 0, 1, 0)
        targetHPFill.BackgroundColor3 = Color3.fromRGB(60, 220, 90)
        targetHPFill.BorderSizePixel = 0
        targetHPFill.Parent = targetHPBg
        local hpf = Instance.new("UICorner")
        hpf.CornerRadius = UDim.new(0, 5)
        hpf.Parent = targetHPFill
        targetGui.Parent = pg
        getgenv().FB_TargetFrame = frame
        -- draggable panel
        local dragging = false
        local dragStart, startPos
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
            end
        end)
        frame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if dragging
                and (input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end)
    end
end)

-- lock indicator: corner brackets + center dot on locked target (like camera focus)
local lockBrackets, lockDot2 = {}, nil
if DRAW_OK then
    pcall(function()
        for i = 1, 8 do
            local l = Drawing.new("Line")
            l.Thickness = 2
            l.Color = Color3.fromRGB(255, 50, 50)
            l.Visible = false
            lockBrackets[i] = l
        end
        lockDot2 = Drawing.new("Circle")
        lockDot2.Radius = 4
        lockDot2.Filled = true
        lockDot2.Color = Color3.fromRGB(255, 50, 50)
        lockDot2.Visible = false
    end)
end

local function hideLock()
    for i = 1, 8 do
        if lockBrackets[i] then lockBrackets[i].Visible = false end
    end
    if lockDot2 then lockDot2.Visible = false end
end

RunService.RenderStepped:Connect(function()
    local okU = pcall(function()
        local cam = workspace.CurrentCamera
        local pre = getgenv().FB_PreShot
        local hasLock = pre and pre.player and pre.part and pre.part.Parent
        local showPanel = getgenv().FB_ShowTargetPanel and hasLock
        local frame = getgenv().FB_TargetFrame
        if frame then
            if showPanel then
                local p = pre.player
                local ch = p.Character
                local hum = ch and ch:FindFirstChildOfClass("Humanoid")
                local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
                local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local dist = (myHRP and hrp) and math.floor((myHRP.Position - hrp.Position).Magnitude) or 0
                local hp = hum and hum.Health or 0
                local maxhp = hum and hum.MaxHealth or 100
                targetL1.Text = "Name: " .. p.Name
                targetL2.Text = "HP: " .. math.floor(hp) .. " / " .. math.floor(maxhp)
                targetL3.Text = "Dist: " .. dist .. "m"
                frame.BackgroundTransparency = getgenv().FB_PanelTransp or 0.25
                if targetHPBg and targetHPFill then
                    targetHPBg.Visible = getgenv().FB_HPBar
                    local frac = math.clamp(hp / math.max(maxhp, 1), 0, 1)
                    targetHPFill.Size = UDim2.new(frac, 0, 1, 0)
                    if frac > 0.5 then
                        targetHPFill.BackgroundColor3 = Color3.fromRGB(60, 220, 90)
                    elseif frac > 0.25 then
                        targetHPFill.BackgroundColor3 = Color3.fromRGB(240, 200, 60)
                    else
                        targetHPFill.BackgroundColor3 = Color3.fromRGB(235, 60, 60)
                    end
                end
                frame.Visible = true
            else
                frame.Visible = false
            end
        end
        -- corner brackets + dot on locked head (independent from panel toggle)
        if #lockBrackets == 8 and lockDot2 then
            if hasLock and getgenv().FB_LockIndicator and cam then
                local hp2, vis2 = cam:WorldToViewportPoint(pre.part.Position)
                if vis2 then
                    local cx, cy = hp2.X, hp2.Y
                    local col = getgenv().FB_LockColor or Color3.fromRGB(255, 50, 50)
                    local s = getgenv().FB_LockSize or 18
                    local lp = getgenv().FB_LockPulse or 0
                    if lp > 0 then
                        s = s + math.sin(os.clock() * (getgenv().FB_AnimSpeed or 3)) * lp
                    end
                    if getgenv().FB_Rainbow then
                        col = Color3.fromHSV((os.clock() * 0.15) % 1, 1, 1)
                    end
                    local th = getgenv().FB_LockThick or 2
                    local a = s * 0.55
                    local segs = {
                        {Vector2.new(cx - s, cy - s), Vector2.new(cx - s + a, cy - s)},
                        {Vector2.new(cx - s, cy - s), Vector2.new(cx - s, cy - s + a)},
                        {Vector2.new(cx + s - a, cy - s), Vector2.new(cx + s, cy - s)},
                        {Vector2.new(cx + s, cy - s), Vector2.new(cx + s, cy - s + a)},
                        {Vector2.new(cx - s, cy + s), Vector2.new(cx - s + a, cy + s)},
                        {Vector2.new(cx - s, cy + s - a), Vector2.new(cx - s, cy + s)},
                        {Vector2.new(cx + s - a, cy + s), Vector2.new(cx + s, cy + s)},
                        {Vector2.new(cx + s, cy + s - a), Vector2.new(cx + s, cy + s)},
                    }
                    for i = 1, 8 do
                        lockBrackets[i].From = segs[i][1]
                        lockBrackets[i].To = segs[i][2]
                        lockBrackets[i].Color = col
                        lockBrackets[i].Thickness = th
                        lockBrackets[i].Visible = true
                    end
                    lockDot2.Position = Vector2.new(cx, cy)
                    lockDot2.Radius = math.max(2, s * 0.22)
                    lockDot2.Color = col
                    lockDot2.Visible = true
                else
                    hideLock()
                end
            else
                hideLock()
            end
        end
    end)
end)

notify("Loaded. ESP + Silent Aim + Friends + Misc ready.", 4)
