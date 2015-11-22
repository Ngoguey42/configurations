<?php

function printInc($str, &$totlen)
{
	$totlen += strlen($str);
	echo $str;
}

if (!isset($argv[1]))
	    exit ;

$ns = $argv[1];


$tolen = 0;
printInc('namespace ', $totlen);
printInc($ns, $totlen);
printInc(' // ', $totlen);
echo str_repeat('~', 80 - 3 - $totlen) . ' //';
echo "\n";

$totlen = 0;
printInc('{ // ', $totlen);
echo str_repeat('~', 80 - 3 - $totlen) . ' //';
echo "\n";
echo "\n";
echo "\n";
echo "\n";
echo "\n";
echo "\n";

$totlen = 0;
printInc('}; // ', $totlen);
$endline = ' END OF NAMESPACE ' . strtoupper($ns) . ' //';
$totlen += strlen($endline);
echo str_repeat('~', 80 - $totlen) . $endline;
echo "\n";

$totlen = 0;
printInc('// ', $totlen);
echo str_repeat('~', 80 - 3 - $totlen) . ' //';
echo "\n";





?>
