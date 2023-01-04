source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in simple_authentication.gemspec.
gemspec

gem "sqlite3"

gem "rake", "~> 13.0"

group :development, :test do
    gem 'rubocop', require: false

    gem 'rubocop-rails', require: false
    gem 'rubocop-rspec', require: false
end

group :test do
    gem "rspec", "~> 3.0"
    # JUnit test report formatter, url: https://github.com/sj26/rspec_junit_formatter
    gem 'rspec_junit_formatter'

    # Additional matchers for testing, url: https://github.com/thoughtbot/shoulda-matchers
    gem 'shoulda-matchers'

    # Code coverage generator tool, url: https://github.com/simplecov-ruby/simplecov
    gem 'simplecov', require: false
    gem 'simplecov_json_formatter', require: false
    gem 'simplecov-cobertura', require: false
end