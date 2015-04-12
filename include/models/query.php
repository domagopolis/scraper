<?php

/*
Name: query.php
Description: Class to retrieve state province detail information.
*/

class query extends orm{
	public $called_class = "query";

	public function save_query( $query_str=false ){
		$query_arr = explode( '&', $query_str );
		foreach( $query_arr as $nvp ){
			$nvp_arr = explode( '=', $nvp );
			$condition = array( 'name' => $nvp_arr[0] );
			if( array_key_exists( 1, $nvp_arr ) ) $condition['value'] = $nvp_arr[1];
			$this->where( $condition )->find();
			if( !$this->query_id ){
				$query = new query();
				$query->name = $nvp_arr[0];
				if( array_key_exists( 1, $nvp_arr ) ) $query->value = $nvp_arr[1];
				$query->save();
			}
		}
	}

	public function query_str( $cached_url=null ){
		$str = '';

		$queries = $cached_url->queries;
		$queries_arr = array();
		foreach( $queries->query_arr as $query ){
			$queries_arr[] = $query->name.'='.$query->value;
		}

		return '?'.implode( '&', $queries_arr );
	}

	public function query_image_str( $cached_image_url=null ){
		$str = '';

		$queries = $cached_image_url->queries;
		$queries_arr = array();
		foreach( $queries->query_arr as $query ){
			$queries_arr[] = $query->name.'='.$query->value;
		}

		return '?'.implode( '&', $queries_arr );
	}
}
?>
