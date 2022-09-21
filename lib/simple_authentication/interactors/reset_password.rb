module SimpleAuthentication
	module Interactors
		class ResetPassword
			def self.with(user_klass_name:, reset_password_params:)
				new(user_klass_name:, reset_password_params:).execute
			end

			def initialize(user_klass_name:, reset_password_params:)
				@user_klass_name = user_klass_name
				@reset_password_params = reset_password_params
			end

			def execute
				generate_new_password
			end

		private

			def generate_new_password
				user_klass_instance = user_klass.reset_password_by_token @reset_password_params
				unless user_klass_instance&.errors&.empty?
					raise SimpleAuthentication::Errors::UnprocessableError.new(
							:invalid_record_attribute,
							:unprocessable,
							user_klass_instance.errors
					)
				end
			end

			def user_klass
				@user_klass_name.camelize.constantize
			end
		end
	end
end
