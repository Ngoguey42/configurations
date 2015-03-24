<?php

function import_init_list($infos, $p)
{
	/* echo $infos['zone2_inheritances']."\n"; */
	preg_match_all("/[^,]*/", $infos['zone2_inheritances'], $tab);

	$toPrint = array();
	
	foreach ($tab[0] as $v)
	{
		if (preg_match("/\S+$/", trim($v), $t))
			$toPrint[] = $t[0];
	}
	/* var_dump($tab); */
	
	
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

	function cmp_vars($a, $b)
	{
		return ($a['index'] > $b['index']);
		
	}
	
	usort($vars, "cmp_vars");
	
	foreach ($vars as $v)
		$toPrint[] =  $v['name'];
	foreach($toPrint as &$v)
	{
		if ($v != $toPrint[0])
			echo ",\n";
		echo "\t".$v."()";
	}
}
?>
