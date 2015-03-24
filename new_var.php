<?php

function input_tabs($align_chars, $already_inputed)
{
	$align_chars -= (int)((int)$already_inputed / (int)4 * (int)4);
	$align_chars /= 4;
	while ($align_chars-- > 0)
		echo "\t";
}


if (!preg_match("/^(.+?)([\*\&])?$/", $argv[3], $tab_vartype))
	    exit;

$filepath = $argv[1];

if (!preg_match("/\/([^\/]*?)(\.class)?\.(hpp|cpp|c|h)$/", $filepath, $tab_filename))
	exit;

$tab_vartype[1] = trim($tab_vartype[1]);
$tab_vartype[2] = trim(isset($tab_vartype[2]) ? trim($tab_vartype[2]) : "");

$cur_col = (int)$argv[2];
$aligncol = 28;
if ($tab_filename[3] === "hpp" || $tab_filename[3] === "h")
	$aligncol = 32;


$str = $tab_vartype[1];
$cur_col += strlen($str);
echo $str;

input_tabs($aligncol, $cur_col);

$str = $tab_vartype[2];
$cur_col += strlen($str);
echo $str;

echo ';';


/* var_dump($tab_filename); */
/* var_dump($tab_vartype); */
/* var_dump($cur_col); */


?>
