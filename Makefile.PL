use ExtUtils::MakeMaker;

use 5.004;

WriteMakefile(
    NAME          => 'Test::SDK',
    VERSION       => 0.04, 
    INSTALLDIRS   => perl,
    INST_LIB      => './blib/lib',
    INST_ARCHLIB  => './blib/arch',
);
