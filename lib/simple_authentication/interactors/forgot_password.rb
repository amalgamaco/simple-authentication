module SimpleAuthentication
	module Interactors
		class ForgotPassword < BaseInteractor
			def self.with(user_email:, user_klass_name:)
				new(user_email:, user_klass_name:).execute
			end

			def initialize(user_email:, user_klass_name:)
				super
				@user_email = user_email
			end

			def execute
				send_email_with_instructions
			end

		private

			def send_email_with_instructions
				user.send_reset_password_instructions
			end

			def user
				user_klass.find_by! email: @user_email
			end
		end
	end
end
