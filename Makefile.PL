use 5.004;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME            => 'Test-SDK',
    VERSION         => '0.02',
    INST_LIB        => './blib/lib',
    INST_ARCHLIB    => './blib/arch',
);
