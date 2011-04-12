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
    
    $("#k_start").click ->
        Start()

    $("#k_step").click ->
        clearInterval t
        Run 1

    $("#k_reset").click ->
        clearInterval t
        CPUReset()
        
    $("#k_debug").click ->
        ToggleDebug()    
        $("#debugwindow").toggle()
        UpdateDebug()   