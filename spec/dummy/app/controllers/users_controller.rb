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
end
