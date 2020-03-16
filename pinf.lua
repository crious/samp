script_name('player_info')
script_author('crious')
script_description('siema')

local font = renderCreateFont("Arial", 10, 4)
local imgui = require 'imgui'
local encoding = require 'encoding'
local inicfg = require 'inicfg'
encoding.default = 'CP1251'
u8 = encoding.UTF8

setini = getWorkingDirectory()
--optioncfg = "moonloader\\player_info.ini"

optioncfg = setini .. '\\player_info.ini'

if not doesFileExist(optioncfg) then
	f = io.open(optioncfg, 'w')
	f:close()
end

setting = inicfg.load(nil, optioncfg)

if not setting then
	inicfg.save({
		set = {
			boxPosX = 21,
			boxPosY = 470,
			colorBox = 'DB0096',
			isEnabled = true
		}
	}, optioncfg)
	setting = inicfg.load(nil, optioncfg)
end

local boxPosX = setting.set.boxPosX
local boxPosY = setting.set.boxPosY
local colorBox = setting.set.colorBox
local isEnabled = setting.set.isEnabled
local sizeX = 360
local sizeY = 151
local window = imgui.ImBool(false)
local boxPosX_buffer = imgui.ImInt(boxPosX)
local boxPosY_buffer = imgui.ImInt(boxPosY)
local colorBox_buffer = imgui.ImBuffer(7)
local isEnabled_ImBool = imgui.ImBool(isEnabled)

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	sampAddChatMessage('{FFC32C}[Player info]   {7E7E7E}Х   {FFFFFF}load1.', 0xAA7E7E7E)
	sampAddChatMessage('{FFC32C}[Player info]   {7E7E7E}Х   {FFFFFF}on1: {00FFA9}1. {FFFFFF}set: {00FFA9} / {FFFFFF} -  NumPad', 0xAA7E7E7E)
	sampAddChatMessage('{FFC32C}[Player info]   {7E7E7E}Х   {FFFFFF}creat: {00FFA9}ard..', 0xAA7E7E7E)
	while true do
		 wait(0)
		imgui.Process = window.v
		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
			if isKeyJustPressed(111) then wait(100)
				window.v = not window.v
			end
		end
		if window.v == false then
			imgui.Process = false
		end
	end
end

function apply_custom_style()
	local style 					   = imgui.GetStyle()
	local colors 					   = style.Colors
	local clr 						   = imgui.Col
	local ImVec4 					   = imgui.ImVec4
	style.WindowRounding 			   = 5
	style.WindowTitleAlign 			   = imgui.ImVec2(0.5, 0.5)
	style.ChildWindowRounding 		   = 1.5
	style.FrameRounding 			   = 1.0
	style.ItemSpacing 				   = imgui.ImVec2(5.0, 4.0)
	style.ScrollbarSize 			   = 13.0
	style.ScrollbarRounding 		   = 0
	style.GrabMinSize 				   = 8.0
	style.GrabRounding 				   = 1.0
	style.WindowPadding 			   = imgui.ImVec2(4.0, 4.0)
	style.FramePadding 				   = imgui.ImVec2(2.5, 3.5)
	style.ButtonTextAlign  			   = imgui.ImVec2(0.02, 0.4)
	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg]               = imgui.ImColor(36, 36, 36, 180):GetVec4()
	colors[clr.FrameBg]                = imgui.ImColor(30, 30, 30, 255):GetVec4()
	colors[clr.FrameBgHovered]         = imgui.ImColor(50, 50, 50, 255):GetVec4()
	colors[clr.FrameBgActive]          = imgui.ImColor(40, 142, 110, 255):GetVec4()
	colors[clr.TitleBg]                = imgui.ImColor(40, 142, 110, 236):GetVec4()
	colors[clr.TitleBgActive]          = imgui.ImColor(40, 142, 110, 236):GetVec4()
	colors[clr.TitleBgCollapsed]       = ImVec4(0.05, 0.05, 0.05, 0.79)
	colors[clr.Button]                 = imgui.ImColor(44,157,121, 255):GetVec4()
	colors[clr.ButtonHovered]          = imgui.ImColor(35, 121, 93, 174):GetVec4()
	colors[clr.ButtonActive]           = imgui.ImColor(22, 77, 60, 255):GetVec4()
	colors[clr.Header]                 = imgui.ImColor(40, 142, 110, 255):GetVec4()
	colors[clr.ScrollbarBg]            = imgui.ImColor(36, 36, 36, 180):GetVec4()
	colors[clr.ScrollbarGrab]          = imgui.ImColor(50, 50, 50, 255):GetVec4()
	colors[clr.ScrollbarGrabHovered]   = imgui.ImColor(40, 142, 110, 255):GetVec4()
	colors[clr.ScrollbarGrabActive]    = imgui.ImColor(40, 142, 110, 255):GetVec4()
	colors[clr.HeaderHovered] 				 = imgui.ImColor(40, 142, 110, 255):GetVec4()
	colors[clr.HeaderActive] 				   = imgui.ImColor(22, 77, 60, 255):GetVec4()
	colors[clr.CloseButton] 					 = imgui.ImColor(50, 50, 50, 180):GetVec4()
	colors[clr.CloseButtonHovered] 		 = imgui.ImColor(50, 50, 50, 180):GetVec4()
	colors[clr.CloseButtonActive] 		 = imgui.ImColor(22, 77, 60, 180):GetVec4()
end
apply_custom_style()

function imgui.OnDrawFrame()
	local resX, resY = getScreenResolution()
	local posX = (resX / 2) - (sizeX / 2)
	local posY = (resY / 2) - (sizeY / 2)

	imgui.SetNextWindowPos(imgui.ImVec2(posX, posY), imgui.Cond.FirstUseEver, imgui.ImVec2(0.0, 0.0))
	imgui.SetNextWindowSize(imgui.ImVec2(sizeX, sizeY), imgui.Cond.FirstUseEver)

	imgui.Begin(u8"menu", window, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
	if imgui.InputInt(u8'X', boxPosX_buffer) then
		boxPosX = boxPosX_buffer.v
		setting.set.boxPosX = boxPosX_buffer.v
		inicfg.save(setting, optioncfg)
  end
  if imgui.InputInt(u8'Y', boxPosY_buffer) then
		boxPosY = boxPosY_buffer.v
		setting.set.boxPosY = boxPosY_buffer.v
		inicfg.save(setting, optioncfg)
  end
	if imgui.InputText(u8'Hex', colorBox_buffer) then
		colorBox = colorBox_buffer.v
		setting.set.colorBox = colorBox_buffer.v
		inicfg.save(setting, optioncfg)
  end
	if imgui.Checkbox(u8"INF", isEnabled_ImBool) then
		isEnabled = isEnabled_ImBool.v
		setting.set.isEnabled = isEnabled_ImBool.v
		inicfg.save(setting, optioncfg)
	end
	if imgui.Button(u8'Sett') then
		boxPosX = 21
		boxPosY = 470
		colorBox = 'DB0096'
		isEnabled = true
		setting.set.boxPosX = 21
		setting.set.boxPosY = 470
		setting.set.colorBox = 'DB0096'
		setting.set.isEnabled = true
		inicfg.save(setting, optioncfg)
		boxPosX_buffer = imgui.ImInt(boxPosX)
		boxPosY_buffer = imgui.ImInt(boxPosY)
		colorBox_buffer = imgui.ImBuffer(7)
		isEnabled_ImBool = imgui.ImBool(isEnabled)
		sampAddChatMessage('{FFC32C}[Player info]   {7E7E7E}Х   {00FFA9}Set1', 0xAA7E7E7E)
	end
	imgui.End()
end

lua_thread.create(function()
	while true do wait(0)
		res, handle = getCharPlayerIsTargeting(playerHandle)
			if res and doesCharExist(handle) and isKeyDown(0x02) and isEnabled then
				 local resid, id = sampGetPlayerIdByCharHandle(handle)
				if id >= 0 then
					 nick = sampGetPlayerNickname(id)
				 else
					 nick = ''
				end
				local result = sampIsPlayerNpc(handle)
					if result or id <= -1 then
						npc = 'ƒа'
					else
						npc = 'Ќет'
					end
				local result = sampIsPlayerPaused(id)
					if result then
						afk = '   AFK'
					else
						afk = ''
					end
			--	local mX, mY, mZ = getCharCoordinates(playerPed)
				local	x, y, z = getCharCoordinates(handle)
				local dl = 0
				local score = sampGetPlayerScore(id)
				local skinid = getCharModel(handle)
				local hp = sampGetPlayerHealth(id)
				local armor = sampGetPlayerArmor(id)
				local ping = sampGetPlayerPing(id)
			  local color =	sampGetPlayerColor(id)
				local weapon = getCurrentCharWeapon(handle)
				local ammo = getAmmoInCharWeapon(handle, weapon)
			--	local dis = getDistanceBetweenCoords3d(x, y, z, mX, mY, mZ)
			--	print(("%06X"):format(sampGetPlayerColor(id)))
				if not sampIsPlayerPaused(id) then
					l1 = renderGetFontDrawTextLength(font, '{DB0096}Nick[{FFFFFF}ID{DB0096}]:   {FFFFFF}'..nick..'{DB0096}[{FFFFFF}'..id..'{DB0096}]  '..afk, false) + 12
				else
					l1 = renderGetFontDrawTextLength(font, '{DB0096}Nick[{FFFFFF}ID{DB0096}]:   {FFFFFF}'..nick..'{DB0096}[{FFFFFF}'..id..'{DB0096}]  '..afk, false) + 22
				end
				l2 = renderGetFontDrawTextLength(font, '                        '..'{DB0096}Armor: {FFFFFF}'..armor, false) + 25
				l3 = renderGetFontDrawTextLength(font, '                        '..'{DB0096}Ammo: {FFFFFF}'..ammo, false) + 24
				l4 = renderGetFontDrawTextLength(font, '                        '..'{DB0096}NPC: {FFFFFF}'..npc, false) + 24
				l5 = renderGetFontDrawTextLength(font, '                        '..'{FFFFFF}PING: {FFFFFF}'..ping, false) + 22
				l6 = renderGetFontDrawTextLength(font, '{DB0096}Pos:   {FFFFFF}'..math.floor(x)..'   {DB0096}|   {FFFFFF}'..math.floor(y)..'   {DB0096}|   {FFFFFF}'..math.floor(z), false) + 21
				dl = math.max(l1, l2, l3, l4, l5, l6)
				local info1 = {'{'..colorBox..'}Nick[{FFFFFF}ID{'..colorBox..'}]:   {FFFFFF}'..nick..'{'..colorBox..'}[{FFFFFF}'..id..'{'..colorBox..'}]'..afk, '',
				'{'..colorBox..'}Score: {FFFFFF}'..score,
				'{'..colorBox..'}HP: {FFFFFF}'..hp, '{'..colorBox..'}WeaponID: {FFFFFF}'..weapon, '{'..colorBox..'}SkinID: {FFFFFF}'..skinid, '',
				'{'..colorBox..'}Pos:   {FFFFFF}'..math.floor(x)..'   {'..colorBox..'}|   {FFFFFF}'..math.floor(y)..'   {'..colorBox..'}|   {FFFFFF}'..math.floor(z)}
				local info2 = {'{'..colorBox..'}NPC: {FFFFFF}'..npc, '{'..colorBox..'}Armor: {FFFFFF}'..armor, '{'..colorBox..'}Ammo: {FFFFFF}'..ammo, '{'..colorBox..'}PING: {FFFFFF}'..ping}
--ќтрисовка
					renderDrawBoxWithBorder(boxPosX, boxPosY,dl ,173, 0xAA000000, 3, string.format("0x90%s", colorBox))
					renderDrawLine(boxPosX+4, boxPosY+37, boxPosX+(-2)+dl, boxPosY+37, 3, string.format("0x90%s", colorBox))
					renderDrawLine(boxPosX+4, boxPosY+135, boxPosX+(-2)+dl, boxPosY+135, 3, string.format("0x90%s", colorBox))
						local i = 0
						for _, v in ipairs(info1) do
							i = i + 20
							renderFontDrawText(font, v, boxPosX+10, boxPosY+(-13)+i, 0xFFFFFFFF)
						end
						for _, v in ipairs(info2) do
							i = i + 20
							renderFontDrawText(font, v, boxPosX+133, boxPosY+(-133)+i, 0xFFFFFFFF)
						end
			end
	end
end)
