<?php

function import_getters($infos, $p)
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


		$str = $v['type'];
		if ($v['typeSuffix'] != "" ||
								($addref && !preg_match("/\bconst\b/", $v['type'])))
									$str .= " const";
		echo $str;
		indent_line(CPP_INDENT_COL, strlen($str));
		$len = max(CPP_INDENT_COL, strlen($str));
		
		$str  = "";
		if ($v['typeSuffix'] != "")
			$str .= $v['typeSuffix'];
		elseif ($addref)
			$str .= "&";
		$str .= "get";
		if (preg_match("/^_/", $v['name']))
			$str .= strtoupper(substr($v['name'], 1, 2)).substr($v['name'], 2);
		else
			$str .= strtoupper(substr($v['name'], 0, 1)).substr($v['name'], 1);
		$str .= "(void) const";
		
		echo $str;
		$len += strlen($str);

		$str = '{return this->'.$v['name'].';}';

		if (strlen($str) + $len > 80)
			echo "\n";
		echo $str;
		echo "\n";
		
		/* $len = put_member($v, $infos['filename_class'], '', false); */
		
	}
	
}
?>
