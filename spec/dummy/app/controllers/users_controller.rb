class UsersController < ApplicationController
	include SimpleAuthentication::Controllers::SimpleAuth
	rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_error
	rescue_from SimpleAuthentication::Errors::UnprocessableError, with: :render_invalid_error
	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
	skip_before_action :doorkeeper_authorize!,
																				only: %i[sign_up forgot_password forgot_pass reset_password current_user]

	def render_invalid_error
		render(status: '422')
	end

	def render_not_found
		render(status: '404')
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

	def forgot_password_params
		params.permit(:email)
	end
end
