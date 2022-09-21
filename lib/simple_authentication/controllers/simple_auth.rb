module SimpleAuthentication
	module Controllers
		class SimpleAuth < ActionController::API
			def sign_up
				SimpleAuthentication::Interactors::SignUp.with(
					user_klass_name: user_klass_name, user_attributes: user_attributes
				)
			end

		private

			def user_klass_name
				raise 'subclass responsability'
			end

			def user_attributes
				raise 'subclass responsability'
			end
		end
	end
end
