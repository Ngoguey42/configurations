<?php

include("parse_hpp.php");
define('CPP_INDENT_COL', 28);
define('HPP_INDENT_COL', 32);

function indent_line($column_number, $already_inputed)
{
	$column_number -= (int)((int)$already_inputed / (int)4 * (int)4);
	$column_number /= 4;
	while ($column_number-- > 0)
		echo "\t";
}

function rawArgumentsToTab($rawArguments)
{
	preg_match_all(	'/[^,]*/', $rawArguments, $arguments);
	$arguments = $arguments[0];
	foreach ($arguments as $k => $v)
	{
		$arguments[$k] = trim($v);
		if (strlen($arguments[$k]) === 0)
			unset($arguments[$k]);
	}
	return ($arguments);
}

function put_variable($v, $class)
{
	echo $v['type'];
	indent_line(CPP_INDENT_COL, strlen($v['type']));
	echo $v['typeSuffix'].$class.'::'.$v['name']." = ";
	if ($v['nameSuffix'] != null)
		echo "{}";
	else
		echo ";";
	echo "\n";
}

function put_parenthesis_content_and_end($tab, $len)
{
	foreach ($tab as &$v)
	{
		$str = $v['full'];
		$nextLen = strlen($str);
		if ($v != end($tab))
		{
			$nextLen += 2;
			$str .= ", ";
		}
		else
		{
			$nextLen += 1;
			// $str .= ")";
		}
		if ($len + $nextLen > 80)
		{
			echo "\n\t";
			$len = 4;
		}
		$len += $nextLen;
		echo $str;
	}
	echo ")";
	return ($len);
}
function put_parenthesis_content_and_end_throw($tab, $len)
{
	foreach ($tab as &$v)
	{
		$str = $v;
		$nextLen = strlen($str);
		if ($v != end($tab))
		{
			$nextLen += 2;
			$str .= ", ";
		}
		else
		{
			$nextLen += 1;
			// $str .= ")";
		}
		if ($len + $nextLen > 80)
		{
			echo "\n\t";
			$len = 4;
		}
		$len += $nextLen;
		echo $str;
	}
	echo ")";
	return ($len);
}

function put_member($v, $class)
{
	$str = "";
	$len = 0;
	if ($v['type'] !== '')
	{
		echo $v['type'];
		indent_line(CPP_INDENT_COL, strlen($v['type']));
		
		$str .= $v['typeSuffix'].$class.'::';
		if (isset($v['isOperator']))
			$str .= "operator";
		$len = max(CPP_INDENT_COL, strlen($v['type']));
	}
	$str .= $v['funName'].'(';
	$len += strlen($str);
	echo $str;
	
	$len = put_parenthesis_content_and_end($v['funargs'], $len);
	
	if (strlen($v['postFun']) + $len + 1 <= 80)
	{
		echo " ".$v['postFun'];
		$len += strlen($v['postFun']) + 1;
	}
	else
	{
		echo "\n\t".$v['postFun'];
		$len = 4 + strlen($v['postFun']);
	}
	if (isset($v['throwArgs']))
	{
		$str = "throw(";
		if (strlen($str) + $len + 1 <= 80)
		{
			echo " $str";
			$len += strlen($str) + 1;
		}
		else
		{
			echo "\n\t$str";
			$len = 4 + strlen($str);
		}
		$len = put_parenthesis_content_and_end_throw($v['throwArgs'], $len);
	}
	echo "\n{\n";
	foreach ($v['funargs'] as $w)
	{
		if ($w['name'] != "void")
			echo "\t(void)".$w['name'].";\n";
	}
	echo "\treturn ";
	if ($v['type'] != "void" && $v['type'] != "")
		echo "()";
	echo ";\n}\n";
}

//$argv[1]		origin file name
//$argv[2]		wished hpp
//$argv[3]		option

if (!isset($argv[3]))
	exit ;

if (!preg_match("/^(.*?\/)([^\/]*?)(\.class)?(\.(?:hpp|h|c|cpp|php))$/", $argv[1], $tab))
	exit ;
$infos = null;


if ($argv[2] !== '')
{
	$infos = ParseHppFile($argv[2]);
}
else if ($tab[4] === '.cpp' || $tab[4] === '.c')
{
	$infos = ParseHppFile($tab[1].$tab[2].$tab[3].'.hpp');
	if ($infos == null)
		$infos = ParseHppFile($tab[1].$tab[2].$tab[3].'.h');
}
if ($infos == null)
	exit ;
$infos['orig_filename_full'] = $tab[0];
$infos['orig_filename_path'] = $tab[1];
$infos['orig_filename_class'] = $tab[2];
$infos['orig_filename_preextension'] = $tab[3];
$infos['orig_filename_extension'] = $tab[4];

$p['parenthesisContent'] =	'[^\(\)\,]*'.
							'(?:\,[^\(\)\,]*)*';
$p['matchParenthesisContent'] =	'([^\(\)\,]*)'.
								'(?:\,([^\(\)\,]*))*';
$p['throwAndContent'] =	'\bthrow\s*'.
								'\('.
									$p['parenthesisContent'].
								'\)';
if ($argv[3] === 'statics')
{
	include("import_statics.php");
	import_statics($infos, $p);
}
if ($argv[3] === 'constructors')
{
	include("import_constructors.php");
	import_constructors($infos, $p);
}
if ($argv[3] === 'operators')
{
	include("import_operators.php");
	import_operators($infos, $p);
}
if ($argv[3] === 'getters')
{
	include("import_getters.php");
	import_getters($infos, $p);
}
if ($argv[3] === 'setters')
{
	include("import_setters.php");
	import_setters($infos, $p);
}
if ($argv[3] === 'member_functions')
{
	include("import_member_functions.php");
	import_member_functions($infos, $p);
}
if ($argv[3] === 'methods')
{
	include("import_methods.php");
	import_methods($infos, $p);
}
if ($argv[3] === 'pure_methods')
{
	include("import_pure_methods.php");
	import_pure_methods($infos, $p);
}


// var_dump($infos);
?>
