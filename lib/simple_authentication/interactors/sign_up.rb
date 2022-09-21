module SimpleAuthentication
	module Interactors
		class SignUp
			def self.with(user_klass_name:, user_attributes:)
				new(user_klass_name: user_klass_name, user_attributes: user_attributes).execute
			end

			def initialize(user_klass_name:, user_attributes:)
				@user_attributes = user_attributes
				@user_klass_name = user_klass_name
			end

			def execute
				create_user
			end

		private

			def create_user
				klass.create! @user_attributes
			end

			def klass
				@user_klass_name.camelize.constantize
			end
		end
	end
end
