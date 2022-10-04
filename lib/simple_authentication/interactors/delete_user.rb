module SimpleAuthentication
	module Interactors
		class DeleteUser < BaseInteractor
			def self.with(user_id:, user_klass_name:, delete_user_callback: nil)
				new(
					user_id:,
					user_klass_name:,
					delete_user_callback:
				).execute
			end

			def initialize(user_id:, user_klass_name:, delete_user_callback: nil)
				super
				@user_id = user_id
				@delete_user_callback = delete_user_callback
			end

			def execute
				destroy_user
				@delete_user_callback&.call(@deleted_user)
			end

		private

			def destroy_user
				ActiveRecord::Base.transaction do
					@deleted_user = user_klass.destroy @user_id
				end
			end
		end
	end
end
