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

if (isset($_POST['fetch']) && $_POST['fetch'] == 1)
    echo join("%",$roms);

else
{
$req_rom = $_POST['rom'];
if (isset($req_rom) && in_array($req_rom, $roms))
    get($req_rom);    
}