--NO U

ENT.Type            = "anim"
DEFINE_BASECLASS( "lunasflightschool_basescript" )

ENT.PrintName = "TIE Fighter"
ENT.Author = "Digger"
ENT.Information = ""
ENT.Category = "[LFS]"

ENT.Spawnable		= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/DiggerThings/TieFighter/tief.mdl"
ENT.GibModels = {
	"models/DiggerThings/TieFighter/gib1.mdl",
	"models/DiggerThings/TieFighter/gib2.mdl",
	"models/DiggerThings/TieFighter/gib3.mdl",
	"models/DiggerThings/TieFighter/gib4.mdl",
	"models/DiggerThings/TieFighter/gib5.mdl"
}

ENT.AITEAM = 1

ENT.Mass = 2000
ENT.Inertia = Vector(150000,150000,150000)
ENT.Drag = -1

ENT.SeatPos = Vector(0,0,-30)
ENT.SeatAng = Angle(0,-90,0)

ENT.IdleRPM = 1
ENT.MaxRPM = 2800
ENT.LimitRPM = 3000

ENT.RotorPos = Vector(40,0,0)
ENT.WingPos = Vector(100,0,0)
ENT.ElevatorPos = Vector(-300,0,0)
ENT.RudderPos = Vector(-300,0,0)

ENT.MaxVelocity = 2400

ENT.MaxThrust = 20000

ENT.MaxTurnPitch = 700
ENT.MaxTurnYaw = 700
ENT.MaxTurnRoll = 550

ENT.MaxPerfVelocity = 1400

ENT.MaxHealth = 800

ENT.Stability = 0.8

ENT.MaxPrimaryAmmo = 1500
ENT.VerticalTakeoff = true
ENT.VtolAllowInputBelowThrottle = 40
ENT.MaxThrustVtol = 10000

sound.Add( {
	name = "TIE_FIRE",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = 125,
	pitch = {95, 105},
	sound = "^lfs/tie/wpn_tie_blaster_long.wav"
} )

sound.Add( {
	name = "TIE_ENGINE",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "^lfs/tie/eng_tieBomber_mid_lp.wav"
} )

sound.Add( {
	name = "TIE_DIST",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "lfs/tie/eng_tieFighter_hi_lp.wav"
} )

sound.Add( {
	name = "TIE_BOOST",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "lfs/tie/IE_BY_1.wav"
} )

sound.Add( {
	name = "TIE_BRAKE",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	sound = "lfs/tie/IE_BY_2.wav"
} )

sound.Add( {
	name = "LFS_TIE_EXPLOSION",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 125,
	pitch = {90, 110},
	sound = "lfs/tie/ie_by_2.wav"
} )