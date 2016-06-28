# Torminator
[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](/LICENSE.md)

Torrent remote downloader.

## Development
### Requirements
#### rbenv

- Install `rbenv` (ex.`brew install rbenv`)
- Install `ruby-build` (ex.`brew install ruby-build`)
- (Optional) Install [rbenv-vars](https://github.com/sstephenson/rbenv-vars) plugin
- (Optional) Install [rbenv-gem-rehash](https://github.com/sstephenson/rbenv-gem-rehash) plugin

#### Ruby version
- Install the desired ruby version using `rbenv install $(cat .ruby-version)`

#### bundler
- Install bundler using `gem install bundler`

#### Postgres
- Install Postgres (ex.`brew install postgres`)

### Setup

- Clone the repo
- Install the gems using
```
bundle install
```
- Add `.env` file similar to the provided `.env.example`
- Run `bundle exec rake db:setup`
- Run the server
```sh
bundle exec puma
# or
bundle exec rails server
# or
foreman start
```
## RSpecs
- Run the specs (test suite) using rspec
```sh
bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/<USER_NAME>/<REPO>

This project is intended to be a safe,
welcoming space for collaboration,
and contributors are expected to adhere to the
Contributor Covenant [code of conduct.](/CODE_OF_CONDUCT.md)

- Read the previous [code of conduct](/CODE_OF_CONDUCT.md) once again.
- Write clean code.
- Write clean tests.
- Make sure your code is covered by test. (check coverage mentioned earlier)
- Make sure you follow the code style mentioned by
[rubocop](http://batsov.com/rubocop/) (run `bundle exec rubocop`)
- A pre-commit hook included with repo can be used to remember rubocop
it won't disable commits, but will remind you of violations.
you can set it up using `chmod +x pre-commit && cp pre-commit .git/hooks/`
- Be nice to your fellow human-beings/bots contributing to this repo.

## License

The project is available as open source under the terms of the
[MIT License](/LICENSE.md)
