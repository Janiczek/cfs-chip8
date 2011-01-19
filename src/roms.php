<?php
        
function get ($s)
{
    $path = "../roms/" . $s;
    $fh = fopen($path, "rb");
    $data = fread($fh, filesize($path));
    echo bin2hex($data);
    fclose($fh);
}

$dir = dir('../roms');

while(($file = $dir->read()) !== false)
    if ($file != "." && $file != "..")
        $roms[] = $file;

$req_list = $_POST['fetch'];
if (isset($req_list)) echo join("%",$roms);

else
{
$req_rom = $_POST['rom'];
if (isset($req_rom) && in_array($req_rom, $roms))
    get($req_rom);    
}