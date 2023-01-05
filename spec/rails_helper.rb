# Prevent database truncation if the environment is production
ENV['RAILS_ENV'] = 'test'

require 'spec_helper'
require 'active_record'
require 'rspec/rails'
require 'shoulda/matchers'

Shoulda::Matchers.configure do |config|
	config.integrate do |with|
		with.test_framework :rspec
		with.library :rails
	end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'shared_examples'))

RSpec.configure do |config|
	config.include Helpers
end
