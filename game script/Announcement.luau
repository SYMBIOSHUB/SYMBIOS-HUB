local Players = game:GetService("Players")
local UIS     = game:GetService("UserInputService")
local Tween   = game:GetService("TweenService")
if not game:IsLoaded() then game.Loaded:Wait() end
if not Players.LocalPlayer then repeat task.wait() until Players.LocalPlayer end

local DISCORD_URL = "https://discord.com/invite/GxdzSeZHU"
local TITLE  = " 150 Members Milestone Giveaway! "
local BODY   =
    "Once our server reaches 150 members, we'll be dropping 1x FREE Potassium Key for one lucky winner! " ..
    "\n\nInvite your friends and let's get this server growing!"
local TAG    = "GIVEAWAY"
local AUTO_SECS = 12

local C = {
    scrim  = Color3.fromHex("000000"),
    ground = Color3.fromHex("0a0a0b"), panel = Color3.fromHex("0f0f11"), raise = Color3.fromHex("17171a"),
    ink = Color3.fromHex("f2f2ef"), ink2 = Color3.fromHex("c7c7c2"), label = Color3.fromHex("9a9aa0"),
    dim = Color3.fromHex("74747a"), dim2 = Color3.fromHex("4c4c54"),
    line = Color3.fromHex("242429"), line2 = Color3.fromHex("38383f"),
    ok = Color3.fromHex("78e696"), bad = Color3.fromHex("f07878"),
}
local RM = "rbxasset://fonts/families/RobotoMono.json"
local W  = { reg = Enum.FontWeight.Medium, med = Enum.FontWeight.SemiBold, semi = Enum.FontWeight.Bold, bold = Enum.FontWeight.Heavy }
local function mono(w) return Font.new(RM, w or W.med) end

local function new(cls, props, kids)
    local o = Instance.new(cls)
    for k, v in pairs(props or {}) do o[k] = v end
    for _, c in ipairs(kids or {}) do c.Parent = o end
    return o
end
local function corner(r) return new("UICorner", { CornerRadius = UDim.new(0, r or 4) }) end
local function stroke(col, th, tr) return new("UIStroke", { Color = col, Thickness = th or 1, Transparency = tr or 0, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }) end
local function pad(t, r, b, l) return new("UIPadding", { PaddingTop = UDim.new(0, t), PaddingRight = UDim.new(0, r), PaddingBottom = UDim.new(0, b), PaddingLeft = UDim.new(0, l) }) end
local function vlist(gap) return new("UIListLayout", { FillDirection = Enum.FillDirection.Vertical, Padding = UDim.new(0, gap or 0), SortOrder = Enum.SortOrder.LayoutOrder }) end
local function hlist(gap, align) return new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, gap or 0), VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = align or Enum.HorizontalAlignment.Left }) end
local function fillsp(parent, order)
    local s = new("Frame", { Parent = parent, BackgroundTransparency = 1, Size = UDim2.fromOffset(0, 1), LayoutOrder = order or 500 })
    pcall(function() new("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill, Parent = s }) end)
    return s
end
local function track(s) return (s:gsub("(.)", "%1\u{200A}")):gsub("\u{200A}$", "") end
local function clipboard(s)
    local fn = setclipboard or toclipboard or writeclipboard or (syn and syn.write_clipboard)
    if fn then local ok = pcall(fn, s); return ok end
    return false
end

local width = 460
local parentGui = (gethui and gethui()) or game:GetService("CoreGui")
local prev = parentGui:FindFirstChild("SYMBIOS_ANNOUNCE"); if prev then prev:Destroy() end

local screen = new("ScreenGui", {
    Name = "SYMBIOS_ANNOUNCE", Parent = parentGui, ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 1000000, IgnoreGuiInset = true,
})

local scrim = new("Frame", { Parent = screen, BackgroundColor3 = C.scrim, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })

local card = new("Frame", {
    Parent = screen, BackgroundColor3 = C.panel, BorderSizePixel = 0,
    AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(width, 0), AutomaticSize = Enum.AutomaticSize.Y,
}, { corner(6), stroke(C.line2, 1, 0), new("UISizeConstraint", { MaxSize = Vector2.new(width, 560) }) })

local function bracket(ax, ay, px, py)
    local b = new("Frame", { Parent = card, BackgroundTransparency = 1, AnchorPoint = Vector2.new(ax, ay), Position = UDim2.fromScale(px, py), Size = UDim2.fromOffset(14, 14), ZIndex = 5 })
    new("Frame", { Parent = b, BackgroundColor3 = C.line2, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 1), Position = UDim2.fromScale(0, ay < 0.5 and 0 or 1), AnchorPoint = Vector2.new(0, ay < 0.5 and 0 or 1) })
    new("Frame", { Parent = b, BackgroundColor3 = C.line2, BorderSizePixel = 0, Size = UDim2.new(0, 1, 1, 0), Position = UDim2.fromScale(ax < 0.5 and 0 or 1, 0), AnchorPoint = Vector2.new(ax < 0.5 and 0 or 1, 0) })
end
bracket(0, 0, 0, 0); bracket(1, 0, 1, 0); bracket(0, 1, 0, 1); bracket(1, 1, 1, 1)

local root = new("Frame", { Parent = card, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0), AutomaticSize = Enum.AutomaticSize.Y }, { vlist(0) })

local header = new("Frame", { Parent = root, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 46), LayoutOrder = 1 }, { pad(0, 16, 0, 18), hlist(10) })
new("Frame", { Parent = header, BackgroundColor3 = C.ink, BorderSizePixel = 0, Size = UDim2.fromOffset(7, 7), LayoutOrder = 1 })
new("TextLabel", { Parent = header, BackgroundTransparency = 1, FontFace = mono(W.semi), Text = track("ANNOUNCEMENT"), TextSize = 13, TextColor3 = C.ink, TextXAlignment = Enum.TextXAlignment.Left, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 16), LayoutOrder = 2 })
fillsp(header, 3)
local xBtn = new("TextButton", { Parent = header, BackgroundColor3 = C.raise, BackgroundTransparency = 1, AutoButtonColor = false, BorderSizePixel = 0, FontFace = mono(W.semi), Text = "✕", TextSize = 12, TextColor3 = C.dim, Size = UDim2.fromOffset(24, 24), LayoutOrder = 4 }, { corner(3) })
xBtn.MouseEnter:Connect(function() Tween:Create(xBtn, TweenInfo.new(0.12), { BackgroundTransparency = 0, TextColor3 = C.ink }):Play() end)
xBtn.MouseLeave:Connect(function() Tween:Create(xBtn, TweenInfo.new(0.12), { BackgroundTransparency = 1, TextColor3 = C.dim }):Play() end)

new("Frame", { Parent = root, BackgroundColor3 = C.line, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 1), LayoutOrder = 2 })

local body = new("ScrollingFrame", {
    Parent = root, BackgroundTransparency = 1, BorderSizePixel = 0, Active = true,
    Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 3,
    AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(),
    ScrollBarThickness = 2, ScrollBarImageColor3 = C.line2, ScrollBarImageTransparency = 0.2,
    ScrollingDirection = Enum.ScrollingDirection.Y,
}, { pad(14, 16, 14, 16), vlist(10), new("UISizeConstraint", { MaxSize = Vector2.new(math.huge, 420) }) })

local ec = new("Frame", { Parent = body, BackgroundColor3 = C.raise, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1 }, { corner(4), stroke(C.line, 1, 0), pad(13, 14, 14, 14), vlist(8) })
local topRow = new("Frame", { Parent = ec, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18), LayoutOrder = 1 }, { hlist(8) })
local chip = new("Frame", { Parent = topRow, BackgroundColor3 = C.ink, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 18), LayoutOrder = 1 }, { corner(3), pad(0, 8, 0, 8), hlist(0, Enum.HorizontalAlignment.Center) })
new("TextLabel", { Parent = chip, BackgroundTransparency = 1, FontFace = mono(W.semi), Text = track(TAG), TextSize = 9, TextColor3 = C.ground, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 11) })
new("TextLabel", { Parent = ec, BackgroundTransparency = 1, FontFace = mono(W.semi), Text = TITLE, TextSize = 15, TextColor3 = C.ink, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 2 })
new("TextLabel", { Parent = ec, BackgroundTransparency = 1, FontFace = mono(W.reg), Text = BODY, TextSize = 12, TextColor3 = C.ink2, LineHeight = 1.32, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 3 })

local disc = new("Frame", { Parent = body, BackgroundColor3 = C.ground, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 2 }, { corner(4), stroke(C.line2, 1, 0), pad(11, 11, 11, 12), vlist(9) })
new("TextLabel", { Parent = disc, BackgroundTransparency = 1, FontFace = mono(W.med), Text = track("DISCORD"), TextSize = 10, TextColor3 = C.label, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, 0, 0, 12), LayoutOrder = 1 })
local linkRow = new("Frame", { Parent = disc, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), LayoutOrder = 2 }, { hlist(8) })
local urlWrap = new("Frame", { Parent = linkRow, BackgroundColor3 = C.raise, BorderSizePixel = 0, Size = UDim2.new(1, -110, 1, 0), LayoutOrder = 1, ClipsDescendants = true }, { corner(3), stroke(C.line, 1, 0), pad(0, 10, 0, 10) })
new("TextLabel", { Parent = urlWrap, BackgroundTransparency = 1, FontFace = mono(W.reg), Text = DISCORD_URL, TextSize = 12, TextColor3 = C.ink2, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Size = UDim2.fromScale(1, 1) })
local copyBtn = new("TextButton", { Parent = linkRow, BackgroundColor3 = C.ink, AutoButtonColor = false, BorderSizePixel = 0, FontFace = mono(W.semi), Text = track("COPY LINK"), TextSize = 11, TextColor3 = C.ground, Size = UDim2.new(0, 102, 1, 0), LayoutOrder = 2 }, { corner(3) })
do
    local resetting = false
    copyBtn.MouseEnter:Connect(function() if not resetting then Tween:Create(copyBtn, TweenInfo.new(0.12), { BackgroundColor3 = C.ink2 }):Play() end end)
    copyBtn.MouseLeave:Connect(function() if not resetting then Tween:Create(copyBtn, TweenInfo.new(0.12), { BackgroundColor3 = C.ink }):Play() end end)
    copyBtn.MouseButton1Click:Connect(function()
        local ok = clipboard(DISCORD_URL)
        resetting = true
        copyBtn.Text = track(ok and "COPIED" or "COPY FAILED")
        copyBtn.BackgroundColor3 = ok and C.ok or C.bad
        task.delay(1.1, function()
            if copyBtn and copyBtn.Parent then
                copyBtn.Text = track("COPY LINK"); copyBtn.BackgroundColor3 = C.ink; resetting = false
            end
        end)
    end)
end

new("Frame", { Parent = root, BackgroundColor3 = C.line, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 1), LayoutOrder = 4 })
local footer = new("Frame", { Parent = root, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 52), LayoutOrder = 5 }, { pad(11, 16, 11, 16), hlist(10) })
local cdLabel = new("TextLabel", { Parent = footer, BackgroundTransparency = 1, FontFace = mono(W.med), Text = track(AUTO_SECS > 0 and ("AUTO CLOSE " .. AUTO_SECS .. "s") or "SYMBIOS HUB"), TextSize = 10, TextColor3 = C.dim, TextXAlignment = Enum.TextXAlignment.Left, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 12), LayoutOrder = 1 })
fillsp(footer, 2)
local closeBtn = new("TextButton", { Parent = footer, BackgroundColor3 = C.ink, AutoButtonColor = false, BorderSizePixel = 0, FontFace = mono(W.semi), Text = track("CLOSE"), TextSize = 12, TextColor3 = C.ground, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 30), LayoutOrder = 3 }, { corner(4), pad(0, 22, 0, 22) })
closeBtn.MouseEnter:Connect(function() Tween:Create(closeBtn, TweenInfo.new(0.12), { BackgroundColor3 = C.ink2 }):Play() end)
closeBtn.MouseLeave:Connect(function() Tween:Create(closeBtn, TweenInfo.new(0.12), { BackgroundColor3 = C.ink }):Play() end)

local cdBar
if AUTO_SECS > 0 then
    local bt = new("Frame", { Parent = root, BackgroundColor3 = C.line, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 2), LayoutOrder = 6 })
    cdBar = new("Frame", { Parent = bt, BackgroundColor3 = C.ink, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
end

local uiScale = new("UIScale", { Parent = card, Scale = 0.96 })
local finished = Instance.new("BindableEvent")
local closed = false
local function doClose()
    if closed then return end
    closed = true
    Tween:Create(scrim, TweenInfo.new(0.16), { BackgroundTransparency = 1 }):Play()
    Tween:Create(uiScale, TweenInfo.new(0.16), { Scale = 0.96 }):Play()
    local ct = Tween:Create(card, TweenInfo.new(0.16), { BackgroundTransparency = 1 })
    ct:Play()
    ct.Completed:Once(function()
        if screen then screen:Destroy() end
        finished:Fire()
    end)
end
xBtn.MouseButton1Click:Connect(doClose)
closeBtn.MouseButton1Click:Connect(doClose)

do
    local dragging, dragStart, startPos
    header.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = inp.Position; startPos = card.Position
            inp.Changed:Connect(function() if inp.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - dragStart
            card.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
end

Tween:Create(scrim, TweenInfo.new(0.18), { BackgroundTransparency = 0.45 }):Play()
Tween:Create(uiScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()

if AUTO_SECS > 0 then
    task.spawn(function()
        local t0 = os.clock()
        while not closed do
            local remaining = AUTO_SECS - (os.clock() - t0)
            if remaining <= 0 then break end
            if cdLabel and cdLabel.Parent then cdLabel.Text = track("AUTO CLOSE " .. math.ceil(remaining) .. "s") end
            if cdBar and cdBar.Parent then cdBar.Size = UDim2.fromScale(math.clamp(remaining / AUTO_SECS, 0, 1), 1) end
            task.wait(0.1)
        end
        if not closed then doClose() end
    end)
end

finished.Event:Wait()
