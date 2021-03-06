use 5.012000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Net::GereTPs',
    VERSION_FROM      => 'lib/Net/GereTPs.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Net/GereTPs.pm', # retrieve abstract from module
       AUTHOR         => 'André Santos <gerente@apple.com>') : ()),
    EXE_FILES         => ['bin/geretps']
);
