module SimpleAuthentication
	module Interactors
		class SignUp < BaseInteractor
			def self.with(user_klass_name:, user_attributes:)
				new(user_klass_name:, user_attributes:).execute
			end

			def initialize(user_klass_name:, user_attributes:)
				super
				@user_attributes = user_attributes
			end

			def execute
				create_user
			end

		private

			def create_user
				user_klass.create! @user_attributes
			end
		end
	end
end
