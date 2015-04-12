<?php include('include/general.php'); ?>
<?php
$str1 = 'the cat sat on the mat.';
$str2 = 'the dog also sat on the mat.';
$str3 = 'An apple a day keeps the doctor away.';

$utterance = new utterance;
//$utterance->tokenise_syntax( $str1, $str2 );
$utterance->tokenise_morph( $str1.' '.$str2 );

/*$last_score = 0;
$truncate = true;
$temp = '';
$i = 0;
do{
	$score = levenshtein($str1, $str2);
	if( $last_score > 0 ){
		;
	}
	if( $score > $last_score || $score < $last_score ){
		if( $truncate ){
			$char2 = substr( $str2, 0, 1 );
			$str2 = substr( $str2, 1 );
		}else{
			$char1 = substr( $str1, 0, 1 );
			$str1 = substr( $str1, 1) ;
		}
		$truncate = !$truncate;
	}else if( $score === $last_score ){
		$temp .= $char1;
	}

	var_dump($score, $last_score, $str1, $str2);echo '<br>';
	$last_score = $score;
	$i++;

}while( $i < 20 );
var_dump($score, $temp);echo '<br>';*/
return false;
$utterances = new utterance;
$utterances->find_all();
foreach( $utterances->utterance_arr as $utterance ){
	if( sizeof( $utterance->utterance ) < 100 ){
		$score = levenshtein($utterance->utterance, 'Sunday, April 27');
		if( $score < 10 ){
			var_dump($utterance->utterance, $score );
			echo '<br><br>';
		}
	}
}