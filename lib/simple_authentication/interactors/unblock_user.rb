module SimpleAuthentication
	module Interactors
		class UnblockUser
			def self.with(current_user:, blocked_user_id:, block_relation_klass_name:)
				new(
					current_user:,
					blocked_user_id:,
					block_relation_klass_name:
				).execute
			end

			def initialize(current_user:, blocked_user_id:, block_relation_klass_name:)
				@blocker_user_id = current_user.id
				@blocked_user_id = blocked_user_id.to_i
				@block_relation_klass_name = block_relation_klass_name
			end

			def execute
				validate_user_is_not_unblocking_himself
				unblock_user
			end

		private

			def unblock_user
				block_relation_klass.destroy(user_block.id)
			end

			def user_block
				block_relation_klass.find_by!(
					blocker_id: @blocker_user_id,
					blocked_user_id: @blocked_user_id
				)
			end

			def block_relation_klass
				@block_relation_klass_name.camelize.constantize
			end

			def validate_user_is_not_unblocking_himself
				self_unblock_error if is_unblocking_himself?
			end

			def self_unblock_error
				raise SimpleAuthentication::Errors::UnprocessableError.new(
					:invalid_record_attribute, :unprocessable
				)
			end

			def is_unblocking_himself?
				@blocker_user_id == @blocked_user_id
			end
		end
	end
end
