<?php


function ParseHppFile($filename)
{
	//#1 retreiving file content
	if (!isset($filename) || !file_exists($filename))
		return (null);
	$content = file_get_contents($filename);
	if ($content == null)
		return (null);
	$ret = array();
	$ret['rawfile'] = $content;

	//#2 parsing file name
	$tab = array();
	if (!preg_match("/^(.*?\/)([^\/]*?)(\.class)?(\.(?:hpp|h))$/", $filename, $tab))
		return (null);
	$ret['filename_full'] = $tab[0];
	$ret['filename_path'] = $tab[1];
	$ret['filename_class'] = $tab[2];
	$ret['filename_preextension'] = $tab[3];
	$ret['filename_extension'] = $tab[4];

	//#3 removing all comments, crln, and preprocessors
	$comStart = '\/\*';
	$comEnd = '\*\/';
	$comLine = '\/\/';
	$content = preg_replace("/$comStart.*?$comEnd/s", '', $content);
	$content = preg_replace("/$comLine.*/", '', $content);
	$content = preg_replace("/\r\n/s", "\n", $content);
	$content = preg_replace("/\#.*/m", '', $content);

	//#4 splitting file's class
	$nl = '[\r\n]{1,2}';
	$sp = '[ \t]';
	$spnl = '[ \t\r\n]';

	$encapsulationKeyword = '(?:public|private|protected)';

	$identifier = '[a-zA-Z_][a-zA-Z_0-9]*';
	$varType ="$identifier(?:[:]{2}$identifier)?";

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

	// matching a maximum of 4lvl of nested brackets
	$bodyBetweenMatchingBracketsL4 =
	'[^\{\}]*'.
		'(?:'.
		'\{'.
		'[^\{\}]*'.
		'\}[^\{\}]*'.
		')*';
	
	$bodyBetweenMatchingBracketsL3 =
	'[^\{\}]*'.
		'(?:'.
		'\{'.
		$bodyBetweenMatchingBracketsL4.
		'\}[^\{\}]*'.
		')*';
	
	$bodyBetweenMatchingBracketsL2 =
	'[^\{\}]*'.
		'(?:'.
		'\{'.
		$bodyBetweenMatchingBracketsL3.
		'\}[^\{\}]*'.
		')*';
	
	$bodyBetweenMatchingBrackets =
	'[^\{\}]*'.
		'(?:'.
		'\{'.
		$bodyBetweenMatchingBracketsL2.
		'\}[^\{\}]*'.
		')*';
	
	// $bodyBetweenMatchingBrackets =
	// '[^\{\}]*'.
	// '(?:'.
	// '\{'.
	// '[^\{\}]*'.
	// '\}[^\{\}]*'.
	// ')*';
	// $bodyBetweenMatchingBracketsR =
	// '[^\{\}]*'.
	// '(?:\{(?:R)\}*)*'.
	// '[^\{\}]*?';
	
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
	$ret['zone2_inheritances'] = trim($tab[2], " \t\n\r\0\x0B:");
	$ret['zone3_class'] = $tab[3];
	$ret['zone4_postClass'] = $tab[4];

	//#6 extracting nested classes
	$content = $tab[3];
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
		$nestedClass = array();
		$nestedClass['name'] = $tab[1];
		$nestedClass['inheritances'] = trim($tab[2], " \t\n\r\0\x0B:");
		$nestedClass['body'] = $tab[3];
		$ret['nested_classes'][] = $nestedClass;
		$content = preg_replace($nestedClassPattern, '', $content, 1);
	}
	
	function rawArgumentsToTab2($rawArguments)
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
	
	function trim_variable($rawText)
	{
		$variableName = "([a-zA-Z_][a-zA-Z_0-9]*)\s*".
			'((?:\['.
			'[^\[\]]*'.
			'\]\s*)*)';
		$replacements = array();
		
		if (preg_match("/\bstatic\b/", $rawText, $tab))
		{
			$replacements['isStatic'] = true;
			$rawText = preg_replace("/".preg_quote($tab[0])."/", '', $rawText);
		}
		$rawText = trim($rawText, " \t\n\r\0\x0B;");
		$replacements['full'] = $rawText;
		preg_match("/^(.*?)([\&\*]?)$variableName$/", $rawText, $tab);
		$replacements['type'] = trim($tab[1]);
		$replacements['typeSuffix'] = trim($tab[2]);
		$replacements['name'] = trim($tab[3]);
		$replacements['nameSuffix'] = trim($tab[4]);
		return ($replacements);
	}
	
	function trim_function_prototype($rawPrototype)
	{
		$ret = array();
		$ret['raw'] = $rawPrototype;
		$parenthesisContent = '[^\(\)]*';
		$throwAndContent =	'\bthrow\s*'.
			'\(('.$parenthesisContent.')\)';
		if (preg_match("/$throwAndContent/", $rawPrototype, $tab))
		{
			$rawPrototype = preg_replace("/".preg_quote($tab[0])."/", '', $rawPrototype);
			$tab = rawArgumentsToTab2($tab[1]);
			$ret['throwArgs'] = $tab;
		}
		$funcNameAndContent =	'\b(\w*)\s*'.
			'\(('.$parenthesisContent.')\)'.
			'('.$parenthesisContent.')';
		$operatorNameAndContent =	'\boperator\s*([\-\+\*\/\=\[\]\<\>]*)\s*'.
			'\(('.$parenthesisContent.')\)'.
			'('.$parenthesisContent.')';
		// $ret['raw2'] = $rawPrototype;
		if (preg_match("/$operatorNameAndContent/", $rawPrototype, $tab))
			$ret['isOperator'] = true;
		else if (preg_match("/$funcNameAndContent/", $rawPrototype, $tab))
			;
		else
			return (null);
		$rawPrototype = preg_replace("/".preg_quote($tab[0])."/", '', $rawPrototype);
		$ret['funName'] = trim($tab[1]);
		$ret['funargs'] = rawArgumentsToTab2($tab[2]);
		$ret['postFun'] = trim($tab[3], " \t\n\r\0\x0B;");
		if (preg_match("/\=\s*0/", $ret['postFun'], $tab))
		{
			$ret['isPure'] = true;
			$ret['postFun'] = trim(preg_replace("/".preg_quote($tab[0])."/", '', $ret['postFun']));
		}
		if (preg_match("/\bstatic\b/", $rawPrototype, $tab))
		{
			$ret['isStatic'] = true;
			$rawPrototype = preg_replace("/".preg_quote($tab[0])."/", '', $rawPrototype);
		}
		if (preg_match("/\bvirtual\b/", $rawPrototype, $tab))
		{
			$ret['isVirtual'] = true;
			$rawPrototype = preg_replace("/".preg_quote($tab[0])."/", '', $rawPrototype);
		}
		if (preg_match("/[\&\*]/", $rawPrototype, $tab))
		{
			$ret['typeSuffix'] = $tab[0];
			$rawPrototype = preg_replace("/".preg_quote($tab[0])."/", '', $rawPrototype);
		}
		else
			$ret['typeSuffix'] = '';
		$ret['type'] = trim($rawPrototype);
		foreach ($ret['funargs'] as $k => $v)
			$ret['funargs'][$k] = trim_variable($v);
		// unset($ret['raw']);
		return ($ret);
	}
	
	
	
	function trim_class_content($content, $bodyBetweenMatchingBrackets, $className)
	{
		//#5 splitting class by encapsulation
		$encapsulationKeyword = '(?:public|private|protected)'; //redef
		$sp = '[ \t]'; //redef
		$spnl = '[ \t\r\n]'; //redef
		
		
		$encapsulationSpacer = "$encapsulationKeyword$sp*:$spnl*";

		$tab = array();
		$nextSticker = "";
		$trim_result = array();

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
			
			if (isset($trim_result[$curSticker]))
				$trim_result[$curSticker] .= "\n".$tab[1];
			else
				$trim_result[$curSticker] = $tab[1];
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
		if (isset($trim_result[$curSticker]))
			$trim_result[$curSticker] .= "\n".$content;
		else
			$trim_result[$curSticker] = $content;


		//#6 splitting encapsulation zones by instructions
		$functionDefinition = '{'."$bodyBetweenMatchingBrackets".'}';

		if (isset($trim_result['private']) &&
			strlen(trim($trim_result['private'])) === 0)
				unset($trim_result['private']);
		
		if (isset($trim_result['protected']) &&
			strlen(trim($trim_result['protected'])) === 0)
				unset($trim_result['protected']);
		
		if (isset($trim_result['public']) &&
			strlen(trim($trim_result['public'])) === 0)
				unset($trim_result['public']);
		
		foreach ($trim_result as $k => $v)
		{
			preg_match_all(
				'/'.
					"[^\{\}\;]*(?:$functionDefinition|\;)".
					'/s', $v, $matches);
			foreach ($matches[0] as $l => $w)
				$matches[0][$l] = trim(preg_replace("/[ \n\v\r\t]+/s", ' ', $w));
			//removing defined functions
			foreach ($matches[0] as $l => $w)
			{
				if (substr($w, -1) === '}')
					unset($matches[0][$l]);
			}
			$trim_result[$k] = $matches[0];
		}
		
		//#7 sort instructions:
		//external overload
		
		//static variable
		//variable
		
		//destructor		//has no return type and a tilde
		//constructor		//has no return type
		//static function	//is static
		//pure method		//pure
		//operator			//has keywords
		//getter			//get[A-Z]
		//setter			//set[A-Z]
		//method			//is virtual
		//member function	//is function
		foreach ($trim_result as $encapsK => $encapsV)
		{
			foreach($encapsV as $k => $v)
			{
				if (!preg_match("/\(/", $v))
				{
					if (preg_match("/\bstatic\b/", $v))
					{
						if (!isset($trim_result[$encapsK]['static_variable']))
							$trim_result[$encapsK]['static_variable'] = array();
						$trim_result[$encapsK]['static_variable'][] = trim_variable($v);
					}
					else
					{
						if (!isset($trim_result[$encapsK]['variable']))
							$trim_result[$encapsK]['variable'] = array();
						$trim_result[$encapsK]['variable'][] = trim_variable($v);
					}
				}
				else
				{
					if (preg_match("/\b$className\s?\(/", $v))
					{
						if (!preg_match("/\~/", $v))
						{
							if (!isset($trim_result[$encapsK]['constructor']))
								$trim_result[$encapsK]['constructor'] = array();
							$trim_result[$encapsK]['constructor'][] = trim_function_prototype($v);
						}
						else
						{
							if (!isset($trim_result[$encapsK]['destructor']))
								$trim_result[$encapsK]['destructor'] = array();
							$trim_result[$encapsK]['destructor'][] = $v;
						}
					}
					else if (preg_match("/\bstatic\b/", $v))
					{
						if (!isset($trim_result[$encapsK]['static_function']))
							$trim_result[$encapsK]['static_function'] = array();
						$trim_result[$encapsK]['static_function'][] = trim_function_prototype($v);
					}
					else if (preg_match("/\s?=\s?0;$/", $v))
					{
						if (!isset($trim_result[$encapsK]['pure_method']))
							$trim_result[$encapsK]['pure_method'] = array();
						$trim_result[$encapsK]['pure_method'][] = trim_function_prototype($v);
					}
					else if (preg_match("/\boperator\b/", $v))
					{
						if (!isset($trim_result[$encapsK]['operator']))
							$trim_result[$encapsK]['operator'] = array();
						$trim_result[$encapsK]['operator'][] = trim_function_prototype($v);
					}
					else if (preg_match("/\bget[A-Z]\w*\b\s?\(/", $v))
					{
						if (!isset($trim_result[$encapsK]['getter']))
							$trim_result[$encapsK]['getter'] = array();
						$trim_result[$encapsK]['getter'][] = trim_function_prototype($v);
					}
					else if (preg_match("/\bset[A-Z]\w*\b\s?\(/", $v))
					{
						if (!isset($trim_result[$encapsK]['setter']))
							$trim_result[$encapsK]['setter'] = array();
						$trim_result[$encapsK]['setter'][] = trim_function_prototype($v);
					}
					else if (preg_match("/\bvirtual\b/", $v))
					{
						if (!isset($trim_result[$encapsK]['method']))
							$trim_result[$encapsK]['method'] = array();
						$trim_result[$encapsK]['method'][] = trim_function_prototype($v);
					}
					else
					{
						if (!isset($trim_result[$encapsK]['member_function']))
							$trim_result[$encapsK]['member_function'] = array();
						$trim_result[$encapsK]['member_function'][] = trim_function_prototype($v);
					}
					
				}
				unset($trim_result[$encapsK][$k]);
			}
		}
		
		
		return ($trim_result);
	}

	$ret['encaps_zones'] = trim_class_content($content, $bodyBetweenMatchingBrackets, $ret['filename_class']);

	foreach($ret['nested_classes'] as $k => $v)
	{
		$ret['nested_classes'][$k]['body'] =
		trim_class_content($v['body'], $bodyBetweenMatchingBrackets, $v['name']);
	}

	$functionDefinition = '{'."$bodyBetweenMatchingBrackets".'}'; //redef

	//getting external overloads
	preg_match_all(
		'/'.
			"[^\{\}\;]*(?:$functionDefinition|\;)".
			'/s', $ret['zone4_postClass'], $matches);
	foreach ($matches[0] as $l => $w)
		$matches[0][$l] = trim(preg_replace("/[ \n\v\r\t]+/s", ' ', $w));
	foreach ($matches[0] as $l => $w)
	{
		if (!(substr($w, -1) === '}'))
		{
			if (!isset($ret['encaps_zones']['public']))
				$ret['encaps_zones']['public'] = array();
			if (!isset($ret['encaps_zones']['public']['extern_operator']))
				$ret['encaps_zones']['public']['extern_operator'] = array();
			$ret['encaps_zones']['public']['extern_operator'][] = trim_function_prototype($w);
		}
	}
	preg_match_all(
		'/'.
			"[^\{\}\;]*(?:$functionDefinition|\;)".
			'/s', $ret['zone1_preClass'], $matches);
	foreach ($matches[0] as $l => $w)
		$matches[0][$l] = trim(preg_replace("/[ \n\v\r\t]+/s", ' ', $w));
	foreach ($matches[0] as $l => $w)
	{
		if (!(substr($w, -1) === '}'))
		{
			if (!isset($ret['encaps_zones']['public']))
				$ret['encaps_zones']['public'] = array();
			if (!isset($ret['encaps_zones']['public']['extern_operator']))
				$ret['encaps_zones']['public']['extern_operator'] = array();
			$ret['encaps_zones']['public']['extern_operator'][] = trim_function_prototype($w);
		}
	}

	// var_dump($matches[0]);
	// var_dump($tab);
	// echo $content;
	// exit;

	unset($ret['zone1_preClass']);
	unset($ret['zone3_class']);
	unset($ret['zone4_postClass']);
	unset($ret['rawfile']);

	
	return ($ret);
	//DEBUG START
	$color2 = "\033[32m";
	$i = 0; foreach($ret as $k => $v){
		echo "\033[37m=======================================================================\n";
		if ($i++ % 2 == 1) echo "\033[33m";
		else echo "$color2";
		if (gettype($v) == "array"){
			echo "[$k:]";
			var_dump($v);
		}
		else
			echo "[$k:]$v\n";
	} echo "\033[37mThen:\n";
	$i = 0; foreach($ret as $k => $v){
		if ($i++ % 2 == 1) echo "\033[33m";
		else echo "$color2";
		if (gettype($v) == "array")
			echo "[$k:]array\n";
		else
			echo "[$k:]".strlen($v)."\n";
	} echo "\033[37m";
	//DEBUG END
	
	exit ;
}

?>
