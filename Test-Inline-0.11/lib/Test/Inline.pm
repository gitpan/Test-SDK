package Test::Inline;

$VERSION = '0.11';


=head1 NAME

Test::Inline - Inlining your tests next to the code being tested.

=head1 SYNOPSIS

B<LOOK AT Test::Inline::Tutorial FIRST!>

   =item B<is_pirate>

        @pirates = is_pirate(@arrrgs);

    Go through @arrrgs and return a list of pirates.

    =begin testing

    my @p = is_pirate('Blargbeard', 'Alfonse', 'Capt. Hampton', 'Wesley');
    is(@p,  2,   "Found two pirates.  ARRR!");

    =end testing

    =cut

    sub is_pirate {
        ....
    }

=head1 DESCRIPTION

B<LOOK AT Test::Inline::Tutorial FIRST!>

Embedding tests allows tests to be placed near the code its testing.
This is a nice supplement to the traditional .t files.  It's like
XUnit, Perl-style.

Test::Tutorial is just documentation.  To actually get anything done
you use pod2test.  Read the Test::Inline::Tutoral, really.

A test is denoted using either "=for testing" or a "=begin/end
testing" block.

   =item B<is_pirate>

        @pirates = is_pirate(@arrrgs);

    Go through @arrrgs and return a list of pirates.

    =begin testing

    my @p = is_pirate('Blargbeard', 'Alfonse', 'Capt. Hampton', 'Wesley');
    ok(@p == 2);

    =end testing

    =cut

    sub is_pirate {
        ....
    }

=head2 Code Examples

Code examples in documentation are rarely tested.  Pod::Tests provides
a way to do some testing of your examples without repeating them.

A code example is denoted using "=for example begin" and "=for example
end".

=for _deprecated
Older versions used "=also begin/end example"  This still works, but it's 
deprecated and will break many POD utilities.

    =for example begin

    use LWP::Simple;
    getprint "http://www.goats.com";

    =for example end

The code between the begin and end B<will> be displayed as
documentation.  So it will show up in perldoc.  It will be tested to
ensure it compiles.

Using a normal C<=for example> or C<=begin/end example> block lets you
add code to your example that won't get displayed.  This is nice when
you only want to show a code fragment, yet still want to ensure things
work.

    =for example
    sub mygrep (&@) { }

    =for example begin

    mygrep { $_ eq 'bar' } @stuff

    =for example end

The mygrep() call would be a syntax error were the routine not
declared with the proper prototype.  Both pieces will be considered
part of the same example for the purposes of testing, but will only
display the C<mygrep {...}> line.  You can also put C<=for example>
blocks afterwards.

Normally, an example will only be checked to see if it compiles.  If
you put a C<=for example_testing> afterwards, more through checking
will be done:

    =for example begin

      my $result = 2 + 2;

    =for example end

    =for example_testing
      is( $result, 4,         'addition works' );

It will work like any other embedded test.  In this case the code will
actually be run.

Finally, since many examples print their output, we trap that into
$_STDOUT_ and $_STDERR_ variables to capture prints and warnings.

    =for example begin

      print "Hello, world!\n";
      warn  "Beware the Ides of March!\n";

    =for example end

    =for example_testing
      ok( $_STDOUT_ eq "Hello, world!\n" );
      ok( $_STDERR_ eq "Beware the Ides of March!\n" );


=head2 Formatting

The code examples and embedded tests are B<not> translated from POD,
thus all the CE<lt>E<gt> and BE<lt>E<gt> style escapes are not valid.
Its literal Perl code.


=head1 NOTES

Test::Inline has been tested and works on perl back to 5.004.

=head1 AUTHOR

Michael G Schwern E<lt>schwern@pobox.comE<gt>


=head1 SEE ALSO

L<Test::Inline::Tutorial>, L<pod2test>

=cut

1;
