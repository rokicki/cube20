for $file (glob "golomb-* modrules-* rulers-*") {
   next if $file =~ /zip/ ;
   system("zip $file.zip $file") ;
   unlink($file) ;
}
