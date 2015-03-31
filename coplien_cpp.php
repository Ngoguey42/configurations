<?php

function input_tabs($align_chars, $already_inputed)
{
	$align_chars -= (int)((int)$already_inputed / (int)4 * (int)4);
	$align_chars /= 4;
	while ($align_chars-- > 0)
		echo "\t";
}

function input_starter($str, $iter = 1)
{
	echo '// ';
	$i = 0;
	while ($i++ < $iter)
		echo '* '.$str.' **';
	echo str_repeat('*', 80 - 6 - strlen($str) * $iter - 5 * $iter);
	echo ' //'.PHP_EOL;
}

$filepath = $argv[1];

if (!preg_match("/\/([^\/]*?)(\.class)?\.cpp$/", $filepath, $tab))
	exit;
$class = $tab[1];
$preextension;
if (isset($tab[2]))
	$preextension = $tab[2];
else
	$preextension = "";
$hppfilename = $class.$preextension.'.hpp';

echo PHP_EOL;
echo "//#include <iostream>".PHP_EOL;
echo "#include \"$hppfilename\"".PHP_EOL;
echo PHP_EOL;


input_starter('STATICS');
input_starter('CONSTRUCTORS');

input_starter('DESTRUCTORS');
echo "$class::~$class()".PHP_EOL;
echo "{".PHP_EOL;
echo "\t// std::cout << \"[$class]() Dtor called\" << std::endl;".PHP_EOL;
echo "\treturn ;".PHP_EOL;
echo "}".PHP_EOL;
echo PHP_EOL;
input_starter('OPERATORS');
input_starter('GETTERS');
input_starter('SETTERS');
input_starter('MEMBER FUNCTIONS / METHODS');
input_starter('NESTED_CLASSES');

?>
