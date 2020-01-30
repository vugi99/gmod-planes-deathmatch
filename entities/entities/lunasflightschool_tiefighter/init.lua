--DO NOT EDIT OR REUPLOAD THIS FILE

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:SpawnFunction( ply, tr, ClassName )

	if not tr.Hit then return end

	local ent = ents.Create( ClassName )
	ent:SetPos( tr.HitPos + tr.HitNormal * 120 )
	ent:Spawn()
	ent:Activate()

	return ent

end

function ENT:RunOnSpawn()
end

function ENT:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	self:EmitSound( "TIE_FIRE" )
	
	self:SetNextPrimary( 0.32 )
	
	for i = 0,1 do
		self.MirrorPrimary = not self.MirrorPrimary
		
		local Mirror = self.MirrorPrimary and -1 or 1
		
		local bullet = {}
		bullet.Num 	= 1
		bullet.Src 	= self:LocalToWorld( Vector(36.78,11.5 * Mirror,-30.955) )
		bullet.Dir 	= self:LocalToWorldAngles( Angle(0,0,0) ):Forward()
		bullet.Spread 	= Vector( 0.02,  0.02, 0 )
		bullet.Tracer	= 1
		bullet.TracerName	= "lfs_laser_green"
		bullet.Force	= 100
		bullet.HullSize 	= 35
		bullet.Damage	= 60
		bullet.Attacker 	= self:GetDriver()
		bullet.AmmoType = "Pistol"
		bullet.Callback = function(att, tr, dmginfo)
		dmginfo:SetDamageType(DMG_AIRBOAT)
		local effectdata = EffectData()
			effectdata:SetOrigin( tr.HitPos )
		util.Effect( "helicoptermegabomb", effectdata )
		end
		self:FireBullets( bullet )
		
		self:TakePrimaryAmmo()
		end
end

function ENT:SecondaryAttack()
	if not self:CanSecondaryAttack() then return end

	self:EmitSound( "TIE_FIRE" )
	
	self:SetNextSecondary( 0.16 )
	
	local fP = { Vector(36.78,11.5,-30.955), Vector(36.78,-11.5,-30.955), Vector(36.78,11.5,-30.955),Vector(36.78,-11.5,-30.955) }

	self.NumPrim = self.NumPrim and self.NumPrim + 1 or 1
	if self.NumPrim > 4 then self.NumPrim = 1 end
	
	local startpos =  self:GetRotorPos()
	local TracePlane = util.TraceHull( {
		start = startpos,
		endpos = (startpos + self:GetForward() * 50000),
		mins = Vector( -10, -10, -10 ),
		maxs = Vector( 10, 10, 10 ),
		filter = self
	} )
	
	local bullet = {}
	bullet.Num 	= 1
	bullet.Src 	= self:LocalToWorld( fP[self.NumPrim] )
	bullet.Dir 	= (TracePlane.HitPos - bullet.Src):GetNormalized()
	bullet.Spread 	= Vector( 0.01,  0.01, 0 )
	bullet.Tracer	= 1
	bullet.TracerName	= "lfs_laser_green"
	bullet.Force	= 100
	bullet.HullSize 	= 50
	bullet.Damage	= 50
	bullet.Attacker 	= self:GetDriver()
	bullet.AmmoType = "Pistol"
	bullet.Callback = function(att, tr, dmginfo)
		dmginfo:SetDamageType(DMG_AIRBOAT)
		local effectdata = EffectData()
			effectdata:SetOrigin( tr.HitPos )
		util.Effect( "helicoptermegabomb", effectdata )
	end
	self:FireBullets( bullet )
	
	self:TakePrimaryAmmo()
end




function ENT:RunEngine()
	local IdleRPM = self:GetIdleRPM()
	local MaxRPM =self:GetMaxRPM()
	local LimitRPM = self:GetLimitRPM()
	local MaxVelocity = self:GetMaxVelocity()
	
	self.TargetRPM = self.TargetRPM or 0
	
	if self:GetEngineActive() then
		local Pod = self:GetDriverSeat()
		
		if not IsValid( Pod ) then return end
		
		local Driver = Pod:GetDriver()
		
		local RPMAdd = 0
		local KeyThrottle = false
		local KeyBrake = false
		
		if IsValid( Driver ) then 
			KeyThrottle = Driver:KeyDown( IN_FORWARD )
			KeyBrake = Driver:KeyDown( IN_BACK )
			RPMAdd = ((KeyThrottle and 2000 or 0) - (KeyBrake and 2000 or 0)) * FrameTime()
		end
		
		if KeyThrottle ~= self.oldKeyThrottle then
			self.oldKeyThrottle = KeyThrottle
			if KeyThrottle then
				if self:CanSound() then
					self:EmitSound( "TIE_BOOST" )
					self:DelayNextSound( 1 )
				end
			else
				if (self:GetRPM() + 1) > MaxRPM then
					if self:CanSound() then
						self:EmitSound( "TIE_BRAKE" )
						self:DelayNextSound( 0.5 )
					end
				end
			end
		end
		
		self.TargetRPM = math.Clamp( self.TargetRPM + RPMAdd,IdleRPM,KeyThrottle and LimitRPM or MaxRPM)
	else
		self.TargetRPM = self.TargetRPM - math.Clamp(self.TargetRPM,-250,250)
	end
	
	self:SetRPM( self:GetRPM() + (self.TargetRPM - self:GetRPM()) * FrameTime() )
	
	local PhysObj = self:GetPhysicsObject()
	if not IsValid( PhysObj ) then return end
	
	local Throttle = self:GetRPM() / self:GetLimitRPM()
	
	local Power = (MaxVelocity * Throttle - self:GetForwardVelocity()) / MaxVelocity * self:GetMaxThrust() * self:GetLimitRPM()
	
	if self:IsDestroyed() or not self:GetEngineActive() then
		self:StopEngine()
		
		return
	end
	
	PhysObj:ApplyForceOffset( self:GetForward() * Power * FrameTime(),  self:GetRotorPos() )
	
end

function ENT:HandleActive()
	local Pod = self:GetDriverSeat()
	
	if not IsValid( Pod ) then
		self:SetActive( false )
		return
	end
	
	local Driver = Pod:GetDriver()
	
	if Driver ~= self:GetDriver() then
		if IsValid( self:GetDriver() ) then
			self:GetDriver():SetNoDraw( false )
		end
		if IsValid( Driver ) then
			Driver:SetNoDraw( true )
		end
		
		self:SetDriver( Driver )
		self:SetActive( IsValid( Driver ) )
		
		if self:GetActive() then
			self:EmitSound( "vehicles/atv_ammo_close.wav" )
		else
			self:EmitSound( "vehicles/atv_ammo_open.wav" )
		end
	end
end

function ENT:PrepExplode()
	if self.MarkForDestruction then
		self:Explode()
	end
	if self:IsDestroyed() then
			self:Explode()
	end
end

function ENT:Explode()
	if self.ExplodedAlready then return end
	
	self.ExplodedAlready = true
	
	local Driver = self:GetDriver()
	local Gunner = self:GetGunner()
	
	if IsValid( Driver ) then
		Driver:TakeDamage( 200, self.FinalAttacker or Entity(0), self.FinalInflictor or Entity(0) )
	end
	
	if IsValid( Gunner ) then
		Gunner:TakeDamage( 200, self.FinalAttacker or Entity(0), self.FinalInflictor or Entity(0) )
	end
	
	if istable( self.pSeats ) then
		for _, pSeat in pairs( self.pSeats ) do
			if IsValid( pSeat ) then
				local psgr = pSeat:GetDriver()
				if IsValid( psgr ) then
					psgr:TakeDamage( 200, self.FinalAttacker or Entity(0), self.FinalInflictor or Entity(0) )
				end
			end
		end
	end
	
	local ent = ents.Create( "lunasflightschool_destruction_tie" )
	if IsValid( ent ) then
		ent:SetPos( self:GetPos() + Vector(0,0,100) )
		ent.GibModels = self.GibModels
		
		ent:Spawn()
		ent:Activate()
	end
	
	self:Remove()
end

function ENT:CreateAI()
end

function ENT:RemoveAI()
end

function ENT:InitWheels()
	local PObj = self:GetPhysicsObject()
	
	if IsValid( PObj ) then 
		PObj:EnableMotion( true )
	end
end

function ENT:ToggleLandingGear()
end

function ENT:RaiseLandingGear()
end

function ENT:CreateAI()
	self:SetBodygroup( 1, 1 ) 
end

function ENT:RemoveAI()
	self:SetBodygroup( 1, 0 ) 
end

function ENT:HandleWeapons(Fire1, Fire2)
	local Driver = self:GetDriver()
	
	if IsValid( Driver ) then
		if self:GetAmmoPrimary() > 0 then
			Fire1 = Driver:KeyDown( IN_ATTACK )
		end
		if self:GetAmmoPrimary() > 0 then
			Fire2 = Driver:KeyDown( IN_ATTACK2 )
		end
	end
	
	if Fire1 then
		self:PrimaryAttack()
	end
	
	if Fire2 then
		self:SecondaryAttack()
	end
end
