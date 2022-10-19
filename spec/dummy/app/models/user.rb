class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
	has_many \
		:given_blocks,
		foreign_key: 'blockee_id',
		class_name: 'Block',
		dependent: :delete_all,
		inverse_of: :blockee

	has_many :blocked_users, through: :given_blocks, source: :blocked_user

	has_many \
		:received_blocks,
		foreign_key: 'blocked_user_id',
		class_name: 'Block',
		dependent: :delete_all,
		inverse_of: :blocked_user

	has_many :blockee_users, through: :received_blocks, source: :blockee

end
