@UpdateDebug = ->   

    str_regs = "\n      REGISTERS\n" +
               " -------------------\n" +
               " r0: #{toHex r[0], 2}   r8: #{toHex r[8], 2}\n" +
               " r1: #{toHex r[1], 2}   r9: #{toHex r[9], 2}\n" +
               " r2: #{toHex r[2], 2}   rA: #{toHex r[10], 2}\n" +
               " r3: #{toHex r[3], 2}   rB: #{toHex r[11], 2}\n" +
               " r4: #{toHex r[4], 2}   rC: #{toHex r[12], 2}\n" +
               " r5: #{toHex r[5], 2}   rD: #{toHex r[13], 2}\n" +
               " r6: #{toHex r[6], 2}   rE: #{toHex r[14], 2}\n" +
               " r7: #{toHex r[7], 2}   rF: #{toHex r[15], 2}\n"
    
    str_ctrls = "\n  CONTROLS\n" +
                " ----------\n" +
                " PC:  #{toHex pc, 3}\n" +
                " I:   #{toHex i,  3}\n" + 
                " DT:   #{toHex dt, 2}\n" +
                " ST:   #{toHex st, 2}\n" + 
                " WAIT:  #{toHex wait, 1}\n" +
                " WR:   #{toHex waitr, 2}\n"
    
    str_keys = "\n        KEYS\n" +
               " -------------------\n" +
               " k0: #{toHex keys[0], 2}   k8: #{toHex keys[8], 2}\n" +
               " k1: #{toHex keys[1], 2}   k9: #{toHex keys[9], 2}\n" +
               " k2: #{toHex keys[2], 2}   kA: #{toHex keys[10], 2}\n" +
               " k3: #{toHex keys[3], 2}   kB: #{toHex keys[11], 2}\n" +
               " k4: #{toHex keys[4], 2}   kC: #{toHex keys[12], 2}\n" +
               " k5: #{toHex keys[5], 2}   kD: #{toHex keys[13], 2}\n" +
               " k6: #{toHex keys[6], 2}   kE: #{toHex keys[14], 2}\n" +
               " k7: #{toHex keys[7], 2}   kF: #{toHex keys[15], 2}\n"
    
    str_stack = "\n  STACK\n" +
                " -------\n"
                
    for num in stck
        str_stack += "  #{toHex num, 3}\n"
    
    $("#d_regs").val  str_regs
    $("#d_ctrls").val str_ctrls
    $("#d_keys").val  str_keys
    $("#d_stack").val str_stack

toHex = (num, length) ->    
    
    str = parseInt(num).toString 16
    
    zeros = length - str.length
    if zeros > 0
        for tmp in [1..zeros]
            str = "0" + str
            
    str = str.toUpperCase()
    return "0x" + str
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        