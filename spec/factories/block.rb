FactoryBot.define do
	factory :block do
		blocker { build :user }
		blocked_user { build :user }
	end
end
