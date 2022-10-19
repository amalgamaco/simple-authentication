module SimpleAuthentication
	module Interactors
		class BlockUser
			def self.with(current_user:, block_user_params:)
				new(
					current_user:,
					block_user_params:
				).execute
			end

			def initialize(current_user:, block_user_params:)
				@blocker_user_id = current_user&.id
				@blocked_user_id = block_user_params[:blocked_user_id].to_i
				@block_relation_klass_name = block_user_params[:block_relation_klass_name]
			end

			def execute
				validate_user_cant_block_himself
				block_user
			end

		private

			def block_user
				block_relation_klass.create!(
					blocker_id: @blocker_user_id,
					blocked_user_id: @blocked_user_id
				)
			end

			def block_relation_klass
				@block_relation_klass_name.camelize.constantize
			end

			def validate_user_cant_block_himself
				self_block_error if is_blocking_himself
			end

			def self_block_error
				raise SimpleAuthentication::Errors::UnprocessableError.new(
						:invalid_record_attribute, :unprocessable
					)
			end

			def is_blocking_himself
				@blocker_user_id == @blocked_user_id
			end
		end
	end
end
