module SimpleAuthentication
	module Controllers
		class SimpleAuth < ActionController::API
			def sign_up
				SimpleAuthentication::Interactors::SignUp.with(
					user_klass_name:, user_attributes:
				)
			end

			def reset_password
				render_empty_response if SimpleAuthentication::Interactors::ResetPassword.with(
					user_klass_name:, reset_password_params:
				)
			end

		private

			def user_klass_name
				raise 'subclass responsability'
			end

			def user_attributes
				raise 'subclass responsability'
			end

			def reset_password_params
				raise 'subclass responsability'
			end

			def render_empty_response
				render json: {}, adapter: :json, status: :no_content
			end
		end
	end
end
