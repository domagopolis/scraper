<?php

/*
Name: domain.php
Description: Class to retrieve domain url information.
*/

class domain extends orm{
	public $called_class = "domain";

	public function __get( $key ){
		if( $key === "domain" ){
			$domain_str = $this->scheme.'://'.$this->host;
			if( $this->port ) $domain_str .= ':'.$this->port;
			return $domain_str;
		}else{
			return parent::__get( $key );
			}
	}

	public function get_parsed_domain( $parsed=array() ){
		if( !array_key_exists('scheme', $parsed) ) $parsed['scheme'] = 'http';

		$domain_str = $parsed['scheme'].'://'.$parsed['host'];
		if( array_key_exists( 'port', $parsed ) AND !empty( $parsed['port'] ) ) $domain_str .= ':'.$parsed['port'];

		$conditions = array( 'scheme' => $parsed['scheme'], 'host' => $parsed['host'] );
		if( array_key_exists( 'port', $parsed ) AND !empty( $parsed['port'] ) ) $conditions['port'] = $parsed['port'];
		$this->where( $conditions )->find();
		if( !$this->domain_id ){
			$this->scheme = $parsed['scheme'];
			$this->host = $parsed['host'];
			if( array_key_exists( 'port', $parsed ) AND !empty( $parsed['port'] ) ) $this->port = $parsed['port'];
			$this->save();
		}
	}
}
?>
