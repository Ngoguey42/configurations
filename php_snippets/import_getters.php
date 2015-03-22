<?php

function import_getters($infos, $p)
{
	$getters = array();
	
	if (isset($infos['encaps_zones']['private']))
	{
		if (isset($infos['encaps_zones']['private']['getter']))
			$getters = array_merge($getters, $infos['encaps_zones']['private']['getter']);
	}
	if (isset($infos['encaps_zones']['protected']))
	{
		if (isset($infos['encaps_zones']['protected']['getter']))
			$getters = array_merge($getters, $infos['encaps_zones']['protected']['getter']);
	}
	if (isset($infos['encaps_zones']['public']))
	{
		if (isset($infos['encaps_zones']['public']['getter']))
			$getters = array_merge($getters, $infos['encaps_zones']['public']['getter']);
	}
	// var_dump($getters);
	// return ;
	foreach($getters as $v)
	{
		put_member($v, $infos['filename_class']);
	}
}
?>
