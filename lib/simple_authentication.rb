require 'rails'
require 'active_support/dependencies'
require 'simple_authentication/version'
require 'simple_authentication/engine'

module SimpleAuthentication
	module Controllers
		autoload :SimpleAuth, 'simple_authentication/controllers/simple_auth'
	end

	module Errors
		autoload :UnprocessableError, 'simple_authentication/errors/unprocessable_error'
	end

	module Interactors
		autoload :BaseInteractor, 'simple_authentication/interactors/base_interactor'
		autoload :SignUp, 'simple_authentication/interactors/sign_up'
		autoload :ResetPassword, 'simple_authentication/interactors/reset_password'
		autoload :ForgotPassword, 'simple_authentication/interactors/forgot_password'
	end
end
