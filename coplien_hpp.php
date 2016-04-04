<?php

function input_tabs($align_chars, $already_inputed)
{
	$align_chars -= (int)((int)$already_inputed / (int)4 * (int)4);
	$align_chars /= 4;
	while ($align_chars-- > 0)
		echo "\t";
}

$filepath = $argv[1];

if (!preg_match("/\/([^\/]*?)(\.class)?\.hpp$/", $filepath, $tab))
	exit;
$class = $tab[1];
$macro = strtoupper($class);
if (isset($tab[2]))
	$macro .= '_CLASS';
$macro .= '_HPP';

echo "\n";
echo "#ifndef $macro"."\n";
echo "# define $macro"."\n";
echo "\n";
echo "// # include <iostream>"."\n";
echo "// # include <>"."\n";
echo "\n";
echo "// # include \"\""."\n";
echo "\n";
echo "class $class"."\n";
echo "{"."\n";
echo "public:"."\n";
echo "\n";

echo "\t/* CONSTRUCTION ***************** */\n";
echo "\t$class();"."\n";
echo "\t// virtual ~$class();"."\n";
echo "\t~$class();"."\n";
echo "\n";

echo "\t// $class() = delete;"."\n";
echo "\t$class($class const &src) = delete;"."\n";
echo "\t$class($class &&src) = delete;"."\n";

echo "\t$class ";
#input_tabs(28, 4 + strlen($class));
echo "&operator=($class const &rhs) = delete;"."\n";

echo "\t$class ";
#input_tabs(28, 4 + strlen($class));
echo "&operator=($class &&rhs) = delete;"."\n";

echo "\n";
echo "protected:"."\n";
echo "private:"."\n";
echo "};"."\n";
echo "//std::ostream\t\t\t&operator<<(std::ostream &o, $class const &rhs);"."\n";
echo "\n";
echo "#endif /* ".str_repeat('*', 66 - strlen($macro))." $macro */"."\n";

?>
