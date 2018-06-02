while (<>) {
   chomp ;
   my $seq = $_ ;
   @f = split " ", $_ ;
   my %seen = () ;
   for (@f) {
      $seen{$_}++ ;
   }
   if (keys %seen < 6) {
      my $v = keys %seen ;
      print "$v $seq\n" ;
   }
}
