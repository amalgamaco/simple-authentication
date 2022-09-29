module SimpleAuthentication
	module Errors
		class UnprocessableError < StandardError
			attr_reader :error_name, :error_message, :errors

			def initialize(error_name, error_message, errors = nil)
				super "#{error_name}: #{error_message}."
				@error_name = error_name
				@error_message = error_message
				@errors = errors
			end

			def http_status_code
				422
			end
		end
	end
end
