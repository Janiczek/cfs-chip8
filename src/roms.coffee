LoadRom = (string) ->
    
    temp_mem = new Array()
    for key of string
        # we have to form the hex number from two chars
        # if the key is even, it's the 1st char
        if key % 2 == 0
            temp_mem.push string[key]
        # else it's the 2nd char and we just contencate the two strings
        else
            temp_mem[(key - 1) / 2] += string[key]
    
    # now let's copy it into the main memory
    mem_index = 0x200
    
    for number in temp_mem
        m[mem_index] = parseInt number, 16
        mem_index += 1
    
    CPUReset()

$ ->
    
    # list of ROMs    
    roms = $.ajax({
        type: "POST"
        url: "./src/roms.php"
        data: "fetch=1"
        async: false
    }).responseText
    
    if not roms.length
        alert info = "Error, didn't fetch the ROMs!"
    else
        info = roms.split "%"

    for tmp of info
        $("#loadroms select").append "<option>#{info[tmp]}</option>"
    
    # selected something? load it.    
    $("#loadroms select").change ->
        name = $("#loadroms select option:selected").html()
        
        data = $.ajax({
            type: "POST"
            url: "./src/roms.php"
            data: "rom=" + name
            async: false
        }).responseText
    
        LoadRom data