if ("KLib" in getroottable()){
    printa("klib is already loaded")

    return
}

::KLib_Version <- 1.0
::istype <- function(o,...){
    for (local i = 0;i < vargv.len();i++){
        if (type(o) == vargv[i]) return true
        if ((typeof o) == vargv[i]) return true
    }

    return false
}

local function add(s){
    getroottable()["is"+s] <- function(o) return type(o) == s
}

add("string")
add("table")
add("array")
add("bool")
add("class")
add("float")
add("instance")
add("function")

::isint <- function(o) return type(o) == "integer"
::isnum <- function(o) return istype(o,"integer","float")
::isvector <- function(o) return (typeof o) == "Vector"

::tobool <- function(o){
    if (o){
        return true
    }
    else {
        return false
    }
}

::printtable <- function(t,s = "",b = false){
    if (!b){
        if (istype(t,"table","class")){
            print(s+"{\n")

            s += "    "
        }
        else if (isarray(t)){
            print(s+"[\n")

            s += "    "
        }
    }

    foreach(k,v in t){
        if (istype(v,"table","class")){
            print(s+"["+k+"] = {\n")
            printtable(v,s+"    ",true)
            print(s+"}\n")
        }
        else if (isarray(v)){
            print(s+"["+k+"] = [\n")
            printtable(v,s+"    ",true)
            print(s+"]\n")
        }
        else {
            print(s+"["+k+"] = "+v+"\n")
        }
    }

    if (!b){
        if (istype(t,"table","class")){
            print("}\n")
        }
        else if (isarray(t)){
            print("]\n")
        }
    }
}

::printarray <- printtable

::printa <- function(...){
    local o = ""
    local s = ""

    for (local i = 0;i < vargv.len();i++){
        if (i > 0){
            s = "\t"
        }

        if (istype(vargv[i],"table","array","class")){
            printtable(vargv[i])
        }
        else {
            o += s+vargv[i]
        }
    }

    print(o+"\n")
}

local function isvalid(o){
    if (!("IsValid" in o)) return false

    return o.IsValid()
}

::IsValid <- function(...){
    if (vargv.len() < 1) return false

    local o = vargv[0]

    if (vargv.len() > 1){
        o = vargv

        for (local i = 0;i < vargv.len();i++){
            if (!(isvalid(vargv[i]))){
                return false
            }
        }

        return true
    }
    else {
        return isvalid(o)
    }
}

local function add(s){
    if (!(s in getroottable())){
        getroottable()[s] <- {}
    }

    local t = {}

    IncludeScript("klib/"+s.tolower(),t)

    foreach (k,v in t){
        getroottable()[s][k] <- v
    }
}

add("math")
add("string")
add("table")
add("arrayX")

::KLib <- {
    function Error(s){
        ::error("[KLib Error] "+s+"\n")
    }

    function Info(s){
        printa("[KLib] " + s)
    }

    function Assert(b,s = "assertion failed",bo = false){
        if (b) return true

        if (bo){
            throw s
        }
        else {
            this.Error(s)
        }

        return false
    }
}

local function add(s){
    KLib[s] <- {}

    IncludeScript("klib/"+s.tolower(),KLib[s])
}

add("Player")
add("Entity")
add("Util")
add("Timer")

local function add(s){
    IncludeScript("klib/"+s.tolower())
}

add("enums")
add("entitiyclass")
// add("colorclass")
// add("menu")

printa(string.format("Loaded KLib version %f", KLib_Version))