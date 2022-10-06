FactoryBot.define do
	factory :block do
		blockee { build :user }
		blocked_user { build :user }
	end
end
