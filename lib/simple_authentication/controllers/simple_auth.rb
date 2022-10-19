module SimpleAuthentication
	module Controllers
		module SimpleAuth
			delegate :current_user, to: :current_controller
			delegate :user_attributes, to: :current_controller
			delegate :reset_password_params, to: :current_controller
			delegate :forgot_password_params, to: :current_controller

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

			def block_user
				SimpleAuthentication::Interactors::BlockUser.with(
					current_user:,
					blocked_user_id: block_user_params[:blocked_user_id],
					block_relation_klass_name: block_user_params[:block_relation_klass_name]
				)
			end

			def unblock_user
				SimpleAuthentication::Interactors::UnblockUser.with(
					current_user:,
					blocked_user_id: block_user_params[:blocked_user_id],
					block_relation_klass_name: block_user_params[:block_relation_klass_name]
				)
			end

		private

			def current_controller
				self.class
			end

			def user_klass_name
				self.class.name.gsub(/Controller$/, '').downcase
			end

			def delete_user_params
				nil
			end

			def delete_user_callback
				nil
			end

			def block_user_params
				raise 'class responsability'
			end

			def unblock_user_params
				raise 'class responsability'
			end
		end
	end
end
