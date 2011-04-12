<?php

// if we wanted to change the directory quickly
define("ROMS_DIR", "../roms/");

// fn for passing the binary source code as hexa values
function fetchROM ($filename)
{
    $path = ROMS_DIR . $filename;
    
    $handle = fopen($path, "rb");
    $data   = fread($handle, filesize($path));
    
    echo bin2hex($data);
    
    fclose($handle);
}

// fetch the list of ROMs in the directory
$directory = dir(ROMS_DIR);

while ( ($file = $directory->read()) !== false )
    if ($file != "." && $file != "..")
        $roms[] = $file;

// if the list is wanted, serialize it into a string and echo
if (isset($_POST["fetch"]) && $_POST["fetch"] == 1)
    echo join("%", $roms);
// else if particular ROM is wanted, check if it exists and echo it
else
{
    $selectedROM = $_POST["rom"];
    
    if (isset($selectedROM) && in_array($selectedROM, $roms))
        fetchROM($selectedROM);    
}