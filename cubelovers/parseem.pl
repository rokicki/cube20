my @f = ((glob "cube-mail-?.txt"), (glob "cube-mail-??.txt"), "recent-mail.txt") ;
my @store ;
my $fileno = 0 ;
my $dirname = '' ;
my $msgnum = 0 ;
my $date = undef ;
my $from = undef ;
my $subject = undef ;
sub newfile {
   my $name = $fileno++ ;
   $name = '0' . $name if $name < 10 ;
   $name = "CL$name" ;
   $dirname = $name ;
   $msgnum = 0 ;
   mkdir $dirname ;
}
sub makelink {
   my $url = shift ;
   my $desc = shift ;
   $desc =~ s/\&/\&amp;/g ;
   $desc =~ s/</\&lt;/g ;
   $desc =~ s/>/\&gt;/g ;
   print "<a href=\"$url\">$desc</a><br>\n" ;
}
sub newmsg {
   my $msg = $msgnum++ ;
   $msg = '0' . $msg while length($msg) < 3 ;
   open G, ">$dirname/$msg.txt" or die "Can't write $dirname/$msg.txt" ;
   print G @store ;
   close G ;
   makelink("$dirname/$msg.txt", "$date $from $subject") ;
}
for $f (@f) {
   newfile() ;
   open F, $f or die "Can't read $f" ;
   @store = () ;
   my $state = 1 ;
   while (<F>) {
      if (/^Date: (\S.*\S)/i) {
         $date = $1 ;
      }
      if (/^From: (\S.*\S)/i) {
         $from = $1 ;
      }
      if (/^Subject: (\S.*\S)/) {
         $subject = $1 ;
      }
      if (/^From/ && $state == 2) {
         newmsg() if @store ;
         @store = () ;
         push @store, $_ ;
         $state = 1 ;
      } elsif (/\x1f/) {
         newmsg() if @store ;
         @store = () ;
         $state = 1 ;
      } elsif (/^\s*$/ && $state == 1) {
         $state = 2 ;
         push @store, $_ ;
      } else {
         push @store, $_ ;
      }
   }
   newmsg() if @store ;
}
