local HUB_URL = "https://raw.githubusercontent.com/SYMBIOSHUB/SYMBIOS-HUB/refs/heads/main/game%20script/RollAnime.luau"
local Games = {
    [107653945083776]  = HUB_URL,
    [133623616308412]  = HUB_URL,
    [133207600268474]  = HUB_URL,
    [133188236593503]  = "https://raw.githubusercontent.com/SYMBIOSHUB/SYMBIOS-HUB/refs/heads/main/game%20script/MagicLootOBF.lua",
}

local Players = game:GetService("Players")
local Tween   = game:GetService("TweenService")
if not game:IsLoaded() then game.Loaded:Wait() end
repeat task.wait() until Players.LocalPlayer

local C = {
    ground = Color3.fromHex("0a0a0b"), panel = Color3.fromHex("0f0f11"),
    ink = Color3.fromHex("f2f2ef"), ink2 = Color3.fromHex("c7c7c2"),
    dim = Color3.fromHex("74747a"), dim2 = Color3.fromHex("4c4c54"),
    line2 = Color3.fromHex("38383f"), red = Color3.fromHex("e0564e"),
}
local RM = "rbxasset://fonts/families/RobotoMono.json"
local FW = { med = Enum.FontWeight.SemiBold, semi = Enum.FontWeight.Bold, bold = Enum.FontWeight.Heavy }
local function mono(w) return Font.new(RM, w or FW.med) end
local function new(cls, props, kids)
    local o = Instance.new(cls)
    for k, v in pairs(props or {}) do o[k] = v end
    for _, c in ipairs(kids or {}) do c.Parent = o end
    return o
end
local function corner(r) return new("UICorner", { CornerRadius = UDim.new(0, r or 3) }) end
local function stroke(col, th) return new("UIStroke", { Color = col, Thickness = th or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }) end
local function track(s) return (s:gsub(".", "%0 ")):gsub(" $", "") end

local parentGui = (gethui and gethui()) or game:GetService("CoreGui")
if not parentGui then parentGui = Players.LocalPlayer:WaitForChild("PlayerGui") end
if parentGui:FindFirstChild("SYMBIOS_LOADER") then parentGui.SYMBIOS_LOADER:Destroy() end
local screen = new("ScreenGui", { Name = "SYMBIOS_LOADER", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 100000, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = parentGui })

local card = new("Frame", { Parent = screen, BackgroundColor3 = C.panel, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.fromOffset(360, 290) }, { corner(3), stroke(C.line2, 1) })
local function bracket(ax, ay)
    local b = new("Frame", { Parent = card, BackgroundTransparency = 1, AnchorPoint = Vector2.new(ax, ay), Position = UDim2.new(ax, ax == 0 and -1 or 1, ay, ay == 0 and -1 or 1), Size = UDim2.fromOffset(13, 13) })
    new("Frame", { Parent = b, BackgroundColor3 = C.ink, BorderSizePixel = 0, Size = UDim2.fromOffset(13, 2), AnchorPoint = Vector2.new(ax, ay), Position = UDim2.fromScale(ax, ay) })
    new("Frame", { Parent = b, BackgroundColor3 = C.ink, BorderSizePixel = 0, Size = UDim2.fromOffset(2, 13), AnchorPoint = Vector2.new(ax, ay), Position = UDim2.fromScale(ax, ay) })
end
bracket(0, 0); bracket(1, 0); bracket(0, 1); bracket(1, 1)

local box = new("Frame", { Parent = card, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(1, -56, 0, 0), AutomaticSize = Enum.AutomaticSize.Y }, { new("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }) })
new("TextLabel", { Parent = box, BackgroundTransparency = 1, FontFace = mono(FW.bold), Text = track("SYMBIOS"), TextSize = 26, TextColor3 = C.ink, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 32), LayoutOrder = 1 })
new("TextLabel", { Parent = box, BackgroundTransparency = 1, FontFace = mono(FW.med), Text = "HUB LOADER", TextSize = 11, TextColor3 = C.dim, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 16), LayoutOrder = 2 })
new("Frame", { Parent = box, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 14), LayoutOrder = 3 })
local log = new("Frame", { Parent = box, BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 4 }, { new("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder }) })
new("Frame", { Parent = box, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 14), LayoutOrder = 5 })
local prow = new("Frame", { Parent = box, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 16), LayoutOrder = 6 })
local ptrack = new("Frame", { Parent = prow, BackgroundColor3 = C.line2, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, -46, 0, 2) })
local pfill = new("Frame", { Parent = ptrack, BackgroundColor3 = C.ink, BorderSizePixel = 0, Size = UDim2.new(0, 0, 1, 0) })
local pct = new("TextLabel", { Parent = prow, BackgroundTransparency = 1, FontFace = mono(FW.semi), Text = "0%", TextSize = 12, TextColor3 = C.ink, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 40, 1, 0) })

local lines = {}
local function addStep(i, labels) lines[i] = new("TextLabel", { Parent = log, BackgroundTransparency = 1, FontFace = mono(FW.med), RichText = true, Text = "> " .. labels[i] .. "…", TextSize = 12, TextColor3 = C.dim, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, 0, 0, 15), LayoutOrder = i }) end
local function okStep(i, labels) if lines[i] then lines[i].Text = "> " .. labels[i] .. "  <font color='#f2f2ef'>OK</font>"; lines[i].TextColor3 = C.ink2 end end
local function failStep(i, labels) if lines[i] then lines[i].Text = "> " .. labels[i] .. "  <font color='#e0564e'>FAIL</font>"; lines[i].TextColor3 = C.ink2 end end
local prog = 0
local function setProgress(target, dur)
    local start, t0 = prog, os.clock()
    while true do
        local a = dur <= 0 and 1 or math.clamp((os.clock() - t0) / dur, 0, 1)
        prog = start + (target - start) * a
        pfill.Size = UDim2.new(prog, 0, 1, 0)
        pct.Text = string.format("%d%%", math.floor(prog * 100))
        if a >= 1 then break end
        task.wait()
    end
end

local ERR = {
    UNSUPPORTED = { "GAME NOT SUPPORTED", "This game isn't on the SYMBIOS list yet." },
    DOWNLOAD    = { "DOWNLOAD FAILED", "Couldn't fetch the hub, check your connection." },
    COMPILE     = { "SCRIPT ERROR", "The hub script failed to compile." },
    RUNTIME     = { "HUB CRASHED", "The hub errored while starting." },
}
local function showError(kind, detail)
    local info = ERR[kind] or { "ERROR", "Something went wrong." }
    for _, d in ipairs(box:GetChildren()) do if not d:IsA("UIListLayout") then Tween:Create(d, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play(); if d:IsA("TextLabel") then Tween:Create(d, TweenInfo.new(0.2), { TextTransparency = 1 }):Play() end end end
    task.wait(0.22); box:Destroy()

    local ebox = new("Frame", { Parent = card, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(1, -56, 0, 0), AutomaticSize = Enum.AutomaticSize.Y }, { new("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center }) })
    new("TextLabel", { Parent = ebox, BackgroundColor3 = C.red, BorderSizePixel = 0, FontFace = mono(FW.semi), Text = "ERROR", TextSize = 10, TextColor3 = C.ground, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 18), LayoutOrder = 1 }, { corner(2), new("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }) })
    new("TextLabel", { Parent = ebox, BackgroundTransparency = 1, FontFace = mono(FW.bold), Text = info[1], TextSize = 19, TextColor3 = C.ink, TextXAlignment = Enum.TextXAlignment.Center, TextWrapped = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 2 })
    new("TextLabel", { Parent = ebox, BackgroundTransparency = 1, FontFace = mono(FW.med), Text = info[2], TextSize = 12, TextColor3 = C.dim, TextXAlignment = Enum.TextXAlignment.Center, TextWrapped = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 3 })
    local sub = (kind == "UNSUPPORTED") and ("PLACE ID · " .. tostring(game.PlaceId)) or (detail and ("· " .. tostring(detail):sub(1, 80)) or nil)
    if sub then new("TextLabel", { Parent = ebox, BackgroundTransparency = 1, FontFace = mono(FW.med), Text = sub, TextSize = 11, TextColor3 = C.dim2, TextXAlignment = Enum.TextXAlignment.Center, TextWrapped = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 4 }) end
    new("Frame", { Parent = ebox, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 6), LayoutOrder = 5 })
    local dismiss = new("TextButton", { Parent = ebox, AutoButtonColor = false, FontFace = mono(FW.semi), Text = "DISMISS", TextSize = 12, TextColor3 = C.ink, BackgroundColor3 = C.panel, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 34), LayoutOrder = 6 }, { corner(2), stroke(C.line2, 1) })
    dismiss.MouseButton1Click:Connect(function() screen:Destroy() end)
end

task.spawn(function()
    local placeId = game.PlaceId
    local url, res, fn, compileErr
    local labels = { "INITIALIZING RUNTIME", "CHECKING FOR UPDATES", "VERIFYING GAME", "DOWNLOADING HUB", "COMPILING MODULES" }
    local work = {
        function() return true end,
        function() return true end,
        function() url = Games[placeId]; return url ~= nil, "UNSUPPORTED" end,
        function() local ok, r = pcall(function() return game:HttpGet(url) end); if ok and type(r) == "string" and #r > 0 then res = r; return true end; return false, "DOWNLOAD" end,
        function() local f, e = loadstring(res); if f then fn = f; return true end; compileErr = e; return false, "COMPILE" end,
    }
    local N = #labels + 1
    for i = 1, #labels do
        addStep(i, labels)
        task.wait(0.18)
        local ok, kind = work[i]()
        if not ok then
            failStep(i, labels); setProgress(i / N, 0.25); task.wait(0.35); showError(kind, kind == "COMPILE" and compileErr or nil); return
        end
        setProgress(i / N, 0.5); okStep(i, labels)
    end
    new("TextLabel", { Parent = log, BackgroundTransparency = 1, FontFace = mono(FW.semi), Text = "> LAUNCHING…", TextSize = 12, TextColor3 = C.ink, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, 0, 0, 15), LayoutOrder = #labels + 1 })
    setProgress(1, 0.4)
    task.wait(0.35)
    for _, d in ipairs(card:GetDescendants()) do
        if d:IsA("TextLabel") then Tween:Create(d, TweenInfo.new(0.35), { TextTransparency = 1 }):Play() end
        if d:IsA("Frame") then Tween:Create(d, TweenInfo.new(0.35), { BackgroundTransparency = 1 }):Play() end
    end
    local tw = Tween:Create(card, TweenInfo.new(0.4, Enum.EasingStyle.Quad), { BackgroundTransparency = 1 })
    tw:Play(); tw.Completed:Wait()
    local rok, rerr = pcall(fn)
    if rok then screen:Destroy() else card.BackgroundTransparency = 0; showError("RUNTIME", rerr) end
end)
