----- NN D0g Pack by xpoker

----- Main Locals

local mainREF = gui.Reference( "Settings" )

local mainTAB = gui.Tab(mainREF, "doggo.pack.tab", "NN D0g Pack")

local maingroupBox = gui.Groupbox(mainTAB, "                                                                            NN D0g Pack by xpoker", 16, 16, 608, 500)

-- local visualgroupBox = gui.Groupbox(maingroupBox, "Visuals", 1, 1, 250)

local showserveripgroupBox = gui.Groupbox(maingroupBox, "ShowServerIP by xpoker", 305, 1, 270)

local showserveripCheckbox = gui.Checkbox(showserveripgroupBox, "showserverip.checkbox", "ShowServerIP", false)

local crosshairgroupBox = gui.Groupbox(maingroupBox, "Masterlooser's Crosshair by Cheeseot", 0, 0, 260, 150)

showserveripCheckbox:SetDescription("Show 'connect' + server ip address.")

----- ShowServerIP by xpoker

--- Locals

local showserveripWindow = gui.Window( "showserverip", "ShowServerIP by xpoker", 50, 50, 270, 170 )
local showserveripGroupBox = gui.Groupbox( showserveripWindow, "Server Ip", 15, 20, 240)
local showserveripEditBox = gui.Editbox( showserveripGroupBox, "editboxip", "")

--- Aw Menu Check

local awMenu = gui.Reference( "Menu" )

local function MenuToggle()
	if awMenu:IsActive() and showserveripCheckbox:GetValue() then
		showserveripWindow:SetActive(true)
		else
		showserveripWindow:SetActive(false)
	end
end
callbacks.Register( "Draw", "MenuToggle", MenuToggle)

--- Function

local function ShowServerIP()

local serverip = engine.GetServerIP()

	if (serverip == "loopback") then

		showserveripEditBox:SetValue("Local Server");

		elseif (serverip == nil) then

		showserveripEditBox:SetValue("not connected");

		elseif (serverip ~= nil) then

		showserveripEditBox:SetValue("connect "..serverip);

	end
end
callbacks.Register( "Draw", "ShowServerIP", ShowServerIP)

----- ShowServerIP End

----- Masterlooser's Crosshair by Cheeseot

local PunchCheckbox = gui.Checkbox(crosshairgroupBox, "recoilcrosshair", "Recoil Crosshair", 0 );
local recoilcolor = gui.ColorPicker(PunchCheckbox, "recoilcolor", "Recoil Crosshair Color", 255,255,255,255)
local IdleCheckbox = gui.Checkbox(crosshairgroupBox, "_recoilidle", "Crosshair only while recoil", 0 );

PunchCheckbox:SetDescription("Shows a nice little crosshair with recoil.")
IdleCheckbox:SetDescription("Shows recoil crosshair only while recoil presented.")

local function punch()

local rifle = 0;
local me = entities.GetLocalPlayer();
if me ~= nil and not gui.GetValue("rbot.master") then
    if me:IsAlive() then
    local scoped = me:GetProp("m_bIsScoped");
    if scoped == 256 then scoped = 0 end
    if scoped == 257 then scoped = 1 end
    local my_weapon = me:GetPropEntity("m_hActiveWeapon");
    if my_weapon ~=nil then
        local weapon_name = my_weapon:GetClass();
        local canDraw = 0;
        local snipercrosshair = 0;
        weapon_name = string.gsub(weapon_name, "CWeapon", "");
        if weapon_name == "Aug" or weapon_name == "SG556" then
            rifle = 1;
            else
            rifle = 0;
            end

        if scoped == 0 or (scoped == 1 and rifle == 1) then
            canDraw = 1;
            else
            canDraw = 0;
            end

        if weapon_name == "Taser" or weapon_name == "CKnife" then
            canDraw = 0;
            end

        if weapon_name == "AWP" or weapon_name == "SCAR20" or weapon_name == "G3SG1"  or weapon_name == "SSG08" then
            snipercrosshair = 1;
            end

    --Recoil Crosshair by Cheeseot

        if PunchCheckbox:GetValue() and canDraw == 1 then
            local punchAngleVec = me:GetPropVector("localdata", "m_Local", "m_aimPunchAngle");
            local punchAngleX, punchAngleY = punchAngleVec.x, punchAngleVec.y
            local w, h = draw.GetScreenSize();
            local x = w / 2;
            local y = h / 2;
            local fov = 90 --gui.GetValue("vis_view_fov");      polak pls add this back

            if fov == 0 then
                fov = 90;
                end
            if scoped == 1 and rifle == 1 then
                fov = 45;
                end
            
            local dx = w / fov;
            local dy = h / fov;
			
			local px = 0
			local py = 0
			
            if gui.GetValue("esp.other.norecoil") then
				px = x - (dx * punchAngleY)*1.2;
				py = y + (dy * punchAngleX)*2;
            else
				px = x - (dx * punchAngleY)*0.6;
				py = y + (dy * punchAngleX);
			end
            
            if px > x-0.5 and px < x then px = x end
            if px < x+0.5 and px > x then px = x end
            if py > y-0.5 and py < y then py = y end
            if py < y+0.5 and py > y then py = y end

			if IdleCheckbox:GetValue() then
            if px == x and py == y and snipercrosshair ~=1 then return; end
			end
				
            draw.Color(recoilcolor:GetValue());
            draw.FilledRect(px-3, py-1, px+3, py+1);
            draw.FilledRect(px-1, py-3, px+1, py+3);
            end
        end
    end
    end
end
callbacks.Register("Draw", "punch", punch);

----- Masterlooser's Crosshair by Cheeseot END

----- FOV and Viewmodel Changer (With Zoom/Scope Fix) by atk3001

local FOVBOX = gui.Groupbox(maingroupBox, "FOV Changer by atk3001 ", 0, 175, 570, 500)
local SLIDER = gui.Slider( FOVBOX, "lua_fov_slider", "Field of View", 90, 0, 180 )
local SLIDER_ONE = gui.Slider( FOVBOX, "lua_fov_slider_one", "Field of View for 1st Zoom", 40, 0, 180 )
local SLIDER_TWO = gui.Slider( FOVBOX, "lua_fov_slider_two", "Field of View for 2nd Zoom", 15, 0, 180 )
local FOVBETWEENCHECK = gui.Checkbox( FOVBOX, "lua_fov_between__shot_checkbox", "Reset FOV between scoped shots" , 0 )

local VIEWBOX = gui.Groupbox(maingroupBox, "Viewmodel Changer by atk3001", 0, 420, 570, 500)
local SLIDER_VIEW = gui.Slider( VIEWBOX, "lua_fov_slider_view", "Viewmodel Field of View", 60, 0, 180 )
local SLIDER_VIEWX = gui.Slider( VIEWBOX, "lua_fov_slider_viewX", "Viewmodel Offset X", 1, -40, 40 )
local SLIDER_VIEWY = gui.Slider( VIEWBOX, "lua_fov_slider_viewY", "Viewmodel Offset Y", 1, -40, 40 )
local SLIDER_VIEWZ = gui.Slider( VIEWBOX, "lua_fov_slider_viewZ", "Viewmodel Offset Z", -1, -40, 40 )

local betweenshot

callbacks.Register( "Draw", function()
    if(entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then
        local a = 0
        local player_local = entities.GetLocalPlayer();
        local scoped = player_local:GetProp("m_bIsScoped")

        if scoped ~= 0 and scoped ~= 256 and (FOVBETWEENCHECK:GetValue() and tostring(scoped) == "65536") ~= true then
            local gWeapon = player_local:GetPropEntity("m_hActiveWeapon")
            local zoomLevel = gWeapon:GetProp("m_zoomLevel")
            if zoomLevel == 1 then 
                if SLIDER_ONE:GetValue() == 90 then
                    a = -40
                end
                client.SetConVar( "fov_cs_debug", SLIDER_ONE:GetValue(), true )
            elseif zoomLevel == 2 then 
                if SLIDER_TWO:GetValue() == 90 then
                    a = -40
                end
                client.SetConVar( "fov_cs_debug", SLIDER_TWO:GetValue(), true )
            end
        else
            client.SetConVar( "fov_cs_debug", SLIDER:GetValue(), true )
        end
        client.SetConVar("viewmodel_fov", SLIDER_VIEW:GetValue(), true)
        client.SetConVar("viewmodel_offset_x", SLIDER_VIEWX:GetValue(), true);
        client.SetConVar("viewmodel_offset_y", SLIDER_VIEWY:GetValue(), true);
        client.SetConVar("viewmodel_offset_z", SLIDER_VIEWZ:GetValue() + a, true);
    end
end)


