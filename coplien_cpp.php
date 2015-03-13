<?php

function input_tabs($align_chars, $already_inputed)
{
	$align_chars -= (int)((int)$already_inputed / (int)4 * (int)4);
	$align_chars /= 4;
	while ($align_chars-- > 0)
		echo "\t";
}
std::cout <<  << std::endl;

function input_starter($str)
{
	echo '// ';
	echo str_repeat('*', 80 - 6 - strlen($str) * 2 - 5 * 2);
	echo '** '.$str.' *';
	echo '** '.$str.' *';
	echo ' //'.PHP_EOL;
}
function input_ender($str)
{
	echo '// ';
	echo '* '.$str.' **';
	echo '* '.$str.' **';
	echo str_repeat('*', 80 - 6 - strlen($str) * 2 - 5 * 2);
	echo ' //'.PHP_EOL;
}
function input_spacer()
{
	echo '// '.str_repeat('*', 80 - 6).' //'.PHP_EOL;
}


$filepath = $argv[1];

if (!preg_match("/([^\/]*?)(\.class)?\.cpp$/", $filepath, $tab))
	exit;
$class = $tab[1];
$preextension = $tab[2];
$hppfilename = $class.$preextension.'.hpp';

echo PHP_EOL;
echo "//#include <iostream>".PHP_EOL;
echo "#include \"$hppfilename\"".PHP_EOL;
echo PHP_EOL;

input_spacer();
input_starter('STATICS');

input_ender('STATICS');
input_spacer();
input_starter('CONSTRUCTORS');
echo "$class::$class()".PHP_EOL;
echo "{".PHP_EOL;
echo "\t// std::cout << \"[$class]() Ctor called\" << std::endl;".PHP_EOL;
echo "\treturn ;".PHP_EOL;
echo "}".PHP_EOL;
echo PHP_EOL;

echo "$class::$class($class const &src)".PHP_EOL;
echo "{".PHP_EOL;
echo "\t// std::cout << \"[$class](cpy) Ctor called\" << std::endl;".PHP_EOL;
echo "\t(void)src;".PHP_EOL;
echo "\treturn ;".PHP_EOL;
echo "}".PHP_EOL;
echo PHP_EOL;

echo "// $class::$class() : ".PHP_EOL;
echo "// ".PHP_EOL;
echo "// {".PHP_EOL;
echo "//\tstd::cout << \"[$class](main) Ctor called\" << std::endl;".PHP_EOL;
echo "//\treturn ;".PHP_EOL;
echo "// }".PHP_EOL;
echo PHP_EOL;
input_ender('CONSTRUCTORS');
input_spacer();
input_starter('DESTRUCTORS');
echo "$class::~$class()".PHP_EOL;
echo "{".PHP_EOL;
echo "\t// std::cout << \"[$class]() Dtor called\" << std::endl;".PHP_EOL;
echo "\treturn ;".PHP_EOL;
echo "}".PHP_EOL;
echo PHP_EOL;
input_ender('DESTRUCTORS');
input_spacer();
input_starter('OPERATORS');
echo "$class";
input_tabs(28, strlen($class));
echo "&$class::operator=($class const &rhs)".PHP_EOL;
echo "{".PHP_EOL;
echo "\t// std::cout << \"[$class]= Overload called\" << std::endl;".PHP_EOL;
echo "\t(void)rhs;".PHP_EOL;
echo "\treturn (*this);".PHP_EOL;
echo "}".PHP_EOL;
echo PHP_EOL;

echo "// std::ostream";
input_tabs(28, strlen('std::ostream'));
echo "&$class::operator<<(std::ostream &o, $class const &rhs)".PHP_EOL;
echo "// {".PHP_EOL;
echo "//\t(void)rhs;".PHP_EOL;
echo "//\treturn (o);".PHP_EOL;
echo "// }".PHP_EOL;
echo PHP_EOL;

input_ender('OPERATORS');
input_spacer();
input_starter('GETTERS');

input_ender('GETTERS');
input_spacer();
input_starter('SETTERS');

input_ender('SETTERS');
input_spacer();

exit ;

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
echo "protected:".PHP_EOL;
echo "pritate:".PHP_EOL;
echo "};".PHP_EOL;
echo "//std::ostream\t\t\t\t\t&operator(std::ostream &o, $class const &rhs);".PHP_EOL;
echo PHP_EOL;
echo "#endif // ".str_repeat('*', 66 - strlen($macro))." $macro //".PHP_EOL;
	
?>
