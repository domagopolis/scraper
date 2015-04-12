<?php include('include/general.php'); ?>
<?php
$scan_cached_urls = new cached_url();
$scan_cached_urls->limit(1000)->find_all();
foreach( $scan_cached_urls->cached_url_arr as $scan_cached_url ){
  /*$parsed = parse_url( $scan_cached_url->url );
  $domain = new domain();
  $domain->where( array( 'domain' => $parsed['scheme'].'://'.$parsed['host'] ) )->find();
  $domain->domain = $parsed['scheme'].'://'.$parsed['host'];
  $domain->cached_time = time();
  $domain->save();

  $scan_cached_url->domain_id = $domain->domain_id;
  $scan_cached_url->path = $parsed['path'];
  $scan_cached_url->query = $parsed['query'];
  $scan_cached_url->save();*/
  }

$keyword = new keyword();
$keyword->clear_keywords();

$keywords = new keyword();
$keywords->where( array( 'last_referenced' => 0 ) )->limit(10000)->find_all();
foreach( $keywords->keyword_arr as $keyword ){
  $keyword->delete();
}
?>