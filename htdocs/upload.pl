#!/usr/bin/perl
#
#   sleep.
#
use CGI ;
$ENV{PATH} = "/bin:/usr/bin:/usr/X11R6/bin" ;
$workdir = "/kunden/homepages/5/d113153492/htdocs/uploads" ;
my $q = new CGI ;

chdir "$workdir" ;

$now = scalar time ;

sub sanitize {
   my $s = shift ;
   return undef() if !defined($s) ;
   $s =~ s/[^a-zA-Z0-9_]//g ;
   $s =~ /(.*)/ ;
   return $1 ;
}
#
print $q->header("text/html"),
      $q->start_html(-title => "UploadTest") ;
$uf = $q->upload('myfile') ;
if (defined($uf)) {
   my $fn = "$now-$$-upload.tst" ;
   open F, ">$fn" or die "Can't open temp file" ;
   binmode F ;
   my $len ;
   my $tot = 0 ;
   while (($len=sysread($uf, $a, 4096)) > 0) {
       syswrite(F, $a, $len) ;
       $tot += $len ;
   }
   close F ;
   print "Successfully uploaded file.<br>\n" ;
   print "Got $tot bytes.<br>\n" ;
   $sum = `md5sum $fn` ;
   print "md5 sum is $sum.<br>"
}
print "<form method=post action=\"/cgi-bin/upload.pl/submit\" ENCTYPE=\"multipart/form-data\">" ;
print "<input type=\"file\" name=\"myfile\"><br>\n" ;
print "<input type=submit>\n" ;
print "</form>" ;
print $q->end_html() ;
