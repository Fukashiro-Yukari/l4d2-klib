local function add(s){
    if (!(s in getroottable())) return

    this[s] <- getroottable()[s]
}

add("abs")
add("acos")
add("asin")
add("atan")
add("atan2")
add("ceil")
add("cos")
add("exp")
add("fabs")
add("floor")
add("log")
add("log10")
add("pow")
add("rand")
add("sin")
add("sqrt")
add("tan")

function min(x,y){
    return x<y?x:y
}

function max(x,y){
    return x>y?x:y
}

function center(c,a,b){
    return c<a?a:(c>b?b:c)
}