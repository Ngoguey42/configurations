<?php

function input_tabs($align_chars, $already_inputed)
{
	$align_chars -= (int)((int)$already_inputed / (int)4 * (int)4);
	$align_chars /= 4;
	while ($align_chars-- > 0)
		echo "\t";
}

if (!preg_match("/^(.+?)([\*\&])?$/", $argv[1], $tab))
	exit;

$tab[1] = trim($tab[1]);
$tab[2] = trim(isset($tab[2]) ? trim($tab[2]) : "");

echo $tab[1];
input_tabs(28, strlen($tab[1]));
echo $tab[2].'()'.PHP_EOL;
echo '{'.PHP_EOL;
echo "\t".PHP_EOL;
if ($tab[0] == "void" || $tab[0] == "static void")
	echo "\treturn ;".PHP_EOL;
else
	echo "\treturn ();".PHP_EOL;
echo '}'.PHP_EOL;

?>
