<?php include('include/general.php'); ?>
<?php
$fd = fopen( "languages.csv", "r" );

$field_arr = fgetcsv($fd, 1024);

var_dump($field_arr);echo '<br><br>';

$field_arr = fgetcsv($fd, 1024);

var_dump($field_arr); echo '<br><br>';

fclose($fd);
?>