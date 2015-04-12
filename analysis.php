<?php include('include/general.php'); ?>
<?php
$total_keywords = new keyword();
$total_keywords->select( array( 'keyword_sum' => 'sum(count)',  'keyword_count' => 'count(keyword_id)' ) )->find();
$average_count = floor( $total_keywords->keyword_sum / $total_keywords->keyword_count );
$keywords = new keyword();
$keywords->select( array( 'keyword_id', 'keyword' ) )->where( array( 'count>=' => $average_count ) )->order_by( array( 'last_referenced' => 'DESC' ) )->find_all();
$affix_count = array();
echo 'Word count: '.sizeof($keywords->keyword_arr ).'<br><br>';
foreach( $keywords->keyword_arr as $keyword ){
  $key_word_str = $keyword->keyword;
  do{
  $similar_keywords = new keyword();
  $similar_keywords->select( array( 'keyword_id', 'keyword' ) )->where( array( 'keyword' => '%'.$key_word_str.'%', 'keyword_id<>' => $keyword->keyword_id, 'count>=' => $average_count ) )->limit(500)->find_all();
  foreach( $similar_keywords->keyword_arr as $similar_keyword ){
    $affix_str = str_replace( $key_word_str, '', $similar_keyword->keyword );
    if( substr( $similar_keyword->keyword, 0, strlen( $affix_str ) ) === $affix_str ){
      $affix_str = $affix_str.'-';
    }
    if( substr( $similar_keyword->keyword, -strlen( $affix_str ), strlen( $affix_str ) ) === $affix_str){
      $affix_str = '-'.$affix_str;
    }

    if( strstr( $affix_str, '-' ) AND $affix_str !== '-' ){
      $affix = new affix();
      $affix->where( array( 'keyword' => $affix_str ) )->find();
      $affix->keyword = $affix_str;
      $affix->save();

      $keyword->remove( $affix );
      $keyword->add( $affix );
    }
  }

  $key_word_str = substr( $key_word_str, 0, strlen( $key_word_str ) - 1 );
  }while( strlen( $key_word_str ) > 0 AND sizeof( $similar_keywords->keyword_arr ) > 0 );
}

echo 'deleting';exit;

$affixes= new affix();
$affixes->where( array( 'count' => 0 ) )->find_all();
foreach( $affixes->affix_arr as $affix ){
  $affix->delete();
  }

$matrix = array();
$count = 0;
foreach( $keywords->keyword_arr as $keyword ){
  $affixes = $keyword->affixes;
  if( sizeof($affixes->affix_arr ) > 1 ){
    foreach( $affixes->affix_arr as $affix ){
        if( $affix->count >= 100 ){
          $matrix[$keyword->keyword][$affix->keyword] = true;
        }
      }
    }
  }

//SELECT keyword_id, count(keyword_id) as total FROM closed_morphemes_keywords group by keyword_id ORDER BY `total` desc
//SELECT closed_morpheme_id, count(closed_morpheme_id) as total FROM closed_morphemes_keywords group by closed_morpheme_id ORDER BY `total` desc

$affix_arr = array();
foreach( $matrix as $morph => $affixes ){
  $affix_arr = array_merge( $affixes, $affix_arr );
}

echo '<table border="1">';
echo "<th>Word</th>";
foreach( $affix_arr as $affix => $value ){
  echo '<th>'.$affix.'</th>';
  }

foreach( $matrix as $morph => $affixes ){
  echo '<tr><td>'.$morph.'</td>';
  foreach( $affix_arr as $affix => $value ){
    $result = '&nbsp;';
    if( $affixes[$affix] ) $result = $affix;
    $keyword = new keyword();
    if( strpos( $affix, '-' ) === 0 ) $keyword->where( array( 'keyword' => $morph.str_replace('-', '', $affix ) ) )->find();
    if( $keyword->keyword_id ) $result = $affix;
    //if( strpos( $affix, '-' ) === 0 ) $keyword->where( array( 'keyword' => substr( $morph, 0, strlen( $morph )-1).str_replace('-', '', $affix ) ) )->find();
    //if( $keyword->keyword_id ) $result = $affix;
    echo '<td>'.$result.'</td>';
  }
  echo '</tr>';
}
echo '</table>';

echo 'Finished';
?>