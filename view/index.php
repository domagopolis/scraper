<h2>Search</h2>
<?php $form->display_form(); ?>
<?php if( !empty( $query ) ){ ?>
<h3>Search results for "<?php echo $query; ?>"</h3>
<?php if( sizeof( $results ) > 0 ){ ?>
<ol data-role="listview">
<?php foreach( $results as $result ){ ?>
<li>
<?php if( array_key_exists( 'type', $_GET ) AND $_GET['type'] === 'image' ){ ?>
<a href="<?php echo $result['link']; ?>"><img src="<?php echo $result['link']; ?>" style="max-width: 100%;" /></a>
<?php }else{ ?>
<a href="<?php echo $result['link']; ?>"><h4><?php echo $result['name']; ?></h4></a>
<?php } ?>
<p><?php echo str_ireplace( $query, '<strong>'.$query.'</strong>', $result['summary'] ); ?></p>
<p><i><?php echo $result['link']; ?> (Last cached - <?php echo date( 'd/m/Y H:i:s', $result['cached_time'] ); ?>)</i></p>
</li>
<?php } ?>
</ol>
<?php }else{ ?>
<p>No Results found.</p>
<?php } ?>
<?php } ?>
