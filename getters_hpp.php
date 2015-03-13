<?php

function input_tabs($align_chars, $already_inputed)
{
	$align_chars -= (int)((int)$already_inputed / (int)4 * (int)4);
	$align_chars /= 4;
	while ($align_chars-- > 0)
		echo "\t";
}

function input_getter($tab, $i, $class)
{
	if (preg_match("/static/", $tab[1][$i]))
		return ;
	echo "\t".$tab[1][$i];
	input_tabs(32, strlen($tab[1][$i]) + 4);

	if ($tab[2][$i] === '*')
	{
		echo '*';
	}
	else if (preg_match("/((std::string)|([A-Z]))/", $tab[1][$i]))
	{
		//if stdstring or any uppercase char, return reference to instance
		echo '&';
	}

	$str = 'get';
	echo $str;
	
	$str = strtoupper(substr($tab[3][$i], 0, 1)).substr($tab[3][$i], 1);
	echo $str;
	
	$str = '(void) const;'.PHP_EOL;
	echo $str;
}

$filepath = $argv[1];

if (!preg_match("/^(.*?\/)([^\/]*?)(\.class)?(\.(?:hpp|h))$/", $filepath, $tab))
	exit;

$lines = file_get_contents($argv[1]);

if ($lines == false)
	exit;

if (!preg_match_all("/\t([^\t]+)[\t]+([\*])?_([a-zA-Z0-1_]+);/", $lines, $tab2))
	exit;

$i = 0;
while ($tab2[0][$i] != NULL)
	input_getter($tab2, $i++, $tab[2]);
/* var_dump($tab2); */



?>
