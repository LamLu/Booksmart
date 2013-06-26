<?php
$name = "lam p       lu";

$name2 = "lam lu";
var_dump($name);
echo '<br />';
$name = preg_replace("/\s+/", " ", $name);
$name = str_replace (" ", "%", $name);
var_dump ($name);
echo '<br />';
var_dump ($name2);



/*
select b.title, b.edition, b.isbn_10, b.isbn_13, a.first_name, a.middle_name, a.last_name from author a, book b, author_book ab where a.id = ab.author_id and b.id = ab.book_id and (CONCAT (a.first_name, a.middle_name, a.last_name) like "lam%lu" or (CONCAT (a.last_name, a.middle_name, a.first_name) like "lam%lu"))
*/
?>

