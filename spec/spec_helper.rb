# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require 'rspec'
require 'byebug'
require 'devise'
require 'doorkeeper'
require 'factory_bot_rails'
require 'simplecov'
require 'simplecov_json_formatter'
require 'simplecov-cobertura'

SimpleCov.start 'rails' do
	project_name 'Simple Authentication Gem'

	formatter SimpleCov::Formatter::MultiFormatter.new([
		SimpleCov::Formatter::JSONFormatter,
		SimpleCov::Formatter::HTMLFormatter,
		SimpleCov::Formatter::CoberturaFormatter
	])

	coverage_dir 'reports/coverage'

	add_filter '/vendor/'
	add_filter '/bin/'
	add_filter '/spec/'
	add_filter '/config/'
	add_filter '/lib/tasks'

	add_filter '/lib/simple_authentication.rb'
	add_filter '/lib/simple_authentication/engine.rb'
	add_filter '/lib/simple_authentication/version.rb'

	add_group 'Interactors', '/lib/simple_authentication/interactors'
	add_group 'Controllers', '/lib/simple_authentication/controllers'
	add_group 'Errors', '/lib/simple_authentication/errors'
end

require_relative '../spec/dummy/config/environment'
require_relative '../spec/support/helpers'
require_relative '../spec/shared_examples/for_interactors'
require_relative '../spec/shared_contexts/for_controllers'
require_relative '../spec/factories/users'

ActiveRecord::Migrator.migrations_paths = [File.expand_path('../spec/dummy/db/migrate', __dir__)]

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

RSpec.configure do |config|
	config.include FactoryBot::Syntax::Methods

	config.expect_with :rspec do |expectations|
		expectations.include_chain_clauses_in_custom_matcher_descriptions = true
	end

	config.mock_with :rspec do |mocks|
		mocks.verify_partial_doubles = true
	end
end
