<?php include('include/general.php'); ?>
<?php
$scan_cached_urls = new cached_url();
$time_filter = time() - 60*60*24;
$scan_cached_urls->where( array( 'cached_time<' => $time_filter ) )->order_by( array( 'cached_time', 'cached_url_id' ) )->limit(2)->find_all();
foreach( $scan_cached_urls->cached_url_arr as $scan_cached_url ){
   $scan_cached_url->cached_time = time();
   $scan_cached_url->save();
   }
foreach( $scan_cached_urls->cached_url_arr as $scan_cached_url ){
   $scan_cached_url->scan_url();
   }
?>