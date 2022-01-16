//Timer library

__simpletimet <- {}
__timet <- {}
__stoptimet <- {}

function Simple(n,f,t = null)
{
    if (!isnum(n)) return
    if (!(Time()+n in __simpletimet)){
        __simpletimet[Time()+n] <- {
            __n = 0
        }
    }

    __simpletimet[Time()+n].__n += 1

    local tn = __simpletimet[Time()+n].__n

    __simpletimet[Time()+n][tn] <- {
        f = f
        t = t
    }
}

function Create(n,d,r,f,t = null)
{
    if (!isnum(d) || !isnum(r)) return
    if (Exists(n)) return

    __timet[n] <- {
        time = Time()+d
        delay = d
        rc = r
        r = r
        func = f
        isrun = false
        t = t
    }
}

function Start(n)
{
    if (n in __stoptimet){
        local t = __stoptimet[n]

        __timet[n] <- {
            time = Time()+t.delay
            delay = t.delay
            rc = t.r
            r = t.r
            func = t.func
            isrun = false
            t = t.t
        }

        table.remove(__stoptimet,n)

        return true
    }

    return false
}

function Stop(n)
{
    if (n in __timet){
        local t = __timet[n]

        __stoptimet[n] <- {
            time = t.time
            delay = t.delay
            rc = t.rc
            r = t.r
            func = t.func
            isrun = false
            t = t.t
        }

        table.remove(__timet,n)

        return true
    }

    return false
}

function Exists(n)
{
    if (n in __timet){
        return true
    }

    if (n in __stoptimet){
        return true
    }

    return false
}

function Adjust(n,d,r,f)
{
    if (!isnum(d) || !isnum(r)) return
    if (!Exists(n)) return false

    if (n in __stoptimet){
        table.remove(__stoptimet,n)
    }

    __timet[n] = {
        time = Time()+d
        delay = d
        rc = r
        r = r
        func = f
        isrun = false
        t = t
    }

    return true
}

function Remove(n)
{
    if (n in __timet){
        table.remove(__timet,n)
    }

    if (n in __stoptimet){
        table.remove(__stoptimet,n)
    }
}

function TimeLeft(n)
{
    if (n in __timet){
        return (__timet.time-Time())
    }

    if (n in __stoptimet){
        return (__stoptimet.time-Time())
    }
}

function RepsLeft(n)
{
    if (n in __timet){
        return __timet.rc
    }

    if (n in __stoptimet){
        return __stoptimet.rc
    }
}

function Pause(n)
{
    if (n in __timet){
        local t = __timet[n]

        __stoptimet[n] <- {
            time = t.time
            delay = t.delay
            rc = t.rc
            r = t.r
            func = t.func
            isrun = false
            t = t.t
        }

        table.remove(__timet,n)

        return true
    }

    return false
}

function UnPause(n)
{
    if (n in __stoptimet){
        local t = __stoptimet[n]

        __stoptimet[n] <- {
            time = Time()+t.delay
            delay = t.delay
            rc = t.rc
            r = t.r
            func = t.func
            isrun = false
            t = t.t
        }

        table.remove(__stoptimet,n)

        return true
    }

    return false
}

function Toggle(n)
{
    if (n in __stoptimet){
        UnPause(n)

        return true
    }
    else if (n in __timet){
        Pause(n)

        return false
    }

    return false
}

function Think()
{
    foreach (k,v in __simpletimet){
        if (k <= Time()){
            local n = v.__n

            for (local i = 1;i <= n;i++){
                if (!(i in __simpletimet[k])) break
                
                local t = __simpletimet[k][i].t

                if (t){
                    table.remove(__simpletimet[k],i).f(t)
                }
                else {
                    table.remove(__simpletimet[k],i).f()
                }
            }

            table.remove(__simpletimet,k)
        }
    }

    foreach (k,v in __timet){
        if (v.time <= Time() && !v.isrun){
            if (v.t != null){
                v.func(v.t)
            }
            else {
                v.func()
            }
            
            v.isrun = true

            if (v.rc > 0){
                v.rc -= 1

                if (v.rc < 1){
                    __stoptimet[k] <- {
                        time = v.time
                        delay = v.delay
                        rc = v.rc
                        r = v.r
                        func = v.func
                        isrun = v.isrun
                        t = v.t
                    }

                    table.remove(__timet,k)
                }
                else {
                    v.time = Time()+v.delay
                    v.isrun = false
                }
            }
            else {
                v.time = Time()+v.delay
                v.isrun = false
            }
        }
    }
}

if (!("__thinkTimer" in this)){
    __thinkTimer <- SpawnEntityFromTable("logic_script",{targetname = "klib_timer"})

    if (__thinkTimer != null)
    {
        __thinkTimer.ValidateScriptScope()
        local t = __thinkTimer.GetScriptScope()
        t["ThinkTimer"] <- function(){
            KLib.Timer.Think()
        }
        AddThinkToEnt(__thinkTimer,"ThinkTimer")
    }
    else
        throw "[KLib Error] Timer system could not be created; Could not create dummy entity"
}

::timer <- this