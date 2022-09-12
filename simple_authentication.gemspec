require_relative 'lib/simple_authentication/version'

Gem::Specification.new do |spec|
	spec.name        = 'simple_authentication'
	spec.version     = SimpleAuthentication::VERSION
	spec.authors     = ['luca']
	spec.email       = ['lucagiabbani@amalgama.co']
	spec.homepage    = 'https://git.amalgama.co/'
	spec.summary     = 'Summary of SimpleAuthentication.'
	spec.description = 'Description of SimpleAuthentication.'

	# Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
	# to allow pushing to a single host or delete this section to allow pushing to any host.
	spec.metadata['allowed_push_host'] = 'TODO: Set to http://mygemserver.com'

	spec.metadata['homepage_uri'] = spec.homepage
	spec.metadata['source_code_uri'] = 'https://git.amalgama.co/'
	spec.metadata['changelog_uri'] = 'https://git.amalgama.co/'

	spec.files = Dir.chdir(File.expand_path(__dir__)) do
		Dir['{app,config,db,lib}/**/*', 'Rakefile', 'README.md']
	end

	spec.add_dependency 'rails', '>= 7.0.3.1'
	spec.add_dependency "byebug"
	spec.add_dependency "rake"
	spec.add_dependency "bundler"
	spec.add_dependency "openssl"

	spec.add_dependency('railties', '>= 5.2.0') # encrypted credentials
	spec.add_development_dependency 'test-unit-rails'
	spec.add_development_dependency 'rubocop-rails'
end
