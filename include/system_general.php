<?php
$db=mysql_connect ("localhost", "root", "root") or die ('I cannot connect to the database because: ' . mysql_error());
mysql_select_db ("websearch");

$domain = "http://".$_SERVER['HTTP_HOST'];
$path = "websearch";
$system_root_path = $_SERVER['DOCUMENT_ROOT']."/";
$document_root_path = $_SERVER['DOCUMENT_ROOT']."/".$path."/";
?>