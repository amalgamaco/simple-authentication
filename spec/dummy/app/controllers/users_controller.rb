class UsersController < ApplicationController
	include SimpleAuthentication::Controllers::SimpleAuth
	rescue_from ActiveRecord::RecordInvalid, with: :render_error

	def render_error
		render(status: '422')
	end

	def forgot_pass
		render forgot_password
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

	def current_user
		User.find doorkeeper_token.resource_owner_id rescue nil if doorkeeper_token
	end

	def forgot_password_params
		params.permit(:email)
	end
end
