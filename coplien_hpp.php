<?php

$class = $argv[1];
$macro = strtoupper($argv[1])."_CLASS_HPP";

echo PHP_EOL;
echo "#ifndef $macro".PHP_EOL;
echo "# define $macro".PHP_EOL;
echo PHP_EOL;
echo "//# include <iostream>".PHP_EOL;
echo PHP_EOL;
echo "class $class".PHP_EOL;
echo "{".PHP_EOL;
echo "public:".PHP_EOL;
echo "\t$class();".PHP_EOL;
echo "\t$class($class const &src);".PHP_EOL;
echo "\tvirtual ~$class();".PHP_EOL;

$classlen = strlen($class);
$ntabs = 5 - (int)((int)$classlen / (int)4);

echo "\t$class";
while ($ntabs--)
	echo "\t";
echo "&operator=($class const &rhs);".PHP_EOL;
echo PHP_EOL;
echo "protected:".PHP_EOL;
echo "pritate:".PHP_EOL;
echo "};".PHP_EOL;
echo "//std::ostream\t\t\t&operator(std::ostream &o, $class const &rhs);".PHP_EOL;
echo PHP_EOL;

echo "#endif // ";
$nbstars = 66 - strlen($macro);
while ($nbstars--)
	echo "*";
echo " $macro //".PHP_EOL;
	
?>
