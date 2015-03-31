<?php

function import_getters_self($infos, $p)
{
	$vars = array();
	
	if (isset($infos['encaps_zones']['private']))
	{
		if (isset($infos['encaps_zones']['private']['variable']))
			$vars = array_merge($vars, $infos['encaps_zones']['private']['variable']);
	}
	if (isset($infos['encaps_zones']['protected']))
	{
		if (isset($infos['encaps_zones']['protected']['variable']))
			$vars = array_merge($vars, $infos['encaps_zones']['protected']['variable']);
	}
	if (isset($infos['encaps_zones']['public']))
	{
		if (isset($infos['encaps_zones']['public']['variable']))
			$vars = array_merge($vars, $infos['encaps_zones']['public']['variable']);
	}
	/* var_dump($vars); */
	/* var_dump($infos); */
	// return ;
	foreach($vars as $v)
	{
		echo "\t";
		$str = $v['type'];

		$addref = false;
		if (preg_match("/((\:\:)|([A-Z]))/", $v['type']) || $v['typeSuffix'] != "")
			$addref = true;

		$hasConst = false;
		if (preg_match("/\bconst\b/", $v['type']))
			$hasConst = true;

		if ($addref && !$hasConst)
			$str .= " const";
		else if (!$addref && $hasConst)
			$str = preg_replace("/\s*\bconst\b\s*/", '', $str);


		echo $str;
		indent_line(HPP_INDENT_COL, 4 + strlen($str));
		$len = max(HPP_INDENT_COL, 4 + strlen($str));
		
		$str  = "";
		if ($v['typeSuffix'] != "")
			$str .= $v['typeSuffix'];
		elseif ($addref)
			$str .= "&";
		$str .= "get";
		if (preg_match("/^_/", $v['name']))
			$str .= strtoupper(substr($v['name'], 1, 1)).substr($v['name'], 2);
		else
			$str .= strtoupper(substr($v['name'], 0, 1)).substr($v['name'], 1);
		$str .= "(void) const";
		
		echo $str;
		$len += strlen($str);

		echo ";\n";
		continue ;
		$str = '{return this->'.$v['name'].';}';

		if (strlen($str) + $len > 80)
			echo "\n";
		echo $str;
		echo "\n";
		
		/* $len = put_member($v, $infos['filename_class'], '', false); */
		
	}
	
}
?>
