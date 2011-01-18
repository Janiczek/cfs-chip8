@UpdateDebug = ->   
    
    d_PC    = $ "#d_PC"
    d_I     = $ "#d_I"
    d_DT    = $ "#d_DT"
    d_ST    = $ "#d_ST"
    d_WAIT  = $ "#d_WAIT"
    d_WAITR = $ "#d_WAITR"
    d_r0    = $ "#d_r0"
    d_r1    = $ "#d_r1"
    d_r2    = $ "#d_r2"
    d_r3    = $ "#d_r3"
    d_r4    = $ "#d_r4"
    d_r5    = $ "#d_r5"
    d_r6    = $ "#d_r6"
    d_r7    = $ "#d_r7"
    d_r8    = $ "#d_r8"
    d_r9    = $ "#d_r9"
    d_rA    = $ "#d_rA"
    d_rB    = $ "#d_rB"
    d_rC    = $ "#d_rC"
    d_rD    = $ "#d_rD"
    d_rE    = $ "#d_rE"
    d_rF    = $ "#d_rF"
    d_STCK  = $ "#d_STCK"
    
    d_PC.html    toHex @pc, 3
    d_I.html     toHex @i, 3
    d_DT.html    toHex @dt, 2
    d_ST.html    toHex @st, 2
    d_WAIT.html  toHex @wait, 1
    d_WAITR.html toHex @waitr, 2
    
    d_r0.html   toHex r[0], 2
    d_r1.html   toHex r[1], 2
    d_r2.html   toHex r[2], 2
    d_r3.html   toHex r[3], 2
    d_r4.html   toHex r[4], 2
    d_r5.html   toHex r[5], 2
    d_r6.html   toHex r[6], 2
    d_r7.html   toHex r[7], 2
    d_r8.html   toHex r[8], 2
    d_r9.html   toHex r[9], 2
    d_rA.html   toHex r[10], 2
    d_rB.html   toHex r[11], 2
    d_rC.html   toHex r[12], 2
    d_rD.html   toHex r[13], 2
    d_rE.html   toHex r[14], 2
    d_rF.html   toHex r[15], 2
    
    $("#d_STCK tbody tr").remove()
    
    for num in stck
        $("#d_STCK tbody").prepend "<tr><td>" + (toHex num, 4) + "</td></tr>"

@toHex = (num, length) ->    
    str = num.toString 16
    zeros = length - str.length
    if zeros > 0
        for tmp in [1..zeros]
            str = "0" + str
    str = str.toUpperCase()
    str = "0x" + str        
        
$ ->

    $("#debug").one 'click', ->
    
        SetDebug 1
        
        $("#debugwindow").css('display', 'block')
        
        UpdateDebug()    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        