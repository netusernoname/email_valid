#!/usr/bin/perl -w
use Email::Valid;

my $file_email = 'email.txt';
my $file_email_good = 'good.txt';
my $file_email_bad = 'bad.txt';

my @list = readfile($file_email);

foreach my $email (@list){
  print "[?] Checking : $email\n";
  if(Email::Valid->address($email)){
	print "[+] GOOD : $email\n";
	writefile($file_email_good, $email."\n");
  }else{
	print "[-] BAD : $email\n";
	writefile($file_email_bad, $email."\n");
  }
}


sub writefile{
  open F, ">>".$_[0] or die $!;
  print F $_[1];
  close F;
}

sub readfile{
  my %var;
  open F, $_[0] or die $!;
  while(<F>){
  	my $line = $_;
  	$line =~ s/\r?\n//ig;
  	$var{$line} = 1;
  }
  close F;
  return keys(%var);
}