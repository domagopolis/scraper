<?php

/*
Name: cached_url.php
Description: Class to retrieve state province detail information.
*/

class cached_url extends orm{
   	public $called_class = "cached_url";

	public function __get( $key ){
		if( $key === "url" ){
			return $this->domain->domain.$this->path.( ( $this->query )?'?'.$this->query:'' );
		}else{
			return parent::__get( $key );
			}
	}

	public function save(){
		if( $this->cached_url_id ){
			$this->cached_time = time();
		}

		return parent::save();
	}

	public function scan_url(){

		$handle = @fopen( $this->url, "r" );
		var_dump($this->url);

		$lexicon_keywords = new keyword;
		$lexicon_keywords->create_lexicon();

		if ($handle) {

			$content = '';
			while (($file = fgets($handle, 4096)) !== false) {
				$content .= trim($file);
			}
			$encoding = mb_detect_encoding( $content, array( "UTF-8", "UTF-32", "UTF-32BE", "UTF-32LE", "UTF-16", "UTF-16BE", "UTF-16LE" ), TRUE );

			if( $encoding !== "UTF-8" ) {
				$content = mb_convert_encoding( $content, "UTF-8", $encoding );
			}

			//Extract links
			$regexp = "<a\s[^>]*href=(\"??)([^\" >]*?)\\1[^>]*>(.*)<\/a>";
			preg_match_all( "/$regexp/siU", $content, $matches );

			foreach( $matches[2] as $key => $match ){

				$parsed = parse_url( $match );

				if( !array_key_exists('path', $parsed) ) $parsed['path'] = '/';
				if( !array_key_exists('port', $parsed) ) $parsed['port'] = null;
				if( !array_key_exists('query', $parsed) ) $parsed['query'] = null;

				if( substr( $parsed['path'], 0, 1 ) === '/' ){
					$parsed_domain = parse_url( $this->url );
				}else{
					$parsed_domain = parse_url( $this->domain->domain );
					$parsed['path'] = str_replace($this->domain->domain, '', substr( $this->url, 0, strrpos($this->url, '/') + 1 ) ).$parsed['path'];
				}

				if( !array_key_exists('port', $parsed_domain) ) $parsed_domain['port'] = '';

				if( empty( $parsed['host'] ) ){
					$parsed['scheme'] = $parsed_domain['scheme'];
					$parsed['host'] = $parsed_domain['host'];
					$parsed['port'] = $parsed_domain['port'];
				}

				$domain = new domain;
				$domain->get_parsed_domain( $parsed );

				$cached_url = new cached_url;
				$cached_url->where( array( 'domain_id' => $domain->domain_id, 'path' => $parsed['path'], 'query' => $parsed['query'] ) )->find();
				if( !$cached_url->cached_url_id ){
					$cached_url->domain_id = $domain->domain_id;
					$cached_url->path = $parsed['path'];
					$cached_url->query = $parsed['query'];
					$cached_url->save();
				}

				if( !empty( $parsed['query'] ) ) {
					$query = new query();
					$query->save_query( $parsed['query'] );
					$cached_url->add( $query );

					$query_str = $query->query_str( $cached_url );
				}
			}
          
			$content = preg_replace("/<script\b[^>]*>(.*?)<\/script>/is", "", $content);

			$language = new language;
			$language->extract_html_lang( $content );

			cached_image_url::extract_images( $this, $content, $language );

			preg_match( '/<title\b[^>]*>(.*?)<\/title>/is', $content, $title_arr );
			if( strlen( $title_arr[1] ) ){

				$utterance = new utterance;
				$utterance->format = 'title';
				$utterance->where( array( 'utterance' => $title_arr[1], 'format' => $utterance->format ) )->find();
				if( !$utterance->utterance_id ){
					$utterance->language_id = $language->language_id;
					$utterance->utterance = $title_arr[1];
					$utterance->save();
				}

				$this->add( $utterance );
				
				$words = explode( ' ', $title_arr[1] );
				foreach( $words as $word ){
					if( strlen( $word ) ){
						$keyword = new keyword;
						$keyword->where( array( 'keyword' => $word ) )->find();
						$keyword->language_id = $language->language_id;
						$keyword->keyword = $word;
					}
				}
			}

			preg_match_all( '/(<p\b[^>]*>(.*?)<\/p>|<h[0-6]\b[^>]*>(.*?)<\/h[0-6]>)/is', $content, $content_arr );
			foreach ( $content_arr[0] as $content_segment ) {

				$utterance = new utterance;
				if( preg_match( '/(<h[0-6]\b[^>]*>(.*?)<\/h[0-6]>)/is', $content_segment ) ) $utterance->format = 'heading';
				if( preg_match( '/(<p\b[^>]*>(.*?)<\/p>)/is', $content_segment ) ) $utterance->format = 'paragraph';
				$content_segment = strip_tags( $content_segment );
				$utterance->where( array( 'utterance' => $content_segment, 'format' => $utterance->format ) )->find();
				if( !$utterance->utterance_id ){
					$utterance->language_id = $language->language_id;
					$utterance->utterance = $content_segment;
					$utterance->save();
				}

				$this->add( $utterance );

				$words = explode( ' ', $utterance->utterance );
				for( $i=1; $i<strlen( $utterance->utterance ); $i++ ){
					$substr = strtolower( substr($utterance->utterance, 0, $i ) );
					if( array_key_exists( hash( 'md5', $substr ), $lexicon_keywords->lexicon ) ){
						$utterance->utterance = str_replace( $substr, '', $utterance->utterance );
					}
				}

				foreach( $words as $word ){
					if( strlen( $word ) ){
						$keyword = new keyword;
						$keyword->where_or( array( 'language_id' => $language->language_id, 'language_id IS' => 'null' ) )->where( array( 'keyword' => $word ) )->find();
						$keyword->language_id = $language->language_id;
						$keyword->keyword = $word;
						$keyword->save();

						$this->add( $keyword );

						/*$morpheme = new morpheme;
						$morpheme->where( array( 'keyword_id' => $keyword->keyword_id, 'linked_keyword_id' => $last_keyword->keyword_id ) )->find();
						$morpheme->keyword_id = $keyword->keyword_id;
						$morpheme->linked_keyword_id = $last_keyword->keyword_id;
						$morpheme->weight++;
						$morpheme->save();*/

						$last_keyword = $keyword;
					}
				}
			}
		}
	}
}