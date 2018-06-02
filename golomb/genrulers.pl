$|++ ;
my $th = shift ;
defined($th) or die "need thousands argument" ;
my $lab = $th ;
$lab = '0' . $th if $th < 10 ;
open F, "golomb-all-$lab" or die "Can't read golomb-all-$lab" ;
while (<F>) {
   chomp ;
   my ($n, $len, $co, $g, $m) = split " ", $_ ;
   $len[$n] = $len ;
}
close F ;
open F, ">rulers-all-$lab" or die "Can't write rulers-all-$lab" ;
for ($i=$th*1000; $i<($th+1)*1000; $i++) {
   next if !defined($len[$i]) ;
   my $r = `./getruler $i | tail -n 1` ;
   chomp $r ;
   print F "$i $len[$i]:$r\n" ;
   print $i % 10 == 0 ? $i : "." ;
}
close F ;
