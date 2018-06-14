# [CoinMarketCap](https://coinmarketcap.com/)'s API v1 wrapped for Perl

## INSTALLATION

To install this module type the following:

```bash
perl Makefile.PL
make
make test
make install
```

## USAGE

```
use CoinMarketCap::API;

my $api = new CoinMarketCap::API;

my $ticker_data = $api->ticker;
my $global_data = $api->global;

my $ethereum_data = $api->ticker('etherium', convert => 'EUR'); 
my $ticker_data_top_10 = $api->global(limit => '10');
```

## DEPENDENCIES

This module requires the following Perl modules and libraries:

- [LWP::UserAgent](https://metacpan.org/pod/release/ETHER/libwww-perl-6.31/lib/LWP/UserAgent.pm)
- [LWP::Protocol::https](https://metacpan.org/pod/LWP::Protocol::https)
- [JSON](https://metacpan.org/pod/JSON)
- [Try:Tiny](https://metacpan.org/pod/Try::Tiny)
