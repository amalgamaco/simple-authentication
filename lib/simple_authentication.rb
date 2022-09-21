require 'rails'
require 'active_support/dependencies'
require "simple_authentication/version"
require "simple_authentication/engine"

module SimpleAuthentication
	module Controllers
		autoload :SimpleAuth, 'simple_authentication/controllers/simple_auth'
	end

	module Interactors
		autoload :SignUp, 'simple_authentication/interactors/sign_up'
	end
end
