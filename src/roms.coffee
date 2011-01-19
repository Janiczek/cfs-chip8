LoadRom = (data) ->
    
    d = new Array()
    for x of data
        if x % 2 == 0
            d.push data[x]
        else
            d[(x - 1) / 2] += data[x]
    
    mi = 0x200
    
    for x in d
        @m[mi] = parseInt x, 16
        mi += 1
        
    @CPUReset()

$ ->
    
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
        
    $("#loadroms select").change ->
        name = $("#loadroms select option:selected").html()
        
        data = $.ajax({
            type: "POST"
            url: "./src/roms.php"
            data: "rom=" + name
            async: false
        }).responseText
    
        LoadRom data