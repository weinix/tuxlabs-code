#!/usr/bin/perl

use strict;
use LWP::Simple;
use File::Path qw( make_path );

my $URL='http://your_url_goes_here';

my $NEW_HOST_ALL_FILE;
my $CURRENT_HOST_ALL_FILE;
my $SAVED_HOST_ALL_FILE;


my $date=time();

my $RUNNER_DIR = 'hosts';

if ( !-d $RUNNER_DIR ) {
    make_path $RUNNER_DIR or die "Failed to create path: $RUNNER_DIR";
}

$NEW_HOST_ALL_FILE="$RUNNER_DIR/hosts-all.new";
$CURRENT_HOST_ALL_FILE="$RUNNER_DIR/hosts-all";
$SAVED_HOST_ALL_FILE="$RUNNER_DIR/hosts-all.$date";

print "Getting hosts from $URL\n";
my $content = get($URL);
if (! defined $content) {
	die "Couldn't get $URL" ;
	exit 2;
}

# Strip out HTML and spaces
my @hosts=split(/<br>/,$content);
open (HOST_FILE,"> $NEW_HOST_ALL_FILE");
foreach my $line (@hosts) {
	chomp $line;
	$line =~ s/\s+//;
	print HOST_FILE "$line\n";
}
close (HOST_FILE);

if ( (-f $CURRENT_HOST_ALL_FILE) && (-f $NEW_HOST_ALL_FILE) ) {
	if ( ! rename($CURRENT_HOST_ALL_FILE, $SAVED_HOST_ALL_FILE) ) {
		print "Problem saving $CURRENT_HOST_ALL_FILE to $SAVED_HOST_ALL_FILE\n. Exiting.";
		exit 3;
	}
	else {
		print "$CURRENT_HOST_ALL_FILE has been backed up to $SAVED_HOST_ALL_FILE\n";
		if (! rename($NEW_HOST_ALL_FILE, $CURRENT_HOST_ALL_FILE)) {
			print "Problem updating $CURRENT_HOST_ALL_FILE\n. Exiting.";
			exit 4;
		}
		else {
			print "$CURRENT_HOST_ALL_FILE has been updated\n";
		}
	}
}
elsif (-f $NEW_HOST_ALL_FILE) {
	if (! rename($NEW_HOST_ALL_FILE, $CURRENT_HOST_ALL_FILE)) {
		print "Problem updating $CURRENT_HOST_ALL_FILE\n. Exiting.";
		exit 5;
	}
		else {
			print "$CURRENT_HOST_ALL_FILE has been updated\n";
	}
}
