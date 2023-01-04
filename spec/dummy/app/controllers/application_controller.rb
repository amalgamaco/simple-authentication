class ApplicationController < ActionController::API
	before_action :doorkeeper_authorize!

protected

	def current_user
		return unless doorkeeper_token

		begin
			User.find doorkeeper_token.resource_owner_id
		rescue StandardError
			nil
		end
	end
end
