<?php

/*
Name: affix.php
Description: Class to retrieve function closed class morpheme information.
*/

class affix extends orm{
   public $called_class = "affix";
   
	public function save(){
		$this->count++;
		$this->last_referenced = time();

		return parent::save();
	}

	public function delete(){
		$keyword = new keyword();
		$this->remove( $keyword );

		return parent::delete();
	}
}
?>
