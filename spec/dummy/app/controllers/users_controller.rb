class UsersController < ApplicationController
	include SimpleAuthentication::Controllers::SimpleAuth
	rescue_from ActiveRecord::RecordInvalid, with: :render_error
	before_action :doorkeeper_authorize!
	skip_before_action :doorkeeper_authorize!, only: %i[sign_up forgot_password forgot_pass reset_password current_user]

	def render_error
		render(status: '422')
	end

	def forgot_pass
		render forgot_password
	end

	def block
		block_user
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

	def block_user_params
		{ blocked_user_id: params[:blocked_user_id], block_relation_klass_name: 'block' }
	end
end
