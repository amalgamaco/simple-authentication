module SimpleAuthentication
	module Controllers
		module SimpleAuth
			include SimpleAuthentication::Errors

			REQUIRED_METHODS = %i[
				current_user user_attributes reset_password_params
				forgot_password_params
			].freeze

			def sign_up
				SimpleAuthentication::Interactors::SignUp.with(
					user_klass_name:, user_attributes:
				)
			end

			def delete
				SimpleAuthentication::Interactors::DeleteUser.with(
					user_klass_name:, user_id: current_user&.id, delete_user_callback:
				)
			end

			def reset_password
				SimpleAuthentication::Interactors::ResetPassword.with(
					user_klass_name:, reset_password_params:
				)
			end

			def forgot_password
				SimpleAuthentication::Interactors::ForgotPassword.with(
					user_email: forgot_password_params[:email], user_klass_name:
				)
			end

		private

			def user_klass_name
				self.class.name.gsub(/Controller$/, '').downcase
			end

			def delete_user_params
				nil
			end

			def delete_user_callback
				nil
			end

			def method_missing(method, *args, &block)
				raise MethodRequiredError.new(method, self.class) if REQUIRED_METHODS.include? method

				super
			end

			# Not really necessary in this case but fixes rubocop warning
			# Ref: https://thoughtbot.com/blog/always-define-respond-to-missing-when-overriding
			def respond_to_missing?(method_name, include_private = false)
				super
			end
		end
	end
end
