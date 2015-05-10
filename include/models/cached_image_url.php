<?php

/*
Name: cached_image_url.php
Description: Class to retrieve image details.
*/

class cached_image_url extends orm{
   	public $called_class = "cached_image_url";

	public function __get( $key ){
		if( $key === "url" ){
		return $this->domain->domain.$this->path.( ( $this->query )?'?'.$this->query:'' );
	}else{
		return parent::__get( $key );
		}
	}

	public function save(){
		if( !$this->cached_image_url_id ){
			$this->cached_time = time();
		}

		return parent::save();
	}

	public static function extract_images( $cached_url = null, $content=FALSE, $language=NULL ){
		preg_match_all( '/<img[^>]+>/i', $content, $images );
		foreach( $images[0] as $image ){
			preg_match_all( '/(alt|title|src)=("[^"]*")/i', $image, $image_tags );
			foreach($image_tags[0] as $image_tag ){
				$image_tag = str_replace('"', '', $image_tag);
				if( strstr( $image_tag, 'src=' ) ) $image_src = str_replace('src=', '', $image_tag );
				if( strstr( $image_tag, 'alt=' ) ) $image_alt = str_replace('alt=', '', $image_tag );
				if( strstr( $image_tag, 'title=' ) ) $image_title = str_replace('title=', '', $image_tag );
			}
			if( !empty( $image_alt ) ){
				
				if( substr($image_src, 0, 2) == '//' ) $image_src = 'http:'.$image_src;

				$parsed = parse_url( $image_src );

				if( !array_key_exists('port', $parsed) ) $parsed['port'] = null;
				if( !array_key_exists('query', $parsed) ) $parsed['query'] = null;

				if( substr( $parsed['path'], 0, 1 ) === '/' ){
					$parsed_domain = parse_url( $cached_url->url );
				}else{
					$parsed_domain = parse_url( $cached_url->domain->domain );
					$parsed['path'] = str_replace($cached_url->domain->domain, '', substr( $cached_url->url, 0, strrpos($cached_url->url, '/') + 1 ) ).$parsed['path'];
				}

				if( !array_key_exists('port', $parsed_domain) ) $parsed_domain['port'] = '';

				if( empty( $parsed['host'] ) ){
					$parsed['scheme'] = $parsed_domain['scheme'];
					$parsed['host'] = $parsed_domain['host'];
					$parsed['port'] = $parsed_domain['port'];
				}

				if( !array_key_exists('scheme', $parsed) ) $parsed['scheme'] = 'http';

				if( array_key_exists('scheme', $parsed) ){
					$domain = new domain;
					$domain->get_parsed_domain( $parsed );
					
					$cached_image_url = new cached_image_url;
					$cached_image_url->where( array( 'domain_id' => $domain->domain_id, 'path' => $parsed['path'], 'query' => $parsed['query'] ) )->find();
					if( !$cached_image_url->cached_image_url_id ){
						$cached_image_url->domain_id = $domain->domain_id;
						$cached_image_url->path = $parsed['path'];
						$cached_image_url->query = $parsed['query'];
						$cached_image_url->save();
					}

					if( !empty( $parsed['query'] ) ) {
						$query = new query();
						$query->save_query( $parsed['query'] );
						$cached_image_url->add( $query );

						$query_str = $query->query_image_str( $cached_image_url );
					}

					$utterance = new utterance;
					$utterance->where( array( 'utterance' => $image_alt, 'format' => 'alt' ) )->find();
					if( !$utterance->utterance_id ){
						$utterance->language_id = $language->language_id;
						$utterance->utterance = $image_alt;
						$utterance->format = 'alt';
						$utterance->save();
					}

					$cached_image_url->add( $utterance );

					$words = explode( ' ', $image_alt );
					foreach( $words as $word ){
						$word = strtolower( preg_replace( "/[^A-Za-z1-9 ]/", '', $word ) );
						if( strlen( $word ) ){
							$keyword = new keyword;
							$keyword->where( array( 'keyword' => $word ) )->find();
							$keyword->keyword = $word;
							$keyword->save();

							$cached_image_url->add( $keyword );
						}
					}
				}
			}
		}
	}
}
?>