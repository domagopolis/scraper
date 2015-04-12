<?php
$db=mysql_connect ("10.5.42.14", "u5392_websearch", "subl27") or die ('I cannot connect to the database because: ' . mysql_error());
mysql_select_db ("db5392_websearch");

$domain = "http://".$_SERVER['HTTP_HOST'];
$path = "websearch";
$document_root_path = $_SERVER['DOCUMENT_ROOT']."/";
$system_root_path = str_replace( 'websearch.domagi.com/', '', $document_root_path );
$google_map_key = "ABQIAAAA2XRzvzOJ2Nnp2HkiclChvxT2yXp_ZAY8_ufC3CFXhHIE1NvwkxQnKJKyXQhvSmjujsUeTYLVDTmxGA";
?>
