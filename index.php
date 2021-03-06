<?php include('include/general.php'); ?>
<?php
$languages = new language;
$languages->order_by( array( 'popular' => 'DESC', 'english_name' ) )->find_all();
$language_arr = array();
foreach( $languages->language_arr as $language ){
	if( $language->iso2letter AND $language->native_name ){
		$language_arr[$language->iso2letter] = $language->native_name;
	}
}

$results = array();
$query = '';
$type = 'web';
$format = 'web';
$language = new language;
if( array_key_exists( 'search', $_GET ) AND array_key_exists( 'query', $_GET ) AND !empty( $_GET['query'] ) ){
	$query = $_GET['query'];

	if( array_key_exists( 'type', $_GET ) AND !empty( $_GET['type'] ) ){
		$type = $_GET['type'];
	}

	if( array_key_exists( 'language', $_GET ) AND !empty( $_GET['language'] ) ){
		if( strlen( $_GET['language'] ) === 2 ){
			$language->where( array( 'iso2letter' => $_GET['language'] ) )->find();
		}else{
			$language->where( array( 'native_name' => $_GET['language'] ) )->find();
		}
	}

	if( array_key_exists( 'format', $_GET ) AND !empty( $_GET['format'] ) ){
		$format = $_GET['format'];
	}

	$query_search = new query_search();
	$query_search->where( array( 'language_id' => $language->language_id, 'query' => $query ) )->find();
	if( !$query_search->query_search_id ){
		$query_search->language_id = $language->language_id;
		$query_search->query = $query;
	}
	$query_search->save();

	$utterances = new utterance;
	$results = array_merge( $results, $utterances->query_search( $query, $type, $language ) );
}

if( !$language->language_id ){
	$language->where( array( 'iso2letter' => 'en' ) )->find();
}

$form = new form_builder( 'search-form', FALSE, 'get' );
$form->input( 'query', 'search' )->label('Search')->default_value( $query );
$form->input( 'type', 'select' )->select_values( array( '' => 'web', 'image' => 'image' ) )->default_value( $type );
$form->input( 'language', 'select' )->select_values( $language_arr )->default_value( $language->iso2letter );
$form->input( 'search', 'button' );
?>
<?php if( $format === 'json' ){ ?>
<?php include('view/json/index.php'); ?>
<?php }else{ ?>
<?php include('view/header.php'); ?>
<?php include('view/index.php'); ?>
<?php include('view/footer.php'); ?>
<?php } ?>
