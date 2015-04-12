<?php include('include/general.php'); ?>
<?php
$scan_cached_url = new cached_url();
$time_filter = time() - 60*60*24;
$scan_cached_url->where( array( 'cached_time<' => $time_filter ) )->order_by( array( 'cached_time', 'cached_url_id' ) )->find();
$scan_cached_url->cached_time = time();
$scan_cached_url->save();
$scan_cached_url->scan_url();
?>