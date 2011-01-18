@z   = 3 # zoom
@c   = document.getElementById 'scr'
@ctx = @c.getContext '2d'
    
@Draw = ->
    @c.width = @c.width
    for row in [0 .. 31]
        for col in [0 .. 63]
            if @scr[col][row] == 1
                @ctx.fillRect col*z, row*z, z, z