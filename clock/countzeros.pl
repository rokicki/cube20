while (<>) {
   chomp ;
   my $seq = $_ ;
   @f = split " ", $_ ;
   my $zeros = 0 ;
   for (@f) {
      $zeros++ if !$_ ;
   }
   if ($zeros >= 6) {
      print "$zeros $seq\n" ;
   }
}
