$sum = 0 ;
while (<>) {
   chomp ;
   s/:/ /g ;
   @f = split " ", $_ ;
   push @a, [@f] ;
   $sum += $f[1] ;
}
sub commafy {
   my $v = shift ;
   return $v if length($v) <= 3 ;
   return commafy(substr($v, 0, length($v)-3)) . "," .
                  substr($v, length($v)-3) ;
}
@mw = () ;
sub updatew {
   my @a = @_ ;
   my $i ;
   for ($i=0; $i<@a; $i++) {
      $mw[$i] = length($a[$i]) if !defined($mw[$i]) || length($a[$i]) > $mw[$i] ;
   }
}
for ($i=0; $i<@a; $i++) {
   @{$a[$i]} = map { commafy($_) } @{$a[$i]} ;
   updatew(@{$a[$i]}) ;
}
updatew((0, commafy($sum))) ;
sub sendnum {
   my $w = shift ;
   my $v = shift ;
   print " " x ($w-length($v)) ;
   print $v ;
}
for ($i=0; $i<@a; $i++) {
   for ($j=0; $j<2; $j++) {
      print " " if $j ;
      sendnum($mw[$j], $a[$i][$j]) ;
   }
   print "\n" ;
}
print " " x $mw[0] ;
print " " ;
sendnum($mw[1], commafy($sum)) ;
print "\n" ;
