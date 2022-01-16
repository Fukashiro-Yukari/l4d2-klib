function Color(r = 255,g = 255,b = 255,a = 255)
{
    return r+" "+g+" "+b+" "+a
}

::Color <- this.Color

function Say(t,t2 = "",e = null,te = false)
{
    t = t.tostring()
    t2 = t2.tostring()

    local text = t

    if (t2 != ""){
        text = "["+t2+"] "+t
    }

    ::Say(e,text,te)
}

function ConVarChangedMsg(n,nv)
{
    KLib.Util.Say("Server cvar \""+n+"\" changed to "+nv,"ConVar")
}

function PrecacheCSSWeapons()
{
    // Do nothing
}

local survivors = [
    "models/survivors/survivor_coach.mdl"
    "models/survivors/survivor_gambler.mdl"
    "models/survivors/survivor_mechanic.mdl"
    "models/survivors/survivor_producer.mdl"
    "models/survivors/survivor_biker.mdl"
    "models/survivors/survivor_manager.mdl"
    "models/survivors/survivor_namvet.mdl"
    "models/survivors/survivor_teenangst.mdl"
    "models/survivors/survivor_biker_light.mdl"
    "models/survivors/survivor_teenangst_light.mdl"
]

function PrecacheSurvivors()
{
    foreach (v in survivors){
        PrecacheModel(v)
    }
}

function ShowHint(t,i = "icon_info",c = Color(255,255,255),time = 2,a = null,name = "")
{
    if (name == ""){
        name = t+"_hint"
    }

    local e = ent(null).Create("env_instructor_hint",Vector(),QAngle(),{
        hint_name = name
        hint_caption = t
        hint_auto_start = 0
        hint_target = ""
        hint_timeout = time
        hint_static = 1
        hint_forcecaption = 1
        hint_icon_onscreen = i
        hint_instance_type = 2
        hint_color = c
    })

    if (a != null){
        if (typeof a == "KLib_Entity"){
            a = a.toent()
        }

        e.Fire("ShowHint","!activator",0.01,a)
    }
    else {
        e.Fire("ShowHint","!player",0.01)
    }
    
    e.Remove(time+1)
}

function ShowBar(barname,n,max,i = "icon_info",c = Color(255,255,255),time = 2,a = null,tname = "",b = false)
{
    if (tname == ""){
        tname = barname
    }

    local bar = barname+" ["
    local val = math.center(n/max*80,0,80)
    local val2 = math.center((1-n/max)*80,0,80)

    for (local i = 0;i < val;i++){
        bar += "|"
    }

    for (local i = 0;i < val2;i++){
        bar += "."
    }

    bar += "]"

    if (b){
        bar += " ("+n+"|"+max+")"
    }

    KLib.Util.ShowHint(bar,i,c,time,a,tname)
}

function SpawnZombie(zombieType, pos = null, ang = QAngle(0,0,0), offerTank = false, victim = null)
{
    if ( zombieType == 7 || zombieType == "witch" )
        PrecacheModel( "models/infected/witch.mdl" )
    else if ( zombieType == 11 || zombieType == "witch_bride" )
		PrecacheModel( "models/infected/witch_bride.mdl" )

    if (isint(zombieType)){
		if ( zombieType == 10 && pos == null )
			pos = Vector(0,0,0)
		
		return ZSpawn( { type = zombieType, pos = pos, ang = ang } )
	}
	else
	{
		local e = ent().Create("info_zombie_spawn", pos, ang)
		e.SetKeyValue("population", zombieType)
		e.SetKeyValue("offer_tank", offerTank.tointeger())
		e.Input("SpawnZombie")
		if ( victim != null )
			e.Input("StartleZombie", victim, 0.1)
		
		e.Input("Kill", "", 0.2)
	}
}