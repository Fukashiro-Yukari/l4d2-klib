local function add(s){
    if (!(s in getroottable())) return

    this[s] <- getroottable()[s]
}

add("split")
add("strip")
add("rstrip")
add("lstrip")
add("format")

function lower(s) return s.tolower()
function upper(s) return s.toupper()
function find(s,f) return s.find(f)

function replace(s,o,rep){
    o = regexp(o)

    local r = ""
    local pos = 0
    local caps = o.capture(s)

	while (caps != null){
        foreach (i,cap in caps)
		{
			r += s.slice(pos,cap.begin)
			r += rep
			pos = cap.end
		}

        caps = o.capture(s,pos)
    }

    r += s.slice(pos)

    return r
}

function startwich(s,s2){
    for (local i = 0;i < s2.len();i++){
        if (!(i in s) || s[i] != s2[i]){
            return false
        }
    }

    return true
}