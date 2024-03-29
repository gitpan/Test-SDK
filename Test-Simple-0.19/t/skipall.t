use strict;

# Can't use Test.pm, that's a 5.005 thing.
package My::Test;

print "1..2\n";

my $test_num = 1;
# Utility testing functions.
sub ok ($;$) {
    my($test, $name) = @_;
    my $ok = '';
    $ok .= "not " unless $test;
    $ok .= "ok $test_num";
    $ok .= " - $name" if defined $name;
    $ok .= "\n";
    print $ok;
    $test_num++;
}


package main;
require Test::More;

push @INC, 't/lib';
require Test::Simple::Catch::More;
my($out, $err) = Test::Simple::Catch::More::caught();

Test::More->import('skip_all');


END {
    My::Test::ok($$out eq "1..0\n");
    My::Test::ok($$err eq "");
}
