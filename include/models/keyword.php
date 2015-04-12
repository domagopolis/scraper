<?php

/*
Name: keyword.php
Description: Class to retrieve state province detail information.
*/

class keyword extends orm{
   public $called_class = "keyword";

   public $lexicon = array();
   
   public function save(){
      $this->count++;
      $this->last_referenced = time();

      return parent::save();
   }

   public function delete(){
      $cached_url = new cached_url();
      $this->remove( $cached_url );
      $cached_image_url = new cached_image_url();
      $this->remove( $cached_image_url );

      return parent::delete();
   }

   public function clear_keywords(){

      $this->select( array( 'keyword_sum' => 'sum(count)',  'keyword_count' => 'count(keyword_id)' ) )->find();
      $this->keyword_count;

      $last_timestamp = time();
      $limit = 10000;
      $max_time_gap = 0;
      for( $i = 0; $i <= $this->keyword_count; $i += $limit ){
         $this->select( array( 'keyword_id', 'last_referenced' ) )->order_by( array( 'last_referenced' => 'desc' ) )->limit( $i, $limit )->find_all();
         foreach( $this->keyword_arr as $keyword ){
            $gap_sum += $last_timestamp - $keyword->last_referenced;

            if( $max_time_gap <= $last_timestamp - $keyword->last_referenced ){
               $max_time_gap = $last_timestamp - $keyword->last_referenced;
            }

            $last_timestamp = $keyword->last_referenced;
         }
      }

      $gap_avg = $gap_sum / ($this->keyword_count);

      $std_sum = 0;
      $last_timestamp = 0;
      for( $i = 0; $i <= $this->keyword_count; $i += $limit ){
         $this->select( array( 'keyword_id', 'last_referenced' ) )->order_by( array( 'last_referenced' => 'desc' ) )->limit( $i, $limit )->find_all();
         foreach( $this->keyword_arr as $keyword ){
            $std_sum += pow( ( $keyword->last_referenced - $last_timestamp ) - $gap_avg, 2 );

            $last_timestamp = $keyword->last_referenced;
         }
      }

      $std_dev = sqrt( $std_sum / ($this->keyword_count) );

      $days = ( $std_dev * 3 )/60/60/24;

      var_dump($std_dev, $gap_avg, $gap_sum, $max_time_gap, $days );exit;

      $this->select( array( 'keyword_id', 'count', 'last_referenced' ) )->where( array( 'last_referenced<=' => ( time() - ( 60*60*24*$days ) ) ) )->limit( 5000 )->find_all();
      foreach( $this->keyword_arr as $keyword ){
         $keyword->count -= $days;
         $keyword->last_referenced = time();
         if( $keyword->count <= 0 ){
            $keyword->delete();
         }else{
            $keyword->save();
         }
      }
   }

   public function query_search( $query=FALSE, $type=FALSE ){
      $results = array();

      $keywords = explode( ' ', $query );
      
      $this->where_or( array( 'keyword' => $query ) );
      $keywords_arr = array();
      foreach( $keywords as $keyword ){
         $keywords_arr[] = '"'.$keyword.'"';
         }
      //$this->where_or( array( 'keyword REGEXP' => implode( '|', $keywords_arr ) ) );
      $this->where_or( array( 'keyword IN' => implode( ',', $keywords_arr ) ) );
      $this->find_all();
      
      foreach( $this->keyword_arr as $keyword ){
         if( $type === 'image' ){
            $urls = $keyword->group_by( array( 'cached_image_url_id' ) )->order_by( array( 'cached_time' => 'DESC' ) )->limit(10)->cached_image_urls;
            foreach( $urls->cached_image_url_arr as $cached_image_url ){
               $cached_image_urls_keywords = new cached_image_urls_keyword();
               $cached_image_urls_keywords->where( array( 'cached_image_url_id' => $cached_image_url->cached_image_url_id ) )->limit(10)->find_all();
               $summary = array();
               foreach( $cached_image_urls_keywords->cached_image_urls_keyword_arr as $cached_image_urls_keyword ){
                  $summary[] = $cached_image_urls_keyword->keyword_id;
                  if( sizeof( $summary ) > 20 )
                     array_shift( $summary );
                  if( $summary[10] === $keyword->keyword_id )
                     break;
               }
               
               $summary_txt = '...';
               foreach ( $summary as $keyword_id ) {
                  $summary_keyword = new keyword( $keyword_id );
                  $summary_txt .= $summary_keyword->keyword.' ';
               }
               $summary_txt .= '...';

               $results[] = array( 'link' => $cached_image_url->url, 'name' => $keyword->keyword, 'summary' => $summary_txt, 'cached_time' => $cached_image_url->cached_time );
            }
         }else{
            $urls = $keyword->group_by( array( 'cached_url_id' ) )->order_by( array( 'cached_time' => 'DESC' ) )->limit(10)->cached_urls;
            foreach( $urls->cached_url_arr as $cached_url ){
               $cached_urls_keywords = new cached_urls_keyword();
               $cached_urls_keywords->where( array( 'cached_url_id' => $cached_url->cached_url_id ) )->find_all();
               $summary = array();
               foreach( $cached_urls_keywords->cached_urls_keyword_arr as $cached_urls_keyword ){
                  $summary[] = $cached_urls_keyword->keyword_id;
                  if( sizeof( $summary ) > 20 )
                     array_shift( $summary );
                  if( $summary[10] === $keyword->keyword_id )
                     break;
               }
               
               $summary_txt = '...';
               foreach ( $summary as $keyword_id ) {
                  $summary_keyword = new keyword( $keyword_id );
                  $summary_txt .= $summary_keyword->keyword.' ';
               }
               $summary_txt .= '...';

               $results[] = array( 'link' => $cached_url->url, 'name' => $keyword->keyword, 'summary' => $summary_txt, 'cached_time' => $cached_url->cached_time );
            }
         }
      }

      return $results;
   }

   public function create_lexicon(){

      $this->select( array( 'keyword_id', 'keyword' ) )->where( array( 'count>=' => '80' ) )->order_by( array( 'count' => 'desc' ) )->find_all();

      foreach( $this->keyword_arr as $lookup_keyword ){
         $this->lexicon[ hash( 'md5', $lookup_keyword->keyword ) ] = $lookup_keyword->keyword;
      }
      //var_dump($this->lexicon);
   }
}
?>