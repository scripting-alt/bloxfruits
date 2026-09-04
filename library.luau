local a=cloneref or(function(...)return...end)

local b=delfolder or deletefolder
local c=delfile or deletefile
local d=makefolder
local e=writefile
local f=readfile

local g=setmetatable({},{
__index=function(g,h)
rawset(g,h,a(game:GetService(h)))
return rawget(g,h)
end
})

local h=g.MarketplaceService
local i=g.UserInputService
local j=g.TweenService
local k=g.HttpService
local l=g.RunService
local m=g.Players

local n=l.Heartbeat

local o=m.LocalPlayer
local p=o:GetMouse()

local q=(gethui or function()return g.CoreGui end)()

local r={
Darker={
Colors={
Background=ColorSequence.new{
ColorSequenceKeypoint.new(0.00,Color3.fromRGB(25,25,25)),
ColorSequenceKeypoint.new(0.50,Color3.fromRGB(32.5,32.5,32.5)),
ColorSequenceKeypoint.new(1.00,Color3.fromRGB(25,25,25))
},
Primary=Color3.fromRGB(88,101,242),
OnPrimary=Color3.fromRGB(61,67,135),
ScrollBar=Color3.fromRGB(1,76,105),
Stroke=Color3.fromRGB(45,45,45),

Error=Color3.fromRGB(255,102,102),
Icons=Color3.fromRGB(232,233,235),

JoinButton=Color3.fromRGB(37,128,69),
Link=Color3.fromRGB(40,150,255),

Dialog={
Background=Color3.fromRGB(28,28,28)
},
Buttons={
Holding=Color3.fromRGB(34,34,34),
Default=Color3.fromRGB(28,28,30)
},
Border={
Holding=Color3.fromRGB(60,60,60),
Default=Color3.fromRGB(38,38,38),
},
Text={
Default=Color3.fromRGB(255,255,255),
Dark=Color3.fromRGB(200,200,200),
Darker=Color3.fromRGB(175,175,175),
},
Slider={
SliderBar=Color3.fromRGB(1,76,105),
SliderNumber=Color3.fromRGB(232,233,235),
},
Dropdown={
Holder=Color3.fromRGB(30,30,30),
}
},
Icons={
Error="rbxassetid://10709752996",
Button="rbxassetid://10709791437",
Close="rbxassetid://10747384394",
TextBox="rbxassetid://15637081879",
Search="rbxassetid://10734943674",
Keybind="rbxassetid://10734982144",
Dropdown={
Open="rbxassetid://10709791523",
Close="rbxassetid://10709790948"
}
},
Font={
Normal=Enum.Font.BuilderSans,
Medium=Enum.Font.BuilderSansMedium,
Bold=Enum.Font.BuilderSansBold,
ExtraBold=Enum.Font.BuilderSansExtraBold,
SliderValue=Enum.Font.FredokaOne
},
BackgroundTransparency=0.03
}
}

for s,t in r do
t.Name=s
table.freeze(t)
end

local s={
Information={
Version="v2.0.1",
GitHubOwner="tlredz"
},
Default={
Theme="Darker",
UISize=UDim2.fromOffset(550,380),
TabSize=160
},

Themes=r,

Connections={},
Options={},
Tabs={},

FarmStatusColors={
Running="#5CB85C",
Waiting="#F0AD4E",
Need="#D9534F"
}
}

-- ==========================================================
-- Sistema de tradução embutido
-- ==========================================================
local function Localize(aText)
	if type(aText)~="string" or aText=="" then
		return aText
	end

	local aPack=s.Translations[s.Locale]
	return (aPack and aPack[aText]) or aText
end

s.Locale="en"
s.Translations={}
s.LocalizedLabels={}

function s:AddTranslations(aLocale,aTable)
	assert(type(aLocale)=="string","Library.AddTranslations: locale precisa ser string")
	assert(type(aTable)=="table","Library.AddTranslations: translations precisa ser uma table")

	self.Translations[aLocale]=self.Translations[aLocale] or {}

	for aKey,aValue in aTable do
		self.Translations[aLocale][aKey]=aValue
	end
end

function s:UpdateTranslate(aLocale)
	if aLocale then
		self.Locale=aLocale
	end

	for aIndex=#self.LocalizedLabels,1,-1 do
		local aEntry=self.LocalizedLabels[aIndex]

		if aEntry.Instance and aEntry.Instance.Parent then
			aEntry.Instance.Text=Localize(aEntry.Original)
		else
			table.remove(self.LocalizedLabels,aIndex)
		end
	end
end

s.SetLocale=s.UpdateTranslate

s.Info=s.Information
s.Save=s.Default

function s:SetFarmStatusColor(aName,aHex)
	assert(type(aName)=="string","Library.SetFarmStatusColor: 'name' precisa ser string")
	assert(type(aHex)=="string","Library.SetFarmStatusColor: 'hex' precisa ser string (ex: '#5CB85C')")

	self.FarmStatusColors[aName]=aHex
end

local t=workspace.CurrentCamera.ViewportSize local u=function(

u, v, w)
table.insert(s.Connections,u[w or"Connect"](u,v))end


local v={}
v.__index=v local w=function(

w, x)
for y in x:gmatch"[^%.]+"do
w=w[y]
end

return w end local x=function(


x, y, z, A)
if not A then
A=s.CurrentTheme
end

x[y]=w(A,if type(z)=="function"then z()else z)end local y=function(


y, z, A)
for B,C in A do
x(z,B,C,y)
end end local z=function(


z, A)
if d then
local B=z:split"/"
B[#B]=nil

local C=table.concat(B,"/")

if C~=""and(isfolder==nil or not isfolder(C))then
d(C)
end
end

e(z,A)end


local A=false

local B={
MAX_SCALE=1.6,
MIN_SCALE=0.6,

TEXTBOX={
PLACEHOLDER_TEXT="Input"
}
}

function v:add(C,D)
self.Descendants[D]=C

if self.IS_RENDERING then
y(s.CurrentTheme,C,D)
end
end

function v:update()
if self.IS_RENDERING and not self.UPDATED_OBJECTS then
local C=s.CurrentTheme
self.UPDATED_OBJECTS=true

for D,E in self.Descendants do
local F=typeof(E)
if F=="table"then E:update()continue end

y(C,E,D)
end
end
end

function v:destroy()
local C=self.Parent and table.find(self.Parent.Descendants)

if C then
table.remove(self.Parent.Descendants,C)
end

table.clear(self.Descendants)
setmetatable(self,nil)
end

function v:changeRendering(C)
if self.IS_RENDERING~=C then
self.IS_RENDERING=C
self.UPDATED_OBJECTS=false
end
end

function v:new()
local C=setmetatable({
IS_RENDERING=true,
UPDATED_OBJECTS=false,
Descendants={},
Parent=self.Descendants~=nil and self or nil
},v)

if self.Descendants then
table.insert(self.Descendants,C)
end

return C
end

local C=v:new()

local D,E={}do
local F={}

local G={}do
G.ElementsTable={
Corner=function(H)
return E("UICorner",{
CornerRadius=H or UDim.new(0,8)
})
end,
Stroke=function(H,I)
return E("UIStroke",{
Color=H or Color3.fromRGB(60,60,60),
Thickness=I or 1
})
end,
Image=function(H)
return E("ImageLabel",{
Image=H or"",
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1)
})
end,
Button=function()
return E("TextButton",{
Text="",
Size=UDim2.fromScale(1,1),
AutoButtonColor=false
})
end,
Padding=function(H,I,J,K)
return E("UIPadding",{
PaddingLeft=H or UDim.new(0,10),
PaddingRight=I or UDim.new(0,10),
PaddingTop=J or UDim.new(0,10),
PaddingBottom=K or UDim.new(0,10)
})
end,
ListLayout=function(H)
return E("UIListLayout",{
Padding=H or UDim.new(0,5)
})
end,
Text=function(H)
return E("TextLabel",{
BackgroundTransparency=1,
Text=H or""
})
end,
Gradient=function(H)
return E("UIGradient",{
Color=H
})
end
}

function G:Create(H,I,...)
local J=self.ElementsTable[I]

if J then
local K=J(...)
K.Parent=H
return K
end
end
end

local H={}

function H:Childs(I)
for J=1,#I do
I[J].Parent=self
end
end

function H:Elements(I)
for J,K in pairs(I)do
if type(K)=="table"then
D.SetProperties(G:Create(self,J),K)
else
G:Create(self,J,K)
end
end
end

function H:ThemeTag(I)
local J=I.OBJECTS
I.OBJECTS=nil
return(J or C):add(self,I)
end

function D:SetProperties(I)
for J,K in pairs(I)do
if H[J]then
H[J](self,K)
else
self[J]=K
end
end
end

function D:SetValues(...)
local I=self

for J,K in{...}do
local L=typeof(K)

if L=="table"then
D.SetProperties(I,K)
else
I[if L=="string"then"Name"else"Parent"]=K
end
end

return I
end

local I

function D:Draggable(J,K,L)
local M,N,O,P
local Q=K or 0.28
local R=0
local S local T=function(

T)
local U=T.Position-N
local V
R=tick()

if L then
V=L(
O.X.Scale,O.X.Offset+U.X/J.Scale,
O.Y.Scale,O.Y.Offset+U.Y/J.Scale
)
else
V=UDim2.new(
O.X.Scale,O.X.Offset+U.X/J.Scale,
O.Y.Scale,O.Y.Offset+U.Y/J.Scale
)
end
self.Position=self.Position:Lerp(V,Q)end local U=function(


)

while I==self do
if(tick()-R)>=1 then
S()
break
end
task.wait()
end
end


local V={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true
}

local W={
[Enum.UserInputType.MouseMovement]=true,
[Enum.UserInputType.Touch]=true
}

u(self.InputBegan,function(X)
if A==false and I==nil and V[X.UserInputType]then
N=X.Position
O=self.Position
I=self
R=tick()
A=true

local Y;

function S()
A=false
I=nil
Y:Disconnect()
end

task.spawn(U)

Y=X.Changed:Connect(function()
if X.UserInputState==Enum.UserInputState.End then
S()
end
end)
end
end)

u(i.InputChanged,function(X)
if I==self and W[X.UserInputType]then
T(X)
end
end)
end

function D:CreateNewTemplate(J)
return D.CloneObject(F[self],J)
end

function D.new(J,...)
return D.SetValues(Instance.new(J),...)
end

E=D.new
end local F=function(

F)
if F==nil then
return{}
end

if type(F)~="function"and type(F)~="table"then
error(`Failed to get Callback: 'function', or 'table' expected, got {typeof(F)}`,2)
end

if type(F)~="function"then
local G=F[1]
local H=F[2]

F=function(I)
G[H]=I
end
end

return table.pack(F)end local G=function(


G, ...)
for H=1,#G do
task.spawn(G[H],...)
end
end


local H="redz-library-v5"
local I=q:FindFirstChild(H)

if not I then
I=E("ScreenGui",H,q,{
IgnoreGuiInset=true
})
end local J=function(

J, K, L, M, ...)
local N=TweenInfo.new(M,EasingStyle or Enum.EasingStyle.Quint,...)

return j:Create(J,N,{
[K]=L
})end local K=function(


K)
local L={}
for M=1,#K do
rawset(L,K[M],true)
end
return L end


local L=K(string.split"\n\t,_:;()[]#&=!. \"'*^<>$")local M=function(

M)
return string.gsub(M:lower(),".",function(N)
return L[N]and""or N
end)end local N=function(


N)
local O,P,Q=tostring(N),"",0

for R=#O,1,-1 do
P=O:sub(R,R)..P
Q+=1

if R>1 and Q%3==0 then
P=","..P
end
end

return P end local O=function(


O)
local P="rbxassetid://"
return O:sub(1,#P)==P end local P=function(


P)
return(t.Y/450)*P end local Q=function(


Q)
local R=math.floor(Q/60)
local S=math.floor(Q/60/60)
Q=math.floor((Q-(R*60))*10)/10
R=R-(S*60)

if S>0 then
return`{S}h {R}m {math.floor(Q)}s`
elseif R>0 then
return`{R}m {math.floor(Q)}s`
else
return tostring(Q)
end end


local R={}do
local S={}
local T={}
local U={}
local V={}

local W
local X
local Y
local Z
local _
local aa
local ab
local ac
local ad
local ae

local af=""

local ag={SelectedTab=1,Minimized=false}
ag.__index=ag

local ah={}
ah.__index=ah

local ai={}
ai.__index=ai

local aj={}
aj.__index=aj

local ak={}do local al=function()

local al={}
al.__index=function(am,an)
return al[an]or rawget(ai,an)
end

return al end


local am=al()
ak.TextBox=am

local an=al()
ak.Toggle=an

local ao=al()
ak.Slider=ao

local ap=al()
ak.Dropdown=ap

local aq=al()
ak.Keybind=aq

local ar=al()
ak.Dialog=ar local as=function()


Z.Closed=true
Z.Closing=false
setmetatable(Z,nil)

Z=nil
aa.Parent=nil end local at=function()


if Z~=nil then
Z:Close()
end end

function ar:NewOption(au)
local av=au[1]or au.Name or au.Title
local aw=F(au[2]or au.Callback)

table.insert(aw,at)

assert(type(av)=="string",`"Dialog.NewOption.Name". 'string' expected, got {typeof(av)}`)

local ax=E("TextButton",{
AutoButtonColor=false,
Size=UDim2.fromScale(0.2,1),
BackgroundTransparency=1,
TextSize=10,
Text=av,
Elements={
Corner=UDim.new(1,0)
},
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
TextColor3="Colors.Text.Dark",
Font="Font.Normal"
}
})

local ay=J(ax,"BackgroundTransparency",0,0.3)
local az=J(ax,"BackgroundTransparency",1,0.3)

u(ax.MouseLeave,function()az:Play()end)
u(ax.MouseEnter,function()ay:Play()end)
u(ax.Activated,function()G(aw)end)

ax.Parent=aa.Template.Options
end

function ar:Close(au)
if self.Closed or self.Closing or Z~=self then
return nil
end

self.Closing=true

local av=J(self.TEMPLATE,"Size",self.NEW_SIZE,0.1)
av:Play()

if au then
av.Completed:Wait()
as()
else
u(av.Completed,as)
end
end

function ar.new(au,av)
return setmetatable({
TITLE_LABEL=au,
DESCRIPTION_LABEL=au,
Content=au.Text,
Title=av.Text,

Closed=false,
Closing=false,
Kind="Dialog"
},ar)
end

function ap:SetEnabled(au)
assert(type(au)=="table",`"Dropdown.SetEnabled[param 1]". 'table' expected, got {typeof(au)}`)

self.SET_ENABLED_OPTIONS(au)
end

function ap:Clear()
self.CLEAR_DROPDOWN()
end

function ap:NewOptions(...)
self:Clear()
self:Add(...)
end

function ap:GetOptionsCount()
return#self.DROPDOWN_OPTIONS
end

function ap:Remove(...)
local au={...}
assert(#au>0,"'Dropdown.Remove' requires one or more options.")

for av,aw in au do
self.REMOVE_DROPDOWN_OPTION(aw)
end
end

function ap:Add(...)
local au={...}
assert(#au>0,"'Dropdown.Add' requires one or more options.")

for av,aw in au do
self.ADD_DROPDOWN_OPTION(aw)
end
end

function ap.new(au,av,aw,ax,ay)
return setmetatable({
CALLBACKS=ay,

DESTROY_ELEMENT=av,
VISIBLE_ELEMENT=av,

TITLE_LABEL=aw,
DESCRIPTION_LABEL=ax,
Description=ax.Text,
Title=aw.Text,

Parent=au,
Kind="Dropdown"
},ap)
end

function ao:SetValue(au)
assert(type(au)=="number",`"Slider.SetValue". 'number' expected, got {typeof(au)}`)

if self.Value~=au then
self.WHEN_VALUE_CHANGED(au)
end
end

function ao.new(au,av,aw,ax,ay)
return setmetatable({
CALLBACKS=ay,

DESTROY_ELEMENT=av,
VISIBLE_ELEMENT=av,

TITLE_LABEL=aw,
DESCRIPTION_LABEL=ax,
Description=ax.Text,
Title=aw.Text,

Parent=au,
Kind="Slider"
},ao)
end

function an:SetValue(au)
assert(type(au)=="boolean",`"Toggle.SetValue". 'boolean' expected, got {typeof(au)}`)

if self.Value~=au then
self.Value=au
self.WHEN_VALUE_CHANGED(au)
end
end

function an.new(au,av,aw,ax,ay,az)
return setmetatable({
CALLBACKS=az,
WHEN_VALUE_CHANGED=ay,

DESTROY_ELEMENT=av,
VISIBLE_ELEMENT=av,

TITLE_LABEL=aw,
DESCRIPTION_LABEL=ax,
Description=ax.Text,
Title=aw.Text,

Parent=au,
Kind="Toggle"
},an)
end

function am:SetText(au)
assert(type(au)=="string",`"TextBox.SetText". 'string' expected, got {typeof(au)}`)

self.TEXTBOX.Text=au
return self
end

function am:SetPlaceholder(au)
assert(type(au)=="string",`"TextBox.SetPlaceholder". 'string' expected, got {typeof(au)}`)

self.TEXTBOX.PlaceholderText=au
return self
end

function am:CaptureFocus()
self.TEXTBOX:CaptureFocus()
return self
end

function am:Clear()
self.TEXTBOX.Text=""
return self
end

function am:SetTextFilter(au)
if au~=nil then
assert(type(au)=="function",`"TextBox.SetTextFilter[param 1]". 'function', or 'nil' expected, got {typeof(au)}`)
end

self.TEXTBOX_TEXT_FILTER=au
return self
end

function am.new(au,av,aw,ax,ay,az)
return setmetatable({
Title=av.Text,
Description=aw.Text,
DESCRIPTION_LABEL=aw,
TITLE_LABEL=av,

CALLBACKS=az,
DESTROY_ELEMENT=ax,
VISIBLE_ELEMENT=ax,

TEXTBOX=ay,
BUTTON=ax,

Parent=au,
Kind="TextBox"
},am)
end

am.Set=am.SetText
an.Set=an.SetValue
ao.Set=ao.SetValue
end local al=function(

al, am, an)
local ao=E("TextButton","Button",an,{
Size=UDim2.new(1,0,0,24),
AutoButtonColor=false,
Text="",
Elements={
Corner=UDim.new(0,6)
},
ThemeTag={
BackgroundColor3="Colors.Buttons.Default"
},
Childs={
E("TextLabel","Title",{
BackgroundTransparency=1,
Font=Enum.Font.GothamMedium,
Text=Localize(am.Title),
TextSize=10,
TextXAlignment=Enum.TextXAlignment.Left,
TextTransparency=(FirstTab and 0.3)or 0,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
TextColor3="Colors.Text.Default"
}
})
}
})

table.insert(s.LocalizedLabels,{Instance=ao.Title,Original=am.Title})

local ap=E("Frame",ao,{
Position=UDim2.new(0,1,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
Size=UDim2.fromOffset(4,4),
BackgroundTransparency=1,
ThemeTag={
BackgroundColor3="Colors.Primary"
},
Elements={
Corner=UDim.new(0.5,0)
}
})

local aq=E("ScrollingFrame","Container",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0,0,1),
AnchorPoint=Vector2.new(0,1),
ScrollBarThickness=1.5,
BackgroundTransparency=1,
ScrollBarImageTransparency=0.2,
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ScrollingDirection=Enum.ScrollingDirection.Y,
BorderSizePixel=0,
CanvasSize=UDim2.new(),
ThemeTag={
ScrollBarImageColor3="Colors.ScrollBar"
},
Elements={
Padding={
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingTop=UDim.new(0,10),
PaddingBottom=UDim.new(0,10)
},
ListLayout={
SortOrder=Enum.SortOrder.LayoutOrder,
Padding=UDim.new(0,5)
}
}
})

local ar=E("ImageLabel",ao,{
Position=UDim2.new(0,8,0.5),
Size=UDim2.new(0,13,0,13),
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
ImageTransparency=0.3,
Image=am.Icon or""
})local as=function()


local as=string.sub(ar.Image,1,13)=="rbxassetid://"
local at=ao.Title
ar.Visible=as
at.Size=UDim2.new(1,as and-25 or-15,1)
at.Position=UDim2.fromOffset(as and 25 or 15)end


u(ar:GetPropertyChangedSignal"Image",as)
as()

-- ChangeLog: adiciona método profissional ao container da tab (sem depender de módulo externo)
do
	local COLOR_ADD = Color3.fromRGB(76, 175, 80)
	local COLOR_REMOVE = Color3.fromRGB(217, 83, 79)
	local COLOR_UPDATE = Color3.fromRGB(240, 173, 78)
	local COLOR_HEADER = (s.Themes and s.Themes.Darker and s.Themes.Darker.Colors and s.Themes.Darker.Colors.Text and s.Themes.Darker.Colors.Text.Default) or Color3.fromRGB(232,233,235)
	local COLOR_TEXT = (s.Themes and s.Themes.Darker and s.Themes.Darker.Colors and s.Themes.Darker.Colors.Text and s.Themes.Darker.Colors.Text.Dark) or Color3.fromRGB(200,200,200)

	local function makeLabel(props)
		local L = Instance.new("TextLabel")
		for k,v in pairs(props) do
			if k ~= "Parent" then
				pcall(function() L[k] = v end)
			end
		end
		if props.Parent then L.Parent = props.Parent end
		return L
	end

	local function makeSpacer(parent, height)
		height = height or 6
		local sp = Instance.new("Frame")
		sp.BackgroundTransparency = 1
		sp.Size = UDim2.new(1,0,0,height)
		sp.Parent = parent
		return sp
	end

	function aq:ChangeLog(changes)
		assert(type(changes) == "table", "ChangeLog: expected table")

		-- header (usando Localize para tradução)
		makeLabel{
			Parent = aq,
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 16,
			Text = Localize("ChangeLog"),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			AutomaticSize = Enum.AutomaticSize.Y,
			TextColor3 = COLOR_HEADER
		}

		makeSpacer(aq, 6)

		local function addLine(symbol, color, text)
			local line = Instance.new("Frame")
			line.BackgroundTransparency = 1
			line.Size = UDim2.new(1,0,0,20)
			line.Parent = aq

			makeLabel{
				Parent = line,
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextSize = 14,
				Text = symbol,
				TextColor3 = color,
				Size = UDim2.new(0,28,1,0),
				TextXAlignment = Enum.TextXAlignment.Left
			}

			makeLabel{
				Parent = line,
				BackgroundTransparency = 1,
				Font = Enum.Font.Gotham,
				TextSize = 14,
				Text = " " .. tostring(Localize(text)),
				TextColor3 = COLOR_TEXT,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				Position = UDim2.new(0,28,0,0),
				Size = UDim2.new(1,-28,1,0),
				TextXAlignment = Enum.TextXAlignment.Left
			}
		end

		local function processField(key, symbol, color)
			local v = changes[key]
			if v == nil then return end
			if type(v) == "string" then
				addLine(symbol, color, v)
			elseif type(v) == "table" then
				for _,item in ipairs(v) do
					if type(item) == "string" then addLine(symbol, color, item) end
				end
			end
		end

		processField("add", "[+]", COLOR_ADD)
		processField("remove", "[-]", COLOR_REMOVE)
		processField("update", "[/]", COLOR_UPDATE)
	end
end

return ao,aq,ap,ar end local am=function(

am, an, ao, ap)
local aq=E("TextLabel",{
TextXAlignment=Enum.TextXAlignment.Left,
TextTruncate=Enum.TextTruncate.AtEnd,
AutomaticSize=Enum.AutomaticSize.Y,
