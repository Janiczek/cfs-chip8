Number::mod = (n) -> ((this % n) + n) % n
# This is for modulo with negative numbers
# (-1).mod 256 ----> 255

@m       = (0 for tmp in [0..0xFFF])
@r       = (0 for tmp in [0..15])
@i       = 0
@pc      = 0x200
@dt      = 0
@st      = 0
@stck    = []
@scr     = ((0 for tmp2 in [0..31]) for tmp in [0..63])
@keys    = (0 for tmp in [0..15])
@wait    = 0
@waitr   = 0x10
@t       = 0
@pc_of   = 0

@perinv  = 10

@debug   = 0

@loc     = (tmp for tmp in [0x1b0..0x1fb] by 5)
fonts = "F999F26227F1F8FF1F1F99F11F8F1FF8F9FF1244F9F9FF9F1FF9F99E9E9EF888FE999EF8F8FF8F88"
tmp = 0x1b0
for char in fonts
    num = parseInt char, 16
    num <<= 4
    @m[tmp] = num
    tmp += 1

@SetDebug = (val) ->
    @debug = val
    
@CPUReset = ->

    @r    = (0 for tmp in [0..15])
    @i    = 0
    @pc   = 0x200
    @dt   = 0
    @st   = 0
    @stck = []
    @wait = 0
    
    @scr  = ((0 for tmp2 in [0..31]) for tmp in [0..63])
    Draw()
    
    clearInterval @t
    @t = 0
    
    @pc_of = 0
    
    if @debug then UpdateDebug()
    
@KeyPressed = (key) ->

    @wait = 0
    @r[@waitr] = key
    @waitr = 0x10  
    if @debug then UpdateDebug()
    
@GetNextOpcode = ->

    res = @m[@pc] << 8
    res |= @m[@pc + 1]
    @pc += 2
    return res

@FetchDecodeLoop = ->

    op = GetNextOpcode()
    
    switch op & 0xF000
        when 0x0000
            switch op & 0x000F
                when 0x0000 then code00E0()
                when 0x000E then code00EE()
        when 0x1000 then code1NNN op
        when 0x2000 then code2NNN op
        when 0x3000 then code3XNN op
        when 0x4000 then code4XNN op
        when 0x5000 then code5XY0 op
        when 0x6000 then code6XNN op
        when 0x7000 then code7XNN op
        when 0x8000
            switch op & 0x000F
                when 0x0000 then code8XY0 op
                when 0x0001 then code8XY1 op
                when 0x0002 then code8XY2 op
                when 0x0003 then code8XY3 op
                when 0x0004 then code8XY4 op
                when 0x0005 then code8XY5 op
                when 0x0006 then code8XY6 op
                when 0x0007 then code8XY7 op
                when 0x000E then code8XYE op
        when 0x9000 then code9XY0 op
        when 0xA000 then codeANNN op
        when 0xB000 then codeBNNN op
        when 0xC000 then codeCXNN op
        when 0xD000 then codeDXYN op
        when 0xE000
            switch op & 0x000F
                when 0x000E then codeEX9E op
                when 0x0001 then codeEXA1 op
        when 0xF000
            switch op & 0x00FF
                when 0x0007 then codeFX07 op
                when 0x000A then codeFX0A op
                when 0x0015 then codeFX15 op
                when 0x0018 then codeFX18 op
                when 0x001E then codeFX1E op
                when 0x0029 then codeFX29 op
                when 0x0033 then codeFX33 op
                when 0x0055 then codeFX55 op
                when 0x0065 then codeFX65 op
    
    if @debug then UpdateDebug()

@Run = (step = 0) ->

    DoStep = ->
    
        if @pc_of then return 0
    
        if @dt > 0 then @dt -= 1
        if @st > 0 then @st -= 1
        
        if @pc <= 0xFFF
            FetchDecodeLoop()
        else
            clearInterval @t
            @CPUReset()
            @pc_of = 1
            return 0

    if @wait or @pc_of then return 0 
    
    if step
        DoStep()
    else
        for tmp in [perinv .. 0] by -1
            DoStep()
        
@Start = ->
    CPUReset()
    @t = setInterval Run, 1
                
code00E0 = ->
    # clear screen
    @scr = ((0 for tmp2 in [0..31]) for tmp in [0..63]) 

code00EE = ->
    # return from subroutine
    @pc = stck.pop()

code1NNN = (op) ->
    # jump to NNN
    addr = op & 0xFFF
    @pc = addr

code2NNN = (op) ->
    # call subroutine NNN
    @stck.push @pc
    addr = op & 0xFFF
    @pc = addr
    
code3XNN = (op) ->
    # skip next if rX == NN
    x = (op & 0x0F00) >> 8
    nn = op & 0x00FF
    if @r[x] == nn then @pc += 2
    
code4XNN = (op) ->
    # skip next if rX != NN
    x = (op & 0x0F00) >> 8
    nn = op & 0x00FF
    if @r[x] != nn then @pc += 2
                
code5XY0 = (op) ->
    # skip next if rX == rY
    x = (op & 0x0F00) >> 8
    y = (op & 0x00F0) >> 4
    if @r[x] == @r[y] then @pc += 2
    
code6XNN = (op) ->
    # rX = NN
    x = (op & 0x0F00) >> 8
    nn = op & 0x00FF
    @r[x] = nn
    
code7XNN = (op) ->
    # rX += NN
    x = (op & 0x0F00) >> 8
    nn = op & 0x00FF
    @r[x] += nn
    @r[x] &= 0xFF
                
code8XY0 = (op) ->
    # rX = rY
    x = (op & 0x0F00) >> 8
    y = (op & 0x00F0) >> 4
    @r[x] = @r[y]
                
code8XY1 = (op) ->
    # rX |= rY
    x = (op & 0x0F00) >> 8
    y = (op & 0x00F0) >> 4
    @r[x] |= @r[y]
                
code8XY2 = (op) ->
    # rX &= rY
    x = (op & 0x0F00) >> 8
    y = (op & 0x00F0) >> 4
    @r[x] &= @r[y]
                
code8XY3 = (op) ->
    # rX ^= rY
    x = (op & 0x0F00) >> 8
    y = (op & 0x00F0) >> 4
    @r[x] ^= @r[y]
                
code8XY4 = (op) ->
    # rX += rY, rF = carry
    x = (op & 0x0F00) >> 8
    y = (op & 0x00F0) >> 4
    @r[x] += @r[y]
    if @r[x] > 0xFF
        @r[15] = 1
        @r[x] &= 0xFF
                
code8XY5 = (op) ->
    # rX -= rY, rF = not borrow
    x = (op & 0x0F00) >> 8
    y = (op & 0x00F0) >> 4
    @r[x] -= @r[y]
    @r[15] = 1
    if @r[x] < 0
        @r[15] = 0
        @r[x] = @r[x].mod 0x100 # 256
                
code8XY6 = (op) ->
    # rF = rX & 1, rX >>= 1
    x = (op & 0x0F00) >> 8
    @r[15] = @r[x] & 1
    @r[x] >>= 1
    
                
code8XY7 = (op) ->
    # rX = rY - rX, rF = not borrow
    x = (op & 0x0F00) >> 8
    y = (op & 0x00F0) >> 4
    @r[x] = @r[y] - @r[x]
    @r[15] = 1
    if @r[x] < 0
        @r[15] = 0
        @r[x] = @r[x].mod 0x100 # 256
                
code8XYE = (op) ->
    # rF = rX & 0x80, rX <<= 1
    x = (op & 0x0F00) >> 8
    @r[15] = (@r[x] >> 7) & 1 # leftmost bit
    @r[x] <<= 1
    @r[x] &= 0xFF
                    
code9XY0 = (op) ->
    # skip next if rX != rY
    x = (op & 0x0F00) >> 8
    y = (op & 0x00F0) >> 4
    if @r[x] != @r[y] then @pc += 2
                    
codeANNN = (op) ->
    # i = NNN
    nnn = op & 0x0FFF
    @i = nnn
                    
codeBNNN = (op) ->
    # jump to NNN + r0
    nnn = op & 0x0FFF
    @pc = (nnn + @r[0]) & 0xFFF
                    
codeCXNN = (op) ->
    # rX = random & NN
    x = (op & 0x0F00) >> 8
    nn = op & 0x00FF
    random = Math.floor (Math.random() * 0x100)
    @r[x] = random & nn
    @r[x] &= 0xFF
                    
codeDXYN = (op) ->
    # draw sprite at (rX,rY); height N; starting at I; rF = any_pixels_flipped_from_0_to_1?
    x = (op & 0x0F00) >> 8
    y = (op & 0x00F0) >> 4
    n = op & 0x000F
    @r[15] = 0
    for row in [0 ... n]
        data = @m[@i + row]
        pixinv = 7
        for pix in [0 ... 8]
            mask = 1 << pixinv
            if data & mask
                xx = @r[x] + pix
                yy = @r[y] + row
                if @scr[xx][yy] == 1
                    @r[15] = 1
                @scr[xx][yy] ^= 1
            pixinv -= 1
    @Draw()

codeEX9E = (op) ->
    # skip if key rX is pressed
    x = (op & 0x0F00) >> 8
    if @keys[x] then @pc += 2
                    
codeEXA1 = (op) ->
    # skip if key rX is not pressed
    x = (op & 0x0F00) >> 8
    if not @keys[x] then @pc += 2
                    
codeFX07 = (op) ->
    # rX = DT
    x = (op & 0x0F00) >> 8
    @r[x] = @dt
                    
codeFX0A = (op) ->
    # wait for keypress, store to rX
    x = (op & 0x0F00) >> 8
    @wait = 1
    @waitr = x
                    
codeFX15 = (op) ->
    # DT = rX
    x = (op & 0x0F00) >> 8
    @dt = @r[x]
                    
codeFX18 = (op) ->
    # ST = rX
    x = (op & 0x0F00) >> 8
    @st = @r[x]
                    
codeFX1E = (op) ->
    # i += rX, carry if overflow
    x = (op & 0x0F00) >> 8
    @i += @r[x]
    @r[15] = 0
    if @i > 0xFFF
        @i &= 0xFFF
        @r[15] = 1
                    
codeFX29 = (op) ->
    # i = location of sprite rX
    x = (op & 0x0F00) >> 8
    @i = @loc[@r[x]]
                    
codeFX33 = (op) ->
    # m[i],m[i+1],m[i+2] = BCD(rX)
    x = (op & 0x0F00) >> 8
    num = @r[x]
    @m[@i]   = Math.floor (num / 100)
    @m[@i+1] = (Math.floor (num / 10)) % 10
    @m[@i+2] = num % 10
                    
codeFX55 = (op) ->
    # m[i],m[i+1],...,m[i+x] = r0,r1,...,rX; i += x + 1
    x = (op & 0x0F00) >> 8
    for tmp in [0..x]
        @m[@i+tmp] = @r[tmp]
    @i += x + 1
                    
codeFX65 = (op) ->
    # = r0,r1,...,rX = m[i],m[i+1],...,m[i+x] ; i += x + 1
    x = (op & 0x0F00) >> 8
    for tmp in [0..x]
        @r[tmp] = @m[@i+tmp]
    @i += x + 1
    