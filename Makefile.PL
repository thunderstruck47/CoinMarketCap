use 5.026001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'CoinMarketCap::API',
    VERSION_FROM      => 'lib/CoinMarketCap/API.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/CoinMarketCap/API.pm', # retrieve abstract from module
    AUTHOR            => 'V. D. Gerov <velislav.gerov.12@aberdeen.ac.uk>',
    LICENSE           => 'mit',
    #Value must be from legacy list of licenses here
    #http://search.cpan.org/perldoc?Module%3A%3ABuild%3A%3AAPI
);
