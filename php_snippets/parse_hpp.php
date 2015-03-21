<?php

//#1 retreiving file content
if (!isset($argv[1]) || !file_exists($argv[1]))
	return (null);
$content = file_get_contents($argv[1]);
if ($content == null)
	return (null);
$ret = array();
$ret['rawfile'] = $content;

//#2 parsing file name
$tab = array();
if (!preg_match("/^(.*?\/)([^\/]*?)(\.class)?(\.(?:hpp|h))$/", $argv[1], $tab))
	return (null);
$ret['filename_full'] = $tab[0];
$ret['filename_path'] = $tab[1];
$ret['filename_class'] = $tab[2];
$ret['filename_preextension'] = $tab[3];
$ret['filename_extension'] = $tab[4];

// var_dump($tab);
// var_dump($content);


$nl = '[\r\n]{1,2}';
$sp = '[ \t]';
$spnl = '[ \t\r\n]';

$cppKeyword = '[a-z]*';
$identifier = '[a-zA-Z_][a-zA-Z_0-9]*';
$varType ="$identifier(?:[:]{2}$identifier)?";
$encapsulationKeyword = '(?:public|private|protected)';

					
$operatorOverload =	"operator$spnl*".
					"(?:".
						"\=".'|'.
						"\+".'|'.
						"\-".'|'.
						"\*".'|'.
						"\/".'|'.
						"\%".'|'.
						"\+\+".'|'.
						"\-\-".'|'.
						"\=\=".'|'.
						"\!\=".'|'.
						"\>".'|'.
						"\<".'|'.
						"\>\=".'|'.
						"\<\=".'|'.
						"\!".'|'.
						"\&\&".'|'.
						"\|\|".'|'.
						"\~".'|'.
						"\&".'|'.
						"\|".'|'.
						"\^".'|'.
						"\<\<".'|'.
						"\>\>".'|'.
						"\+\=".'|'.
						"\-\=".'|'.
						"\*\=".'|'.
						"\/\=".'|'.
						"\%\=".'|'.
						"\&\=".'|'.
						"\|\=".'|'.
						"\^\=".'|'.
						"\<\<\=".'|'.
						"\>\>\=".'|'.
						"\[\]".'|'.
						"\-\>".'|'.
						"\-\>\*".'|'.
						"\(\)".'|'.
						"\,".
					")";



$varORfuncPrefix =	"(?:$cppKeyword$spnl*)*".
					"$varType$spnl*".
					"(?:$cppKeyword$spnl*)*".
					"[\*&]?";
					
$varORfuncName =	"(?:$identifier|$operatorOverload|\~$identifier)";

$function = "$varORfuncPrefix$varORfuncName";
					

//#3 removing all comments and cr ln
$comStart = '\/\*';
$comEnd = '\*\/';
$comLine = '\/\/';
$content = preg_replace("/$comStart.*?$comEnd/s", '', $content);
$content = preg_replace("/$comLine.*/", '', $content);
$content = preg_replace("/\r\n/", '\n', $content);

//#4 splitting file's class
$inheritances =
	":$spnl*".
	"(?:virtual$spnl*)?".
	"(?:$encapsulationKeyword$spnl*)?".
	"$varType$spnl*".
	'(?:'.
		",$spnl*".
		"(?:virtual$spnl*)?".
		"(?:$encapsulationKeyword$spnl*)?".
		"$varType$spnl*".
	')*';

$bodyBetweenMatchingBrackets =
	'[^\{\}]*'.
	'(?:\{[^\{\}]*\}[^\{\}]*)*';
	
$tab = array();
if (!preg_match(
	'/'.
	'^(.*?)'.
	"class$spnl*".$ret['filename_class']."$spnl*".
	"($inheritances)?".
	'{'."$spnl*".
		"($bodyBetweenMatchingBrackets)".
	"}$spnl*;$spnl*".
		"($bodyBetweenMatchingBrackets)".
	'$'.
	'/s'
	, $content, $tab))
	return (null);
$ret['zone1_preClass'] = $tab[1];
$ret['zone2_inheritances'] = $tab[2];
$ret['zone3_class'] = $tab[3];
$ret['zone4_postClass'] = $tab[4];





//#6 extracting nested classes
$content = $ret['zone3_class'];
$ret['nested_classes'] = array();

$nestedClassPattern = 
	'/'.
	"class$spnl*($identifier)$spnl*($inheritances)?".
	'{'."$spnl*".
		"($bodyBetweenMatchingBrackets)".
	'}'."$spnl*;".
	'/s';

$tab = array();
while (preg_match($nestedClassPattern, $content, $tab))
{
	// var_dump($tab);
	$nestedClass = array();
	$nestedClass['name'] = $tab[1];
	$nestedClass['inheritances'] = $tab[2];
	$nestedClass['body'] = $tab[3];
	$ret['nested_classes'][] = $nestedClass;
	$content = preg_replace($nestedClassPattern, '', $content, 1);
}

	
//#5 splitting class by encapsulation
$encapsulationSpacer = "$encapsulationKeyword$sp*:$spnl*";

$tab = array();
$nextSticker = "";
$ret['encaps_zones'] = array();

	//matching 0-3 first
while (preg_match(
	'/^'.
	"(.*?)".
	"($encapsulationSpacer)".
	'/s', $content, $tab))
{
	$curSticker;
	if ($nextSticker === "")
		$curSticker = "private";
	else
		$curSticker = $nextSticker;
	preg_match("/($encapsulationKeyword)/", $tab[2], $tab2);
	$nextSticker = $tab2[1];
	
	if (isset($ret['encaps_zones'][$curSticker]))
		$ret['encaps_zones'][$curSticker] .= "\n".$tab[1];
	else
		$ret['encaps_zones'][$curSticker] = $tab[1];
	$content = preg_replace('/^'.
	"(.*?)".
	"($encapsulationSpacer)".
	'/s', '', $content, 1);
}

	//matching trailing encapsulation
if ($nextSticker === "")
	$curSticker = "private";
else
	$curSticker = $nextSticker;
if (isset($ret['encaps_zones'][$curSticker]))
	$ret['encaps_zones'][$curSticker] .= "\n".$content;
else
	$ret['encaps_zones'][$curSticker] = $content;





	// var_dump($tab);
// echo $content;
// exit;

//DEBUG START
$i = 0; foreach($ret as $k => $v){
	echo "\033[37m=======================================================================\n";
	if ($i++ % 2 == 1) echo "\033[33m";
	else echo "\033[31m";
	if (gettype($v) == "array"){
		echo "[$k:]";
		var_dump($v);
	}
	else
		echo "[$k:]$v\n";
} echo "\033[37mThen:\n";
$i = 0; foreach($ret as $k => $v){
	if ($i++ % 2 == 1) echo "\033[33m";
	else echo "\033[31m";
	if (gettype($v) == "array")
		echo "[$k:]array\n";
	else
		echo "[$k:]".strlen($v)."\n";
} echo "\033[37m";
//DEBUG END

?>