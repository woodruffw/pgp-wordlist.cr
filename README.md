pgp-wordlist.cr
===============

[![Build Status](https://img.shields.io/github/workflow/status/woodruffw/pgp-wordlist.cr/CI/master)](https://github.com/woodruffw/pgp-wordlist.cr/actions?query=workflow%3ACI)

A simple library for converting sequences of bytes into unambiguous English words.

Uses the "official" word list: <https://philzimmermann.com/docs/PGP_word_list.pdf>

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  pgp-wordlist:
    github: woodruffw/pgp-wordlist.cr
```

## Usage

```crystal
require "pgp-wordlist"

PGP::Wordlist.from_hexstring "0123 cdef" # => "absurd cannonball spindle unravel"

bytes = [0xfe_u8, 0xed_u8, 0xfa_u8, 0xce_u8]
PGP::Wordlist.from_bytes bytes # => "woodlark unify wallet sardonic"
```

## Contributing

1. Fork it (<https://github.com/woodruffw/pgp-wordlist.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [woodruffw](https://github.com/woodruffw) William Woodruff - creator, maintainer
