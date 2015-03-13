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
	$len = 28;
	echo $tab[1][$i];
	input_tabs(28, strlen($tab[1][$i]));

	if ($tab[2][$i] === '*')
	{
		$len++;
		echo '*';
	}
	else if (preg_match("/((std::string)|([A-Z]))/", $tab[1][$i]))
	{
		//if stdstring or any uppercase char, return reference to instance
		$len++;
		echo '&';
	}

	$str = $class.'::get';
	echo $str;
	$len += strlen($str);
	
	$str = strtoupper(substr($tab[3][$i], 0, 1)).substr($tab[3][$i], 1);
	echo $str;
	$len += strlen($str);
	
	$str = '(void) const';
	echo $str;
	$len += strlen($str);

	$str = '{return this->_'.$tab[3][$i].';}';
	if ($len + strlen($str) <= 80)
		echo $str;
	else
		echo PHP_EOL."\t$str";
	echo PHP_EOL;
}

$filepath = $argv[1];

if (!preg_match("/^(.*?\/)([^\/]*?)(\.class)?(\.(?:cpp|c))$/", $filepath, $tab))
	exit;


$hpppath = "";
if ($tab[4] === ".cpp")
	$hpppath = $tab[1].$tab[2].$tab[3].'.hpp';
else
	$hpppath = $tab[1].$tab[2].$tab[3].'.cpp';

$lines = file_get_contents($hpppath);

if ($lines == false)
	exit;

if (!preg_match_all("/\t([^\t]+)[\t]+([\*])?_([a-zA-Z0-1_]+);/", $lines, $tab2))
	exit;

$i = 0;
while ($tab2[0][$i] != NULL)
	input_getter($tab2, $i++, $tab[2]);



?>
