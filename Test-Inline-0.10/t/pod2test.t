#!perl -w

use Test::More no_plan;

package Catch;

sub TIEHANDLE {
    my($class) = shift;
    return bless {}, $class;
}

sub PRINT  {
    my($self) = shift;
    $main::_STDOUT_ .= join '', @_;
}

sub READ {}
sub READLINE {}
sub GETC {}

package main;

local $SIG{__WARN__} = sub { $_STDERR_ .= join '', @_ };
tie *STDOUT, 'Catch' or die $!;


{
#line 91 t/Tests.t
ok(2+2 == 4);

}

{
#line 103 t/Tests.t

my $foo = 0;
ok( !$foo,      'foo is false' );
ok( $foo == 0,  'foo is zero'  );


}

eval q{
  my $example = sub {
    local $^W = 0;

#line 113 t/Tests.t

  # This is an example.
  2+2 == 4;
  5+5 == 10;

;

  }
};
is($@, '', "example from line 113");

eval q{
  my $example = sub {
    local $^W = 0;

#line 122 t/Tests.t
  sub mygrep (&@) { }
  mygrep { $_ eq 'bar' } @stuff
;

  }
};
is($@, '', "example from line 122");

eval q{
  my $example = sub {
    local $^W = 0;

#line 131 t/Tests.t

  my $result = 2 + 2;

;

  }
};
is($@, '', "example from line 131");

{
#line 131 t/Tests.t

  my $result = 2 + 2;

  ok( $result == 4,         'addition works' );

}

eval q{
  my $example = sub {
    local $^W = 0;

#line 142 t/Tests.t

  print "Hello, world!\n";
  warn  "Beware the Ides of March!\n";

;

  }
};
is($@, '', "example from line 142");

{
#line 142 t/Tests.t

  print "Hello, world!\n";
  warn  "Beware the Ides of March!\n";

  ok( $_STDOUT_ eq "Hello, world!\n",                   '$_STDOUT_' );
  ok( $_STDERR_ eq "Beware the Ides of March!\n",       '$_STDERR_' );

}

eval q{
  my $example = sub {
    local $^W = 0;

#line 153 t/Tests.t

  1 + 1 == 2;

;

  }
};
is($@, '', "example from line 153");

