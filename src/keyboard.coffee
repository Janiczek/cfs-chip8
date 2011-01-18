$ ->

    $("#keyboard input").mousedown ->
        key = parseInt ($(this).attr "value"),16
        if wait then KeyPressed key
        keys[key] = 1
        
    $("#keyboard input").mouseup ->
        key = parseInt ($(this).attr "value"),16
        keys[key] = 0

    $("#start").click ->
        Start()

    $("#stop").click ->
        clearInterval t

    $("#step").click ->
        clearInterval t
        Run(1)