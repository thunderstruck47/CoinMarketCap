use strict;
use warnings;

use lib ('../lib');
use CoinMarketCap;
use Data::Dumper;

my $market = new CoinMarketCap;

print Dumper $market->ticker;

