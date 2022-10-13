module SimpleAuthentication
	module Interactors
		class UnblockUser
			def self.with(current_user:, unblock_user_params:)
				new(
					current_user:,
					unblock_user_params:
				).execute
			end

			def initialize(current_user:, unblock_user_params:)
				@blocker_user_id = current_user&.id
				@blocked_user_id = unblock_user_params[:blocked_user_id]
				@block_relation_klass_name = unblock_user_params[:block_relation_klass_name]
			end

			def execute
				validate_user_cant_unblock_himself
				find_block
				unblock_user
			end

		private

			def unblock_user
				block_relation_klass.destroy(@block.id)
			end

			def find_block
					@block = block_relation_klass.find_by!(
						blocker_id: @blocker_user_id,
						blocked_user_id: @blocked_user_id
					)
			end

			def block_relation_klass
				@block_relation_klass_name.camelize.constantize
			end

			def validate_user_cant_unblock_himself
				return unless @blocked_user_id == @blocker_user_id
				raise SimpleAuthentication::Errors::UnprocessableError.new(
						:invalid_record_attribute,
						:unprocessable,
					)
			end
		end
	end
end
