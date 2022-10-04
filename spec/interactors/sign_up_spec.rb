require 'spec_helper'
require 'rails_helper'

RSpec.shared_examples 'SignUp is successful' do
	it 'creates a new instance of klass' do
		expect { call_interactor }.to change(klass, :count).by(1)
	end

	it 'created instance have the given attributes' do
		attributes_without_password = user_attributes.except(:password)
		expect(klass.last).to have_attributes(attributes_without_password)
	end
end

RSpec.describe SimpleAuthentication::Interactors::SignUp do
	let(:user_klass_name) { 'user' }
	let(:klass) { user_klass_name.camelize.constantize }
	let(:user_attributes) do
		{
			email:,
			password:
		}
	end
	let(:email) { 'testemail@amalgama.co' }
	let(:password) { 'password' }

	let(:call_interactor) do
		described_class.with(user_klass_name:, user_attributes:)
	end

	context 'with correct params' do
		include_examples 'SignUp is successful'
	end

	context 'when the unique key has already been taken' do
		let(:duplicate_klass) { create :user }
		let(:duplicated_key) { duplicate_klass.email }
		let(:email) { duplicate_klass.email }

		include_examples 'raises Error exception', ActiveRecord::RecordInvalid
	end

	context 'with invalid params' do
		context 'with empty params' do
			%i[email password].each do |param|
				context "with empty #{param}" do
					before { user_attributes[param] = '' }

					it 'raises record invalid' do
						expect { call_interactor }.to raise_exception ActiveRecord::RecordInvalid
					end
				end
			end
		end
	end
end
