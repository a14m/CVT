source 'https://rubygems.org'
gem 'rails', '>= 5.0.0.rc2', '< 5.1'

gem 'pg'                              # Postgres ORM
gem 'puma'                            # Application server
gem 'redis'                           # Redis adapter
gem 'sorcery', github: 'mad-raz/sorcery', branch: '1-0-x' # authentication
gem 'validates_email_format_of'       # Validate e-mail addreses
gem 'MSP'                             # Less typing in Service Providers

# front-end dependencies
gem 'rails-assets-tether'             # Bootstrap tooltip dependency
gem 'bootstrap', '~> 4.0.0.alpha3'    # Bootstrap 4
gem 'nokogiri', '= 1.6.7.2'           # Pin nokogiri version
gem 'uglifier'                        # compressor for JavaScript assets
gem 'haml-rails'                      # Haml as the templating engine
gem 'coffee-rails'                    # .coffee assets and views
gem 'jquery-rails'                    # jquery as the JavaScript library
gem 'sass-rails'                      # SCSS for stylesheets
gem 'turbolinks', '~> 5.0.0.beta'     # navigating your faster
gem 'parsley-rails'                   # awesome form validation
gem 'tzinfo-data'                     # Timezone Data

group :development, :test do
  # gem 'bullet'                        # kill N+1 queries and unused eager loading
  gem 'pry-byebug'                    # Debugger calling 'beybug'
  gem 'pry-rails'                     # Use Pry instead of IRB in rails console
  gem 'dotenv-rails'                  # Loads environment variables from `.env`
end

group :development do
  gem 'letter_opener'                 # Preview email in the browser
  gem 'rspec-rails', '~> 3.5.0.beta4' # Install Rspec core
  gem 'brakeman', require: false      # Analysis security vulnerability scanner
  gem 'rubocop'                       # Styling ruby cop
  gem 'annotate'                      # Annotate Rails classes
  gem 'web-console'                   # using <%= console %> in views
  gem 'listen'                        # speeds up development
  gem 'rubycritic', require: false    # A Ruby code quality reporter
  # gem 'spring'
  # gem 'spring-watcher-listen'
end

group :test do
  # gem 'webmock'                       # Stubbing HTTP Requests
  gem 'faker'                         # Fake info for db
  gem 'fabrication'                   # Fabricate testing objects
  gem 'shoulda-matchers'              # Validation testing made simple
  # gem 'codeclimate-test-reporter', require: nil # CodeClimate coverage
  # gem 'database_cleaner'              # db cleaner for test env.
end

group :production do
  gem 'rails_12factor'                # Heroku recommended gem
end
