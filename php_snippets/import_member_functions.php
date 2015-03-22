<?php

function import_member_functions($infos, $p)
{
	$member_function = array();
	
	if (isset($infos['encaps_zones']['private']))
	{
		if (isset($infos['encaps_zones']['private']['member_function']))
			$member_function = array_merge($member_function, $infos['encaps_zones']['private']['member_function']);
	}
	if (isset($infos['encaps_zones']['protected']))
	{
		if (isset($infos['encaps_zones']['protected']['member_function']))
			$member_function = array_merge($member_function, $infos['encaps_zones']['protected']['member_function']);
	}
	if (isset($infos['encaps_zones']['public']))
	{
		if (isset($infos['encaps_zones']['public']['member_function']))
			$member_function = array_merge($member_function, $infos['encaps_zones']['public']['member_function']);
	}
	// var_dump($member_function);
	// return ;
	foreach($member_function as $v)
	{
		put_member($v, $infos['filename_class']);
	}
}
?>
