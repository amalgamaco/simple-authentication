class Block < ApplicationRecord
	belongs_to :blockee, class_name: 'User', inverse_of: :given_blocks
	belongs_to :blocked_user, class_name: 'User', inverse_of: :received_blocks

	validates :blocked_user, uniqueness: { scope: :blockee }

end
