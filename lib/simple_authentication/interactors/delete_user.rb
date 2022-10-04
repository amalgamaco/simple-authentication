module SimpleAuthentication
	module Interactors
		class DeleteUser < BaseInteractor
			def self.with(user_id:, user_klass_name:)
				new(
					user_id:,
					user_klass_name:
				).execute
			end

			def initialize(user_id:, user_klass_name:)
				super
				@user_id = user_id
			end

			def execute
				destroy_user
			end

		private

			def destroy_user
				ActiveRecord::Base.transaction do
					user_klass.destroy @user_id
				end
			end
		end
	end
end
