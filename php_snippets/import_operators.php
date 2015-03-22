<?php

function import_operators($infos, $p)
{
	$operators = array();
	
	if (isset($infos['encaps_zones']['private']))
	{
		if (isset($infos['encaps_zones']['private']['operator']))
			$operators = array_merge($operators, $infos['encaps_zones']['private']['operator']);
	}
	if (isset($infos['encaps_zones']['protected']))
	{
		if (isset($infos['encaps_zones']['protected']['operator']))
			$operators = array_merge($operators, $infos['encaps_zones']['protected']['operator']);
	}
	if (isset($infos['encaps_zones']['public']))
	{
		if (isset($infos['encaps_zones']['public']['operator']))
			$operators = array_merge($operators, $infos['encaps_zones']['public']['operator']);
		if (isset($infos['encaps_zones']['public']['extern_operator']))
			$operators = array_merge($operators, $infos['encaps_zones']['public']['extern_operator']);
	}
	// var_dump($operators);
	// return ;
	foreach($operators as $v)
	{
		put_member($v, $infos['filename_class']);
	}
}
?>
