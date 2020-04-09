#!/usr/bin/env perl
use strict;
use warnings;
use File::Basename;
#use FindBin;
#print $FindBin . "\n";
#use lib $FindBin . "../../lib";
=pod
my $dir;
my $path = `which BtToxin_scanner`;
if ($path=~/(.+)\/BtToxin_scanner/) {
	$dir = $1;
}
=cut
#use lib dirname(__FILE__) . "../lib";
#my $path = dirname(__FILE__);
#my $own = $path . "../../lib";
#use lib "/home/lhl/miniconda3/envs/toxins/lib";
use lib dirname(__FILE__) . "/lib";

=pod
BEGIN  {
	my $dir;
	my $path = `which BtToxin_scanner`;
	if ($path=~/(.+)\/BtToxin_scanner/) {
		$dir = $1;
	}
#	my $dir = getcwd;
	push @INC, "$dir/lib";
	open(STDERR, ">&STDOUT");
	$| = 1;
	print '';
}
=cut
use own;
use File::Spec;
#use File::Copy;

system("mkdir -p Results/Toxins");
system("mkdir -p tmp");
my $input = shift;
my $output = shift;
my $seq_type = shift;
my @results;
my $download_dir = "./Results/Toxins/";
#my $CGI_RELEASE = "BtToxin_scanner: A Bt toxin exploration tool";

my $target_file = File::Spec->catfile("./tmp/", $output);
if(!system("cp $input $target_file"))  {
	@results = own::BtToxin_scanner($output, $seq_type, $target_file);
	foreach (@results)  {
		system("mv $_ $download_dir");
	}
	system("rm -f tmp/*");
}
