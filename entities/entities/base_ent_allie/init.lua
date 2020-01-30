-- DO NOT REUPLOAD THIS FILE
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

    self:SetModel("models/Cranes/crane_frame.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then

        phys:Wake()

    end
end

function ENT:OnTakeDamage( dmginfo )
    if(dmginfo:GetAttacker().LFS) then return end
    if (dmginfo:IsExplosionDamage()) then return end
        if(dmginfo:GetAttacker():Team() == 1) then return end
        local Damage = dmginfo:GetDamage()
        local CurHealth = self:Health()
        local NewHealth = math.Clamp( CurHealth - Damage , 0, self:GetMaxHealth()  )
        
        self:SetHealth( NewHealth )
    

end