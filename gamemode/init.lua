-- DO NOT REUPLOAD THIS FILE
--[[
____  _        _    _   _ _____ ____  
|  _ \| |      / \  | \ | | ____/ ___| 
| |_) | |     / _ \ |  \| |  _| \___ \ 
|  __/| |___ / ___ \| |\  | |___ ___) |
|_|   |_____/_/   \_\_| \_|_____|____/ 
                                       
 ____  _____    _  _____ _   _ __  __    _  _____ ____ _   _ 
|  _ \| ____|  / \|_   _| | | |  \/  |  / \|_   _/ ___| | | |
| | | |  _|   / _ \ | | | |_| | |\/| | / _ \ | || |   | |_| |
| |_| | |___ / ___ \| | |  _  | |  | |/ ___ \| || |___|  _  |
|____/|_____/_/   \_\_| |_| |_|_|  |_/_/   \_\_| \____|_| |_|

  ____    _    __  __ _____ __  __  ___  ____  _____ 
 / ___|  / \  |  \/  | ____|  \/  |/ _ \|  _ \| ____|
| |  _  / _ \ | |\/| |  _| | |\/| | | | | | | |  _|  
| |_| |/ ___ \| |  | | |___| |  | | |_| | |_| | |___ 
 \____/_/   \_\_|  |_|_____|_|  |_|\___/|____/|_____|

]]--  
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )
util.AddNetworkString( "AskForPlyPlanes" )
util.AddNetworkString( "ResponseForPlyPlanes" )
util.AddNetworkString( "ChangePlane" )
util.AddNetworkString( "SendBasesToClient" )
util.AddNetworkString( "SendAlliedPlanesToClient" )
util.AddNetworkString( "SendAlliedstwrsPlanesToClient" )
util.AddNetworkString( "SendEnemyPlanesToClient" )
util.AddNetworkString( "SendEnemystwrsPlanesToClient" )
util.AddNetworkString( "ChangePoints" )

local servertesd = false -- this variable is to do a thing one time ,DON'T EDIT IT
local servermapvote = false -- this variable is to launch a mapvote one time ,DON'T EDIT IT
local optionalstable = {} -- optionals gamemodes
optionalstable.optional1 = false 

-- How to get stats ? , go to the plane's folder and go to init.lua to see bullets damage and go to shared.lua for other specs ;)
local AllPlanesallied = {} -- table to set all allied planes
AllPlanesallied["Spitfire"] = {
["Damage"] = 26,
["DamageSecondary"] = 0,
["Health"] = 800,
["PrimaryAmmo"] = 2226,
["SecondaryAmmo"] = 0,
["MaxRPM"] = 1400,
["MaxThrust"] = 700,
["MaxVelocity"] = 2350,
["Name"] = "SpitFire",
["GameName"] = "spitfire", -- GameName = name of the plane's folder example : lunasflightschool_spitfire , the GameName is spitfire , the GameName is lunasflightschool_spitfire without lunasflightschool_
["Price"] = 0,
["ModelPath"] = "models/blu/spitfire.mdl", -- need it to show the model in the shop
["number_z_required"] = 0, -- additional height required to avoid spawning in the ground
}
-- Add a second plane to the shop for example , remove  --[[]]-- ,YOU NEED (https://steamcommunity.com/sharedfiles/filedetails/?id=1706185127)
--[[AllPlanesallied["DewoitineD520"] = {
    ["Damage"] = 35,
    ["DamageSecondary"] = 300,
    ["Health"] = 800,
    ["PrimaryAmmo"] = 2500,
    ["SecondaryAmmo"] = 60,
    ["MaxRPM"] = 1200,
    ["MaxThrust"] = 720,
    ["MaxVelocity"] = 2500,
    ["Name"] = "DewoitineD520",
    ["GameName"] = "dewoitine_d520",
    ["Price"] = 100,
    ["ModelPath"] = "models/diggerthings/d520/6.mdl",
    ["number_z_required"] = 0,
    }]]--
    

local AllPlanesenemies = {} -- table to set all enemy planes
AllPlanesenemies["BF109"] = {
        ["Damage"] = 10,
        ["DamageSecondary"] = 125,
        ["Health"] = 800,
        ["PrimaryAmmo"] = 2000,
        ["SecondaryAmmo"] = 200,
        ["MaxRPM"] = 1200,
        ["MaxThrust"] = 750,
        ["MaxVelocity"] = 2400,
        ["Name"] = "BF109",
        ["GameName"] = "bf109",
        ["Price"] = 0,
        ["ModelPath"] = "models/blu/bf109.mdl",
        ["number_z_required"] = 0,
       }

local AllPlanesalliedstarwars = {} -- table to set all allied planes on a starwars map 
AllPlanesalliedstarwars["Xwing"] = {
        ["Damage"] = 40,
        ["DamageSecondary"] = 0,
        ["Health"] = 600,
        ["Shield"] = 165,
        ["PrimaryAmmo"] = 3000,
        ["SecondaryAmmo"] = 20,
        ["MaxRPM"] = 2800,
        ["MaxThrust"] = 30000,
        ["MaxVelocity"] = 2630,
        ["Name"] = "Xwing",
        ["GameName"] = "xwing",
        ["Price"] = 0,
        ["ModelPath"] = "models/xwing/xwing1.mdl",
        ["number_z_required"] = 0,
       }


local AllPlanesenemiesstarwars = {} -- table to set all enemy planes on a starwars map 
AllPlanesenemiesstarwars["TieFighter"] = {
        ["Damage"] = 60,
        ["DamageSecondary"] = 0,
        ["Health"] = 800,
        ["Shield"] = 0,
        ["PrimaryAmmo"] = 1500,
        ["SecondaryAmmo"] = 0,
        ["MaxRPM"] = 2800,
        ["MaxThrust"] = 20000,
        ["MaxVelocity"] = 2400,
        ["Name"] = "TieFighter",
        ["GameName"] = "tiefighter",
        ["Price"] = 0,
        ["ModelPath"] = "models/diggerthings/tiefighter/tief.mdl",
        ["number_z_required"] = 50,
       }

local AllMaps = {}
AllMaps["gm_flatgrass"] = {
    ["StarWarsMap"] = "false",
    ["Base1Pos"] = {
                ["Posx"]  = -14960,
                ["Posy"] = 754,
                ["Posz"] = -12800,
                   },
    ["Base2Pos"] = {
        ["Posx"]  = 14516,
        ["Posy"] = -1359,
        ["Posz"] = -12800,
           },
    ["xrandom1"] = {["lower"] = -15209, ["higher"] = -13157,},
    ["yrandom1"] = {["lower"] = 2598, ["higher"] = 5190,},
    ["PlaneAngleyaw1"] = 0,
    ["z1"] = -12800,
    ["z2"] = -12800,
    ["PlaneAngleyaw2"] = 180,
    ["xrandom2"] = {["lower"] = 12968, ["higher"] = 15036,},
    ["yrandom2"] = {["lower"] = -6237, ["higher"] = -2954,},
    ["BotsAngle1"] = 0,
    ["BotsAngle2"] = 180,
}

AllMaps["gm_vexten"] = {
    ["StarWarsMap"] = "false",
    ["Base1Pos"] = {
                ["Posx"]  = -12353,
                ["Posy"] = -14900,
                ["Posz"] = -12275,
                   },
    ["Base2Pos"] = {
        ["Posx"]  = -600,
        ["Posy"] = 14813,
        ["Posz"] = -10250,
           },
    ["xrandom1"] = {["lower"] = -14624, ["higher"] = -10874,},
    ["yrandom1"] = {["lower"] = -13458, ["higher"] = -10307,},
    ["PlaneAngleyaw1"] = 90,
    ["z1"] = -12275,
    ["z2"] = -12800,
    ["PlaneAngleyaw2"] = -90,
    ["xrandom2"] = {["lower"] = 4602, ["higher"] = 8272,},
    ["yrandom2"] = {["lower"] = 2027, ["higher"] = 5052,},
    ["BotsAngle1"] = 90,
    ["BotsAngle2"] = -90,
}

AllMaps["gm_vexten_night"] = {
    ["StarWarsMap"] = "false",
    ["Base1Pos"] = {
                ["Posx"]  = -12353,
                ["Posy"] = -14900,
                ["Posz"] = -12275,
                   },
    ["Base2Pos"] = {
        ["Posx"]  = -600,
        ["Posy"] = 14813,
        ["Posz"] = -10250,
           },
    ["xrandom1"] = {["lower"] = -14624, ["higher"] = -10874,},
    ["yrandom1"] = {["lower"] = -13458, ["higher"] = -10307,},
    ["PlaneAngleyaw1"] = 90,
    ["z1"] = -12275,
    ["z2"] = -12800,
    ["PlaneAngleyaw2"] = -90,
    ["xrandom2"] = {["lower"] = 4602, ["higher"] = 8272,},
    ["yrandom2"] = {["lower"] = 2027, ["higher"] = 5052,},
    ["BotsAngle1"] = 90,
    ["BotsAngle2"] = -90,
}

AllMaps["gm_jakku_wreck_v1"] = {
    ["StarWarsMap"] = "true",
    ["Base1Pos"] = {
                ["Posx"]  = 9240,
                ["Posy"] = 14516,
                ["Posz"] = 100,
                   },
    ["Base2Pos"] = {
        ["Posx"]  = 6618,
        ["Posy"] = -14398,
        ["Posz"] = 0,
           },
    ["xrandom1"] = {["lower"] = 6836, ["higher"] = 8415,},
    ["yrandom1"] = {["lower"] = 14135, ["higher"] = 15020,},
    ["PlaneAngleyaw1"] = -90,
    ["z1"] = 100,
    ["z2"] = 500,
    ["PlaneAngleyaw2"] = 90,
    ["xrandom2"] = {["lower"] = 7604, ["higher"] = 9540,},
    ["yrandom2"] = {["lower"] = -15029, ["higher"] = -14133,},
    ["BotsAngle1"] = -90,
    ["BotsAngle2"] = 90,
}

AllMaps["rp_stardestroyer_v2_4_inf"] = {
    ["StarWarsMap"] = "true",
    ["Base1Pos"] = {
                ["Posx"]  = 10938,
                ["Posy"] = 0,
                ["Posz"] = -3750,
                   },
    ["Base2Pos"] = {
        ["Posx"]  = -8879,
        ["Posy"] = 0,
        ["Posz"] = 2350,
           },
    ["xrandom1"] = {["lower"] = 902, ["higher"] = 2587,},
    ["yrandom1"] = {["lower"] = -922, ["higher"] = 898,},
    ["PlaneAngleyaw1"] = 0,
    ["z1"] = -5207,
    ["z2"] = -5207,
    ["PlaneAngleyaw2"] = 0,
    ["xrandom2"] = {["lower"] = 902, ["higher"] = 2587,},
    ["yrandom2"] = {["lower"] = -922, ["higher"] = 898,},
    ["BotsAngle1"] = 180,
    ["BotsAngle2"] = 0,
}

AllMaps["gm_deathstar_trench_v2_2_inf"] = {
    ["StarWarsMap"] = "true",
    ["Base1Pos"] = {
                ["Posx"]  = 6776,
                ["Posy"] = -10893,
                ["Posz"] = -9000,
                   },
    ["Base2Pos"] = {
        ["Posx"]  = -13691,
        ["Posy"] = 12693,
        ["Posz"] = -7500,
           },
    ["xrandom1"] = {["lower"] = 3736, ["higher"] = 6688,},
    ["yrandom1"] = {["lower"] = -8671, ["higher"] = -5579,},
    ["PlaneAngleyaw1"] = 90,
    ["z1"] = -9200,
    ["z2"] = -8850,
    ["PlaneAngleyaw2"] = 0,
    ["xrandom2"] = {["lower"] = -15008, ["higher"] = -13991,},
    ["yrandom2"] = {["lower"] = 11672, ["higher"] = 13438,},
    ["BotsAngle1"] = 90,
    ["BotsAngle2"] = 0,
}
AllMaps["gm_warmap_v5"] = {
    ["StarWarsMap"] = "false",
    ["Base1Pos"] = {
                ["Posx"]  = 8161,
                ["Posy"] = 4227,
                ["Posz"] = -10844,
                   },
    ["Base2Pos"] = {
        ["Posx"]  = -7356,
        ["Posy"] = -21,
        ["Posz"] = -10470,
           },
    ["xrandom1"] = {["lower"] = 9039, ["higher"] = 10202,},
    ["yrandom1"] = {["lower"] = 4339, ["higher"] = 6585,},
    ["PlaneAngleyaw1"] = -90,
    ["z1"] = -10867,
    ["z2"] = -10634,
    ["PlaneAngleyaw2"] = 90,
    ["xrandom2"] = {["lower"] = -7874, ["higher"] = -8686,},
    ["yrandom2"] = {["lower"] = 68, ["higher"] = 996,},
    ["BotsAngle1"] = 180,
    ["BotsAngle2"] = 0,
}
-- to take positions in gmod type GetPos in console to know where are you exactly in the map (it will return pos and EyeAngle : x y z pitch yaw roll)
-- remove --[[]]-- when you have finished
--[[AllMaps[name of the map] = { -- the name of the map is the name of the map without.bsp example.bsp ---> example
    ["StarWarsMap"] = "", -- true or false in the ""
    ["Base1Pos"] = {  
                ["Posx"]  = number, -- the allied base x position
                ["Posy"] = number,  -- the allied base y position
                ["Posz"] = number,  -- the allied base z position
                   },
    ["Base2Pos"] = {
        ["Posx"]  = number, -- the enemy base x position
        ["Posy"] = number,  -- the enemy base y position
        ["Posz"] = number,   -- the enemy base z position
           },
    ["xrandom1"] = {["lower"] = number, ["higher"] = number,}, -- when an allied plane spawn in a random  defined area (x)
    ["yrandom1"] = {["lower"] = number, ["higher"] = number,},  -- when an allied plane spawn in a random defined area (y)
    ["PlaneAngleyaw1"] = yaw_angle, -- yaw angle when an allied plane spawn
    ["z1"] = number, -- allied plane z position when he spawn
    ["z2"] = number, -- enemy plane z position when he spawn
    ["PlaneAngleyaw2"] = yaw_angle, -- yaw angle when an enemy plane spawn
    ["xrandom2"] = {["lower"] = number, ["higher"] = number,}, -- when an enemy plane spawn in a random defined area (x)
    ["yrandom2"] = {["lower"] = number, ["higher"] = number,}, -- when an enemy plane spawn in a random defined area (y)
    ["BotsAngle1"] = yaw_angle, -- yaw angle when an allied bot spawn
    ["BotsAngle2"] = yaw_angle, -- yaw angle when an enemy bot spawn
}]]--

-- DON'T EDIT THIS------------
local Nothing = {}
Nothing["RETURN"] = {
    ["Nothingg"] = "Nothinggg"
}
-------------------------------

function GM:Initialize()
    --Create ConVars if they aren't exist
    CreateConVar("pldm_number_bots",5,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_bases_hp",40000,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_optio_bases_hp",50000,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_points_time",200,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_number_points",10,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_player_rocket",1,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_anti_spam",1,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_remove_bot_when_ply",0,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_print_base_life",1,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_bot_plane_allied","lunasflightschool_spitfire",{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_bot_plane_alliedstarwars","lunasflightschool_xwing",{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_bot_plane_enemy","lunasflightschool_bf109",{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_bot_plane_enemystarwars","lunasflightschool_tiefighter",{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_auto_reload",1,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_auto_reload_time_primary",5,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_auto_reload_time_secondary",10,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")
    CreateConVar("pldm_invincible_time",10,{ FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY },"")

end

function ResetPData (ply) -- this function reset all datas
    ply:SetPData("points", 0)
    ply:SetPData("plane_allied", "lunasflightschool_spitfire")
    ply:SetPData("plane_enemy", "lunasflightschool_bf109")
    ply:SetPData("plane_allied_sw", "lunasflightschool_xwing")
    ply:SetPData("plane_enemy_sw", "lunasflightschool_tiefighter")
    ply:SetPData("all_plane_allied", "lunasflightschool_spitfire")
    ply:SetPData("all_plane_enemy", "lunasflightschool_bf109")
    ply:SetPData("all_plane_allied_sw", "lunasflightschool_xwing")
    ply:SetPData("all_plane_enemy_sw", "lunasflightschool_tiefighter")
end
function CreatePDatas (ply)
    --Create A player datas if they aren't exist
   if (!ply:GetPData("points")) then 
     ply:SetPData("points", 0)
   end
   if (!ply:GetPData("plane_allied")) then
    ply:SetPData("plane_allied", "lunasflightschool_spitfire")
   end
   if (!ply:GetPData("plane_enemy")) then
    ply:SetPData("plane_enemy", "lunasflightschool_bf109")
   end
   if (!ply:GetPData("plane_allied_sw")) then
    ply:SetPData("plane_allied_sw", "lunasflightschool_xwing")
   end
   if (!ply:GetPData("plane_enemy_sw")) then
    ply:SetPData("plane_enemy_sw", "lunasflightschool_tiefighter")
   end
   if (!ply:GetPData("all_plane_allied")) then
    ply:SetPData("all_plane_allied", "lunasflightschool_spitfire")
   end
   if (!ply:GetPData("all_plane_enemy")) then
    ply:SetPData("all_plane_enemy", "lunasflightschool_bf109")
   end
   if (!ply:GetPData("all_plane_allied_sw")) then
    ply:SetPData("all_plane_allied_sw", "lunasflightschool_xwing")
   end
   if (!ply:GetPData("all_plane_enemy_sw")) then
    ply:SetPData("all_plane_enemy_sw", "lunasflightschool_tiefighter")
   end

end
function GM:PlayerInitialSpawn( ply )
   ply:SetGravity( 1 )
   ply:SetWalkSpeed( 250 )
   ply:SetRunSpeed( 300 )
   ply:SetCrouchedWalkSpeed( 0.3 )
   ply:SetDuckSpeed( 0.5 )
   ply:SetAvoidPlayers(true)
   ply:SetModel("models/player/kleiner.mdl")
   ply.isinalfs = false
   CreatePDatas(ply)
   --ResetPData(ply) --Enabling this function will reset all player data when they join
   sendmapbasestoclient(ply)
   sendshopplanes(ply)
   ply:SetNWInt( "points",ply:GetPData("points")  )
   check_equipped_plane(ply)
   if (servertesd == true) then return end -- this variable is to do this one time
   servertesd=true
   local map_name = game.GetMap()
   if(!AllMaps[map_name]) then return end
   if (file.Exists("pldm_optio1.txt","DATA") and AllMaps[game.GetMap()].StarWarsMap == "true") then return spawn_bases_alternate_gm() end
   local craneframeent = ents.Create( "base_ent_allie" )
    if ( !IsValid( craneframeent ) ) then return end 
        craneframeent:SetModel( "models/Cranes/crane_frame.mdl" )
        local craneframeent2 = ents.Create( "base_ent_enemy" )
        craneframeent2:SetModel( "models/Cranes/crane_frame.mdl" )
        if ( !IsValid( craneframeent2 ) ) then return end 

        craneframeent:SetPos( Vector( AllMaps[map_name].Base1Pos.Posx,AllMaps[map_name].Base1Pos.Posy,AllMaps[map_name].Base1Pos.Posz) )
        craneframeent:Spawn()
        craneframeent2:SetPos( Vector( AllMaps[map_name].Base2Pos.Posx,AllMaps[map_name].Base2Pos.Posy,AllMaps[map_name].Base2Pos.Posz) )
        craneframeent2:Spawn()

    local physicscrane = craneframeent:GetPhysicsObject()
    physicscrane:EnableMotion(false)
    craneframeent:SetMaxHealth(GetConVar("pldm_bases_hp"):GetInt())
    craneframeent:SetHealth(craneframeent:GetMaxHealth())
    local physicscrane2 = craneframeent2:GetPhysicsObject()
    physicscrane2:EnableMotion(false)
    craneframeent2:SetMaxHealth(GetConVar("pldm_bases_hp"):GetInt())
    craneframeent2:SetHealth(craneframeent:GetMaxHealth())
    GivePointsTimer()
    spawn_lfs_ai(craneframeent, craneframeent2)
end

function antispawnkill(ent, ply) -- to avoid spawnkilling
    ply:GodEnable()
    ply:PrintMessage(HUD_PRINTTALK, ply:GetName() .. " is invincible for " .. GetConVar("pldm_invincible_time"):GetInt() .. " seconds")
    timer.Create("planelife",0.1,GetConVar("pldm_invincible_time"):GetInt()*10, function() 
        if !IsValid(ply) then return end
        if ( !IsValid( ent ) ) then return ply:GodDisable() end
        ent:SetHP( ent:GetMaxHP())
        ent:SetShield( ent:GetMaxShield() )
    end )
    timer.Simple(GetConVar("pldm_invincible_time"):GetInt(), function()
        if ( !IsValid( ent ) ) then  return end
        if ( !IsValid( ply ) ) then return end
        if(!ply:Alive()) then return ply:PrintMessage(HUD_PRINTTALK, ply:GetName() .. " is no longer invincible") end
        ply:GodDisable()
        ply:PrintMessage(HUD_PRINTTALK, ply:GetName() .. " is no longer invincible")
    end )
end

function spitspawn( sender ) -- called when an allied plane spawn
    if(!sender:Alive()) then return sender:SetTeam(1) end
    local map_name = game.GetMap()
        local spitfireent = ents.Create( sender:GetPData("plane_allied") ) -- Get the player's ally equiped plane
        if ( !IsValid( spitfireent ) ) then return end 
            local xrandom = math.random(AllMaps[map_name].xrandom1.lower,AllMaps[map_name].xrandom1.higher)
        local yrandom = math.random(AllMaps[map_name].yrandom1.lower,AllMaps[map_name].yrandom1.higher)
        local ztoadd = 0
        for k,v in pairs(AllPlanesallied) do
        if ("lunasflightschool_" .. v.GameName==sender:GetPData("plane_allied")) then
        if (v.number_z_required) then
           ztoadd = v.number_z_required
        else
            ztoadd = 0
        end
    end
    end
        spitfireent:SetPos( Vector( xrandom, yrandom, AllMaps[map_name].z1 + ztoadd) )
        spitfireent:SetAngles(Angle(0, AllMaps[map_name].PlaneAngleyaw1, 0))
        spitfireent:Spawn()
        local randomchara = {"models/player/paratrooper_01.mdl","models/player/paratrooper_02.mdl","models/player/paratrooper_03.mdl","models/player/paratrooper_04.mdl","models/player/paratrooper_05.mdl"}
        sender:SetModel( randomchara[math.random(#randomchara)] )
        sender:EnterVehicle( spitfireent:GetDriverSeat() )
        sender:GetVehicle():SetThirdPersonMode(true)
        sender.isinalfs=true
        antispawnkill(spitfireent, sender)
end

function bfspawn( sender ) -- called when an enemy plane spawn
    if(!sender:Alive()) then return sender:SetTeam(2) end
    local map_name = game.GetMap()
        local bfent = ents.Create( sender:GetPData("plane_enemy") ) -- Get the player's enemy equiped plane
        if ( !IsValid( bfent ) ) then return end 
            local xrandom = math.random(AllMaps[map_name].xrandom2.lower,AllMaps[map_name].xrandom2.higher)
        local yrandom = math.random(AllMaps[map_name].yrandom2.lower,AllMaps[map_name].yrandom2.higher)
        local ztoadd = 0
        for k,v in pairs(AllPlanesenemies) do
            if ("lunasflightschool_" .. v.GameName==sender:GetPData("plane_enemy")) then
            if (v.number_z_required) then
               ztoadd = v.number_z_required
            else
                ztoadd = 0
            end
        end
        end
        bfent:SetPos( Vector( xrandom, yrandom, AllMaps[map_name].z2 + ztoadd) )
        bfent:SetAngles(Angle(0, AllMaps[map_name].PlaneAngleyaw2, 0))
        bfent:Spawn()
        local randomchara2 = {"models/player/heer_01.mdl","models/player/heer_02.mdl","models/player/heer_03.mdl"}
        sender:SetModel( randomchara2[math.random(#randomchara2)] )
        sender:EnterVehicle( bfent:GetDriverSeat() )
        sender:GetVehicle():SetThirdPersonMode(true)
        sender.isinalfs=true
        antispawnkill(bfent, sender)
end


function xwingspawn( sender ) -- called when an allied plane spawn on a starwars map
    if(!sender:Alive()) then return sender:SetTeam(1) end
    local map_name = game.GetMap()
    local xwingent = ents.Create( sender:GetPData("plane_allied_sw") ) -- Get the player's ally equiped plane  on a starwars map
        if ( !IsValid( xwingent ) ) then return end 
        local xrandom = math.random(AllMaps[map_name].xrandom1.lower,AllMaps[map_name].xrandom1.higher)
        local yrandom = math.random(AllMaps[map_name].yrandom1.lower,AllMaps[map_name].yrandom1.higher)
        local ztoadd = 0
        for k,v in pairs(AllPlanesalliedstarwars) do
            if ("lunasflightschool_" .. v.GameName==sender:GetPData("plane_allied_sw")) then
            if (v.number_z_required) then
               ztoadd = v.number_z_required
            else
                ztoadd = 0
            end
        end
        end
        xwingent:SetPos( Vector( xrandom, yrandom, AllMaps[map_name].z1 + ztoadd) )
        xwingent:SetAngles(Angle(0, AllMaps[map_name].PlaneAngleyaw1, 0))
            xwingent:Spawn()
        local randomchara3 = {"models/player/sgg/starwars/rebels/r_soldier_forest/male_01.mdl","models/player/sgg/starwars/rebels/r_soldier_forest/male_02.mdl","models/player/sgg/starwars/rebels/r_soldier_forest/male_03.mdl","models/player/sgg/starwars/rebels/r_soldier_forest/male_04.mdl","models/player/sgg/starwars/rebels/r_soldier_forest/male_05.mdl","models/player/sgg/starwars/rebels/r_soldier_forest/male_06.mdl","models/player/sgg/starwars/rebels/r_soldier_forest/male_07.mdl","models/player/sgg/starwars/rebels/r_soldier_forest/male_08.mdl","models/player/sgg/starwars/rebels/r_soldier_forest/male_09.mdl","models/player/sgg/starwars/rebels/r_soldier_forest/male_10.mdl","models/player/sgg/starwars/rebels/r_soldier_forest/male_11.mdl","models/player/sgg/starwars/rebels/r_soldier_urban/male_01.mdl","models/player/sgg/starwars/rebels/r_soldier_urban/male_02.mdl","models/player/sgg/starwars/rebels/r_soldier_urban/male_03.mdl","models/player/sgg/starwars/rebels/r_soldier_urban/male_04.mdl","models/player/sgg/starwars/rebels/r_soldier_urban/male_05.mdl","models/player/sgg/starwars/rebels/r_soldier_urban/male_06.mdl","models/player/sgg/starwars/rebels/r_soldier_urban/male_07.mdl","models/player/sgg/starwars/rebels/r_soldier_urban/male_08.mdl","models/player/sgg/starwars/rebels/r_soldier_urban/male_09.mdl","models/player/sgg/starwars/rebels/r_soldier_urban/male_10.mdl","models/player/sgg/starwars/rebels/r_soldier_urban/male_11.mdl","models/player/sgg/starwars/rebels/r_trooper/male_01.mdl","models/player/sgg/starwars/rebels/r_trooper/male_02.mdl","models/player/sgg/starwars/rebels/r_trooper/male_03.mdl","models/player/sgg/starwars/rebels/r_trooper/male_04.mdl","models/player/sgg/starwars/rebels/r_trooper/male_05.mdl","models/player/sgg/starwars/rebels/r_trooper/male_06.mdl","models/player/sgg/starwars/rebels/r_trooper/male_07.mdl","models/player/sgg/starwars/rebels/r_trooper/male_08.mdl","models/player/sgg/starwars/rebels/r_trooper/male_09.mdl","models/player/sgg/starwars/rebels/r_trooper_captain/male_01.mdl","models/player/sgg/starwars/rebels/r_trooper_captain/male_02.mdl","models/player/sgg/starwars/rebels/r_trooper_captain/male_03.mdl","models/player/sgg/starwars/rebels/r_trooper_captain/male_04.mdl","models/player/sgg/starwars/rebels/r_trooper_captain/male_05.mdl","models/player/sgg/starwars/rebels/r_trooper_captain/male_06.mdl","models/player/sgg/starwars/rebels/r_trooper_captain/male_07.mdl","models/player/sgg/starwars/rebels/r_trooper_captain/male_08.mdl","models/player/sgg/starwars/rebels/r_trooper_captain/male_09.mdl"}
        sender:SetModel( randomchara3[math.random(#randomchara3)] )
        sender:EnterVehicle( xwingent:GetDriverSeat() )
        sender:GetVehicle():SetThirdPersonMode(true)
        sender.isinalfs=true
        antispawnkill(xwingent, sender)
end

function tiefighterspawn( sender ) -- called when an enemy plane spawn on a starwars map
    if(!sender:Alive()) then return sender:SetTeam(2) end
    local map_name = game.GetMap()
    local tiefighterent = ents.Create( sender:GetPData("plane_enemy_sw") ) -- Get the player's enemy equiped plane  on a starwars map
        if ( !IsValid( tiefighterent ) ) then return end 
        local xrandom = math.random(AllMaps[map_name].xrandom2.lower,AllMaps[map_name].xrandom2.higher)
        local yrandom = math.random(AllMaps[map_name].yrandom2.lower,AllMaps[map_name].yrandom2.higher)
        local ztoadd = 0
        for k,v in pairs(AllPlanesenemiesstarwars) do
            if ("lunasflightschool_" .. v.GameName==sender:GetPData("plane_enemy_sw")) then
            if (v.number_z_required) then
               ztoadd = v.number_z_required
            else
                ztoadd = 0
            end
        end
        end
        tiefighterent:SetPos( Vector( xrandom, yrandom, AllMaps[map_name].z2 + ztoadd) )
        tiefighterent:SetAngles(Angle(0, AllMaps[map_name].PlaneAngleyaw2, 0))
            tiefighterent:Spawn()
        local randomchara4 = {"models/player/markus/swbf2/characters/hero/imperial_pilots/pilot_imperial_orig_01/pilot_imperial_orig_01.mdl","models/player/markus/swbf2/characters/hero/imperial_pilots/pilot_imperial_orig_02_r/pilot_imperial_orig_02_r.mdl","models/player/markus/swbf2/characters/hero/imperial_pilots/pilot_imperial_orig_03_g/pilot_imperial_orig_03_g.mdl","models/player/markus/swbf2/characters/hero/imperial_pilots/pilot_imperial_orig_04_b/pilot_imperial_orig_04_b.mdl","models/player/markus/swbf2/characters/hero/imperial_pilots/pilot_imperial_orig_05_o/pilot_imperial_orig_05_o.mdl","models/player/markus/swbf2/characters/hero/imperial_pilots/pilot_imperial_orig_06_p/pilot_imperial_orig_06_p.mdl"}
        sender:SetModel( randomchara4[math.random(#randomchara4)] )
        sender:EnterVehicle( tiefighterent:GetDriverSeat() )
        sender:GetVehicle():SetThirdPersonMode(true)
        sender.isinalfs=true
        antispawnkill(tiefighterent, sender)
end


function GM:PlayerSpawn( sender ) -- this is called when a player spawn
    if( sender:Team() == 1 ) then
        if(AllMaps[game.GetMap()].StarWarsMap == "true") then return  xwingspawn(sender) end
        spitspawn(sender)
 end
 if ( sender:Team() == 2 ) then
    if(AllMaps[game.GetMap()].StarWarsMap == "true") then return  tiefighterspawn(sender) end
    bfspawn(sender)
 end

end

function GM:PlayerSay(sender, text, teamChat) -- this is called when a player is chatting
    if ( text == "!spawn1" ) then -- if the text is "!spawn1" then ...
        if (sender:InVehicle()==false) then 
        sender:SetTeam(1) 
        if(AllMaps[game.GetMap()].StarWarsMap == "true") then return  xwingspawn(sender) end
        spitspawn(sender)
        else sender:SetTeam(1)
            sender:lfsGetPlane():Remove()
            sender:Kill()
         end
    elseif ( text == "!spawn2" ) then -- if the text is "!spawn2" then ...
        if (sender:InVehicle()==false) then 
        sender:SetTeam(2)
        if(AllMaps[game.GetMap()].StarWarsMap == "true") then return  tiefighterspawn(sender) end
        bfspawn(sender)
    else sender:SetTeam(2)
        sender:lfsGetPlane():Remove()
        sender:Kill()
     end
        elseif ( text == "!refill_ammo" ) then -- if the text is "!refill_ammo" then ...
            if (GetConVar("pldm_auto_reload"):GetInt()==1) then return sender:PrintMessage(HUD_PRINTTALK, "You can't do this command when the auto reload is enabled") end
            if(sender:InVehicle() == false) then return end
            local plyrefillplane = sender:lfsGetPlane()
            plyrefillplane:SetAmmoPrimary(plyrefillplane:GetMaxAmmoPrimary())
            plyrefillplane:SetAmmoSecondary(plyrefillplane:GetMaxAmmoSecondary())
            sender:PrintMessage(HUD_PRINTTALK,"Ammo reloaded !")
        end
        
   return tostring(text)
end

function setrightangle(angle,ply) -- To set the eyes of the player same as the yaw of the deleted plane to eject him to the right position
    timer.Simple(0.1,function()
   ply:SetEyeAngles(angle)
    end )
end

function rocketplayer(ply,speed) -- Rocket the player when he exit a plane
    timer.Simple(0.2,function()
        local vr = Vector(0,0,1500)+ply:GetForward()*speed*10
        ply:SetVelocity(vr)
        end )
end
hook.Add( "KeyPress", "keypress_use_checkplane", function( ply, key ) -- kill the player and remove his plane when he try to get out of the plane
    if ( key == IN_USE ) then
        if(ply.isinalfs==false) then return end
        ply.isinalfs=false
        if(GetConVar("pldm_player_rocket"):GetInt()==1)then
        local plangle = ply:lfsGetPlane():GetAngles()
        local plangleyaw = plangle.y
        local plangle2 = Angle(0,plangleyaw,0)
        local vel = ply:lfsGetPlane():GetVelocity():Length()
        local speed = math.Round(vel * 0.09144,0)
        setrightangle(plangle2,ply)
        rocketplayer(ply,speed)
        ply:lfsGetPlane():Remove()
        timer.Simple(2,function()
        ply:Kill()
        end )
    else
        ply:lfsGetPlane():Remove()
        ply:Kill()
    end
    --elseif (ply:InVehicle()==true) then
        --ply.isinalfs=true
    end
end )
hook.Add( "KeyPress", "keypress_forward_check", function( ply, key ) -- launch plane's engine when pressing forward key
    if ( key == IN_FORWARD ) then
        if(ply:InVehicle()==false) then return end
        if(ply:lfsGetPlane():GetEngineActive()==true) then return end
        ply:lfsGetPlane():SetEngineActive( true )
    end
end )


function afficher_vie( target, dmginfo ) -- show base life when touched
    local map_name = game.GetMap()
    if (dmginfo:IsExplosionDamage()) then return end
    if(optionalstable.optional1==true) then return afficher_vie_optio1(target, dmginfo) end
    if(dmginfo:GetAttacker().LFS) then return end
    if(AllMaps[game.GetMap()].StarWarsMap == "false") then
        if(target:GetClass() == "base_ent_allie") then
            if(dmginfo:GetAttacker():Team() == 1) then return end
            if(GetConVar("pldm_print_base_life"):GetInt()==1)then
            PrintMessage( HUD_PRINTCENTER, "The american base has " .. math.Round(target:Health()-dmginfo:GetDamage()) .. "HP" )
            end
                 if (Vector(AllMaps[map_name].Base1Pos.Posx,AllMaps[map_name].Base1Pos.Posy,AllMaps[map_name].Base1Pos.Posz):DistToSqr(dmginfo:GetAttacker():GetPos())<250000) then
                    anti_spam(dmginfo)
                 end
                 check_if_died(1,target)
        elseif(target:GetClass() == "base_ent_enemy") then
            if(dmginfo:GetAttacker():Team() == 2) then return end
            if(GetConVar("pldm_print_base_life"):GetInt()==1)then
            PrintMessage( HUD_PRINTCENTER, "The german base has " .. math.Round(target:Health()-dmginfo:GetDamage()) .. "HP" )
            end
            if (Vector(AllMaps[map_name].Base2Pos.Posx,AllMaps[map_name].Base2Pos.Posy,AllMaps[map_name].Base2Pos.Posz):DistToSqr(dmginfo:GetAttacker():GetPos())<250000) then
                anti_spam(dmginfo)
             end
             check_if_died(2,target)

        end
    elseif(AllMaps[game.GetMap()].StarWarsMap == "true") then
        if(target:GetClass() == "base_ent_allie") then
            if(dmginfo:GetAttacker():Team() == 1) then return end
            if(GetConVar("pldm_print_base_life"):GetInt()==1)then
            PrintMessage( HUD_PRINTCENTER, "The rebel base has " .. math.Round(target:Health()-dmginfo:GetDamage()) .. "HP" )
            end
            if (Vector(AllMaps[map_name].Base1Pos.Posx,AllMaps[map_name].Base1Pos.Posy,AllMaps[map_name].Base1Pos.Posz):DistToSqr(dmginfo:GetAttacker():GetPos())<250000) then
                anti_spam(dmginfo)
             end
             check_if_died(3,target)

            elseif(target:GetClass() == "base_ent_enemy") then
                if(dmginfo:GetAttacker():Team() == 2) then return end
                if(GetConVar("pldm_print_base_life"):GetInt()==1)then
            PrintMessage( HUD_PRINTCENTER, "The Empire base has " .. math.Round(target:Health()-dmginfo:GetDamage()) .. "HP" )
                end
            if (Vector(AllMaps[map_name].Base2Pos.Posx,AllMaps[map_name].Base2Pos.Posy,AllMaps[map_name].Base2Pos.Posz):DistToSqr(dmginfo:GetAttacker():GetPos())<250000) then
                anti_spam(dmginfo)
             end
             check_if_died(4,target)
        end
    end
end

function check_if_died(number,target)
local txt = ""
if (number==1) then
txt="Germans won !!!"

elseif (number==2) then
txt="Americans won !!!"

elseif (number==3) then
 txt="Empire won !!!"

elseif (number==4) then
txt="Rebels won !!!"

end
if(target:Health() == 0) then
    PrintMessage(HUD_PRINTCENTER, txt)
    baseexplosion(target)
    if(servermapvote == true) then return end
    if(game.SinglePlayer()==true) then return end
    MapVote.Start()
   servermapvote = true
   end
end

function anti_spam(dmginfo)
    if(GetConVar("pldm_anti_spam"):GetInt()==1)then
        local plane = dmginfo:GetAttacker():lfsGetPlane()
        local ply = dmginfo:GetAttacker()
        plane:SetVelocity(Vector(0,0,0))
        plane:SetPos(Vector(plane:GetPos())+Vector(0,0,1500))
        ply:SetEyeAngles(Angle(0,ply:GetAngles().y-180,0))
        plane:SetAngles(Angle(0,plane:GetAngles().y-180,0))
        dmginfo:GetAttacker():PrintMessage(HUD_PRINTTALK,"Don't be lazy, play correctly")
        end
end
    
hook.Add("EntityTakeDamage", "afficher_viee", afficher_vie ) -- call afficher_vie function when an entity is taking damage

function GM:ShutDown() -- set to false vars when shutdown
 servertesd=false
 servermapvote = false
end

function GM:PlayerDeath( victim, inflictor, attacker ) -- set to false isinalfs var who is determinating when you are in a plane when you're dead
    victim.isinalfs=false
end

function spawn_lfs_ai(base1, base2) --SPAWN LFS AIs TO REMOVE PERMAPROPS DEPENDENCIE !
    local numberzonbase = 1000
   timer.Create("timer_spawn_lfs_ai",10,0,function()
    local numberofallies = 0
    local numberofenemys = 0
    for k,v in pairs (simfphys.LFS:PlanesGetAll()) do
        if !IsValid(v) then return end
        if (AllMaps[game.GetMap()].StarWarsMap == "false") then
            if(v:GetClass()==GetConVar("pldm_bot_plane_allied"):GetString()) then
        numberofallies = v:GetAI() and numberofallies + 1 or numberofallies
            
            elseif(v:GetClass()==GetConVar("pldm_bot_plane_enemy"):GetString()) then
                numberofenemys = v:GetAI() and numberofenemys + 1 or numberofenemys
            end
        elseif (AllMaps[game.GetMap()].StarWarsMap == "true") then
            if(v:GetClass()==GetConVar("pldm_bot_plane_alliedstarwars"):GetString()) then
                numberofallies = v:GetAI() and numberofallies + 1 or numberofallies
                    
            elseif(v:GetClass()==GetConVar("pldm_bot_plane_enemystarwars"):GetString()) then
                        numberofenemys = v:GetAI() and numberofenemys + 1 or numberofenemys
                        
                end
        end
    end
    if(GetConVar("pldm_remove_bot_when_ply"):GetInt()==1)then
        for k,v in pairs (player.GetAll()) do
           if IsValid(v) then
              if (v:Team()==1) then
                 numberofallies=numberofallies+1
              elseif (v:Team()==2) then
                numberofenemys=numberofenemys+1
              end
           end
        end
    end
    if(optionalstable.optional1==true) then return spawn_lfs_ai_optio1(numberzonbase,numberofallies,numberofenemys) end
    if(numberofallies<GetConVar("pldm_number_bots"):GetInt()) then --if number of allies is less than the convar value spawn 1 ally
        if(AllMaps[game.GetMap()].StarWarsMap == "true") then
            hyperspacespawn(GetConVar("pldm_bot_plane_alliedstarwars"):GetString(),AllMaps[game.GetMap()].Base1Pos.Posx,AllMaps[game.GetMap()].Base1Pos.Posy,AllMaps[game.GetMap()].Base1Pos.Posz + numberzonbase,AllMaps[game.GetMap()].BotsAngle1)
        end
        if(AllMaps[game.GetMap()].StarWarsMap == "false") then
            local spawnallieent = ents.Create(GetConVar("pldm_bot_plane_allied"):GetString())
        spawnallieent:SetPos(Vector(base1:GetPos().x,base1:GetPos().y,base1:GetPos().z + numberzonbase))
        spawnallieent:SetAngles(Angle(0,AllMaps[game.GetMap()].BotsAngle1,0) )
		spawnallieent:Spawn()
		spawnallieent:Activate()
        spawnallieent:SetAI( true )
        boostbots(spawnallieent)
        end
     end
    if(numberofenemys<GetConVar("pldm_number_bots"):GetInt()) then --if number of enemys is less than the convar value spawn 1 enemy
        if(AllMaps[game.GetMap()].StarWarsMap == "true") then
            hyperspacespawn(GetConVar("pldm_bot_plane_enemystarwars"):GetString(),AllMaps[game.GetMap()].Base2Pos.Posx,AllMaps[game.GetMap()].Base2Pos.Posy,AllMaps[game.GetMap()].Base2Pos.Posz + numberzonbase,AllMaps[game.GetMap()].BotsAngle2)
            end
            if(AllMaps[game.GetMap()].StarWarsMap == "false") then
            local spawnallieent = ents.Create(GetConVar("pldm_bot_plane_enemy"):GetString())
            spawnallieent:SetPos(Vector(base2:GetPos().x,base2:GetPos().y,base2:GetPos().z + numberzonbase))
            spawnallieent:SetAngles(Angle(0,AllMaps[game.GetMap()].BotsAngle2,0) )
            spawnallieent:Spawn()
            spawnallieent:Activate()
            spawnallieent:SetAI( true )
            boostbots(spawnallieent)
            end
    end
    
   end)
end

function GivePointsTimer() -- give points to players after an amount of time (ConVar)
   timer.Create("GivePointsTIMERR",GetConVar("pldm_points_time"):GetInt(),0,function()
    for k, v in pairs( player.GetAll() ) do
    if (v:Team()!=0) then 
    v:SetPData("points", v:GetPData("points") + GetConVar("pldm_number_points"):GetInt())
    v:PrintMessage(HUD_PRINTTALK, "You won " .. GetConVar("pldm_number_points"):GetInt() .. " points")
    v:SetNWInt( "points",v:GetPData("points")  )
    else
        v:PrintMessage(HUD_PRINTTALK, "You are afk, you don't won points")
    end
    end
end)
end

net.Receive("ChangePlane",function(len,ply) -- ChangePlane function called when a client press a button to buy a plane
    local plnm = net.ReadTable().GameName
   if(AllMaps[game.GetMap()].StarWarsMap == "false") then
   if(ply:Team() == 1) then
   ChangePlaneSuite("plane_allied","all_plane_allied",ply,plnm,AllPlanesallied)
   end
   if(ply:Team() == 2) then
    ChangePlaneSuite("plane_enemy","all_plane_enemy",ply,plnm,AllPlanesenemies)
    end
end
if(AllMaps[game.GetMap()].StarWarsMap == "true") then
    if(ply:Team() == 1) then
        ChangePlaneSuite("plane_allied_sw","all_plane_allied_sw",ply,plnm,AllPlanesalliedstarwars)
        end
    if(ply:Team() == 2) then
        ChangePlaneSuite("plane_enemy_sw","all_plane_enemy_sw",ply,plnm,AllPlanesenemiesstarwars)
    end
end
end)

function ChangePlaneSuite(data,alldata,ply,plnm,pltable) -- To continue the ChangePlane net , DON'T EDIT
    for k,v in pairs(pltable) do
        if(v.GameName==plnm) then
        local prc = v.Price
    if(string.match(ply:GetPData(alldata),plnm)==plnm) then
        ply:SetPData(data,"lunasflightschool_" .. plnm)
        ply:PrintMessage(HUD_PRINTTALK,"Plane changed to : " .. "lunasflightschool_" .. plnm)
    elseif(tonumber(ply:GetPData("points"))>=prc) then
        ply:SetPData("points",tonumber(ply:GetPData("points")) - prc)
        ply:SetNWInt( "points",ply:GetPData("points")  )
        ply:SetPData(data,"lunasflightschool_" .. plnm)
        ply:SetPData(alldata,ply:GetPData(alldata) .. " " .. "lunasflightschool_" .. plnm)
        ply:PrintMessage(HUD_PRINTTALK,"Plane bought and equiped : " .. "lunasflightschool_" .. plnm)
    else 
        ply:PrintMessage(HUD_PRINTTALK,"You need more points to buy this")
    end
end
end
end

 function spawn_bases_alternate_gm() -- spawn bases of the starwars alternate gamemode
    optionalstable.optional1 = true
    local map_name = game.GetMap()
    local spawnalliebase = ents.Create("lunasflightschool_laatgunshipred")
    spawnalliebase:SetPos( Vector( AllMaps[map_name].Base1Pos.Posx,AllMaps[map_name].Base1Pos.Posy,AllMaps[map_name].Base1Pos.Posz) )
    spawnalliebase:SetAngles(Angle(0,AllMaps[game.GetMap()].BotsAngle1,0) )
    spawnalliebase:Spawn()
    spawnalliebase:Activate()
    spawnalliebase:SetAI( true )
    local spawnenemybase = ents.Create("lunasflightschool_lambda")
    spawnenemybase:SetPos( Vector( AllMaps[map_name].Base2Pos.Posx,AllMaps[map_name].Base2Pos.Posy,AllMaps[map_name].Base2Pos.Posz) )
    spawnenemybase:SetAngles(Angle(0,AllMaps[game.GetMap()].BotsAngle2,0) )
    spawnenemybase:Spawn()
    spawnenemybase:Activate()
    spawnenemybase:SetAI( true )

    spawnalliebase.MaxHealth = GetConVar("pldm_optio_bases_hp"):GetInt()
    spawnalliebase:SetHP( spawnalliebase:GetMaxHP())
    spawnalliebase.MaxShield = 0
    spawnalliebase:SetShield(0)

    spawnenemybase.MaxHealth = GetConVar("pldm_optio_bases_hp"):GetInt()
    spawnenemybase:SetHP( spawnenemybase:GetMaxHP())
    spawnenemybase.MaxShield = 0
    spawnenemybase:SetShield(0)
    GivePointsTimer()
    spawn_lfs_ai()
    timer.Simple(5,function()
    check_stwrs_ships(spawnalliebase,spawnenemybase)
    end)
 end

 function afficher_vie_optio1(target, dmginfo)
    if(target:GetClass()=="lunasflightschool_laatgunshipred") then
        if(!dmginfo:GetAttacker():IsPlayer() and !dmginfo:GetAttacker().LFS) then return afficher_vie_apres_verif_optio1(1,target,dmginfo) end
        if(dmginfo:GetAttacker().LFS) then return afficher_vie_apres_verif_optio1(1,target,dmginfo) end
        if(dmginfo:GetAttacker():Team() == 1) then
            local Damage = dmginfo:GetDamage()
            local CurHealth = target:GetHP()
            local NewHealth = math.Clamp( CurHealth + Damage , 0, target:GetMaxHP()  )
            target:SetHP( NewHealth )
        else 
            afficher_vie_apres_verif_optio1(1,target,dmginfo)
        end
    elseif(target:GetClass()=="lunasflightschool_lambda")then
        if(!dmginfo:GetAttacker():IsPlayer() and !dmginfo:GetAttacker().LFS) then return afficher_vie_apres_verif_optio1(2,target,dmginfo) end
        if(dmginfo:GetAttacker().LFS) then return afficher_vie_apres_verif_optio1(2,target,dmginfo) end
        if(dmginfo:GetAttacker():Team() == 2) then
        local Damage = dmginfo:GetDamage()
        local CurHealth = target:GetHP()
        local NewHealth = math.Clamp( CurHealth + Damage , 0, target:GetMaxHP()  )
        target:SetHP( NewHealth )
        else
            afficher_vie_apres_verif_optio1(2,target,dmginfo)
        end
    end
    

 end

 function afficher_vie_apres_verif_optio1(number,target,dmginfo)
    if(number==1) then
        if(GetConVar("pldm_print_base_life"):GetInt()==1)then
        PrintMessage( HUD_PRINTCENTER, "The rebels ship has " .. math.Round(target:GetHP()-dmginfo:GetDamage()) .. "HP" )
        end
        if(target:GetHP() == 0) then
            PrintMessage(HUD_PRINTCENTER, "Empire won !!!")
            if(servermapvote == true) then return end
            if(game.SinglePlayer()==true) then return end
            MapVote.Start()
           servermapvote = true
           end
        else
            if(GetConVar("pldm_print_base_life"):GetInt()==1)then
            PrintMessage( HUD_PRINTCENTER, "The empire ship has " .. math.Round(target:GetHP()-dmginfo:GetDamage()) .. "HP" )
            end
        if(target:GetHP() == 0) then
            PrintMessage(HUD_PRINTCENTER, "Rebels won !!!")
            if(servermapvote == true) then return end
            if(game.SinglePlayer()==true) then return end
            MapVote.Start()
           servermapvote = true
           end
        end

 end

 function check_stwrs_ships(allie,enemy)
    timer.Create( "check_swras_ships_live", 1, 0, function() 
        if(!IsValid(allie)) then
            PrintMessage(HUD_PRINTCENTER, "Empire won !!!")
            if(servermapvote == true) then return end
            if(game.SinglePlayer()==true) then return end
            MapVote.Start()
           servermapvote = true
        elseif(!IsValid(enemy)) then
            PrintMessage(HUD_PRINTCENTER, "Rebels won !!!")
            if(servermapvote == true) then return end
            if(game.SinglePlayer()==true) then return end
            MapVote.Start()
           servermapvote = true
        end

    end)
 end

 function spawn_lfs_ai_optio1(numberzonbase,numberofallies,numberofenemys)
    if(numberofallies<GetConVar("pldm_number_bots"):GetInt()) then
        hyperspacespawn(GetConVar("pldm_bot_plane_alliedstarwars"):GetString(),AllMaps[game.GetMap()].Base1Pos.Posx,AllMaps[game.GetMap()].Base1Pos.Posy,AllMaps[game.GetMap()].Base1Pos.Posz + numberzonbase,AllMaps[game.GetMap()].BotsAngle1)
    end
    if(numberofenemys<GetConVar("pldm_number_bots"):GetInt())then
        hyperspacespawn(GetConVar("pldm_bot_plane_enemystarwars"):GetString(),AllMaps[game.GetMap()].Base2Pos.Posx,AllMaps[game.GetMap()].Base2Pos.Posy,AllMaps[game.GetMap()].Base2Pos.Posz + numberzonbase,AllMaps[game.GetMap()].BotsAngle2)
    end
 end


 function sendmapbasestoclient(ply)
    net.Start("SendBasesToClient")
    if(!AllMaps[game.GetMap()]) then
        net.WriteTable(Nothing)
    else
        net.WriteTable(AllMaps[game.GetMap()])
    end
    if(file.Exists("pldm_optio1.txt","DATA"))then
    net.WriteBool(true)
    else
    net.WriteBool(false)
    end
    net.WriteBool(optionalstable.optional1)

    if(!AllMaps[game.GetMap()]) then
        net.WriteBool(true)
    else
        net.WriteBool(false)
    end
    net.Send(ply)
 end

 function sendshopplanes(ply)
local jsonalliedpl = util.TableToJSON(AllPlanesallied)
local jsonenemypl = util.TableToJSON(AllPlanesenemies)
local jsonalliedstarwarspl = util.TableToJSON(AllPlanesalliedstarwars)
local jsonenemystarwarspl = util.TableToJSON(AllPlanesenemiesstarwars)

local calliedpl = util.Compress(jsonalliedpl)
local cenemypl = util.Compress(jsonenemypl)
local calliedstwrspl = util.Compress(jsonalliedstarwarspl)
local cenemystwrspl = util.Compress(jsonenemystarwarspl)

local lencalliedpl = string.len( calliedpl )
local lencenemypl = string.len( cenemypl )
local lencalliedstwrspl = string.len( calliedstwrspl )
local lencenemystwrspl = string.len( cenemystwrspl )


net.Start("SendAlliedPlanesToClient")
net.WriteData(calliedpl,lencalliedpl)
net.Send(ply)

net.Start("SendAlliedstwrsPlanesToClient")
net.WriteData(calliedstwrspl,lencalliedstwrspl)
net.Send(ply)

net.Start("SendEnemyPlanesToClient")
net.WriteData(cenemypl,lencenemypl)
net.Send(ply)

net.Start("SendEnemystwrsPlanesToClient")
net.WriteData(cenemystwrspl,lencenemystwrspl)
net.Send(ply)
 end


 net.Receive("AskForPlyPlanes", function(len,ply)
    local plyteam = ply:Team()
    local desired = ""
    local desiredall = ""
if (plyteam==1 and AllMaps[game.GetMap()].StarWarsMap=="false") then
    desired = "plane_allied"
    desiredall = "all_plane_allied"
elseif(plyteam==1 and AllMaps[game.GetMap()].StarWarsMap=="true") then
    desired = "plane_allied_sw"
    desiredall = "all_plane_allied_sw"
elseif(plyteam==2 and AllMaps[game.GetMap()].StarWarsMap=="false") then
    desired = "plane_enemy"
    desiredall = "all_plane_enemy"
elseif(plyteam==2 and AllMaps[game.GetMap()].StarWarsMap=="true") then
    desired = "plane_enemy_sw"
    desiredall = "all_plane_enemy_sw"
 end
net.Start("ResponseForPlyPlanes")
net.WriteString(ply:GetPData(desiredall))
net.WriteString(ply:GetPData(desired))
net.Send(ply)
end)


function hyperspacespawn(Ship,x,y,z,angle)
    local hyperspaceent = ents.Create("IGvanilla_hyperspace_ship")
    hyperspaceent:SetKeyValue("AI", "1")
    hyperspaceent:SetKeyValue("Freeze", "0")
    hyperspaceent:SetKeyValue("Flip", "0")
    hyperspaceent:SetKeyValue("Shake", "0")
    hyperspaceent:SetKeyValue("Sound", "1")
    hyperspaceent:SetKeyValue("SpawnModel", "0")
    hyperspaceent:SetKeyValue("ActualModel", "")
    hyperspaceent:SetKeyValue("Entity", Ship)
    hyperspaceent:SetOwner("thx_for_the_if_not_IsValid(value)_then_return_end")
    hyperspaceent:SetPos(Vector(x,y,z))
    hyperspaceent:SetAngles(Angle(0,0,0) + Angle(0,angle,0))
    hyperspaceent:Spawn()
end

function GM:PlayerDeath( victim, inflictor, attacker )
timer.Simple(2,function()
    if !IsValid(victim) then return end
   if (victim:Health()==0) then
   victim:Spawn()
   end
end)

end

function baseexplosion(b)
    local explode = ents.Create( "env_explosion" )
    explode:SetPos( b:GetPos() )
    explode:Spawn() 
	explode:SetKeyValue( "iMagnitude", "220" ) 
    explode:Fire( "Explode", 0, 0 )
    explode:EmitSound( "BaseExplosionEffect.Sound", 75, 100,1 )
    b:Remove()
end

function boostbots(ent)
   fwrd = ent:GetForward()
   physob = ent:GetPhysicsObject()
   physob:SetVelocity(fwrd*1000)
end


function GM:Think() 
    if (GetConVar("pldm_auto_reload"):GetInt()==0) then return end
    for k,v in pairs(simfphys.LFS:PlanesGetAll()) do
        if  IsValid(v)  and not v:IsDestroyed() and IsValid(v:GetDriver()) and not v:GetAI() then
        if (v:GetAmmoPrimary()==0 and v:GetMaxAmmoPrimary()!=0) then
            if (v.reloading == false or v.reloading == nil) then
                v.reloading = true
            v:GetDriver():PrintMessage(HUD_PRINTTALK, "Primary ammo reloaded in " .. GetConVar("pldm_auto_reload_time_primary"):GetInt() .. " seconds")
           timer.Simple(GetConVar("pldm_auto_reload_time_primary"):GetInt(),function()
             if IsValid(v) then 
             if !v:IsDestroyed() then 
             if IsValid(v:GetDriver()) then 
             v.reloading = false
             v:SetAmmoPrimary(v:GetMaxAmmoPrimary())
             v:GetDriver():PrintMessage(HUD_PRINTTALK, "Primary ammo reloaded")
             end
            end
        end
           end)
        end
        end
        if (v:GetAmmoSecondary()==0 and v:GetMaxAmmoSecondary()!=0) then
            if (v.seconreloading == false or v.seconreloading == nil) then
                v.seconreloading = true
         v:GetDriver()PrintMessage(HUD_PRINTTALK, "Secondary ammo reloaded in " .. GetConVar("pldm_auto_reload_time_secondary"):GetInt() .. " seconds")
          timer.Simple(GetConVar("pldm_auto_reload_time_secondary"):GetInt(),function()
            if IsValid(v) then 
            if !v:IsDestroyed() then 
            if IsValid(v:GetDriver()) then 
             v.seconreloading=false
             v:SetAmmoSecondary(v:GetMaxAmmoSecondary())
             v:GetDriver():PrintMessage(HUD_PRINTTALK, "Secondary ammo reloaded")
            end
        end
    end
          end)
        end
        end
    end
     end
end

 net.Receive("ChangePoints",function(len,ply) 
     if !ply:IsSuperAdmin() then return end
     local ent = net.ReadEntity()
     local points = net.ReadInt(32)
     ent:SetPData("points", points)
     ent:SetNWInt( "points",ent:GetPData("points")  )
     ply:PrintMessage(HUD_PRINTTALK, "The points of " .. ent:GetName() .. " have been changed to " .. points)
 end)


function check_equipped_plane(ply)
   local equipped_allie = ply:GetPData("plane_allied")
   local equipped_enemy = ply:GetPData("plane_enemy")
   local equipped_allie_stwrs = ply:GetPData("plane_allied_sw")
   local equipped_enemy_stwrs = ply:GetPData("plane_enemy_sw")
   local alliechecked = false
   local enemychecked = false
   local alliestarchecked = false
   local enemystarchecked = false
   for k,v in pairs(AllPlanesallied) do
      if (equipped_allie=="lunasflightschool_" .. v.GameName) then
         alliechecked=true
      end
   end
   for k,v in pairs(AllPlanesenemies) do
    if (equipped_enemy=="lunasflightschool_" .. v.GameName) then
        enemychecked=true
     end
   end
   for k,v in pairs(AllPlanesalliedstarwars) do
    if (equipped_allie_stwrs=="lunasflightschool_" .. v.GameName) then
        alliestarchecked=true
     end
   end
   for k,v in pairs(AllPlanesenemiesstarwars) do
    if (equipped_enemy_stwrs=="lunasflightschool_" .. v.GameName) then
        enemystarchecked=true
     end
   end
   timer.Simple(5,function()
   if IsValid(ply) then
    if !alliechecked then
       ply:PrintMessage(HUD_PRINTTALK, "Your allied equipped plane was reset because he was removed")
        ply:SetPData("plane_allied", "lunasflightschool_spitfire")
    end
    if !enemychecked then
        ply:PrintMessage(HUD_PRINTTALK, "Your enemy equipped plane was reset because he was removed")
        ply:SetPData("plane_enemy", "lunasflightschool_bf109")
    end
    if !alliestarchecked then
        ply:PrintMessage(HUD_PRINTTALK, "Your starwars allied equipped plane was reset because he was removed")
        ply:SetPData("plane_allied_sw", "lunasflightschool_xwing")
    end
    if !enemystarchecked then
        ply:PrintMessage(HUD_PRINTTALK, "Your starwars enemy equipped plane was reset because he was removed")
        ply:SetPData("plane_enemy_sw", "lunasflightschool_tiefighter")
    end
   end
end)
end