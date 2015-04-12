<?php

/*
Name: language.php
Description: Class to retrieve language list.
*/

class language extends orm{
	public $called_class = "language";

	public function extract_html_lang( $content='' ){
		preg_match( '/<html[^>]+>/i', $content, $html );

		if( strlen( $html[0] ) ){
			preg_match_all( '/(lang|xml:lang)=("[^"]*")/i', $html[0], $html_tags );
			foreach($html_tags[0] as $html_tag ){
				if( strstr( $html_tag, 'lang=' ) ){
					$lang = str_replace( '"', '', str_replace('lang=', '', $html_tag ) );
					$lang = substr($lang, 0, 2);
					$this->where( array( 'iso2letter' => $lang ) )->find();
				}
			}
		}
	}
}
?>