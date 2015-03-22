<?php

function import_setters($infos, $p)
{
	$setters = array();
	
	if (isset($infos['encaps_zones']['private']))
	{
		if (isset($infos['encaps_zones']['private']['setter']))
			$setters = array_merge($setters, $infos['encaps_zones']['private']['setter']);
	}
	if (isset($infos['encaps_zones']['protected']))
	{
		if (isset($infos['encaps_zones']['protected']['setter']))
			$setters = array_merge($setters, $infos['encaps_zones']['protected']['setter']);
	}
	if (isset($infos['encaps_zones']['public']))
	{
		if (isset($infos['encaps_zones']['public']['setter']))
			$setters = array_merge($setters, $infos['encaps_zones']['public']['setter']);
	}
	// var_dump($setters);
	// return ;
	foreach($setters as $v)
	{
		put_member($v, $infos['filename_class']);
	}
}
?>
