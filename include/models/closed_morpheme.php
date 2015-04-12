<?php

/*
Name: closed_morpheme.php
Description: Class to retrieve function closed class morpheme information.
*/

class closed_morpheme extends orm{
   public $called_class = "closed_morpheme";
   
   public function save(){
      return parent::save();
   }

   public function delete(){
      $keyword = new keyword();
      $this->remove( $keyword );

      return parent::delete();
   }
}
?>
