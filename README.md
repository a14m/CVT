# CVT
[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](/LICENSE.md)
[![wercker status](https://app.wercker.com/status/a8ba15bb8de5b3addaa638e34ac644a6/s/master "wercker status")](https://app.wercker.com/project/bykey/a8ba15bb8de5b3addaa638e34ac644a6)

[CVT: Continuously variable transmission](https://en.wikipedia.org/wiki/Continuously_variable_transmission)

Torrent remote downloader (using [transmission](https://transmissionbt.com/) daemon)

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

#### Postgres (for local.dev)
- Install Postgres (ex.`brew install postgres`)
- Create Postgres User and Grant him super user privilages
```
$ createuser -s postgres
```

### Setup
#### local.dev
- Clone the repo
- Install the gems using
```
bundle install
```
- Add `.env` file similar to the provided `.env.example`
- Run `bundle exec rake db:setup`
- Run the server
```sh
$ bundle exec puma -e development -C config/puma.rb
$ bundle exec rails s -b 0.0.0.0
```
#### docker.dev
- Clone the repo
- Add `.env` file similar to the provided `.env.example`
- Build the docker dependencies `docker-compose build`
- Run `docker-compose run app rake db:setup`
- Run the server `docker-compose up`

## RSpecs
- Run the specs (test suite) using rspec
```sh
$ bundle exec rspec
$ docker-compose run app rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/mad-raz/<REPO>

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
