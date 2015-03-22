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

function put_function_body($returnType, $arguments)
{
	echo '{'."\n";
	// preg_match(	'/^([^\(\)\,]*)'.
				// '(?:\,([^\(\)\,]*))*$/', $rawArguments, $arguments);
	// unset($arguments[0]);
	foreach ($arguments as $v)
	{
		if (strlen(trim($v)) === 0)
			continue ;
		echo "\t";
		preg_match("/^(.*)\b([a-zA-Z_][a-zA-Z_0-9]*)\s*".
						'(?:\['.
							'[0-9\s]*'.
						'\]\s*)*'.
					"$/", $v, $tab);
		echo '(void)'.$tab[2].';';
		echo "\n";
	}
	echo "\t";
	if (preg_match("/\bvoid\b/", $returnType)
			&& !preg_match("/\*/", $returnType))
		echo "return ;";
	else
		echo "return ();";
	echo "\n";
	echo '}'."\n";
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

// var_dump($infos);
?>