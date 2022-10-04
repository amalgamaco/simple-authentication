module SimpleAuthentication
	module Controllers
		class SimpleAuth < ActionController::API
			def sign_up
				SimpleAuthentication::Interactors::SignUp.with(
					user_klass_name:, user_attributes:
				)
			end

			def delete
				SimpleAuthentication::Interactors::DeleteUser.with(
					user_klass_name:, user_id: current_user&.id
				)
			end

			def reset_password
				SimpleAuthentication::Interactors::ResetPassword.with(
					user_klass_name:, reset_password_params:
				)
			end

			def forgot_password
				SimpleAuthentication::Interactors::ForgotPassword.with(
					user_email: params[:user_email], user_klass_name:
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

			def current_user
				raise 'sublcass responsability'
			end

			def render_empty_response
				render json: {}, adapter: :json, status: :no_content
			end
		end
	end
end
