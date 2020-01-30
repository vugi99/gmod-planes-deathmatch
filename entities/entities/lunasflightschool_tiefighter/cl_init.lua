--DO NOT EDIT OR REUPLOAD THIS FILE

include("shared.lua")

function ENT:Initialize()	
end

function ENT:ExhaustFX()
	if not self:GetEngineActive() then return end
	
	self.nextEFX = self.nextEFX or 0
	
	local THR = (self:GetRPM() - self.IdleRPM) / (self.LimitRPM - self.IdleRPM)
	
	local Driver = self:GetDriver()
	if IsValid( Driver ) then
		local W = Driver:KeyPressed( IN_FORWARD )
		if W ~= self.oldW then
			self.oldW = W
			if W then
				self.BoostAdd = 80
			end
		end
	end
	
	self.BoostAdd = self.BoostAdd and (self.BoostAdd - self.BoostAdd * FrameTime()) or 0
	
	if self.nextEFX < CurTime() then
		self.nextEFX = CurTime() + 0.01
		
		local emitter = ParticleEmitter( self:GetPos(), false )
		local Pos = {
			Vector(-38,-28.8,0),
			Vector(-38,28.8,0),
		}
		
		if emitter then
			for _, v in pairs( Pos ) do
				local Sub = Mirror and 1 or -1
				local vOffset = self:LocalToWorld( v )
				local vNormal = -self:GetForward()

				vOffset = vOffset + vNormal * 5

				local particle = emitter:Add( "effects/muzzleflash2", vOffset )
				if not particle then return end

				particle:SetVelocity( vNormal * math.Rand(500,1000) + self:GetVelocity() )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.1 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(15,25) )
				particle:SetEndSize( math.Rand(0,10) )
				particle:SetRoll( math.Rand(-1,1) * 100 )
				
				particle:SetColor( 205, 0, 0 )
			end
			
			emitter:Finish()
		end
	end
end

function ENT:CalcEngineSound()
	local CurDist = (LocalPlayer():GetViewEntity() :GetPos() - self:GetPos()):Length()
	self.PitchOffset = self.PitchOffset and self.PitchOffset + (math.Clamp((CurDist - self.OldDist) * FrameTime() * 300,-40,40) - self.PitchOffset) * FrameTime() * 5 or 0
	local Doppler = -self.PitchOffset
	self.OldDist = CurDist
	
	local RPM = self:GetRPM()
	local Pitch = (RPM - self.IdleRPM) / (self.LimitRPM - self.IdleRPM)
	
	if self.ENG then
		self.ENG:ChangePitch(  math.Clamp(math.Clamp(  60 + Pitch * 50, 80,255) + Doppler,0,255) )
		self.ENG:ChangeVolume( math.Clamp( -1 + Pitch * 6, 0.5,1) )
	end
	
	if self.DIST then
		self.DIST:ChangePitch(  math.Clamp(math.Clamp(  Pitch * 100, 50,255) + Doppler * 1.25,0,255) )
		self.DIST:ChangeVolume( math.Clamp( -1.5 + Pitch * 6, 0.5,1) )
	end
end

function ENT:EngineActiveChanged( bActive )
	if bActive then
		self.ENG = CreateSound( self, "TIE_ENGINE" )
		self.ENG:PlayEx(0,0)
		
		self.DIST = CreateSound( self, "TIE_DIST" )
		self.DIST:PlayEx(0,0)
	else
		self:SoundStop()
	end
end

function ENT:OnRemove()
	self:SoundStop()

	if IsValid( self.Cockpit ) then
		self.Cockpit:Remove()
	end

end

function ENT:SoundStop()
	if self.DIST then
		self.DIST:Stop()
	end
	
	if self.ENG then
		self.ENG:Stop()
	end
end

function ENT:AnimFins()
end

function ENT:AnimRotor()
end


function ENT:AnimCabin()


	if not IsValid( self.Cockpit ) then
		local Prop = ents.CreateClientProp()
		Prop:SetPos( self:LocalToWorld( Vector(10,0,0) ) )
		Prop:SetAngles( self:GetAngles() )
		Prop:SetModel( "models/DiggerThings/tieadvanced/cockpit.mdl" )
		Prop:SetParent( self )
		Prop:Spawn()
		
		self.Cockpit = Prop
	end
	
	self.Cockpit:SetNoDraw( not self.FirstPerson ) 

end

function ENT:AnimLandingGear()
end

local mat = Material( "sprites/light_glow02_add" )
function ENT:Draw()
	local ply = LocalPlayer()
	if not IsValid( ply ) then return end
	
	local Pod = ply:GetVehicle()
	
	if ply == self:GetDriver() then
		if IsValid( Pod ) then
			if Pod:GetThirdPersonMode() then
				self:DrawModel()
				self.FirstPerson = false
			else
				self.FirstPerson = true
			end
		else
			self:DrawModel()
			self.FirstPerson = false
		end
	else
		self:DrawModel()
		self.FirstPerson = false
	end

	
	if not self:GetEngineActive() then return end
	
	local Boost = self.BoostAdd or 0
	
	local Size = 40 + (self:GetRPM() / self:GetLimitRPM()) * 40 + Boost

	render.SetMaterial( mat )
	render.DrawSprite( self:LocalToWorld( Vector(-38,-28.8,0) ), Size, Size, Color( 205, 0, 0, 255) )
	render.DrawSprite( self:LocalToWorld( Vector(-38,28.8,0) ), Size, Size, Color( 205, 0, 0, 255) )
	
end

