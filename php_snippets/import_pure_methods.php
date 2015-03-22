<?php

function import_pure_methods($infos, $p)
{
	$pure_methods = array();
	
	if (isset($infos['encaps_zones']['private']))
	{
		if (isset($infos['encaps_zones']['private']['pure_method']))
			$pure_methods = array_merge($pure_methods, $infos['encaps_zones']['private']['pure_method']);
	}
	if (isset($infos['encaps_zones']['protected']))
	{
		if (isset($infos['encaps_zones']['protected']['pure_method']))
			$pure_methods = array_merge($pure_methods, $infos['encaps_zones']['protected']['pure_method']);
	}
	if (isset($infos['encaps_zones']['public']))
	{
		if (isset($infos['encaps_zones']['public']['pure_method']))
			$pure_methods = array_merge($pure_methods, $infos['encaps_zones']['public']['pure_method']);
	}
	// var_dump($pure_methods);
	// return ;
	foreach($pure_methods as $v)
	{
		put_member($v, $infos['filename_class']);
	}
}
?>
