local model = {
    coach = "models/survivors/survivor_coach.mdl"
    ellis = "models/survivors/survivor_mechanic.mdl"
    nick = "models/survivors/survivor_gambler.mdl"
    rochelle = "models/survivors/survivor_producer.mdl"
    louis = "models/survivors/survivor_manager.mdl"
    francis = "models/survivors/survivor_biker.mdl"
    zoey = "models/survivors/survivor_teenangst.mdl"
    bill = "models/survivors/survivor_namvet.mdl"
}

local namet = {
    c = "coach"
    e = "ellis"
    n = "nick"
    r = "rochelle"
    l = "louis"
    f = "francis"
    z = "zoey"
    b = "bill"
}

function GetAll(b = false)
{
    local t = []

    foreach (v in KLib.Entity.FindByClassname("player")){
        if (b){
            t.append(v.toent())
        }
        else {
            t.append(v)
        }
    }

    return t
}

function Get(n)
{
    if (n in namet){
        n = namet[n]
    }

    return ent("!"+n)
}

function GetViewModel(p,i = 0)
{
    local t = []

    foreach (v in KLib.Entity.FindByClassname("predicted_viewmodel")){
        if (v.GetRootMoveParent() == p){
            t.append(v)
        }
    }

    if (i in t){
        return t[i]
    }
}

function GetActiveWeapon(p)
{
    if (!("userid" in p)) return

    local e = ent(p.userid)

    if (!IsValid(e)) return

    return e.GetActiveWeapon()
}

::player <- this