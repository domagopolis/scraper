<?php

/*
Name: utterance.php
Description: Class to retrieve utterances.
*/

class utterance extends orm{
	public $called_class = "utterance";

	public function tokenise_syntax( $str1=FALSE, $str2=FALSE ){
		$last_score = 0;
		$temp = '';

		do{
			$score = levenshtein($str1, $str2);
			if( $last_score !== $score and $last_score > 0 ){
				$temp .= $char1;
			}
			if( $score > 0 ){
				$char1 = substr( $str1, 0, 1 );
				$char2 = substr( $str2, 0, 1 );
				$str1 = substr( $str1, 1 );
				$str2 = substr( $str2, 1 );
			}

			if( $score === 0 ) break;

			$last_score = $score;
		}while( sizeof( $str1 ) > 0 );

		var_dump( $temp );
		return true;
	}

	public function tokenise_morph( $str=FALSE ){
		var_dump($str);
		$keywords = array();
		$language = new language;

		for ($i = 0; $i < strlen( $str ); $i++){
			for ($j = 0; $j < strlen( $str ); $j++){
				for ($k = 1; $k < strlen( $str ); $k++){
					if( $i !== $j and substr( $str, $i, $k ) === substr( $str, $j, $k ) ){
						$keyword = substr( $str, $i, $k );
						$token_keyword = new keyword;
						$token_keyword->where( array( 'keyword' => $keyword ) )->find();
						if( $token_keyword->language_id ) $language->language_id = $token_keyword->language_id;
						if( array_key_exists( $keyword, $keywords ) ){
							//$token_keyword->count++;
							//$keywords[$keyword]++;
						}else{
							$token_keyword->keyword = $keyword;
							$token_keyword->language_id = $language->language_id;
							//$keywords[$keyword] = 0;
						}
						$token_keyword->save();
						$keywords[$keyword] = $token_keyword->keyword_id;
					}
				}
			}
		}
		
		foreach( $keywords as $keyword1 => $keyword_id1 ){
			foreach( $keywords as $keyword2 => $keyword_id2 ){
				$morpheme = new morpheme;
				$morpheme->where( array( 'keyword_id' => $keyword_id1, 'linked_keyword_id' => $keyword_id2 ) )->find();
				if( $morpheme->morpheme_id ){
					$morpheme->weight++;
				}else{
					$morpheme->keyword_id = $keyword_id1;
					$morpheme->linked_keyword_id = $keyword_id2;
				}
				$morpheme->save();
			}
			echo '<br>'; var_dump($keyword1, $keyword_id1); 
		}

		return true;
	}

	public function query_search( $query=FALSE, $type=FALSE, $language=NULL ){

		$results = array();

		$this->select( array( '*', 'rank' => 'MATCH(utterance) AGAINST ( \'*'.$query.'*\' IN BOOLEAN MODE)' ) );
		$this->order_by( array( 'rank' => 'DESC' ) );
		$this->having( array( 'rank>' => 0 ) );
		$this->where( array( 'language_id' => $language->language_id ) );
		$this->limit(30);
		$this->find_all();

		foreach( $this->utterance_arr as $utterance ){
			if( $type === 'image' ){
				$cached_image_urls = $utterance->cached_image_urls;
				foreach( $cached_image_urls->cached_image_url_arr as $cached_image_url ){
					$results[$cached_image_url->cached_image_url_id] = array( 'link' => $cached_image_url->url, 'name' => $utterance->utterance, 'summary' => $utterance->utterance, 'cached_time' => $cached_image_url->cached_time );
				}
			}else{
				$cached_urls = $utterance->cached_urls;
				foreach( $cached_urls->cached_url_arr as $cached_url ){
					$title_str = $cached_url->url;
					$utterances = $cached_url->where( array( 'format' => 'title' ) )->limit( 1 )->utterances;
					foreach( $utterances->utterance_arr as $title ){ $title_str = $title->utterance; }
					$results[$cached_url->cached_url_id] = array( 'link' => $cached_url->url, 'name' => $title_str, 'summary' => $utterance->utterance, 'cached_time' => $cached_url->cached_time );
				}
			}
		}

		return $results;
	}
}
?>