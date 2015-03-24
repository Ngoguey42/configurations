<?php

function import_setters_self($infos, $p)
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
		$addref = false;
		if (preg_match("/((\:\:)|([A-Z]))/", $v['type']))
			$addref = true;

		echo "\t";

		$str = "void";
		echo $str;
		indent_line(HPP_INDENT_COL, 4 + strlen($str));
		$len = max(HPP_INDENT_COL, 4 + strlen($str));
		
		
		$str  = "";
		$str .= "set";
		if (preg_match("/^_/", $v['name']))
			$str .= strtoupper(substr($v['name'], 1, 1)).substr($v['name'], 2);
		else
			$str .= strtoupper(substr($v['name'], 0, 0)).substr($v['name'], 1);
		/* $str .= "(void) const"; */
		$str .= "(";
		$str .= $v['type'];
		$str .= " ";
		if ($v['typeSuffix'] != "")
			$str .= $v['typeSuffix'];
		elseif ($addref)
			$str .= "&";
		$str .= "c";
		
		$str .= ")";
		
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
