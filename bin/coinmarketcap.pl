#!/usr/bin/perl
use strict;
use warnings;

use lib ('../lib');
use CoinMarketCap::API;
use Data::Dumper;

my $api = new CoinMarketCap::API;

#print Dumper $api->ticker({id=>1});
#print Dumper $api->global({convert => 'EUR'});

$api->_trace("hahaha", 1, [1, 3, {1 => 3}]);
$api->_get('ticker', convert => 3, apache => 8);
$api->_trace({1 => "dasdsa"});