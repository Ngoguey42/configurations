<?php

function input_tabs($align_chars, $already_inputed)
{
	$align_chars -= (int)((int)$already_inputed / (int)4 * (int)4);
	$align_chars /= 4;
	while ($align_chars-- > 0)
		echo "\t";
}

$filepath = $argv[1];

if (!preg_match("/([^\/]*?)(\.class)?\.hpp$/", $filepath, $tab))
	exit;
$class = $tab[1];
$preextension = $tab[2];
$macro = strtoupper($class);
if ($preextension != NULL)
	$macro .= '_CLASS';
$macro .= '_HPP';

echo PHP_EOL;
echo "#ifndef $macro".PHP_EOL;
echo "# define $macro".PHP_EOL;
echo PHP_EOL;
echo "//# include <string>".PHP_EOL;
echo "//# include <iostream>".PHP_EOL;
echo PHP_EOL;
echo "class $class".PHP_EOL;
echo "{".PHP_EOL;
echo "public:".PHP_EOL;
echo "\t$class();".PHP_EOL;
echo "\t$class($class const &src);".PHP_EOL;
echo "\tvirtual ~$class();".PHP_EOL;
echo "\t$class";
input_tabs(32, 4 + strlen($class));
echo "&operator=($class const &rhs);".PHP_EOL;
echo PHP_EOL;
echo "\t// $class();".PHP_EOL;
echo PHP_EOL;
echo "protected:".PHP_EOL;
echo "private:".PHP_EOL;
echo "};".PHP_EOL;
echo "//std::ostream\t\t\t\t\t&operator(std::ostream &o, $class const &rhs);".PHP_EOL;
echo PHP_EOL;
echo "#endif // ".str_repeat('*', 66 - strlen($macro))." $macro //".PHP_EOL;
	
?>
