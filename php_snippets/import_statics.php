<?php

function import_statics($infos, $p)
{
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
	// var_dump($staticVars);
	// var_dump($staticFuncs);
	
	foreach($staticVars as $v)
	{
		put_variable($v, $infos['filename_class']);
	}
	
	foreach($staticFuncs as $v)
	{
		put_member($v, $infos['filename_class']);
	}
}
?>
