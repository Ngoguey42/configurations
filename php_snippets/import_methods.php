<?php

function import_methods($infos, $p)
{
	$methods = array();
	
	if (isset($infos['encaps_zones']['private']))
	{
		if (isset($infos['encaps_zones']['private']['method']))
			$methods = array_merge($methods, $infos['encaps_zones']['private']['method']);
	}
	if (isset($infos['encaps_zones']['protected']))
	{
		if (isset($infos['encaps_zones']['protected']['method']))
			$methods = array_merge($methods, $infos['encaps_zones']['protected']['method']);
	}
	if (isset($infos['encaps_zones']['public']))
	{
		if (isset($infos['encaps_zones']['public']['method']))
			$methods = array_merge($methods, $infos['encaps_zones']['public']['method']);
	}
	// var_dump($methods);
	// return ;
	foreach($methods as $v)
	{
		put_member($v, $infos['filename_class']);
	}
}
?>
