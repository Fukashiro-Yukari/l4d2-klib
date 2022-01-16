function totable(a){
    local r = {}

    foreach (k,v in a){
        r[k] <- v
    }

    return r
}

function new(a,id = 0,id2 = -1){
    local r = []
    local add = false

    if (id2 == -1){
        id2 = a.len()
    }
    else {
        id2++
    }

    foreach (k,v in a){
        if (k == id){
            add = true
        }

        if (k == id2){
            add = false
        }

        if (add){
            r.append(v)
        }
    }

    return r
}

function tostring(a,s2 = ""){
    local s = ""

    foreach (v in a){
        s += v+s2
    }

    return s
}