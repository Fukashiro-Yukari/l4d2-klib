class ::KLib.EntityClass {
    __ent = null
    __idx = null

    function __error(s){
        ::error("[KLib __error] "+s+" ("+__idx+")\n")
    }

    function __assert(b,s = "__assertion failed",bo = false){
        if (b) return true

        if (bo){
            throw s
        }
        else {
            this.__error(s)
        }

        return false
    }

    function IsValid(){
        return ::IsValid(__ent)
    }

    function IsValidW(){
        return __assert(IsValid(),"Invalid entity")
    }

    function IsPlayerW(){
        // return __assert(IsPlayer(),"Entity is not a player")

        return IsPlayer()
    }

    function GetBaseIndex(){
        if (!IsValidW()) return -1

        return __ent.GetEntityIndex()
    }

    function GetIndex(){
        return __idx
    }

    function GetEnt(){
        if (!IsValidW()) return

        return __ent
    }

    function GetClass(){
        if (!IsValidW()) return

        return __ent.GetClassname()
    }

    function GetContext(s){
        if (!IsValidW()) return

        return __ent.GetContext(s)
    }

    function GetEntIndex(){
        if (!IsValidW()) return

        return __ent.GetEntityIndex()
    }

    function GetParent(){
        if (!IsValidW()) return

        return __ent.GetMoveParent()
    }

    function GetScriptScope(){
        if (!IsValidW()) return

        __ent.ValidateScriptScope()

        return __ent.GetScriptScope()
    }

    function SetScriptVar(k,v){
        if (!IsValidW()) return

        local t = GetScriptScope()

        t[k] <- v
    }

    function GetScriptVar(k,d = null){
        if (!IsValidW()) return

        local t = GetScriptScope()

        if (k in t){
            return t[k]
        }
        else {
            return d
        }
    }

    function DelScriptVar(k){
        if (!IsValidW()) return

        local t = GetScriptScope()

        if (k in t){
            table.remove(t,k)
        }
    }

    function HasNP(n){
        return NetProps.HasProp(__ent,n)
    }

    function GetNPArraySize(n){
        return NetProps.GetPropArraySize(__ent,n)
    }

    function GetNPType(n){
        return NetProps.GetPropType(__ent,n)
    }

    function GetNP(n,element = 0){
        if (!HasNP(n)) return null

        local type = GetNPType(n)

        switch (type){
            case "integer":
            {
                local entity = GetNPEntity(n,element)

                if (entity != null)
                    return entity
                else
                    return GetNPInt(n,element)
            }
            case "float":
                return GetNPFloat(n,element)
            case "string":
                return GetNPString(n,element)
            case "Vector":
                return GetNPVector(n,element)
        }

        return null
    }

    function SetNP(n,v,element = 0){
        local type = (typeof v)

        switch(type){
            case "string":
                SetNPString(n,v,element)
            case "integer":
                SetNPInt(n,v,element)
            case "bool":
                SetNPBool(n,v,element)
            case "float":
                SetNPFloat(n,v,element)
            case "Vector":
                SetNPVector(n,v,element)
            default:
                SetNPEntity(n,v,element)
        }
    }

    function GetNPEntity(n,element = 0){
        if (!IsValidW()) return
        
        local e = NetProps.GetPropEntityArray(__ent,n.tostring(),element.tointeger())

        if (IsValid(e)){
            return KLib.EntityClass(e)
        }
    }

    function SetNPEntity(n,v,element = 0){
        if (!IsValidW()) return

        if (typeof v == "KLib_Entity")
            v = v.toent()

        NetProps.SetPropEntityArray(__ent,n.tostring(),v,element.tointeger())
    }

    function GetNPBool(n,element = 0){
        if (!IsValidW()) return

        return (NetProps.GetPropIntArray(__ent,n.tostring(),element.tointeger()) > 0) ? true : false
    }

    function SetNPBool(n,v,element = 0){
        if (!IsValidW()) return

        local num = v ? 1 : 0

        NetProps.SetPropIntArray(__ent,n.tostring(),num,element.tointeger())
    }

    function SetNPFloat(n,v,element = 0){
        if (!IsValidW()) return

        NetProps.SetPropIntArray(__ent,n.tostring(),v.tofloat(),element.tointeger())
    }

    function SetNPInt(n,v,element = 0){
        if (!IsValidW()) return

        NetProps.SetPropIntArray(__ent,n.tostring(),v.tointeger(),element.tointeger())
    }

    function SetNPString(n,v,element = 0){
        if (!IsValidW()) return

        NetProps.SetPropIntArray(__ent,n.tostring(),v.toString(),element.tointeger())
    }

    function SetNPVector(n,v,element = 0){
        if (!IsValidW()) return

        NetProps.SetPropIntArray(__ent,n.tostring(),v,element.tointeger())
    }

    function GetOwner(){
        return GetNPEntity("m_hOwner")
    }

    function GetOwnerEntity(){
        if (!IsValidW()) return

        local e = __ent.GetOwnerEntity()

        if (e){
            return KLib.EntityClass(e)
        }
    }

    function GetActiveWeapon(){
        if (!IsPlayerW()) return

        local e = __ent.GetActiveWeapon()

        if (e){
            return KLib.EntityClass(e)
        }
    }

    function GetModel(){
        return GetNPString("m_ModelName")
    }

    function SetModel(s){
        if (!IsValidW()) return

        PrecacheModel(s)
        __ent.SetModel(s)

        // local idx = -1

        // KLib.Util.PrecacheModel(s)

        // if (s in ::__KLibmodelidx){
        //     idx = ::__KLibmodelidx[s]
        // }
        // else {
        //     local e = KLib.EntityClass(null).Create("prop_dynamic_override",Vector(0,0,0),QAngle(0,0,0),{
        //         model = s
        //         renderfx = 15
        //         solid = 1
        //     })

        //     idx = e.GetNPInt("m_nModelIndex")
        //     ::__KLibmodelidx[s] <- idx
        //     e.Remove()
        // }

        // if (IsWeapon()){
        //     SetNPInt("m_iWorldModelIndex",idx)
        // }

        // SetNPInt("m_nModelIndex",idx)
        // SetNPString("m_ModelName",s)
    }

    function GetViewModel(i = 1){
        if (!IsPlayerW()) return

        local e = KLib.PLY.GetViewModel(__ent,i)

        if (e){
            return KLib.EntityClass(e)
        }
    }

    function GetWeapons(b = false){
        if (!IsPlayerW()) return

        local t = []

        foreach (v in GetInvTable()){
            v = KLib.EntityClass(v)

            if (v.IsValid()){
                if (b){
                    t.append(v.toent())
                }
                else {
                    t.append(v)
                }
            }
        }

        return t
    }

    function GetWeapon(s){
        if (!IsPlayerW()) return

        foreach (k,v in GetInvTable()){
            v = KLib.EntityClass(v)

            if (v.IsValid() && v.GetClass() == s){
                return v
            }
        }
    }

    function GiveAmmo(n){
        if (!IsPlayerW()) return

        __ent.GiveAmmo(n)
    }

    function GiveItem(n){
        if (!IsPlayerW()) return

        __ent.GiveItem(n)
    }

    function GiveUpgrade(n){
        if (!IsPlayerW()) return

        __ent.GiveUpgrade(n)
    }

    function EmitSound(n){
        if (!IsValidW()) return

        EmitSoundOn(n,__ent)
    }

    function EmitClientSound(n){
        if (!IsPlayerW()) return

        EmitSoundOnClient(n,__ent)
    }

    function StopSound(n){
        if (!IsValidW()) return

        StopSoundOn(n,__ent)
    }

    function AddThink(n,f = null){
        if (!IsValidW()) return

        local t = GetScriptScope()

        if (isfunction(n) && !isfunction(f)){
            local name = "__think_"+UniqueString()

            f = n
            n = name
        }

        if (!isfunction(f))
            return __error("Think function is not a function type")

        t[n] <- f

        AddThinkToEnt(__ent,n)
    }

    function IsPlayer(){
        if (!IsValidW()) return false

        return __ent.IsPlayer()
    }

    function IsPlayerABot(){
        if (!IsValidW()) return false

        return ::IsPlayerABot(__ent)
    }

    function IsWeapon(){
        if (!IsValidW()) return false

        return GetClass().find("weapon_") != null
    }

    function IsAlive(){
        if (!IsValidW()) return false
        if (GetClass() == "infected" || GetClass() == "witch" || GetClass() == "player"){
            return GetNPInt("m_lifeState") == 0
        }
        else {
            return GetHealth() > 0
        }
    }

    function IsServerHost(){
        if (!IsPlayerW()) return
        if (!Entities.FindByClassname(null,"t__error_player_manager")) return false

        return KLib.EntityClass("t__error_player_manager").GetNPBool("m_listenServerHost",__idx.tointeger())
    }

    function IsAdmin(){
        if (!IsPlayerW()) return
        if ("AdminSystem" in getroottable()){
            return AdminSystem.IsAdmin(tovslib("Player"))
        }

        if (Director.IsSinglePlayerGame() || IsServerHost()) return true

        return false
    }

    function Remove(n = 0){
        if (!IsValidW()) return
        if (IsPlayer()) return

        if (n > 0){
            Fire("Kill","",n)
        }
        else {
            __ent.Kill()
        }
    }

    function Kill(d = 0,a = null){
        if (!IsValidW()) return
        if (IsPlayer()){
            for (local i = 0;i < 2;i++){
                TakeDamage(GetHealth(),d,a)
            }

            return
        }

        Fire("Kill")
    }

    function GetClip(){
        if (!(__assert(IsWeapon(),"Entity is not a weapon"))) return

        return GetNPInt("m_iClip1")
    }

    function SetClip(n){
        if (!(__assert(IsWeapon(),"Entity is not a weapon"))) return

        SetNPInt("m_iClip1",n)
    }

    function GetNextPrimaryFire()
    {
        if (!(__assert(IsWeapon(),"Entity is not a weapon"))) return

        return GetNPFloat("m_flNextPrimaryAttack")
    }

    function SetNextPrimaryFire(time = Time())
    {
        if (!(__assert(IsWeapon(),"Entity is not a weapon"))) return

        SetNPFloat("m_flNextPrimaryAttack",time)
    }

    function GetNextSecondaryFire()
    {
        if (!(__assert(IsWeapon(),"Entity is not a weapon"))) return

        return GetNPFloat("m_flNextSecondaryAttack")
    }

    function SetNextSecondaryFire(time = Time())
    {
        if (!(__assert(IsWeapon(),"Entity is not a weapon"))) return

        SetNPFloat("m_flNextSecondaryAttack",time)
    }

    function GetAmmo(){
        local e,w,type

        if (IsPlayer()){
            e = KLib.EntityClass(__ent)
            w = e.GetActiveWeapon()
        }
        else if (IsWeapon()){
            e = GetOwner()
            w = KLib.EntityClass(__ent)
        }

        if (!(__assert(::IsValid(e),"Entity is neither a weapon nor a player"))) return
        if (!(::IsValid(w))){
            type = -1
        }
        else {
            type = w.GetNPInt("m_iPrimaryAmmoType")
        }

        return e.GetNPInt("m_iAmmo",type)
    }

    function SetAmmo(n){
        local e,w,type

        if (IsPlayer()){
            e = KLib.EntityClass(__ent)
            w = e.GetActiveWeapon()
        }
        else if (IsWeapon()){
            e = GetOwner()
            w = KLib.EntityClass(__ent)
        }

        if (!(__assert(::IsValid(e),"Entity is neither a weapon nor a player"))) return
        if (!(::IsValid(w))){
            type = -1
        }
        else {
            type = w.GetNPInt("m_iPrimaryAmmoType")
        }

        e.SetNPInt("m_iAmmo",n,type)
    }

    function AddAmmo(n){
        local e,w,type

        if (IsPlayer()){
            e = KLib.EntityClass(__ent)
            w = e.GetActiveWeapon()
        }
        else if (IsWeapon()){
            e = GetOwner()
            w = KLib.EntityClass(__ent)
        }

        if (!(__assert(::IsValid(e),"Entity is neither a weapon nor a player"))) return
        if (!(::IsValid(w))){
            type = -1
        }
        else {
            type = w.GetNPInt("m_iPrimaryAmmoType")
        }

        e.SetNPInt("m_iAmmo",e.GetNPInt("m_iAmmo",type)+n,type)
    }

    function GetUpgrades(){
        if (!(__assert(IsWeapon(),"Entity is not a weapon"))) return

        return GetNPInt("m_upgradeBitVec")
    }

    function SetUpgrades(n){
        if (!(__assert(IsWeapon(),"Entity is not a weapon"))) return

        if (n > 0 && n != 4) SetNPInt("m_nUpgradedPrimaryAmmoLoaded",GetNPInt("m_iClip1"))
        
        SetNPInt("m_upgradeBitVec",n.tointeger())
    }

    function HasUpgrade(n){
        if (!(__assert(IsWeapon(),"Entity is not a weapon"))) return

        local up = GetNPInt("m_upgradeBitVec")

        return up == (up | n)
    }

    function AddUpgrade(n){
        if (!(__assert(IsWeapon(),"Entity is not a weapon"))) return

        local up = GetUpgrades()

        SetUpgrades((up | n))
    }

    function RemoveUpgrade(n){
        if (!(__assert(IsPlayer() || IsWeapon(),"Entity is neither a weapon nor a player"))) return
        if (IsPlayer()){
            return __ent.RemoveUpgrade(n)
        }

        local up = GetUpgrades()

        SetUpgrades((up & ~n))
    }

    function OverrideFriction(d,f){
        if (!IsValidW()) return

        __ent.OverrideFriction(d,f)
    }

    function SetContext(n,v,d){
        if (!IsValidW()) return

        __ent.SetContext(n,v,d)
    }

    function SetContextNum(n,v,d){
        if (!IsValidW()) return

        __ent.SetContextNum(n,v,d)
    }

    function TakeDamage(d,i = 0,a = true){
        if (a == true){
            a = null
        }

        if ("GetEnt" in a){
            a = a.GetEnt()
        }

        __ent.TakeDamage(d,i,a)
    }

    function Create(name,pos = Vector(),ang = QAngle(),tbl = {}){
        if (!(__assert(!IsValid(),"Entity already exists"))) return

        tbl.classname <- name
        tbl.origin <- pos
        tbl.angles <- ang

        local e = g_ModeScript.CreateSingleSimpleEntityFromTable(tbl)

        if (!(__assert(e,"Non-existent entity ("+name+")"))) return

        __ent = e
        __idx = GetBaseIndex()

        return this
    }

    function GetMaxHealth(){
        if (!IsValidW()) return

        return GetNPInt("m_iMaxHealth")
    }

    function SetMaxHealth(v){
        if (!IsValidW()) return

        SetKeyValue("max_health",v.tointeger())
    }

    function GetName(){
        if (!IsValidW()) return

        if (IsPlayer()){
            return GetPlayerName()
        }

        return __ent.GetName()
    }

    function Fire(i,v = "",d = 0,a = null){
        if (!IsValidW()) return

        if (a != null){
            if (typeof a == "KLib_Entity"){
                a = a.toent()
            }

            DoEntFire("!self",i.tostring(),v.tostring(),d.tofloat(),a,__ent)
        }
        else {
            DoEntFire("!self",i.tostring(),v.tostring(),d.tofloat(),null,__ent)
        }
    }

    function HasFlags(n){
        if (!IsValidW()) return

        local flags = GetNPInt("m_fFlags")

        return flags == (flags | n)
    }

    function AddFlags(n){
        if (!IsValidW()) return
        if (HasFlags(n)) return

        local flags = GetNPInt("m_fFlags")

        SetNPInt("m_fFlags",(flags | n))
    }

    function RemoveFlags(n){
        if (!IsValidW()) return
        if (!HasFlags(n)) return

        local flags = GetNPInt("m_fFlags")

        SetNPInt("m_fFlags",(flags & ~n))
    }

    function HasEFlags(n){
        if (!IsValidW()) return

        local flags = GetNPInt("m_iEFlags")

        return flags == (flags | n)
    }

    function AddEFlags(n){
        if (!IsValidW()) return
        if (HasEFlags(n)) return

        local flags = GetNPInt("m_iEFlags")

        SetNPInt("m_iEFlags",(flags | n))
    }

    function RemoveEFlags(n){
        if (!IsValidW()) return
        if (!HasEFlags(n)) return

        local flags = GetNPInt("m_iEFlags")

        SetNPInt("m_iEFlags",(flags & ~n))
    }

    function GetSpawnFlags(){
        if (!IsValidW()) return

        return GetNPInt("m_spawnflags")
    }

    function SetSpawnFlags(f){
        if (!IsValidW()) return

        SetKeyValue("spawnflags",f.tostring())
    }

    function HasSpawnFlags(n){
        if (!IsValidW()) return

        local flags = GetNPInt("m_spawnflags")

        return flags == (flags | n)
    }

    function AddSpawnFlags(n){
        if (!IsValidW()) return
        if (IsSpawnFlagsSet(n)) return

        local flags = GetNPInt("m_spawnflags")

        SetNPInt("m_spawnflags",(flags | n))
    }

    function RemoveEFlags(n){
        if (!IsValidW()) return
        if (!IsSpawnFlagsSet(n)) return

        local flags = GetNPInt("m_spawnflags")

        SetNPInt("m_spawnflags",(flags & ~n))
    }

    function GetMoveType(){
        if (!IsValidW()) return

        return GetNPInt("movetype")
    }

    function SetMoveType(n){
        if (!IsValidW()) return

        SetNPInt("movetype",n.tointeger())
    }

    function GetModelScale(){
        if (!IsValidW()) return

        return GetNPInt("m_flModelScale")
    }

    function SetModelScale(n){
        if (!IsValidW()) return

        SetNPInt("m_flModelScale",n.tofloat())
    }

    function SetKeyValue(k,v){
        if (!IsValidW()) return

        k = k.tostring()

        if (isstring(v))
            return __ent.__KeyValueFromString(k,v.tostring())
        else if (isnum(v))
            return __ent.__KeyValueFromInt(k,v)
        else if (isbool(v))
            return __ent.__KeyValueFromInt(k,v.tointeger())
        else
            return __ent.__KeyValueFromVector(k,v)
    }

    function SetAbsVelocity(v){
        if (!IsValidW()) return

        __ent.ApplyAbsVelocityImpulse(v)
    }

    function SetLocalVelocity(v){
        if (!IsValidW()) return

        __ent.ApplyLocalAngularVelocityImpulse(v)
    }

    function SetLaggedMovementValue(v){
        SetNPFloat("m_flLaggedMovementValue",v)
    }

    function GetLaggedMovementValue(){
        return GetNPFloat("m_flLaggedMovementValue")
    }

    function GetInvTable(){
        if (!IsPlayerW()) return

        local t = {}

        ::GetInvTable(__ent,t)

        return t
    }

    function GetSlotWep(n){
        if (!IsPlayerW()) return

        local t = GetInvTable()

        if ("slot"+(n-1) in t){
            return KLib.EntityClass(t["slot"+(n-1)])
        }
    }

    function GetWaterLevel(){
        return GetNPInt("m_nWaterLevel")
    }

    function IsOnGround(){
        return HasFlags(FL_ONGROUND)
    }

    function IsSurvivor(){
        if (!IsPlayer()) return false

        return __ent.IsSurvivor()
    }

    function IsButtonDown(n){
        if (!IsValidW()) return

        local b = GetButtonMask()

        return b == (b | n)
    }

    function IsControlDown(){
        return IsButtonDown(IN_DUCK)
    }

    function IsDuck(){
        return HasFlags(FL_DUCKING)
    }

    function IsDisableButton(n){
        if (!IsValidW()) return

        local b = GetNPInt("m_afButtonDisabled")

        return b == (b | n)
    }

    function DisableButton(n){
        if (!IsValidW()) return
        if (IsDisableButton(n)) return

        local b = GetNPInt("m_afButtonDisabled")

        SetNPInt("m_afButtonDisabled",(b | n))
    }

    function UnDisableButton(n){
        if (!IsValidW()) return
        if (!IsDisableButton(n)) return

        local b = GetNPInt("m_afButtonDisabled")

        SetNPInt("m_afButtonDisabled",(b & ~n))
    }

    function UnDisableButtons(){
        if (!IsValidW()) return

        SetNPInt("m_afButtonDisabled",0)
    }

    function Say(s,b = false){
        if (!IsPlayerW()) return

        ::Say(__ent,s,b)
    }

    constructor(i = null){
        if (i == null){
            __idx = -1
        }
        else if ("__ent" in i && "__idx" in i){
            __ent = i.__ent
            __idx = i.__idx
        }
        else if (isnum(i)){
            __ent = GetPlayerFromUserID(i)

            if (!__ent){
                __ent = Ent(i)
                __idx = i
            }
            else {
                __idx = GetBaseIndex()
            }
        }
        else if (isinstance(i)){
            __ent = i
            __idx = GetBaseIndex()
        }
        else if (isstring(i) && i.find("!") != 0){
            __ent = Entities.FindByName(null,i)

            if (!__ent){
                __ent = Entities.FindByClassname(null,i)
            }

            if (!__ent){
                __error("Invalid target or name ("+i+")")

                __idx = -1
            }
            else {
                __idx = GetBaseIndex()
            }
        }
        else {
            __ent = Ent(i)
            __idx = GetBaseIndex()
        }
    }

    function _typeof() return "KLib_Entity"

    function tovslib(s = ""){
        if (!IsValidW()) return
        if (!__assert("VSLib" in getroottable(),"VSLib does not exist")) return
        if (!__assert("Entity" in VSLib,"VSLib entity does not exist")) return

        if (s != "" && s in VSLib){
            return VSLib[s](__ent)
        }

        return VSLib.Entity(__ent)
    }
}

local function add(s){
    KLib.EntityClass[s] <- function(){
        if (!IsValidW()) return

        return __ent[s]()
    }
}

add("GetAngles")
add("GetBaseVelocity")
add("GetEntityHandle")
add("GetForwardVector")
add("GetHealth")
add("GetLocalAngularVelocity")
add("GetLocalVelocity")
add("GetOrigin")
add("GetPreTemplateName")
add("GetRootMoveParent")
add("GetScriptId")
add("GetVelocity")

local function add(s){
    KLib.EntityClass[s] <- function(o){
        if (!IsValidW()) return

        return __ent[s](o)
    }
}

add("PrecacheModel")
add("PrecacheScriptSound")
add("SetAngles")
add("SetForwardVector")
add("SetFriction")
add("SetGravity")
add("SetHealth")
add("SetOrigin")
add("SetVelocity")

local function add(s){
    KLib.EntityClass[s] <- function(){
        if (!IsPlayerW()) return

        return __ent[s]()
    }
}

add("Extinguish")
add("EyeAngles")
add("EyePosition")
add("GetButtonMask")
add("GetHealthBuffer")
add("GetNetworkIDString")
add("GetPlayerName")
add("GetPlayerUserId")
add("GetSenseFlags")
add("GetSurvivorSlot")
add("GetZombieType")
add("IsDead")
add("IsDying")
add("IsIncapacitated")
add("IsHangingFromLedge")
add("IsGhost")
add("IsOnFire")
add("ReviveByDefib")
add("ReviveFromIncap")

local function add(s){
    KLib.EntityClass[s] <- function(o){
        if (!IsPlayerW()) return

        return __ent[s](o)
    }
}

add("SetFriction")
add("SetHealthBuffer")
add("SetReviveCount")
add("SetSenseFlags")
add("Stagger")
add("TryGetPathableLocationWithin")
add("UseAdrenaline")

local function add(s){
    KLib.EntityClass["GetNP"+s] <- function(n,element = 0){
        if (!IsValidW()) return

        return NetProps["GetProp"+s+"Array"](__ent,n.tostring(),element.tointeger())
    }

    // KLib.EntityClass["SetNP"+s] <- function(n,v,element = 0){
    //     if (!IsValidW()) return

    //     switch (s){
    //         case "Float":
    //             v = v.tofloat()
    //         case "int":
    //             v = v.tointeger()
    //         case "String":
    //             v = v.tostring()
    //     }

    //     NetProps["SetProp"+s+"Array"](__ent,n.tostring(),v,element.tointeger())
    // }
}

add("Float")
add("Int")
add("String")
add("Vector")

KLib.EntityClass.GetNPEnt <- KLib.EntityClass.GetNPEntity
KLib.EntityClass.SetNPEnt <- KLib.EntityClass.SetNPEntity
KLib.EntityClass.toent <- KLib.EntityClass.GetEnt
KLib.EntityClass.IsBot <- KLib.EntityClass.IsPlayerABot
KLib.EntityClass.EyePos <- KLib.EntityClass.EyePosition
KLib.EntityClass.SteamID <- KLib.EntityClass.GetNetworkIDString
KLib.EntityClass.GetPos <- KLib.EntityClass.GetOrigin
KLib.EntityClass.SetPos <- KLib.EntityClass.SetOrigin
KLib.EntityClass.GetForward <- KLib.EntityClass.GetForwardVector
KLib.EntityClass.SetVar <- KLib.EntityClass.SetScriptVar
KLib.EntityClass.GetVar <- KLib.EntityClass.GetScriptVar
KLib.EntityClass.DelVar <- KLib.EntityClass.DelScriptVar
KLib.EntityClass.RemoveVar <- KLib.EntityClass.DelScriptVar
KLib.EntityClass.RemVar <- KLib.EntityClass.DelScriptVar
KLib.EntityClass.Give <- KLib.EntityClass.GiveItem
KLib.EntityClass.GetUserId <- KLib.EntityClass.GetPlayerUserId
KLib.EntityClass.Input <- KLib.EntityClass.Fire

::KEntity <- KLib.EntityClass.weakref()
::ent <- KLib.EntityClass.weakref()