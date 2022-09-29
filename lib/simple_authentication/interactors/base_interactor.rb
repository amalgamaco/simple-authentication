module SimpleAuthentication
	module Interactors
		class BaseInteractor
			def initialize(arguments)
				@user_klass_name = arguments[:user_klass_name]
			end

		private

			def user_klass
				@user_klass_name.camelize.constantize
			end
		end
	end
end
