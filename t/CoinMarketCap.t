# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl CoinMarketCap.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 33;
BEGIN { use_ok('CoinMarketCap::API') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

# CoinMarketCap API v1 tests:

my $api = new_ok('CoinMarketCap::API', [1]);

ok($api->ticker);
ok($api->ticker(limit => 10));
ok($api->ticker(start => 100, limit => 10));
ok($api->ticker(convert => 'EUR', limit => 10));
ok($api->ticker('etherirum', convert => 'EUR'));

my $ticker_data = $api->ticker('ethereum');

ok($ticker_data);
is(scalar @{ $ticker_data }, 1);
ok(exists $$ticker_data[0]{'max_supply'});
ok(exists $$ticker_data[0]{'symbol'});
ok(exists $$ticker_data[0]{'price_usd'});
ok(exists $$ticker_data[0]{'market_cap_usd'});
ok(exists $$ticker_data[0]{'rank'});
ok(exists $$ticker_data[0]{'price_btc'});
ok(exists $$ticker_data[0]{'24h_volume_usd'});
ok(exists $$ticker_data[0]{'percent_change_24h'});
ok(exists $$ticker_data[0]{'percent_change_1h'});
ok(exists $$ticker_data[0]{'percent_change_7d'});
ok(exists $$ticker_data[0]{'available_supply'});
ok(exists $$ticker_data[0]{'total_supply'});
ok(exists $$ticker_data[0]{'name'});
ok(exists $$ticker_data[0]{'id'});
ok(exists $$ticker_data[0]{'last_updated'});

my $err_data = $api->ticker('8a503d4b1d1499177aab10a7798e6b23');
ok(exists $$err_data{error});

my $global_data = $api->global(convert => 'EUR');
ok($global_data);
ok(exists $$global_data{'total_market_cap_usd'});
ok(exists $$global_data{'total_24h_volume_usd'});
ok(exists $$global_data{'bitcoin_percentage_of_market_cap'});
ok(exists $$global_data{'active_currencies'});
ok(exists $$global_data{'active_assets'});
ok(exists $$global_data{'active_markets'});
ok(exists $$global_data{'last_updated'});
