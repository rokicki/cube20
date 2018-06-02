my $n = shift ;
@a = <> ;
for ($i=0; $i<$n; $i++) {
   print $a[int rand @a] ;
}
