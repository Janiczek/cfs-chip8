$ ->

    $("#keyboard input").mousedown ->
        key = parseInt ($(this).attr "value"),16
        if wait then KeyPressed key
        keys[key] = 1
        if debug then UpdateDebug()
        
    $("#keyboard input").mouseup ->
        key = parseInt ($(this).attr "value"),16
        keys[key] = 0
        if debug then UpdateDebug()
    
    $("#kstart").click ->
        Start()

    $("#kstop").click ->
        clearInterval t

    $("#kstep").click ->
        clearInterval t
        Run(1)

    $("#kreset").click ->
        clearInterval t
        CPUReset()