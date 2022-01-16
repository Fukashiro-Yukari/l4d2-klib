function toarray(t)
{
    local r = []

    foreach (k,v in t){
        r.append(v)
    }

    return r
}

function copy(t)
{
    if (istable(t)){
        local r = {}

        foreach (k,v in t){
            r[k] <- v
        }

        return r
    }
    else if (isarray(t)){
        local r = []

        foreach (v in t){
            r.append(v)
        }

        return r
    }
}

function empty(o)
{
    foreach (k,v in o){
        delete o[k]
    }
}

function remove(o,id = -1)
{
    local i = 0
    local r

    if (id in o){
        r = o[id]

        delete o[id]

        return r
    }

    foreach (k,v in o){
        if (id == -1 && i >= o.len()-1){
            r = o[k]

            delete o[k]

            break
        }
        else if (k == id){
            r = o[k]
            
            delete o[k]

            break
        }

        i++
    }

    return r
}

function merge(t,s)
{
    foreach (k,v in s){
        if (istable(v)){
            if (!(k in t)){
                t[k] <- {}
            }

            merge(t[k],v)
        }
        else {
            t[k] <- v
        }
    }
}