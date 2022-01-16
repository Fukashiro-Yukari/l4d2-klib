function GetAll(b = false){
    local t = []
    local e

    for (;;){
        if (!IsValid(e)){
            e = Entities.First()
        }
        else {
            e = Entities.Next(e)
        }

        if (e == null){
            break
        }

        if (b){
            t.append(e)
        }
        else {
            t.append(ent(e))
        }
    }

    return t
}

local function func(ns){
    this[ns] <- function(s,b = false){
        local t = []
        local e

        while (e = Entities[ns](e,s)){
            if (b){
                t.append(e)
            }
            else {
                t.append(ent(e))
            }
        }

        return t
    }
}

func("FindByClassname")
func("FindByModel")
func("FindByName")
func("FindByTarget")

function FindByNameWithin(n,v,r,b = false){
    local t = []
    local e

    while (e = Entities.FindByNameWithin(e,v,r)){
        if (b){
            t.append(e)
        }
        else {
            t.append(ent(e))
        }
    }

    return t
}

function FindByClassnameWithin(n,v,r,b = false){
    local t = []
    local e

    while (e = Entities.FindByClassnameWithin(e,v,r)){
        if (b){
            t.append(e)
        }
        else {
            t.append(ent(e))
        }
    }

    return t
}

function FindInSphere(v,r,b = false){
    local t = []
    local e

    while (e = Entities.FindInSphere(e,v,r)){
        if (b){
            t.append(e)
        }
        else {
            t.append(ent(e))
        }
    }

    return t
}

function TakeDamage(e,n,a,t = 0){
    e.TakeDamage(n,t,a)
}

function Create(s,n = "",p = Vector(),a = QAngle(),k = {}){
    local e = ent(null).Create(s,n,p,a,k)

    if (!e) return

    return e
}

FindByClass <- FindByClassname
FindByClassWithin <- FindByClassnameWithin

function GetWorld()
{
    return ent(Entities.FindByClassname(null,"worldspawn"))
}

::ents <- this