class UsersController < SimpleAuthentication::Controllers::SimpleAuth
	rescue_from ActiveRecord::RecordInvalid, with: :render_error

	def render_error
		render(status: '422')
	end

private

	def user_klass_name
		'user'
	end

	def user_attributes
		params.permit(:email, :password)
	end

	def reset_password_params
		params.require(%i[password password_confirmation reset_password_token])
		params.permit(:password, :password_confirmation, :reset_password_token)
	end
end
