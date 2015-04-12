<?php
$json_results['type'] = $type;
$json_results['language'] = $language->iso2letter;
if( sizeof( $results ) === 0 ){
	$json_results['success'] = false;
	$json_results['message'] = 'No Results found';
}else{
	$json_results['success'] = true;
	$json_results['results'] = $results;
}

header('Content-type: application/json');
echo json_encode( $json_results );
?>