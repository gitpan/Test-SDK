# A template for Makefile.PL used by Arena Networks.
# - Set the $PACKAGE variable to the name of your module.
# - Set $LAST_API_CHANGE to reflect the last version you changed the API 
#   of your module.
# - Fill in your dependencies in PREREQ_PM
# Alternatively, you can say the hell with this and use h2xs.

use 5.004;

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

$PACKAGE = 'Test::Inline';
($PACKAGE_FILE = $PACKAGE) =~ s|::|/|g;
$LAST_API_CHANGE = 0.10;

eval { require Test::Inline; } || eval { require Pod::Tests };

unless ($@) { # Make sure we did find the module.
    if( ${$PACKAGE.'::VERSION'} < $LAST_API_CHANGE ) {
        warn <<API_CHANGE;
*** WARNING *** WARNING *** WARNING *** WARNING *** WARNING *** WARNING ***
Three things.  See the Test::Inline man page for full details.

First.

         Pod::Tests is now Test::Inline

Second.

         The behavior of Pod::Tests (err, Test::Inline) *HAS CHANGED*

Previously, all tests were run in the same lexical scope.  This
version, each individual testing block is lexically isolated (ie. have
braces around it).  This means you can't share 'my' variables between
tests, only globals.

Third.

         '=also begin example' is '=for example begin'

The syntax for declaring code examples has changed.  This one doesn't
cause any warnings from existing POD viewers.

Check your tests and modify them now.

*** WARNING *** WARNING *** WARNING *** WARNING *** WARNING *** WARNING ***
API_CHANGE

        sleep 10;
    }
}


WriteMakefile(
    NAME            => $PACKAGE,
    VERSION_FROM    => "lib/$PACKAGE_FILE.pm", # finds $VERSION
    PREREQ_PM       => { Test::More     => 0.05,
                         Test::Harness  => 1.22,
                       },
    EXE_FILES       => ['bin/pod2test'],
    'dist'          => { COMPRESS   => 'gzip -9',
                         SUFFIX     => '.gz',
                         DIST_DEFAULT   => 'all tardist',
                       },
);


# If PERL_TEST_ALL is set, run "make test" against other perls
# as well as the current perl.
{
    package MY;

    sub test_via_harness {
        my($self, $orig_perl, $tests) = @_;

        my @other_perls = qw(bleadperl perl5.6.1 perl5.005_03
                             perl5.004_05 perl5.004_04 perl5.004
                            );

        my @perls = ($orig_perl);
        push @perls, @other_perls if $ENV{PERL_TEST_ALL};

        my $out;
        foreach my $perl (@perls) {
            $out .= $self->SUPER::test_via_harness($perl, $tests);
        }

        return $out;
    }
}


# Generating pod2test's tests.
print "Running pod2test.\n";
system(qq{$^X -I"lib" bin/pod2test t/Tests.t t/pod2test.t});

# Test that pod2test generates no file when given something that has no
# tests.
system(qq{$^X -I"lib" bin/pod2test MANIFEST t/i_should_not_be_written.t});
