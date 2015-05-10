<?php

/*
Name: query_search.php
Description: Class to retrieve search queries detail information.
*/

class query_search extends orm{
	public $called_class = "query_search";

	public function save(){
		$this->count++;
		$this->last_referenced = time();

		return parent::save();
	}
}