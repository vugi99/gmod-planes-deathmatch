-- DO NOT REUPLOAD THIS FILE
include( "shared.lua" )
local pldm_version = "Planes Deathmatch 0.6.2-2b" --DO NOT EDIT THIS LINE
local CurrentMap = {}

local AllPlanesallied = {}
local AllPlanesenemies = {}
local AllPlanesalliedstarwars = {}
local AllPlanesenemiesstarwars = {}

local isoptionale = false
local isoptionale2 = false
local vertested = 168 -- for the pldm panel to check if pldm has been tested on this version of lfs
local unsuported = false
local hasbeenwelcomed = false
hook.Add( "HUDPaint", "HUDPaint_Version", function()
	draw.Text( {
		text = pldm_version, -- OR THIS LINE 
		pos = { 300, 0 },
        font = "Trebuchet24"
        
	} )
	PaintHUD()
	PaintBaseIdentifier()
	PaintPlayersIdentifiers()
    welcomedraw()
	if(unsuported==false) then return end 
		draw.Text( {
			text = "Cette map n'est pas supportée par Planes Deathmatch / This map isn't supported by Planes Deathmatch",
			pos = { 300, 25 },
			font = "Trebuchet24",
			color = Color( 255, 0, 0, 255 )
			
		} )
end )

function drawshop()

local frame = vgui.Create("DFrame")
frame:SetSize(1000,600)
frame:Center()
frame:SetVisible(true)
frame:MakePopup()
frame:SetTitle("Planes Deathmatch Shop [BETA 3]")
frame.Paint = function (s , w, h)
   draw.RoundedBox(5,0,0,w,h,Color(0,0,0))
end
local label = vgui.Create("DLabel", frame)
label:SetPos(800,30)
label:SetSize(200,50)
local ply = LocalPlayer()
if(ply:InVehicle() == true) then
		local points = ply:GetNWInt("points")
		label:SetText("Points : " .. points)
local DScrollPanel = vgui.Create("DScrollPanel",frame)
DScrollPanel:Dock( FILL )
DScrollPanel:DockMargin( 0, 0, 200, 0 )
if (ply:Team()==1 and CurrentMap.StarWarsMap=="false") then
	dashop(DScrollPanel,AllPlanesallied,frame,points,label)
elseif(ply:Team()==1 and CurrentMap.StarWarsMap=="true") then
	dashop(DScrollPanel,AllPlanesalliedstarwars,frame,points,label)
elseif(ply:Team()==2 and CurrentMap.StarWarsMap=="false") then
	dashop(DScrollPanel,AllPlanesenemies,frame,points,label)
elseif(ply:Team()==2 and CurrentMap.StarWarsMap=="true") then
	dashop(DScrollPanel,AllPlanesenemiesstarwars,frame,points,label)
end
else 
	local labelerror = vgui.Create("DButton", frame)
	labelerror:SetPos(250,200)
	labelerror:SetSize(500,200)
	labelerror:SetColor( Color( 255, 0, 0 ) )
	labelerror:SetFont("CloseCaption_Bold")
	labelerror:SetText("Please Enter In a Plane !")
	labelerror.Paint = function (s , w, h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0))
	 end
end

end

function GM:OnSpawnMenuOpen()
   drawshop()
end
function PaintBaseIdentifier() -- Paint the base identifier
	local ply = LocalPlayer()
	if (ply:Team()==TEAM_UNASSIGNED) then return end
	if(ply:InVehicle() == false) then return end
	for k, v in pairs( ents.FindByClass( "base_ent_allie" )) do
		if (!IsValid(ply:lfsGetPlane())) then return end
	   if (IsValid( v ) and isoptionale2==false ) then
				local rPos = v:GetPos()
				local Pos = rPos:ToScreen()
				local realpos = v:GetPos()
				        local ply = LocalPlayer()
				        local MyPos = ply:lfsGetPlane():GetPos()
						local Size = 60
						local Dist = (MyPos - rPos):Length()
						local Alpha = 255
								if(ply:Team() == 1) then 
									surface.SetDrawColor( 0, 127, 255, Alpha )
								else
									surface.SetDrawColor( 255, 0, 0, Alpha )
								end
							
							if(Dist>10000) then
							   DrawLines(30,Pos)
							else
								DrawLines(60,Pos)
							end
						
						
	   end
	end
	for k, v in pairs( ents.FindByClass( "base_ent_enemy" )) do
		if (!IsValid(ply:lfsGetPlane())) then return end
	   if (IsValid( v ) and isoptionale2==false ) then
				local rPos = v:GetPos()
				local Pos = rPos:ToScreen()
				local realpos = v:GetPos()
				        local ply = LocalPlayer()
				        local MyPos = ply:lfsGetPlane():GetPos()
						local Size = 60
						local Dist = (MyPos - rPos):Length()
						local Alpha = 255
								if(ply:Team() == 2) then 
									surface.SetDrawColor( 0, 127, 255, Alpha )
								else
									surface.SetDrawColor( 255, 0, 0, Alpha )
								end
							
							if(Dist>10000) then
							   DrawLines(30,Pos)
							else
								DrawLines(60,Pos)
							end
						
						
	   end
	end
end

function DrawLines(Size,Pos)
	surface.DrawLine( Pos.x - Size, Pos.y + Size, Pos.x + Size, Pos.y + Size )
	surface.DrawLine( Pos.x - Size, Pos.y - Size, Pos.x - Size, Pos.y + Size )
	surface.DrawLine( Pos.x + Size, Pos.y - Size, Pos.x + Size, Pos.y + Size )
	surface.DrawLine( Pos.x - Size, Pos.y - Size, Pos.x + Size, Pos.y - Size )
end

function PaintHUD() -- Draw Planes Deathmatch HUD
	local ply = LocalPlayer()
	local plyplanehud = ply:lfsGetPlane()
	checkbases()
	if(!IsValid(plyplanehud)) then return end
	if (CurrentMap.StarWarsMap=="true" and plyplanehud:GetMaxShield()>0) then
	   plpos = { 10, ScrH()-140 }
	   cppos = { 10, ScrH()-120 }
	   rboxposy = ScrH()-100
	else
		plpos = { 10, ScrH()-60 }
		cppos = { 10, ScrH()-80 }
		rboxposy = ScrH()-40
	end
	draw.RoundedBox(0,10,rboxposy,300,30,Color(127,127,127))
	draw.RoundedBox(0,10,rboxposy,plyplanehud:GetHP()*300/plyplanehud:GetMaxHP(),30,Color(255,0,0))
	draw.Text( {
		text = "Plane's Life : " .. plyplanehud:GetHP() .. " / " .. plyplanehud:GetMaxHP(), 
		pos = plpos,
        font = "Trebuchet24",
        color = Color(0,255,0)
	} )
	draw.Text( {
		text = "Current Plane : " .. plyplanehud:GetClass(), 
		pos = cppos,
        font = "Trebuchet24",
        color = Color(0,255,0)
	} )
	if (CurrentMap.StarWarsMap=="true" and plyplanehud:GetMaxShield()>0) then
		draw.RoundedBox(0,10,ScrH()-40,300,30,Color(127,127,127))
		draw.RoundedBox(0,10,ScrH()-40,plyplanehud:GetShield()*300/plyplanehud:GetMaxShield(),30,Color(0,0,255))
		draw.Text( {
			text = "Plane's Shield : " .. plyplanehud:GetShield() .. " / " .. plyplanehud:GetMaxShield(), 
			pos = { 10, ScrH()-60 },
			font = "Trebuchet24",
			color = Color(0,255,0)
		} )
       
	end
	
end

function checkbases()
	local ply = LocalPlayer()
	if(ply:InVehicle() == false) then return end
	if(ply:Team()==TEAM_UNASSIGNED) then return end
	for k, v in pairs( ents.FindByClass( "base_ent_allie" )) do
		if(IsValid(v) and isoptionale2==false) then
			if(ply:Team() == 1) then 
				DrawBasesLife(1,v)
			else
				DrawBasesLife(2,v)
			end
		
		end
 
		end
	for k, v in pairs( ents.FindByClass( "base_ent_enemy" )) do
		if(IsValid(v) and isoptionale2==false) then
			if(ply:Team() == 2) then 
				DrawBasesLife(1,v)
			else
				DrawBasesLife(2,v)
			end
			
		end
	 
		end
	 for k,v in pairs(ents.FindByClass( "lunasflightschool_laatgunshipred" )) do 
		if(ply:Team() == 1) then
			DrawBasesLife(3,v)
		else
			DrawBasesLife(4,v)
		end
	end
	for k,v in pairs(ents.FindByClass( "lunasflightschool_lambda" )) do 
		if(ply:Team() == 2) then
			DrawBasesLife(3,v)
		else
			DrawBasesLife(4,v)
		end
	end
end
function DrawBasesLife(Base,ent)
   if(Base==1) then
	draw.Text( {
		text = "Your Base : " .. math.Round(ent:Health()), 
		pos = { ScrW()/2 - 60,50  },
        font = "Trebuchet24",
        color = Color(0,255,0)
	} )
elseif(Base==2) then
	draw.Text( {
		text = "Enemy Base : " .. math.Round(ent:Health()), 
		pos = { ScrW()/2 - 60,70  },
        font = "Trebuchet24",
        color = Color(255,0,0)
	} )
elseif(Base==3) then
	draw.Text( {
		text = "Your Ship : " .. math.Round(ent:GetHP()), 
		pos = { ScrW()/2 - 60,50  },
        font = "Trebuchet24",
        color = Color(0,255,0)
	} )
elseif(Base==4) then
	draw.Text( {
		text = "Enemy Ship : " .. math.Round(ent:GetHP()), 
		pos = { ScrW()/2 - 60,70  },
        font = "Trebuchet24",
        color = Color(255,0,0)
	} )
   end
end
hook.Add( "HUDShouldDraw", "hide_hud_default", function( name )
	if ( name == "CHudHealth" or name == "CHudBattery" ) then
		return false
	end
   
end )

net.Receive( "SendBasesToClient", function( len, pl )
	CurrentMap = net.ReadTable()
	isoptionale = net.ReadBool()
	isoptionale2 = net.ReadBool()
	unsuported = net.ReadBool()
end)

net.Receive( "SendAlliedPlanesToClient", function( len, pl )
	local decompressed = util.Decompress(net.ReadData(len))
	local totable = util.JSONToTable(decompressed)
	AllPlanesallied = totable
end)

net.Receive( "SendAlliedstwrsPlanesToClient", function( len, pl )
	local decompressed = util.Decompress(net.ReadData(len))
	local totable = util.JSONToTable(decompressed)
	AllPlanesalliedstarwars = totable
end)

net.Receive( "SendEnemyPlanesToClient", function( len, pl )
	local decompressed = util.Decompress(net.ReadData(len))
	local totable = util.JSONToTable(decompressed)
	AllPlanesenemies = totable
end)

net.Receive( "SendEnemystwrsPlanesToClient", function( len, pl )
	local decompressed = util.Decompress(net.ReadData(len))
	local totable = util.JSONToTable(decompressed)
	AllPlanesenemiesstarwars = totable
end)

function dashop(DScrollPanel,planeteamtable,frame,points,plabel)
	net.Start("AskForPlyPlanes")
	net.SendToServer()

	net.Receive("ResponseForPlyPlanes",function(len)
		local planesowned = net.ReadString()
		local planeequipped = net.ReadString()
		local ply = LocalPlayer()
		local compteur = 0
		local lines = 0
		local allcompteur = 0
	   for k,v in pairs(planeteamtable) do
		  local button1 = DScrollPanel:Add( "DButton" )
		  local butposx = compteur * 135
		  button1:SetPos(10+butposx,40+280*lines)
		  button1:SetSize(125,200)
		  gudtable={
			["Damage"] = v.Damage,
            ["DamageSecondary"] = v.DamageSecondary,
            ["Health"] = v.Health,
            ["Shield"] = v.Shield,
            ["PrimaryAmmo"] = v.PrimaryAmmo,
            ["SecondaryAmmo"] = v.SecondaryAmmo,
            ["MaxRPM"] = v.MaxRPM,
            ["MaxThrust"] = v.MaxThrust,
            ["MaxVelocity"] = v.MaxVelocity,
            ["Name"] = v.Name,
		  }

		  button1:SetText(table.ToString(gudtable,"Plane" .. allcompteur,true))
		  button1:SetColor(Color( 255, 255, 255 ))
		  button1.Paint = function (s , w, h)
			draw.RoundedBox(5,0,0,w,h,Color(128,128,128))
		 end

		  local labelequipped = DScrollPanel:Add( "DLabel" )
		  labelequipped:SetPos(10+butposx,250+280*lines)
		  if (planeequipped=="lunasflightschool_" .. v.GameName) then
		  labelequipped:SetText("Equipped")
		  labelequipped.letext = "Equipped"
		  labelequipped:SetColor(Color(0,200,0))
		  else
			labelequipped:SetText("Not Equipped")
			labelequipped.letext = "Not Equipped"
			labelequipped:SetColor(Color(200,0,0))
		  end
		  local labelowned = DScrollPanel:Add( "DLabel" )
		  labelowned:SetPos(10+butposx,260+280*lines)
		  if(string.match(planesowned,"lunasflightschool_" .. v.GameName)=="lunasflightschool_" .. v.GameName) then
		   labelowned:SetText("Owned")
		   labelowned:SetColor(Color(0,200,0))
		   labelowned.letext = "Owned"
			else
			labelowned:SetText("Not Owned")
			labelowned:SetColor(Color(200,0,0))
			labelowned.letext = "Not Owned"
			end
			if (labelowned.letext == "Not Owned") then
			local labelprice = DScrollPanel:Add( "DLabel" )
			labelprice.leprc = tonumber(v.Price)
		  labelprice:SetPos(10+butposx,240+280*lines)
		  labelprice:SetText("Price : " .. v.Price)
		  points=tonumber(points)
		  if (v.Price<=points) then
		  labelprice:SetColor(Color(0,200,0))
		  else
			labelprice:SetColor(Color(200,0,0))
		  end
		end
			function button1:DoClick()
			local points = ply:GetNWInt("points")
			points=tonumber(points)
			  if (labelequipped.letext == "Not Equipped") then
				if (v.Price<=points or labelowned.letext == "Owned") then
				net.Start( "ChangePlane" )
	            net.WriteTable(v)
				net.SendToServer()
				for k,v in pairs(labelowned:GetParent():GetChildren()) do
					if (v:GetName()=="DLabel") then
						if (v.letext == "Equipped") then
						v:SetText("Not Equipped")
						v.letext = "Not Equipped"
			            v:SetColor(Color(200,0,0))
						end
					 end
					end
				labelequipped:SetText("Equipped")
				labelequipped.letext = "Equipped"
				labelequipped:SetColor(Color(0,200,0))
				labelowned:SetText("Owned")
		        labelowned:SetColor(Color(0,200,0))
				labelowned.letext = "Owned"
				else
					LocalPlayer():PrintMessage(HUD_PRINTTALK, "You need more money to purchase this")
				end
			 else
				LocalPlayer():PrintMessage(HUD_PRINTTALK, "already equipped")
			  end
			 end
			 function button1:OnCursorEntered()
				local points = ply:GetNWInt("points")
			    local npoints=tonumber(points)
				--local fakeent = ents.CreateClientside("lunasflightschool_" .. v.GameName)
			   local modelprev = vgui.Create("DModelPanel",frame)
			   modelprev:SetPos( 800, 60 )
			   modelprev:SetSize(200,200)
			   modelprev:SetCamPos((modelprev:GetCamPos() - modelprev:GetLookAt())*3.5)
			   --modelprev:SetEntity(fakeent)
			   modelprev:SetModel(v.ModelPath)
			   modelprev:SetCamPos(modelprev:GetCamPos() + Vector(25,0,0))
			   for k,v in pairs(labelowned:GetParent():GetChildren()) do
				if (v:GetName()=="DLabel") then
				   if (v.leprc) then
					  if (v.leprc<=npoints) then
						v:SetColor(Color(0,200,0))
					   else
					      v:SetColor(Color(200,0,0))
					  end
				   end
				end
			end
             plabel:SetText("Points : " .. points)
			end
			function button1:OnCursorExited()
                for k,v in ipairs(frame:GetChildren()) do
					if (v:GetName()=="DModelPanel") then
						--v:SetEntity(nil)
						v:Remove()
					 end
					end
			end
		 if compteur == 4 then
			 compteur=0
			 lines=lines+1
			 allcompteur=allcompteur+1
		else
			compteur=compteur+1
			allcompteur=allcompteur+1
		end
	   end

	end)
	end

	hook.Add( "OnPlayerChat", "menu_pldm", function( ply, strText, bTeam, bDead )
        if ( ply != LocalPlayer() ) then return end
	strText = string.lower( strText )
	print(strText)
	if (strText == "!pmenu") then
	local pframe = vgui.Create("DFrame")
	pframe:SetSize(1000,600)
	pframe:Center()
	pframe:SetVisible(true)
	pframe:MakePopup()
	pframe:SetTitle("Planes Deathmatch Panel")
	pframe.Paint = function (s , w, h)
	   draw.RoundedBox(5,0,0,w,h,Color(0,0,0))
	end
	local ptested = vgui.Create("DButton", pframe)
	ptested:SetPos(10,30)
	ptested:SetSize(900,200)
	ptested:SetFont("CloseCaption_Bold")
	if(simfphys.LFS.GetVersion()>vertested) then 
	ptested:SetText("This version of lfs has not been tested with this version of Planes deathmatch")
	ptested:SetColor( Color( 255, 0, 0 ) )
	elseif(simfphys.LFS.GetVersion()<vertested) then
	ptested:SetText("Please update lfs - Planes addon")
	ptested:SetColor( Color( 255, 0, 0 ) )
    else
	ptested:SetText("This version of lfs has been tested with this version of Planes Deathmatch")
	ptested:SetColor( Color( 0, 255, 0 ) )
	end
	ptested.Paint = function (s , w, h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0))
	 end
	 local poptio1 = vgui.Create("DButton", pframe)
    poptio1:SetPos(10,230)
	poptio1:SetSize(900,200)
	poptio1:SetFont("CloseCaption_Bold")
	if(isoptionale) then 
	poptio1:SetText("Optional starwars mode mounted")
	else
		poptio1:SetText("Optional starwars mode is not mounted")
	end
	poptio1.Paint = function (s , w, h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0))
	 end
	end
	end )

function welcomedraw()
   if hasbeenwelcomed then return end
   hasbeenwelcomed=true
   helpdw()
end

function helpdw()
	local wframe = vgui.Create("DFrame")
	wframe:SetSize(920,600)
	wframe:Center()
	wframe:SetVisible(true)
	wframe:MakePopup()
	wframe:SetTitle("Planes Deathmatch Welcome")
	wframe.Paint = function (s , w, h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0))
	 end
	 local pspawn1 = vgui.Create("DButton", wframe)
	 pspawn1:SetPos(10,130)
	 pspawn1:SetSize(900,100)
	 pspawn1:SetFont("CloseCaption_Bold")
	 pspawn1:SetText("!spawn1 to go in ally team")
	 pspawn1:SetColor( Color( 0, 255, 0 ) )
	 pspawn1.Paint = function (s , w, h)
		 draw.RoundedBox(5,0,0,w,h,Color(0,0,0))
	  end
	  local btnspawn1 = vgui.Create("DButton", wframe)
	  btnspawn1:SetPos(10,230)
	  btnspawn1:SetSize(900,100)
	  btnspawn1:SetFont("CloseCaption_Bold")
	  btnspawn1:SetText("Choose ally team")
	  btnspawn1:SetColor( Color( 0, 255, 0 ) )
	  btnspawn1.Paint = function (s , w, h)
		 draw.RoundedBox(5,0,0,w,h,Color(128,128,128))
	  end
	  function btnspawn1:DoClick()
		LocalPlayer():ConCommand( "say !spawn1" )
		wframe:Close()
	 end
	  local pspawn2 = vgui.Create("DButton", wframe)
	  pspawn2:SetPos(10,330)
	  pspawn2:SetSize(900,100)
	  pspawn2:SetFont("CloseCaption_Bold")
	  pspawn2:SetText("!spawn2 to go in enemy team")
	  pspawn2:SetColor( Color( 255, 0, 0 ) )
	  pspawn2.Paint = function (s , w, h)
		 draw.RoundedBox(5,0,0,w,h,Color(0,0,0))
	  end
	  local btnspawn2 = vgui.Create("DButton", wframe)
	  btnspawn2:SetPos(10,430)
	  btnspawn2:SetSize(900,100)
	  btnspawn2:SetFont("CloseCaption_Bold")
	  btnspawn2:SetText("Choose enemy team")
	  btnspawn2:SetColor( Color( 255, 0, 0 ) )
	  btnspawn2.Paint = function (s , w, h)
		 draw.RoundedBox(5,0,0,w,h,Color(128,128,128))
	  end
	  function btnspawn2:DoClick()
		LocalPlayer():ConCommand( "say !spawn2" )
        wframe:Close()
	 end
	  local pusefull = vgui.Create("DButton", wframe)
	  pusefull:SetPos(10,30)
	  pusefull:SetSize(900,100)
	  pusefull:SetFont("CloseCaption_Bold")
	  pusefull:SetText("Usefull commands :")
	  pusefull.Paint = function (s , w, h)
		  draw.RoundedBox(5,0,0,w,h,Color(0,0,0))
	   end
end

function PaintPlayersIdentifiers()
	local ply = LocalPlayer()
	if (ply:Team()==TEAM_UNASSIGNED) then return end
	if(ply:InVehicle() == false) then return end
	if (!IsValid(ply:lfsGetPlane())) then return end
	local MyPos = ply:lfsGetPlane():GetPos()
	for k, v in pairs( simfphys.LFS:PlanesGetAll()) do
	   if (IsValid( v ) ) then
		  if !v:GetAI() then
		  if !IsValid(v:GetDriverSeat()) then return end
		  if !IsValid(v:GetDriver()) then return end
		  local rPos = v:GetDriverSeat():GetPos()
		  local rrrPos = Vector(rPos.x,rPos.y,rPos.z-150)
		  local Pos = rrrPos:ToScreen()
		  local Dist = (MyPos - rPos):Length()
		  local Alpha = math.max(255 - Dist * 0.015,0)
		  local elcor = Color( 0, 0, 0, 255 )
		  if (ply:lfsGetPlane():GetAITEAM()==v:GetAITEAM()) then
			elcolor=Color( 0, 127, 255, Alpha )
		else
			elcolor=Color( 255, 0, 0, Alpha )
		  end
		  draw.Text( {
			text = v:GetDriver():GetName(),
			pos = { Pos.x-2*string.len(v:GetDriver():GetName()), Pos.y },
			font = "Trebuchet18",
			color = elcolor
		} )
		else
			if !IsValid(v:GetDriverSeat()) then return end
			local rPos = v:GetDriverSeat():GetPos()
		local Pos = rPos:ToScreen()
		local Dist = (MyPos - rPos):Length()
		local Alpha = math.max(255 - Dist * 0.015,0)
			local elcolor = Color( 0, 0, 0, 255 )
	    if (ply:lfsGetPlane():GetAITEAM()==v:GetAITEAM()) then
			elcolor=Color( 0, 127, 255, Alpha )
		else
			elcolor=Color( 255, 0, 0, Alpha )
		end
		local bottext = ""
		if (v:GetClass()=="lunasflightschool_laatgunshipred") then
        bottext = "Rebel Ship"
		elseif (v:GetClass()=="lunasflightschool_lambda") then
        bottext = "Empire Ship"
	    else
			bottext = "Bot"
	    end
		draw.Text( {
		  text = bottext,
		  pos = { Pos.x-2*string.len(bottext), Pos.y },
		  font = "Trebuchet18",
		  color = elcolor
	  } )
	     end
	   end
	end
end
function drawadminshop()
	local ply = LocalPlayer()
   if !ply:IsSuperAdmin() then return end
   local frame = vgui.Create("DFrame")
    frame:SetSize(1000,600)
     frame:Center()
     frame:SetVisible(true)
     frame:MakePopup()
     frame:SetTitle("Planes Deathmatch Admin Shop")
      frame.Paint = function (s , w, h)
      draw.RoundedBox(5,0,0,w,h,Color(0,0,0))
	  end 
	  local DScrollPanel = vgui.Create("DScrollPanel",frame)
      DScrollPanel:Dock( FILL )
	  DScrollPanel:DockMargin( 0, 0, 0, 0 )
		local lines = 0
		for k,v in pairs(player.GetAll()) do
			if !IsValid(v) then return end
			local ppoints = v:GetNWInt("points")
           local button = DScrollPanel:Add( "DButton" )
		   button:SetPos(0,40+25*lines)
		   button:SetSize(1000,25)
		   button:SetText(v:GetName() .. "                              " .. "Points : " .. ppoints)
		   button:SetColor(Color( 255, 255, 255 ))
		   button.Paint = function (s , w, h)
			 draw.RoundedBox(5,0,0,w,h,Color(128,128,128))
		  end
		  function button:DoClick()
			local pointsframe = vgui.Create("DFrame",frame)
            pointsframe:SetSize(400,200)
            pointsframe:Center()
            pointsframe:SetVisible(true)
            pointsframe:MakePopup()
            pointsframe:SetTitle("Change Points of " .. v:GetName())
            pointsframe.Paint = function (s , w, h)
             draw.RoundedBox(5,0,0,w,h,Color(0,0,0))
			end 
			local pointsentry = vgui.Create("DTextEntry",pointsframe)
            pointsentry:SetPos( 100, 50 )
            pointsentry:SetSize( 200, 25 )
            pointsentry:SetText( tostring(ppoints) )
			pointsentry.OnEnter = function( self )
				local points = tonumber(self:GetValue())
				sendpointstochange(v,points)
				button:SetText(v:GetName() .. "                              " .. "Points : " .. points)
				pointsframe:Close()
			end
			local btnpoints = vgui.Create("DButton",pointsframe)
            btnpoints:SetPos( 100, 100 )
            btnpoints:SetSize( 200, 25 )
			btnpoints:SetText( "Change Points of " .. v:GetName())
			btnpoints.Paint = function (s , w, h)
				draw.RoundedBox(5,0,0,w,h,Color(128,128,128))
			 end
			 function btnpoints:DoClick()
				local points = tonumber(pointsentry:GetValue())
				sendpointstochange(v,points)
				button:SetText(v:GetName() .. "                              " .. "Points : " .. points)
				pointsframe:Close()
			 end
		  end
		  lines=lines+1
		end
end


hook.Add( "OnPlayerChat", "cl_chat_commands", function( ply, strText, bTeam, bDead )
    strText = string.lower( strText )
	if (ply==LocalPlayer()) then
	   if (strText=="!help") then
		helpdw()
		return false
	   end
	   if (strText=="!adminshop") then
		drawadminshop()
		return false
	   end
	end
end )

function sendpointstochange(plyy,points)
	if points<0 then return end
	if !IsValid(plyy) then return end
	net.Start("ChangePoints")
	net.WriteEntity(plyy)
	net.WriteInt(points,32)
	net.SendToServer()
end
