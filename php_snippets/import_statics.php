<?php

function import_statics($infos, $p)
{
	// var_dump($infos);
	// return ;
	
	
	$staticVars = array();
	$staticFuncs = array();
	
	if (isset($infos['encaps_zones']['private']))
	{
		if (isset($infos['encaps_zones']['private']['static_variable']))
			$staticVars = array_merge($staticVars, $infos['encaps_zones']['private']['static_variable']);
		if (isset($infos['encaps_zones']['private']['static_function']))
			$staticFuncs = array_merge($staticFuncs, $infos['encaps_zones']['private']['static_function']);
	}
	if (isset($infos['encaps_zones']['protected']))
	{
		if (isset($infos['encaps_zones']['protected']['static_variable']))
			$staticVars = array_merge($staticVars, $infos['encaps_zones']['protected']['static_variable']);
		if (isset($infos['encaps_zones']['protected']['static_function']))
			$staticFuncs = array_merge($staticFuncs, $infos['encaps_zones']['protected']['static_function']);
	}
	if (isset($infos['encaps_zones']['public']))
	{
		if (isset($infos['encaps_zones']['public']['static_variable']))
			$staticVars = array_merge($staticVars, $infos['encaps_zones']['public']['static_variable']);
		if (isset($infos['encaps_zones']['public']['static_function']))
			$staticFuncs = array_merge($staticFuncs, $infos['encaps_zones']['public']['static_function']);
	}
	var_dump($staticVars);
	var_dump($staticFuncs);
	return ;
	
	$class_orp = $infos['filename_class'].'::';
	foreach($staticVars as $v)
	{
		$len = 0;
		$str = preg_replace('/\bstatic\b/', '', $v);
		$str = preg_replace('/\b\S+;$/', '', $str);
		$str = trim($str);
		
		$len += strlen($str);
		echo $str;
		indent_line(CPP_INDENT_COL, $len);
		$len = max($len, CPP_INDENT_COL);
		
		$len += strlen($class_orp);
		echo $class_orp;
		
		preg_match('/\b(\S+);$/', $v, $tab);
		
		$str = $tab[1];
		$len += strlen($str);
		echo $str;
		
		$str = ' =';
		$len += strlen($str);
		echo $str;
		
		if ($len + 1 + 2 + 1 > 80)
			echo "\n\t";
		echo ' ;';
		
		
		echo "\n";
	}
	foreach($staticFuncs as $v)
	{
		$len = 0;
		$v = preg_replace('/\bstatic\b/', '', $v);
		// var_dump($v);
		if (preg_match('/'.$p['throwAndContent'].'/', $v, $throwTab))
			$v = preg_replace('/'.$p['throwAndContent'].'/', '', $v);
		else
			$throwTab = null;
		preg_match(	"/^".
						"([^\(\)\*]*?)".
						"(\*?)\s*".
						"\s*(\w*)\s*".
						"\((".$p['parenthesisContent'].")\)([^\(\)]*);".
					"$/", $v, $tab);
		$len = 0;
		
		$str = trim($tab[1]);
		$len += strlen($str);
		echo $str;
		
		indent_line(CPP_INDENT_COL, $len);
		$len = max(CPP_INDENT_COL, $len);
		
		$str = trim($tab[2]);
		$len += strlen($str);
		echo $str;
		
		$str = $class_orp.trim($tab[3]);
		$len += strlen($str);
		echo $str;
		
		echo '(';
		$len += 1;
		$arguments = rawArgumentsToTab($tab[4]);
		
		$i = 0;
		foreach ($arguments as $v)
		{
			if ($i > 0)
			{
				$len += 1;
				echo ",";
			}
			if ($len + strlen($v) + 1 > 80)
			{
				echo "\n\t";
				$len = 4;
			}
			elseif ($i > 0)
			{
				echo " ";
				$len += 1;
			}
			$i++;
			echo trim($v);
			$len += strlen(trim($v));
		}
		if (strlen(trim($tab[5])) == 0)
			$str = ")";
		else
			$str = ') '.trim($tab[5]);
		
		if ($len + strlen($str) > 80)
		{
			echo "\n\t";
			$len = 4;
		}
		$len += strlen($str);
		echo $str;
		
		if ($throwTab != null)
		{
			echo "\n\t".$throwTab[0];
			// echo "\n\tthrow(";
			// $i = 0;
			// unset($throwTab[0]);
			// foreach ($throwTab as $v)
			// {
				// if ($i++ > 0)
					// echo ", ";
				
				// echo trim($v);
			// }
		}
		echo "\n";
		put_function_body($tab[1].$tab[2], $arguments);
	}
}
?>
