<?php

function import_constructors($infos, $p)
{
	$ctors = array();
	
	if (isset($infos['encaps_zones']['protected']))
	{
		if (isset($infos['encaps_zones']['protected']['constructor']))
			$ctors = array_merge($ctors, $infos['encaps_zones']['protected']['constructor']);
	}
	if (isset($infos['encaps_zones']['public']))
	{
		if (isset($infos['encaps_zones']['public']['constructor']))
			$ctors = array_merge($ctors, $infos['encaps_zones']['public']['constructor']);
	}
	// var_dump($ctors);
	// return ;
	foreach($ctors as $v)
	{
		put_member($v, $infos['filename_class']);
	}
}
?>
